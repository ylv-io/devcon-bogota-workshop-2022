// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { ICounter } from './ICounter.sol';

import { Data } from './Data.sol';
import { Fat } from './Fat.sol';

contract StaticRouter {
    error UnknownSelector(bytes4 sel);

    // calculated precompile time
    address private constant _COUNTER_MODULE = 0x70BEce5a3D1a6eFBC54e1A134cfF3b47EF346bbE;

    fallback() external payable {
        _forward();
    }

    receive() external payable {
        _forward();
    }

    function _forward() internal {
        // Lookup table: Function selector => implementation contract
        bytes4 sig4 = msg.sig;
        address implementation;

        assembly {
            let sig32 := shr(224, sig4)

            function findImplementation(sig) -> result {
                switch sig
                case 0x60fe47b1 { result := _COUNTER_MODULE } // _COUNTER_MODULE.set
                case 0x6d4ce63c { result := _COUNTER_MODULE } // _COUNTER_MODULE.get
                leave
            }

            implementation := findImplementation(sig32)
        }

        if (implementation == address(0)) {
            revert UnknownSelector(sig4);
        }

        // Delegatecall to the implementation contract
        assembly {
            calldatacopy(0, 0, calldatasize())

            let result := delegatecall(gas(), implementation, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())

            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }
}

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
        external
    {
        _store().counter = value;
    }

    function get()
        external
        view
        returns (uint)
    {
        return _store().counter;
    }
}