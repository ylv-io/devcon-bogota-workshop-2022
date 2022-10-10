// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface ICounter {
    function set(uint256 newVal) external;
    function get() external view returns (uint) ;
}

