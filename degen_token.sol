// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    // Mapping to store token balances of players.
    mapping(address => uint256) public playerBalances;

    constructor() ERC20("Degen Gaming Token", "DGN") Ownable(msg.sender) {}

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
    function redeemTokens(uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        require(playerBalances[msg.sender] >= amount, "Insufficient balance");
        playerBalances[msg.sender] -= amount;
        // Add redemption logic here (e.g., granting in-game items).
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
}
