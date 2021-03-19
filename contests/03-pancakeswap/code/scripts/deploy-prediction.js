const hre = require("hardhat");
const config = require('../config');
const { parseEther } = require("ethers/lib/utils");
const network = hre.network.name;

async function main() {
  if (network == 'mainnet' || network == 'testnet') {
    if (!process.env.PK) {
      throw new Error('Missing private key, refer to README \'Deployment\' section')
    }
    if (!config.Admin[network] || config.Admin[network] === '0x0000000000000000000000000000000000000000') {
      throw new Error('Missing admin address, refer to README \'Deployment\' section')
    }
  }

  console.log('Deploying to network:', network)

  let oracle, admin, operator, intervalBlocks, bufferBlocks, minBetAmount, oracleUpdateAllowance
  if (network == 'mainnet' || network == 'testnet') {
    oracle = config.Oracle[network]
    // wbnb = config.WBNB[network]
    admin = config.Admin[network]
    operator = config.Operator[network]
    intervalBlocks = config.IntervalBlocks[network]
    bufferBlocks = config.BufferBlocks[network]
    minBetAmount = config.MinBetAmount[network].toString()
    oracleUpdateAllowance = config.OracleUpdateAllowance[network]
  } else {
    console.log('Defaulting to testnet config')
    admin = config.Admin['testnet']
    operator = config.Operator['testnet']
    intervalBlocks = config.IntervalBlocks['testnet']
    bufferBlocks = config.BufferBlocks['testnet']
    minBetAmount = config.MinBetAmount['testnet'].toString()
    oracleUpdateAllowance = config.OracleUpdateAllowance['testnet']

    console.log('Deploying mocks')
    const OracleContract = await hre.ethers.getContractFactory('MockAggregatorV3')
    // const WbnbContract = await hre.ethers.getContractFactory('MockWbnb')
    oracle = await OracleContract.deploy(8, 100) // 8 decimals, $100 (8 decimals)
    // wbnb = await WbnbContract.deploy()
    oracle = oracle.address
    // wbnb = wbnb.address
    console.log("Oracle deployed to:", oracle);
    // console.log("Wbnb deployed to:", wbnb);
  }

  console.log('Deploying prediction')
  const BnbPricePrediction = await hre.ethers.getContractFactory('BnbPricePrediction');
  const prediction = await BnbPricePrediction.deploy(
    oracle,
    admin,
    operator,
    intervalBlocks,
    bufferBlocks,
    parseEther(minBetAmount),
    oracleUpdateAllowance,
  )
  console.log("BnbPricePrediction deployed to:", prediction.address);
  
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
