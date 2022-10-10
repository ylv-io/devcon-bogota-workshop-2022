// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { ICounter } from './ICounter.sol';

import { Data } from './Data.sol';
import { BigModule } from './BigModule.sol';


contract ExternalLibraryCounter is ICounter {
    Data private data;

    function set(uint value) public {
        // The library functions can be called without a
        // specific instance of the library, since the
        // "instance" will be the current contract.
        StorageLib.set(data, value);
    }

    function get() public view returns (uint) {
        return StorageLib.get(data);
    }

    function quote() public pure returns (string memory) {
        return QuoteLib.quote();
    }

    function const() external pure returns (uint256) {
        return StorageLib.const();
    } 
    // In this contract, we can also directly access data.flags, if we want.
}

library StorageLib {
    function set(Data storage self, uint value)
        public
    {
        self.counter = value;
    }

    function get(Data storage self)
        public
        view
        returns (uint)
    {
        return self.counter;
    }

    function const() external pure returns (uint256) {
        return 18;
    } 
}


library QuoteLib {

    function quote() external pure returns (string memory) {
        return '640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.640K software is all the memory anybody would ever need on a computer.';
    }
}


