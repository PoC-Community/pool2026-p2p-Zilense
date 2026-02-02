// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {SmartContract} from "../src/SmartContract.sol";

contract SmartContractHelper is SmartContract {
    function getAreYouABadPerson() public view returns (bool) {
        return _areYouABadPerson;
    }
}

contract SmartContractTest is Test {
    SmartContractHelper public myContract;

    function setUp() public {
        myContract = new SmartContractHelper();
    }

    function testHalfAnswerOfLife() public view {
        assertEq(myContract.getHalfAnswerOfLife(), 21);
    }

    function testAreYouABadPerson() public view {
        assertEq(myContract.getAreYouABadPerson(), false);
    }

    function testStructData() public view {
        (
            string memory firstName, 
            string memory lastName, 
            uint8 age, 
            string memory city, 
            SmartContract.roleEnum role
        ) = myContract.myInformations();

        assertEq(firstName, "PoC");
        assertEq(lastName, "PoCIs");
        assertEq(age, 25);
        assertEq(city, "Paris");
        assertTrue(role == SmartContract.roleEnum.STUDENT);
    }
}