// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { ICounter } from './ICounter.sol';

import { Data } from './Data.sol';
import { BigModule } from './BigModule.sol';


library Storage {
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
}


contract ExternalLibrary is BigModule, ICounter {
    Data private data;

    function set(uint value) public {
        // The library functions can be called without a
        // specific instance of the library, since the
        // "instance" will be the current contract.
        Storage.set(data, value);
    }

    function get() public view returns (uint) {
        return Storage.get(data);
    }

    // In this contract, we can also directly access data.flags, if we want.

    // Uncomment these functions to see that there is not enough space for them
    // in this contract
}
