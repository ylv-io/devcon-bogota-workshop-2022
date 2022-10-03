// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/ICounter.sol";

import "../src/Counter.sol";
import "../src/ExternalLibrary.sol";
import "../src/StaticRouter.sol";
import "../src/DynamicRouter.sol";

contract SizeTest is Test {
    Counter public counter;
    ExternalLibrary public lib;
    ICounter public staticRouter;
    CounterModule public counterModule;
    ICounter public dynamicRouter;

    function setUp() public {
        lib = new ExternalLibrary();
        counter = new Counter();
        counterModule = new CounterModule();
        staticRouter = (ICounter)((address)(new StaticRouter()));
        dynamicRouter = (ICounter)((address)(new DynamicRouter()));
        // set the counter module on dynamic router
        // boy, this is ugly
        bytes4[] memory selectors = new bytes4[](2);
        selectors[0] = ICounter.get.selector;
        selectors[1] = ICounter.set.selector;
        ModuleDefinition[] memory modules = new ModuleDefinition[](1);
        modules[0] = ModuleDefinition({implementation: address(counterModule), selectors: selectors });
        DynamicRouter(payable(address(dynamicRouter))).updateModules(modules);
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

    function testDynamicRouter() public {
        dynamicRouter.set(42);
        assertEq(dynamicRouter.get(), 42);
    }
}
