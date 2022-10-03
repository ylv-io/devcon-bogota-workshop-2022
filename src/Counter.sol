// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
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
