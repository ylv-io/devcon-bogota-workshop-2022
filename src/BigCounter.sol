// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { ICounter } from './ICounter.sol';
import { Counter } from './Counter.sol';
import { BigModule } from './BigModule.sol';

contract BibCounter is ICounter, Counter, BigModule {
}
