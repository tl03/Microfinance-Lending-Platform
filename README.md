💰 Microfinance Lending Platform

A decentralized microfinance platform that enables transparent, peer-to-peer lending and borrowing using blockchain technology. It leverages smart contracts to ensure trustless transactions, automate loan management, and provide financial access to unbanked or underserved individuals.

🌍 Overview

Traditional microfinance systems often suffer from centralized control, high intermediator costs, and limited transparency.
This project solves those challenges by creating a Web3-powered lending ecosystem that:

Connects lenders and borrowers directly

Uses smart contracts for loan disbursement and repayment

Tracks all transactions transparently on-chain

Enables community-driven credit assessment

🧩 Features

🏦 Decentralized Lending & Borrowing – Peer-to-peer system with no central authority

🔐 Smart Contract Automation – Handles loan creation, collateral, and repayments securely

💳 Tokenized Collateral System – Borrowers lock assets to receive microloans

📈 Dynamic Interest Rates – Set by protocol or community governance

🌐 Transparent Record-Keeping – Every transaction is visible on the blockchain

🧠 Scalable Architecture – Easily extendable for additional loan types or tokens

🛠️ Tech Stack
Layer	Technology
Smart Contracts	Solidity
Blockchain	Ethereum / Polygon / Sepolia (for testing)
Framework	Hardhat / Foundry
Frontend	React.js / Next.js
Web3 Interaction	Ethers.js
Storage	IPFS / Pinata (for metadata or borrower info)
Deployment	Hardhat + Alchemy / Infura RPC
⚙️ Installation & Setup
1️⃣ Clone the Repository
git clone https://github.com/<your-username>/Microfinance-Lending-Platform.git
cd Microfinance-Lending-Platform

2️⃣ Install Dependencies
npm install

3️⃣ Configure Environment Variables

Create a .env file in the project root:

PRIVATE_KEY=<your_wallet_private_key>
RPC_URL=<your_network_rpc_url>
CONTRACT_ADDRESS=<deployed_contract_address>

4️⃣ Compile Smart Contracts
npx hardhat compile

5️⃣ Deploy Contracts
npx hardhat run scripts/deploy.js --network sepolia

📜 Example Smart Contract (Simplified)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract MicrofinanceLending {
    struct Loan {
        address borrower;
        address lender;
        uint256 amount;
        uint256 interest;
        uint256 duration;
        bool repaid;
    }

    Loan[] public loans;

    function requestLoan(uint256 amount, uint256 interest, uint256 duration) public {
        loans.push(Loan(msg.sender, address(0), amount, interest, duration, false));
    }

    function fundLoan(uint256 loanId) public payable {
        Loan storage loan = loans[loanId];
        require(msg.value == loan.amount, "Incorrect loan amount");
        loan.lender = msg.sender;
        payable(loan.borrower).transfer(loan.amount);
    }

    function repayLoan(uint256 loanId) public payable {
        Loan storage loan = loans[loanId];
        require(msg.sender == loan.borrower, "Only borrower can repay");
        require(!loan.repaid, "Already repaid");
        uint256 repayment = loan.amount + (loan.amount * loan.interest / 100);
        require(msg.value == repayment, "Incorrect repayment");
        loan.repaid = true;
        payable(loan.lender).transfer(msg.value);
    }
}

🧪 Testing

Run smart contract tests using Hardhat:

npx hardhat test

🖥️ Frontend

Connect wallet using MetaMask

Borrowers can request loans by specifying amount, duration, and interest

Lenders can fund available loan requests directly from the dashboard

Loan repayment automatically updates the contract’s state

🌐 Deployment

Deployed on testnet (example):
🔗 Contract on Sepolia Etherscan

💻 Frontend Demo

🔮 Future Enhancements

🧾 Credit scoring using on-chain history

🪙 Governance token for community-driven interest rates

📱 Mobile-friendly dApp interface

🧩 Integration with stablecoins (USDC, DAI)

🧠 AI-based risk assessment

📜 License

This project is licensed under the MIT License – free to use, modify, and distribute.

🔗 GitHub : https://github.com/tl03/Microfinance-Lending-Platform
## Contract details
0xfa1472011568C3580C547848F4C2fD2E561d87db
<img width="1801" height="766" alt="image" src="https://github.com/user-attachments/assets/73461fdb-f41e-4f32-ac40-69a8ebf738db" />


