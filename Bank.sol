//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.4.14;
/*  Requirements:
* Hold a number of accounts and balances
* deposit and withdraw Money
* Get the balance of the requested accounts
* Write JS code to test the DApp
* (optional) Write a web app to interact with the smart contract
*/

import "github.com/Arachnid/solidity-stringutils/strings.sol";

contract Banking{
    
    using strings for *;
    
    struct User{
        string name;
        string pass;
        uint bal;
        address addr;
    }
    
    address[] private user_addresses;
    mapping(address => User) private user_map;
    
    function setup() public{
        address a = 0x001;
        user_addresses.push(a);
        user_map[a] = User("Sebas", "1234", 110, a);
    }
    
    function createNewUser(string name, string password) public returns(bool){
        if(!hasUser(name)){
            address addr = address(keccak256(abi.encodePacked(now)));
            user_addresses.push(addr);
            user_map[addr] = User(name, password, 0, addr);
            return true;
        }
        return false;
    }
    
    //Returns the number of registered users
    function getNumberOfUsers() public view returns(uint){
        return user_addresses.length;
    }
    
    //Returns the balance of the address
    function getBalance(address addr) public view returns(uint){
        return user_map[addr].bal;
    }
    
    //Finds the address of the user from name
    function getAddressOfUser(string name) public view returns(bool, address){
        for(uint i = 0; i < user_addresses.length; i++){
            string memory u_name = user_map[user_addresses[i]].name;  
            if(keccak256(abi.encodePacked(u_name)) == keccak256(abi.encodePacked(name))){
                return (true, user_map[user_addresses[i]].addr);
            }
        }
        return (false, 0x00);
    }
    
    //Removes funds from account with address, returns bool to indicate success
    function withdrawFunds(address addr, uint funds) public returns(bool, string){
        if(hasUser(addr)){
            User memory user = user_map[addr];
            if(user.bal >= funds){
                user_map[addr].bal -= funds;
                return (true, "Withdrew funds");
            }else{
                return (false, "Not sufficient funds");
            }
        }
        return (false, "No such user");
    }
    
    //Removes funds from account with address, returns bool to indicate success
    function depositFunds(address addr, uint funds) public returns(bool, string){
        if(hasUser(addr)){
            user_map[addr].bal += funds;
            return (true, "Deposited funds");
        }
        return (false, "No such user");
    }
    
    //Transfers funds from one address to another, returns bool to indicate success
    function transferFunds(address fromAddr, address toAddr, uint funds) public returns(bool){
        if((hasUser(toAddr) && hasUser(fromAddr)) && getBalance(fromAddr) >= funds){
            user_map[toAddr].bal += funds;
            user_map[fromAddr].bal -= funds;
            return true;
        }
        return false;
    }
    
    //Returns bool indicating the existence of the user by name
    function hasUser(string name) public view returns(bool){
        bool foundUser = false;
        for(uint i = 0; i < getNumberOfUsers(); i++){ //Can overflow, and does not say so if using <=..
            if(keccak256(abi.encodePacked(user_map[user_addresses[i]].name)) == keccak256(abi.encodePacked(name))){
                foundUser = true;
            }
        }
        return foundUser;
    }
    
    //Returns bool indicating the existence of the user by address
    function hasUser(address addr) public view returns(bool){
        for(uint i = 0; i < getNumberOfUsers(); i++){ //Can overflow, and does not say so if using <=..
            address u_addr = user_map[user_addresses[i]].addr;
            if(u_addr == addr){
                return true;
            }
        }
        return false;
    }
    
}
