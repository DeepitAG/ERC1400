pragma solidity ^0.5.0;

import "../SwissGoldToken.sol";

contract SwissGoldTokenGSNRecipientSignatureMock is SwissGoldToken {
    constructor(
        string memory name,
        string memory symbol,
        uint256 granularity,
        address[] memory controllers,
        bytes32[] memory defaultPartitions,
        address trustedSigner
    )
    SwissGoldToken(name, symbol, granularity, controllers, defaultPartitions, trustedSigner)
    public {}

    event MockFunctionCalled();

    function mockFunction() public {
        emit MockFunctionCalled();
    }
}