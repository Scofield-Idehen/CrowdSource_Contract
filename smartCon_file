//SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract SimpleStorage {

    //this will get initialized to 0!
    uint256 favoriteNumber;
    bool favoriteBool;


    //struture helps you understand where the name and calling the string 
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    People[] public people;
    //mapping helps you keep track of a name and its number 
    mapping(string => uint256) public nametofavoriteNumber;


    //variable of number to an integer 
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }
    //view, read the state of the blockchain
    function retrive() public view returns(uint256) {
        return favoriteNumber;
    }
// push creates a value for each user and its value 
function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
        nametofavoriteNumber[_name] = _favoriteNumber;
    }

}
