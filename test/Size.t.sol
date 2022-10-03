// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/ICounter.sol";

import "../src/Counter.sol";
import "../src/ExternalLibrary.sol";
import "../src/StaticRouter.sol";

contract SizeTest is Test {
    Counter public counter;
    ExternalLibrary public lib;
    ICounter public staticRouter;
    CounterModule public counterModule;

    function setUp() public {
        lib = new ExternalLibrary();
        counter = new Counter();
        staticRouter = (ICounter)((address)(new StaticRouter()));
        counterModule = new CounterModule();
        console.log(address(counterModule));
    }

    function testCounter() public {
        counter.set(42);
        assertEq(counter.get(), 42);
    }

    function testLibrary() public {
        lib.set(42);
        assertEq(lib.get(), 42);
    }

    function testStaticRouter() public {
        staticRouter.set(42);
        assertEq(staticRouter.get(), 42);
    }
}
