// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Library.sol";

contract LibraryTest is Test {
    ExternalLibrary public lib;

    function setUp() public {
        lib = new ExternalLibrary();
    }

    function testRegister() public {
        lib.set(42);
        assertEq(lib.get(), 42);
    }
}
