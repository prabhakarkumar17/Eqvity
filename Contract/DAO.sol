//SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DAO is ERC20 {
    struct DAOGroup{
        address[] members;
        bytes32 groupName; //Token name and group name can be same
        bytes32 tokenSymbol; //IMG ----> Warrior
        bytes32 tokenImage;
        int totalSupplyOfToken;
        int joiningAmount;
        address tokenAddress;
    }

    mapping(bytes32 => DAOGroup) public groupDetail;

    function DAOCreation(address[] memory _members, 
                         bytes32 _groupName, 
                         bytes32 _tokenSymbol, 
                         bytes32 _tokenImage,
                         int _totalSupplyOfToken,
                         int _joiningAmount
                         ) public returns(bool){

                            groupDetail[_tokenSymbol].members = _members;
                            groupDetail[_tokenSymbol].groupName = _groupName;
                            groupDetail[_tokenSymbol].tokenSymbol = _tokenSymbol;
                            groupDetail[_tokenSymbol].tokenImage = _tokenImage;
                            groupDetail[_tokenSymbol].totalSupplyOfToken = _totalSupplyOfToken;
                            groupDetail[_tokenSymbol].joiningAmount = _joiningAmount;

                            //Creation of ERC-20 token
                            constructor() ERC20(_groupName, _tokenSymbol){
                                _mint(msg.sender, totalSupplyOfToken);
                            }
    }
}