pragma solidity ^0.5.0;

import "../ERC1400.sol";

contract ERC1400ContextMock is ERC1400 {
    constructor(
        string memory name,
        string memory symbol,
        uint256 granularity,
        address[] memory controllers,
        bytes32[] memory defaultPartitions
    )
    ERC1400(name, symbol, granularity, controllers, defaultPartitions)
    public {}

    event Sender(address sender);

    function msgSender() public {
        emit Sender(_msgSender());
    }

    event Data(bytes data, uint256 integerValue, string stringValue);

    function msgData(uint256 integerValue, string memory stringValue) public {
        emit Data(_msgData(), integerValue, stringValue);
    }
}

contract ERC1400ContextMockCaller {
    function callSender(ERC1400ContextMock context) public {
        context.msgSender();
    }

    function callData(ERC1400ContextMock context, uint256 integerValue, string memory stringValue) public {
        context.msgData(integerValue, stringValue);
    }
}