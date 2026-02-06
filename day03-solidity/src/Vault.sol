// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";
import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";   


contract Vault is ReentrancyGuard, Ownable{
    using SafeERC20 for IERC20;
    IERC20 immutable public  asset;
    uint256 public totalShares;
    mapping(address => uint256) public sharesOf;
    event Deposit(address indexed user, uint256 assets, uint256 shares);
    event Withdraw(address indexed user, uint256 assets, uint256 shares);
    event RewardAdded(uint256 amount);

    constructor(address asset_) Ownable(msg.sender){
        asset = IERC20(asset_);
    }

    function _convertToShares(uint256 assets) internal view returns (uint256){
        uint256 vaultBalance = asset.balanceOf(address(this));
        if (totalShares == 0) {
        return assets;
        }
        return (assets * totalShares) / vaultBalance;
    }

    function _convertToAssets(uint256 shares) internal view returns (uint256){
        uint256 vaultBalance = asset.balanceOf(address(this));
        if (totalShares == 0) {
        return shares;
        }
        return (shares * vaultBalance) / totalShares;
    }
  
    function deposit(uint256 assets) external nonReentrant returns (uint256 shares){
        require(assets>0);
        shares = _convertToShares(assets);
        require(shares >0);
        sharesOf[msg.sender] += shares;
        totalShares += shares;
        asset.safeTransferFrom(msg.sender,address(this), assets);
        emit Deposit(msg.sender, assets, shares);
        return shares;
    }

    function withdraw(uint256 shares) public nonReentrant returns (uint256 assets) {
        require(shares > 0);
        require(sharesOf[msg.sender] >= shares);
        assets = _convertToAssets(shares);
        require(assets>0);
        sharesOf[msg.sender] -= shares;
        totalShares -= shares;
        asset.safeTransfer(msg.sender, assets);
        emit Withdraw(msg.sender, assets, shares);
        return assets;
    }

    function withdrawAll() public returns (uint256 assets){
        return withdraw(sharesOf[msg.sender]);
    }

    function previewDeposit(uint256 assets) external view returns (uint256) {
        return _convertToShares(assets);
    }

    function previewWithdraw(uint256 shares) external view returns (uint256) {
        return _convertToAssets(shares);
    }

    function totalAssets() public view returns (uint256){
        return asset.balanceOf(address(this));
    }

    function currentRatio() external view returns (uint256){
        if (totalShares == 0){
        return 1e18;}
        return (totalAssets() * 1e18) / totalShares;
    }

    function assetsof(address user) external view returns (uint256) {
        uint256 usersShares = sharesOf[user];
        return _convertToAssets(usersShares);
    }

    function addReward(uint256 amount) external onlyOwner nonReentrant {
        require (amount > 0 );
        require (totalShares > 0);
        asset.safeTransferFrom(msg.sender, address(this), amount);
        emit RewardAdded(amount);
    }
}