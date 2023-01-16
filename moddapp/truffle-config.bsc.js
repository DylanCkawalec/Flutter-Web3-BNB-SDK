const HDWalletProvider = require('@truffle/hdwallet-provider');
require('dotenv').config();
const mnemonic = process.env["MNEMONIC"].toString().trim();
module.exports = {
  contracts_build_directory: './build/bsc-contracts',
  contracts_directory: './contracts/bsc',
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*"
    },
    bscTestnet: {
      provider: () => new HDWalletProvider(mnemonic, `https://data-seed-prebsc-2-s1.binance.org:8545/`),
      network_id: 97,
      confirmations: 10,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    bscMainnet: {
      provider: () => new HDWalletProvider(mnemonic, `https://bsc-dataseed.binance.org/`),
      network_id: 56,
      confirmations: 10,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    loc_development_development: {
      network_id: "*",
      port: 8545,
      host: "127.0.0.1"
    }
  },
  mocha: {},
  compilers: {
    solc: {
      version: "0.8.4"
    }
  },
  db: {
    enabled: true
  }
};
