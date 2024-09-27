// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Assessment is ERC20 {
    address public owner;
    string[] public redeemableItems;
    mapping(uint256 => uint256) public itemCosts;
    mapping(address => mapping(uint256 => bool)) public itemRedeemed;

    // Event to log item redemption
    event ItemRedeemed(address indexed user, uint256 indexed itemId, uint256 cost);

    constructor() ERC20("Anshuman Roshan", "AR") {
        owner = msg.sender;
        
        // Initialize redeemable items
        redeemableItems.push("Item 1");
        redeemableItems.push("Item 2");
        redeemableItems.push("Item 3");
        redeemableItems.push("Item 4");

        // Set costs for each item
        itemCosts[0] = 100; // Example cost for Item 1
        itemCosts[1] = 200; // Example cost for Item 2
        itemCosts[2] = 300; // Example cost for Item 3
        itemCosts[3] = 400; // Example cost for Item 4
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    function mint(address to, uint256 value) public onlyOwner {
        require(to != address(0), "Invalid address");
        require(value > 0, "Invalid value");
        _mint(to, value);
    }

    function transfer(address to, uint256 value) public override returns (bool) {
        require(to != address(0), "Invalid address");
        require(value > 0, "Invalid value");
        return super.transfer(to, value);
    }

    function redeem(uint256 itemId) public {
        require(itemId < redeemableItems.length, "Item does not exist");
        uint256 cost = itemCosts[itemId];
        require(balanceOf(msg.sender) >= cost, "Insufficient balance");
        require(!itemRedeemed[msg.sender][itemId], "Item already redeemed");

        // Burn tokens as payment for the redeemed item
        _burn(msg.sender, cost);
        
        // Mark item as redeemed for the user
        itemRedeemed[msg.sender][itemId] = true;

        // Emit an event for the redemption
        emit ItemRedeemed(msg.sender, itemId, cost);
    }

    function getRedeemedItems(address user) public view returns (bool[] memory) {
        bool[] memory redeemed = new bool[](redeemableItems.length);
        for (uint256 i = 0; i < redeemableItems.length; i++) {
            redeemed[i] = itemRedeemed[user][i];
        }
        return redeemed;
    }

    function burn(uint256 value) public {
        require(value > 0, "Invalid value");
        require(value <= balanceOf(msg.sender), "Insufficient balance");
        _burn(msg.sender, value);
    }
}
// hridaya madaan phri2898@gmail.com 
