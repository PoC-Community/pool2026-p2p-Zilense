// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {PoolToken} from "../src/PoolToken.sol";

contract testmypooltoken is Test{
    PoolToken token;
    address owner;
    address user = address(0x123);
    uint256 INITIAL_SUPPLY = 1000 ether;


    function setUp() public {
    owner = address(this);
    token=new PoolToken(INITIAL_SUPPLY);
        }

    function testInitialSupply() public {
        assertEq(token.totalSupply(), INITIAL_SUPPLY);
        assertEq(token.balanceOf(owner), INITIAL_SUPPLY);
        }

    function testOnlyOwnerCanMint() public {
        vm.prank(user);
        vm.expectRevert();
        token.mint(user, 1000 ether);
        }
    }