require('dotenv').config();
require('babel-register');
require('babel-polyfill');

const HDWalletProvider = require('truffle-hdwallet-provider');

const providerWithMnemonic = (mnemonic, rpcEndpoint) => () =>
  new HDWalletProvider(mnemonic, rpcEndpoint);

const infuraProvider = network => providerWithMnemonic(
  process.env.MNEMONIC || '',
  `https://${network}.infura.io/v3/${process.env.INFURA_API_KEY}`
);

const ropstenProvider = process.env.SOLIDITY_COVERAGE
  ? undefined
  : infuraProvider('ropsten');

module.exports = {
  networks: {
    develop: {
      host: 'localhost',
      port: 7545,
      network_id: 5777, // eslint-disable-line camelcase
      gas: 0xfffffffffff,
      gasPrice: 0x01,
    },
    development: {
      host: 'localhost',
      port: 7545,
      network_id: '*', // eslint-disable-line camelcase
      gas: 0xfffffffffff,
      gasPrice: 0x01,
    },
    ropsten: {
      provider: ropstenProvider,
      network_id: 3, // eslint-disable-line camelcase
      gasPrice: 5000000000,
    },
    coverage: {
      host: 'localhost',
      network_id: '*', // eslint-disable-line camelcase
      port: 8555,
      gas: 0xfffffffffff,
      gasPrice: 0x01,
    },
    ganache: {
      host: 'localhost',
      port: 7545,
      network_id: '*', // eslint-disable-line camelcase
    },
    dotEnvNetwork: {
      provider: providerWithMnemonic(
        process.env.MNEMONIC,
        process.env.RPC_ENDPOINT
      ),
      network_id: parseInt(process.env.NETWORK_ID) || '*', // eslint-disable-line camelcase
    },
  },
  plugins: ["solidity-coverage"],
  compilers: {
    solc: {
      version: '0.5.17',
      settings: {
        optimizer: {
          enabled: true, // Default: false
          runs: 0, // Default: 200
        },
      },
    },
  },
};
