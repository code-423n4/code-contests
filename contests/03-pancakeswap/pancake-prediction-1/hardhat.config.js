require("@nomiclabs/hardhat-truffle5");
require("@nomiclabs/hardhat-ethers");
require("hardhat-abi-exporter");
require("hardhat-contract-sizer");
require("solidity-coverage");

// This is a sample Buidler task. To learn how to create your own go to
// https://buidler.dev/guides/create-task.html
task("accounts", "Prints the list of accounts", async () => {
  const accounts = await ethers.getSigners();

  for (const account of accounts) {
    console.log(await account.getAddress());
  }
});

// You have to export an object to set up your config
// This object can have the following optional entries:
// defaultNetwork, networks, solc, and paths.
// Go to https://buidler.dev/config/ to learn more
module.exports = {
  // This is a sample solc configuration that specifies which version of solc to use
  solidity: {
    version: "0.6.12", // version is higher than 0.6.0 to allow compiling all OpenZeppelin dependencies
    settings: {
      optimizer: {
        enabled: true,
        runs: 1000,
      },
    },
  },
  networks: {
    hardhat: {
      gas: 9500000,
    },
    development: {
      url: "http://127.0.0.1:7545",
      port: 7545,
      network_id: "101",
    },
    testnet: {
      url: "https://data-seed-prebsc-1-s1.binance.org:8545/",
      chainId: 97,
      // accounts: [process.env.PK],
    },
    mainnet: {
      url: "https://bsc-dataseed.binance.org",
      chainId: 56,
      // accounts: [process.env.PK],
    },
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts",
  },
};
