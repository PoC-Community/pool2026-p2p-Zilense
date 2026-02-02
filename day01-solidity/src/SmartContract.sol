// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SmartContract {
    // Public Variables : 
    uint256 public halfAnswerOfLife = 21;
    address public myEthereumContractAddress = address(this);
    address public myEthereumAddress = msg.sender;
    string public poCIsWhat = "PoC is good, PoC is life.";
    bytes32 public whoIsTheBest;
    mapping(string => uint256) public myGrades;
    string[5] public myPhoneNumber;

    // Internal variable :
    bool internal _areYouABadPerson = false;

    // Private Variable : 
    int256 private _youAreACheater = -42;


enum roleEnum { STUDENT, TEACHER }

struct Information {
    string firstname;
    string lastName;
    uint8 age;
    string city;
    roleEnum role;   
}

Information public myInformations = Information({
    firstname: "PoC",
    lastName: "PoCIs",
    age: 25,
    city: "Paris",
    role : roleEnum.STUDENT
});

//function
function getHalfAnswerOfLife() public view returns (uint256) {
    return halfAnswerOfLife;
}

function _getMyEthereumContractAddress() internal view returns (address) {
    return myEthereumAddress;
}

function getPoCIsWhat() external view returns (string memory) {
    return poCIsWhat;
}

function _setAreYouABadPerson(bool _value) internal {
    _areYouABadPerson = _value;
}
}
