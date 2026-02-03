// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ProfileSystem{

error UserAlreadyExists();
error EmptyUsername();
error UserNotRegistered();

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


}