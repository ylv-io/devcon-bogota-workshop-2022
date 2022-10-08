// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/ICounter.sol";
import "../src/IBig.sol";

import "../src/Counter.sol";
import "../src/ExternalLibrary.sol";
import "../src/StaticRouter.sol";
import "../src/DynamicRouter.sol";
import "../src/CounterModule.sol";
import "../src/BigModule.sol";

contract SizeTest is Test {
    Counter public counter;
    ExternalLibraryCounter public libCounter;
    ICounter public staticRouter;
    CounterModule public counterModule;
    BigModule public bigModule;
    ICounter public dynamicRouter;

    function setUp() public {
        counterModule = new CounterModule();
        bigModule = new BigModule();

        libCounter = new ExternalLibraryCounter();
        counter = new Counter();
        staticRouter = (ICounter)((address)(new StaticRouter()));
        dynamicRouter = (ICounter)((address)(new DynamicRouter()));
        // set the counter module on dynamic router
        // boy, this is ugly
        bytes4[] memory counterSelectors = new bytes4[](2);
        counterSelectors[0] = ICounter.get.selector;
        counterSelectors[1] = ICounter.set.selector;
        bytes4[] memory bigSelectors = new bytes4[](1);
        bigSelectors[0] = IBig.quote.selector;
        ModuleDefinition[] memory modules = new ModuleDefinition[](2);
        modules[0] = ModuleDefinition({implementation: address(counterModule),
                                      selectors: counterSelectors });
        modules[1] = ModuleDefinition({implementation: address(bigModule),
                                      selectors: bigSelectors });
        DynamicRouter(payable(address(dynamicRouter))).updateModules(modules);
    }

    // Big
    function testBig() public {
        assertTrue(bytes(bigModule.quote()).length != 0);
    }

    // Counter
    function testCounter() public {
        counter.set(42);
        assertEq(counter.get(), 42);
    }

    function testCounterGet() public {
        assertEq(counter.get(), 0);
    }

    // ExternalLibraryCounter
    function testLibrary() public {
        libCounter.set(42);
        assertEq(libCounter.get(), 42);
        assertTrue(bytes(libCounter.quote()).length != 0);
    }

    function testLibraryGet() public {
        assertEq(libCounter.get(), 0);
    }

    // StaticRouter
    function testStaticRouter() public {
        staticRouter.set(42);
        assertEq(staticRouter.get(), 42);
        assertTrue(bytes(IBig(address(staticRouter)).quote()).length != 0);
    }

    function testStaticRouterGet() public {
        assertEq(staticRouter.get(), 0);
    }

    // DynamicRouter
    function testDynamicRouterGet() public {
        assertEq(dynamicRouter.get(), 0);
    }

    function testDynamicRouter() public {
        dynamicRouter.set(42);
        assertEq(dynamicRouter.get(), 42);
        assertTrue(bytes(IBig(address(dynamicRouter)).quote()).length != 0);
    }
}
