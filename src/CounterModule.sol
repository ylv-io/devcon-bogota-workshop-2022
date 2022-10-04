// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { ICounter } from './ICounter.sol';
import { Data } from './Data.sol';

// TODO: allow blockalbe methods

contract CounterStorage {
  function _store() internal pure returns (Data storage store) {
    bytes32 slot = bytes32(uint(keccak256("ylv.counter")) - 1);
    assembly {
      store.slot := slot
    }
  }
}

contract CounterModule is CounterStorage, ICounter {
    function set(uint value)
        public
    {
        _store().counter = value;
    }

    function get()
        public
        view
        returns (uint)
    {
        return _store().counter;
    }
}