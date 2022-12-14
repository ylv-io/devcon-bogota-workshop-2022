// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { ICounter } from './ICounter.sol';

import { Data } from './Data.sol';
import { BigModule } from './BigModule.sol';
import { CounterModule } from './CounterModule.sol';
import { StaticRouter } from './StaticRouter.sol';

contract LoadedStaticRouter is CounterModule, StaticRouter {
}

