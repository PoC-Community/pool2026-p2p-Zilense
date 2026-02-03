// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ProfileSystem{

error UserAlreadyExists();
error EmptyUsername();
error UserNotRegistered();

modifier onlyRegistered() {
    if (profiles[msg.sender].level == 0) {
        revert UserNotRegistered();
    }
    _;
}

// Struct to group related data
enum RoleEnum { GUEST, USER, ADMIN }

struct User {
    string username;
    uint256  level;
    RoleEnum role;
    uint256 lastUpdated;
}

// Mapping to store per-address data
mapping(address => User) public profiles;

function createProfile(string calldata _name) external {
    if (bytes(_name).length == 0) {
    revert EmptyUsername();
    }

        if (profiles[msg.sender].level != 0){
        revert UserAlreadyExists();
    }

    uint256 currentTime = block.timestamp;

    profiles[msg.sender]= User({
        username: _name,
        level: 1,
        role: RoleEnum.USER,
        lastUpdated: currentTime
    });
}

function levelUp() external onlyRegistered {
    profiles[msg.sender].level++;
    profiles[msg.sender].lastUpdated = block.timestamp;
}


}