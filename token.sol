// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/IERC20Metadata.sol";

contract ERC20Token is IERC20Metadata {

    string private _name;
    string private _symbol;
    uint private _decimals;

    constructor(string memory name_, string memory symbol_, uint decimals_, uint256 totalSupply_){
        _name = name_;
        _symbol = symbol_;
    }

    function name() external override view returns (string memory) {
        return _name
    }
}