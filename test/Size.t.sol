// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/ICounter.sol";
import "../src/IBig.sol";

import "../src/Counter.sol";
import "../src/ExternalLibrary.sol";
import "../src/StaticRouter.sol";
import "../src/LoadedStaticRouter.sol";
import "../src/DynamicRouter.sol";
import "../src/LoadedDynamicRouter.sol";
import "../src/CounterModule.sol";
import "../src/BigModule.sol";

contract SizeTest is Test {
    Counter public counter;
    ExternalLibraryCounter public libCounter;
    ICounter public staticRouter;
    ICounter public loadedStaticRouter;
    ICounter public loadedDynamicRouter;
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
        bytes4[] memory counterSelectors = new bytes4[](3);
        counterSelectors[0] = ICounter.get.selector;
        counterSelectors[1] = ICounter.set.selector;
        counterSelectors[2] = ICounter.const.selector;
        bytes4[] memory bigSelectors = new bytes4[](1);
        bigSelectors[0] = IBig.quote.selector;
        ModuleDefinition[] memory modules = new ModuleDefinition[](2);
        modules[0] = ModuleDefinition({implementation: address(counterModule),
                                      selectors: counterSelectors });
        modules[1] = ModuleDefinition({implementation: address(bigModule),
                                      selectors: bigSelectors });
        DynamicRouter(payable(address(dynamicRouter))).updateModules(modules);

        loadedDynamicRouter = (ICounter)((address)(new LoadedDynamicRouter()));
        DynamicRouter(payable(address(loadedDynamicRouter))).updateModules(modules);

        loadedStaticRouter = (ICounter)((address)(new LoadedStaticRouter()));
    }

    // Big
    function testBig() public {
        assertTrue(bytes(bigModule.quote()).length != 0);
    }

    // Counter
    function testCounter() public {
        counter.set(42);
        assertEq(counter.const(), 18);
    }

    function testCounterGet() public {
        assertEq(counter.get(), 0);
    }

    // ExternalLibraryCounter
    function testLibrary() public {
        libCounter.set(42);
        assertTrue(bytes(libCounter.quote()).length != 0);
    }

    function testLibraryConst() public {
        assertEq(libCounter.const(), 18);
    }

    function testLibraryGet() public {
        assertEq(libCounter.get(), 0);
    }

    // StaticRouter
    function testStaticRouter() public {
        staticRouter.set(42);
        assertTrue(bytes(IBig(address(staticRouter)).quote()).length != 0);
    }

    function testStaticRouterGet() public {
        assertEq(staticRouter.get(), 0);
    }

    function testStaticRouterConst() public {
        assertEq(staticRouter.const(), 18);
    }

    // DynamicRouter
    function testDynamicRouter() public {
        dynamicRouter.set(42);
        assertTrue(bytes(IBig(address(dynamicRouter)).quote()).length != 0);
    }

    function testDynamicRouterGet() public {
        assertEq(dynamicRouter.get(), 0);
    }

    function testDynamicRouterConst() public {
        assertEq(dynamicRouter.const(), 18);
    }

    // LoadedStaticRouter
    function testLoadedStaticRouter() public {
        loadedStaticRouter.set(42);
        assertTrue(bytes(IBig(address(loadedStaticRouter)).quote()).length != 0);
    }

    function testLoadedStaticRouterGet() public {
        assertEq(loadedStaticRouter.get(), 0);
    }

    function testLoadedStaticRouterConst() public {
        assertEq(loadedStaticRouter.const(), 18);
    }

    // LoadedDynamicRouter
    function testLoadedDynamicRouter() public {
        loadedDynamicRouter.set(42);
        assertTrue(bytes(IBig(address(loadedDynamicRouter)).quote()).length != 0);
    }

    function testLoadedDynamicRouterGet() public {
        assertEq(loadedDynamicRouter.get(), 0);
    }

    function testLoadedDynamicRouterConst() public {
        assertEq(loadedDynamicRouter.const(), 18);
    }
}
