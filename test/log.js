// scripts/log.js

const hre = require("hardhat");
const { ethers } = hre;

async function main() {
  // ⚠️ Replaced with deployed contract address
  const contractAddress = "YOUR_DEPLOYED_CONTRACT_ADDRESS_HERE";

  const MicrofinanceLendingPlatform = await ethers.getContractFactory("MicrofinanceLendingPlatform");
  const platform = MicrofinanceLendingPlatform.attach(contractAddress);

  console.log("🔍 Listening for MicrofinanceLendingPlatform events...");
  console.log(`📄 Contract Address: ${contractAddress}`);
  console.log(`⛽ Network: ${hre.network.name}`);
  console.log("--------------------------------------------");

  // Event : Loan Requested
  platform.on("LoanRequested", (id, borrower, amount, interestRate, duration) => {
    console.log("📋 Loan Requested:");
    console.log(`🆔 ID: ${id}`);
    console.log(`👤 Borrower: ${borrower}`);
    console.log(`💰 Amount: ${ethers.formatEther(amount)} ETH`);
    console.log(`📈 Interest Rate: ${interestRate}%`);
    console.log(`⏱ Duration: ${duration} sec`);
    console.log("--------------------------------------------");
  });

  // Event: Loan Funded
  platform.on("LoanFunded", (id, lender, amount) => {
    console.log("🏦 Loan Funded:");
    console.log(`🆔 ID: ${id}`);
    console.log(`👤 Lender: ${lender}`);
    console.log(`💰 Amount: ${ethers.formatEther(amount)} ETH`);
    console.log("--------------------------------------------");
  });

  // Event: Loan Repaid
  platform.on("LoanRepaid", (id, borrower, totalAmount) => {
    console.log("✅ Loan Repaid:");
    console.log(`🆔 ID: ${id}`);
    console.log(`👤 Borrower: ${borrower}`);
    console.log(`💵 Total Repaid: ${ethers.formatEther(totalAmount)} ETH`);
    console.log("--------------------------------------------");
  });

  // Event: Owner Changed
  platform.on("OwnerChanged", (oldOwner, newOwner) => {
    console.log("⚙️ Owner Changed:");
    console.log(`👤 Old Owner: ${oldOwner}`);
    console.log(`👑 New Owner: ${newOwner}`);
    console.log("--------------------------------------------");
  });

  // Keep script running indefinitely
  process.stdin.resume();
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});


