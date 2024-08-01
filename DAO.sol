//SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20{
    constructor(string memory _groupName, string memory _tokenSymbol, uint _totalSupply) ERC20(_groupName, _tokenSymbol){
        _mint(msg.sender, _totalSupply);
    }
}

contract DAO{
    struct DAOGroup{
        address[] members;
        string groupName; //Token name and group name can be same
        string tokenSymbol; //IMG ----> Warrior
        string tokenImage;
        uint totalSupplyOfToken;
        int joiningAmount;
        address tokenAddress;
    }
    /** 
        Creation of ERC-20 token
        constructor() ERC20(_groupName, _tokenSymbol){
            _mint(msg.sender, totalSupplyOfToken);
        }
    **/

    mapping(string => DAOGroup) public groupDetail;

    function DAOCreation(address[] memory _members, 
                         string memory _groupName, 
                         string memory _tokenSymbol, 
                         string memory _tokenImage,
                         uint _totalSupplyOfToken,
                         int _joiningAmount
                         ) public returns(address){

                            groupDetail[_tokenSymbol].members = _members;
                            groupDetail[_tokenSymbol].groupName = _groupName;
                            groupDetail[_tokenSymbol].tokenSymbol = _tokenSymbol;
                            groupDetail[_tokenSymbol].tokenImage = _tokenImage;
                            groupDetail[_tokenSymbol].totalSupplyOfToken = _totalSupplyOfToken;
                            groupDetail[_tokenSymbol].joiningAmount = _joiningAmount;

                            MyToken tok = new MyToken(_groupName, _tokenSymbol, _totalSupplyOfToken);
                            groupDetail[_tokenSymbol].tokenAddress = address(tok);
                            
                            return address(tok);
    }
}
