// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Fat } from './Fat.sol';

// We define a new struct datatype that will be used to
// hold its data in the calling contract.
struct Data {
    mapping(uint => bool) flags;
}

library Set {
    // Note that the first parameter is of type "storage
    // reference" and thus only its storage address and not
    // its contents is passed as part of the call.  This is a
    // special feature of library functions.  It is idiomatic
    // to call the first parameter `self`, if the function can
    // be seen as a method of that object.
    function insert(Data storage self, uint value)
        public
        returns (bool)
    {
        if (self.flags[value])
            return false; // already there
        self.flags[value] = true;
        return true;
    }

    function remove(Data storage self, uint value)
        public
        returns (bool)
    {
        if (!self.flags[value])
            return false; // not there
        self.flags[value] = false;
        return true;
    }

    function contains(Data storage self, uint value)
        public
        view
        returns (bool)
    {
        return self.flags[value];
    }
}


contract ExternalLibrary is Fat {
    Data private data;

    function register(uint value) public {
        // The library functions can be called without a
        // specific instance of the library, since the
        // "instance" will be the current contract.
        require(Set.insert(data, value));
    }
    // In this contract, we can also directly access data.flags, if we want.

    // Uncomment these functions to see that there is not enough space for them
    // in this contract
    //function insert(uint value)
    //    public
    //    returns (bool)
    //{
    //    if (data.flags[value])
    //        return false; // already there
    //    data.flags[value] = true;
    //    return true;
    //}

    //function remove(uint value)
    //    public
    //    returns (bool)
    //{
    //    if (!data.flags[value])
    //        return false; // not there
    //    data.flags[value] = false;
    //    return true;
    //}

    //function contains(uint value)
    //    public
    //    view
    //    returns (bool)
    //{
    //    return data.flags[value];
    //}
}
