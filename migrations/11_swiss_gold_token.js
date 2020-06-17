const ERC1400TokensValidator = artifacts.require("./ERC1400TokensValidator.sol");
const SwissGoldToken = artifacts.require('./SwissGoldToken.sol');

const controller = '0xb5747835141b46f7C472393B31F8F5A57F74A44f';
const signer = '0xb5747835141b46f7C472393B31F8F5A57F74A44f'; // controller acting also as GSN trusted signer

const partition1 = '0x7265736572766564000000000000000000000000000000000000000000000000'; // reserved in hex
const partition2 = '0x6973737565640000000000000000000000000000000000000000000000000000'; // issued in hex
const partition3 = '0x6c6f636b65640000000000000000000000000000000000000000000000000000'; // locked in hex
const partitions = [partition1, partition2, partition3];

const ERC1400_TOKENS_VALIDATOR = 'ERC1400TokensValidator';

module.exports = async function (deployer, network, accounts) {
  await deployer.deploy(SwissGoldToken, 'Swiss gold token', 'SGT', 1, [controller], partitions, signer);
  console.log('\n   > SwissGoldToken deployment: Success -->', SwissGoldToken.address);
  await deployer.deploy(ERC1400TokensValidator, true, false);
  console.log('\n   > ERC1400TokensValidator deployment: Success -->', ERC1400TokensValidator.address);
  await (await SwissGoldToken.deployed()).setHookContract(ERC1400TokensValidator.address, ERC1400_TOKENS_VALIDATOR);
  console.log('\n   > Token connection to validator: Success');
};
