// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

struct BigStruct {
    uint256 val;
    string title;
    bool flag;
}

interface ICounter {
    function set(uint256 newVal) external;
    function get() external view returns (uint);
    function const() external pure returns (uint);
    function complex(BigStruct[] memory data) external pure;
}

