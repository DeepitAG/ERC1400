pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/GSN/GSNRecipientSignature.sol";

import "./ERC1400.sol";

/**
 * @title SwissGoldToken
 * At least the following custom requirements shall be satisfied:
 * 1) the token shall be compatible with ERC20
 * 2) the token shall be mintable and burnable by the enabled operators
 * 3) the token shall allow the enabled operators to force transfers for legal action or fund recovery, emitting specific events for tracing)
 * 4) the token shall allow the enabled operators to prevent transfers for complicance reasons, emitting specific events for tracing
 * 5) the token shall allow the enabled operators to attach metadata to partitions of token holder's balance as per regulatory restrictions
 * 6) the token shall implement the Gas Station Network (GSN) protocol to be meta-transaction ready
 * @dev The base contract is Consensys' ERC1400 implementation which satifies:
 * 1) by design
 * 2) issue/issueByPartition/redeemFrom/operatorRedeemByPartition functions
 * 3) transferWithData/transferFromWithData/operatorTransferByPartition functions
 * 4) ERC1400TokensValidator checks (whitelist/blacklist)
 * 5) setDocument/getDocument function to query/attach documents (name can be partition)
 * Bonus:
 * + IERC1400TokensSender/IERC1400TokensRecipient interface hooks as ERC777-like extensions
 * @dev In order to satisfy requirement 6) the following changes have been made for GSN support:
 * - upgrade to OpenZeppelin 2.5.1
 * - add Context as base contract for ERC1400
 * - replace usage of msg.sender with _msgSender()
 */
contract SwissGoldToken is ERC1400, GSNRecipientSignature {

  /**
   * @dev Initialize ERC1400 + GSNRecipientSignature.
   * @param name the name of the token
   * @param symbol the symbol of the token
   * @param granularity the granularity (i.e. minimum transferable part) of the token
   * @param controllers the array of initial token controllers
   * @param defaultPartitions the partitions chosen by default, when partition is not specified, like the case ERC20 transfers
   * @param trustedSigner the trusted signer that will produce signatures to approve GSN relayed calls
   */
  constructor(
    string memory name,
    string memory symbol,
    uint256 granularity,
    address[] memory controllers,
    bytes32[] memory defaultPartitions,
    address trustedSigner
  )
  ERC1400(name, symbol, granularity, controllers, defaultPartitions)
  GSNRecipientSignature(trustedSigner)
  public {
  }
}