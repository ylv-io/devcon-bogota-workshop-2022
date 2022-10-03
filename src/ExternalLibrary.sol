// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { ICounter } from './ICounter.sol';

import { Data } from './Data.sol';
import { Fat } from './Fat.sol';


library Storage {
    // Note that the first parameter is of type "storage
    // reference" and thus only its storage address and not
    // its contents is passed as part of the call.  This is a
    // special feature of library functions.  It is idiomatic
    // to call the first parameter `self`, if the function can
    // be seen as a method of that object.
    function set(Data storage self, uint value)
        external
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


contract ExternalLibrary is Fat, ICounter {
    Data private data;

    function set(uint value) public {
        // The library functions can be called without a
        // specific instance of the library, since the
        // "instance" will be the current contract.
        Storage.set(data, value);
    }

    function get() external view returns (uint) {
        return Storage.get(data);
    }

    // In this contract, we can also directly access data.flags, if we want.

    // Uncomment these functions to see that there is not enough space for them
    // in this contract
}
