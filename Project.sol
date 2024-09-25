// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "ERC20.sol";

contract Mtoken is ERC20 {
    address public owner;
    
    modifier onlyOwner { 
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        owner = msg.sender;
        // Mint 100 tokens to msg.sender
        _mint(msg.sender, 100 * (10 ** uint256(decimals())));
    }
    
    function transferTokens(address recipient, uint256 amount) external {
        _transfer(msg.sender, recipient, amount);
    }
    
    function burnTokens(uint256 amount) external {
        burn(msg.sender, amount);
    }
}
