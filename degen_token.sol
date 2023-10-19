// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    // Mapping to store token balances of players.
    mapping(address => uint256) public playerBalances;

    // Define a struct to represent prizes
    struct Prize {
        string name;
        uint256 cost;
        // Add other properties specific to the prize
    }

    // Mapping to store available prizes
    mapping(string => Prize) public prizes;

    constructor() ERC20("Degen Gaming Token", "DGN") Ownable(msg.sender) {
        // Define and add your prizes in the constructor
        prizes["Prize1"] = Prize("Prize 1", 100);  // Example prize with a cost of 100 tokens
        prizes["Prize2"] = Prize("Prize 2", 200);  // Example prize with a cost of 200 tokens
        // Add more prizes as needed
    }

    // Mint new tokens and distribute them to players as rewards.
    function mint(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "Invalid address");
        require(amount > 0, "Amount must be greater than zero");
        _mint(to, amount);
        playerBalances[to] += amount;
    }

    // Players can transfer their tokens to others.
    function transferTokens(address to, uint256 amount) public {
        require(to != address(0), "Invalid address");
        require(amount > 0, "Amount must be greater than zero");
        require(playerBalances[msg.sender] >= amount, "Insufficient balance");
        playerBalances[msg.sender] -= amount;
        playerBalances[to] += amount;
        _transfer(msg.sender, to, amount);
    }

    // Players can redeem their tokens for in-game store items.
    function redeemTokens(uint256 amount, string memory prizeSelection) public {
        require(amount > 0, "Amount must be greater than zero");
        require(playerBalances[msg.sender] >= amount, "Insufficient balance");

        // Check if the selected prize exists
        require(prizes[prizeSelection].cost > 0, "Invalid prize selection");

        // Check if the user has enough tokens to redeem the selected prize
        require(amount >= prizes[prizeSelection].cost, "Insufficient tokens for this prize");

        // Implement the redemption logic here:
        // For example, you can grant the user the selected prize (e.g., in-game items, NFTs, or other rewards).
        // The specific logic for awarding prizes may vary depending on your use case.

        // Deduct the cost of the prize from the user's balance
        playerBalances[msg.sender] -= prizes[prizeSelection].cost;

        // Emit an event to log the redemption event
        emit Redemption(msg.sender, prizeSelection);
    }

    // Check the token balance of the player.
    function checkBalance() public view returns (uint256) {
        return playerBalances[msg.sender];
    }

    // Anyone can burn tokens they own.
    function burnTokens(uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        require(playerBalances[msg.sender] >= amount, "Insufficient balance");
        playerBalances[msg.sender] -= amount;
        _burn(msg.sender, amount);
    }

    event Redemption(address indexed user, string prizeSelection);
}
