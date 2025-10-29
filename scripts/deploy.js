// scripts/deploy.js

const hre = require("hardhat");

async function main() {
  await hre.run("compile");

  console.log("🚀 Deploying MicrofinanceLendingPlatform....");

  const MicrofinanceLendingPlatform = await hre.ethers.getContractFactory("MicrofinanceLendingPlatform");
  const platform = await MicrofinanceLendingPlatform.deploy();

  await platform.waitForDeployment();

  const deployer = await hre.ethers.provider.getSigner();
  const deployerAddress = await deployer.getAddress();

  console.log("✅ Deployment successful!");
  console.log(`📄 Contract: MicrofinanceLendingPlatform`);
  console.log(`📍 Address: ${await platform.getAddress()}`);
  console.log(`👤 Deployed by: ${deployerAddress}`);
  console.log(`⛽ Network: ${hre.network.name}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

