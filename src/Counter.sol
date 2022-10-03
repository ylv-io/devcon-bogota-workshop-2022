// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { ICounter } from './ICounter.sol';

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
}
