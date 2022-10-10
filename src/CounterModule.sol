// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { ICounter, BigStruct } from './ICounter.sol';
import { Data } from './Data.sol';

contract CounterStorage {
  function _counterStorage() internal pure returns (Data storage store) {
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
        _counterStorage().counter = value;
    }

    function get()
        public
        view
        returns (uint)
    {
        return _counterStorage().counter;
    }

    function const() external pure returns (uint256) {
        return 18;
    }

    function complex(BigStruct[] memory data) external pure  {
    }
}
