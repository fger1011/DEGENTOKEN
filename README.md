# Degen Token
This smart contract, named "DegenToken," is an Ethereum-based ERC20 token contract designed for Degen Gaming. 
## Getting Started
### Executing Program
Remix is an online Solidity IDE that you may use to run this application. To get started, go to https://remix.ethereum.org/.
When you are on the Remix website, click the "+" icon in the left sidebar to start a new file. The file should be saved with a.sol extension (such as MyToken.sol). The code below should be copied and pasted into the file:

```solidity
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


```


**Set the Avalanche Network in Remix:**

Open Remix IDE (https://remix.ethereum.org/).
In the Remix IDE, click on the "Settings" tab (the gear icon on the top right).
In the "Plugin Manager" section, search for "Avalanche" and enable the Avalanche plugin.

**Create Your Smart Contract:**
Create or paste the Solidity code for your smart contract into a new file in the Remix IDE.

**Select the Avalanche Network:**
In the Remix IDE, go to the "Plugin Manager" (bottom left corner) and make sure the Avalanche plugin is enabled.

**Connect Your Avalanche Wallet:**
In the Remix IDE, go to the "Deploy & Run Transactions" tab on the left sidebar.
Under the "Environment" dropdown, select "Avalanche - Snowtrace C-Chain."
Note: Make sure that your MetaMask wallet is configured to work with the Avalanche network. If you haven't done this already, you need to set up Avalanche on your MetaMask account. You can find instructions on how to do this in MetaMask's documentation.

**Compile Your Contract:**
In the "Solidity Compiler" tab, select the appropriate Solidity version for your contract, and then click the "Compile" button.

**Deploy Your Contract:**
In the "Deploy & Run Transactions" tab, select your contract from the dropdown.
Fill in any required parameters for the constructor (if your contract has any) and click the "Deploy" button.
MetaMask will open, prompting you to confirm the deployment transaction. Make sure you have enough AVAX in your MetaMask wallet to cover the gas fees.

**Interact with Your Contract:**
After your contract is deployed, you can interact with it using the provided functions in the "Deployed Contracts" section.

**View Transactions and Logs:**
You can also view transaction details and logs by selecting the transaction in the "Transactions" tab on the right sidebar.
## Authors
Metacrafter Franco
