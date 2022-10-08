// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { ICounter } from './ICounter.sol';

import { Data } from './Data.sol';
import { CounterModule } from './CounterModule.sol';
import { BigModule } from './BigModule.sol';
import { DynamicRouter } from './DynamicRouter.sol';

contract LoadedDynamicRouter is CounterModule, DynamicRouter {
}
