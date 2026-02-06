// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Vault} from "../../src/Vault.sol";
import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract MockToken is ERC20 {
    constructor()ERC20("MyToken", "MTK") {}
    function mint(address to, uint256 amount) public{
        _mint(to,amount);   
    }
}

contract myVaultTest is Test {
    Vault public vault;
    MockToken public asset;
    address public alice = address(0x2);
    address public owner = address(0x1);
    
    function setUp() public {
        vm.startPrank(owner); 
        asset = new MockToken();
        vault = new Vault(address(asset));
        asset.mint(owner,100);
        asset.approve(address(vault), 100);
        vm.stopPrank();

        asset.mint(alice, 1000);
        vm.prank(alice);
        asset.approve(address(vault), 1000);
        }

    function testReward() public {
        vm.prank(alice);
        vault.deposit(1000);
        assertEq(vault.sharesOf(alice),1000);

        vm.prank(owner);
        vault.addReward(100);
        assertEq(vault.currentRatio(), 1.1e18);

        vm.prank(alice);
        vault.withdrawAll();
        assertEq(asset.balanceOf(alice), 1100);
    }


}