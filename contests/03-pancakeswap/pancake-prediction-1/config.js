module.exports = {
  Oracle: { // Chainlink
    mainnet: '0x0567F2323251f0Aab15c8dFb1967E4e8A7D42aeE', 
    testnet: '0x2514895c72f50D8bd4B4F9b1110F0D6bD2c97526', 
  },
  Admin: { // TODO: Change
    mainnet: '0x0000000000000000000000000000000000000000',
    testnet: '0x0000000000000000000000000000000000000000',
  },
  Operator: { // TODO: Change
    mainnet: '0x0000000000000000000000000000000000000000',
    testnet: '0x0000000000000000000000000000000000000000',
  },
  IntervalBlocks: { // Blocks
    mainnet: 20,
    testnet: 20,
  },
  BufferBlocks: { // Blocks
    mainnet: 5,
    testnet: 5,
  },
  MinBetAmount: { // BNB
    mainnet: 0.01,
    testnet: 0.01,
  },
  OracleUpdateAllowance: { // seconds
    mainnet: 60,
    testnet: 60,
  },
};