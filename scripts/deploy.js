
const hre = require("hardhat");

async function main() {
  const MarketInteractions = await hre.ethers.getContractFactory("MarketInteractions");
  const marketInteractions = await MarketInteractions.deploy("0xc4dCB5126a3AfEd129BC3668Ea19285A9f56D15D");

  await marketInteractions.deployed();

  console.log("Market Interactions: ", marketInteractions.address);
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
