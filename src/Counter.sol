// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { ICounter, BigStruct } from './ICounter.sol';
import { BigModule } from './BigModule.sol';


contract Counter is ICounter {
    uint256 public val;

    function set(uint256 newVal) public {
        val = newVal;
    }

    function get()
        external
        view
        returns (uint)
    {
        return val;
    }

    function const() external pure returns (uint256) {
        return 18;
    }

    function complex(BigStruct[] memory data) external pure  {
    }
}
