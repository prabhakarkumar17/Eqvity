// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract DAOToken is ERC20 {
    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply
    ) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
    }
}

contract DAO is Ownable {
    using SafeMath for uint256;

    string public daoName;
    string public tokenSymbol;
    string public tokenImage; // Token image URL or IPFS hash
    uint256 public totalSupply;
    uint256 public memberJoinAmount;
    address[] public members;
    mapping(address => uint256) public memberTokens;
    mapping(address => bool) public isMember;
    mapping(address => uint256) public memberVotes;

    DAOToken public daoToken;
    uint256 public votingPowerThreshold = 51; // 51%

    struct Proposal {
        string description;
        address proposer;
        uint256 voteCount;
        mapping(address => bool) votes;
        bool executed;
    }

    Proposal[] public proposals;

    event NewMember(address member, uint256 tokenAmount);
    event MemberRemoved(address member);
    event ProposalPublished(uint256 proposalId, string description);
    event ProposalExecuted(uint256 proposalId);

    constructor(
        string memory _daoName,
        string memory _tokenSymbol,
        string memory _tokenImage,
        uint256 _totalSupply,
        uint256 _memberJoinAmount
    ) {
        daoName = _daoName;
        tokenSymbol = _tokenSymbol;
        tokenImage = _tokenImage;
        totalSupply = _totalSupply;
        memberJoinAmount = _memberJoinAmount;
        daoToken = new DAOToken(_daoName, _tokenSymbol, _totalSupply);
    }

    function joinDAO() public {
        require(!isMember[msg.sender], "Already a member");
        require(daoToken.transferFrom(msg.sender, address(this), memberJoinAmount), "Transfer failed");

        isMember[msg.sender] = true;
        memberTokens[msg.sender] = memberJoinAmount;
        members.push(msg.sender);

        emit NewMember(msg.sender, memberJoinAmount);
    }

    function publishProposal(string memory description) public {
        require(isMember[msg.sender], "Not a DAO member");

        Proposal storage newProposal = proposals.push();
        newProposal.description = description;
        newProposal.proposer = msg.sender;

        emit ProposalPublished(proposals.length - 1, description);
    }

    function voteOnProposal(uint256 proposalId, bool support) public {
        require(isMember[msg.sender], "Not a DAO member");
        require(proposalId < proposals.length, "Invalid proposal ID");
        Proposal storage proposal = proposals[proposalId];
        require(!proposal.votes[msg.sender], "Already voted");

        if (support) {
            proposal.voteCount = proposal.voteCount.add(memberTokens[msg.sender]);
        }

        proposal.votes[msg.sender] = true;
    }

    function executeProposal(uint256 proposalId) public {
        require(proposalId < proposals.length, "Invalid proposal ID");
        Proposal storage proposal = proposals[proposalId];
        require(!proposal.executed, "Proposal already executed");

        uint256 totalVotes = 0;
        for (uint256 i = 0; i < members.length; i++) {
            if (proposal.votes[members[i]]) {
                totalVotes = totalVotes.add(memberTokens[members[i]]);
            }
        }

        uint256 thresholdVotes = totalSupply.mul(votingPowerThreshold).div(100);
        if (totalVotes >= thresholdVotes) {
            proposal.executed = true;
            emit ProposalExecuted(proposalId);
            // Logic for proposal execution
        }
    }

    function removeMember(address member) public onlyOwner {
        require(isMember[member], "Not a DAO member");

        // Check if the member's removal has sufficient consent
        uint256 consentVotes = 0;
        for (uint256 i = 0; i < members.length; i++) {
            if (memberTokens[members[i]] > 0) {
                consentVotes = consentVotes.add(memberTokens[members[i]]);
            }
        }
        uint256 thresholdVotes = totalSupply.mul(votingPowerThreshold).div(100);
        require(consentVotes >= thresholdVotes, "Not enough votes for removal");

        // Remove member
        isMember[member] = false;
        for (uint256 i = 0; i < members.length; i++) {
            if (members[i] == member) {
                members[i] = members[members.length - 1];
                members.pop();
                break;
            }
        }

        emit MemberRemoved(member);
    }

    function payAgreementFees() public payable onlyOwner {
        // Functionality to handle agreement fees
    }
}
