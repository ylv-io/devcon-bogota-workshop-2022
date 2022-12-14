// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { ICounter } from './ICounter.sol';

import { Data } from './Data.sol';
import { BigModule } from './BigModule.sol';
import { CounterModule } from './CounterModule.sol';

contract StaticRouter {
    error UnknownSelector(bytes4 sel);

    // calculated precompile time
    address private constant _COUNTER_MODULE = 0xDb933C92ccafDe43B11D8693c22FEedbD65B7a25;
    address private constant _BIG_MODULE = 0xc94Cf1a6D4b8a25e424b3Ed8792eed1F1B95B86e;

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
                case 0x3b80a793 { result := _COUNTER_MODULE } // _COUNTER_MODULE.const
                case 0x74969fee { result := _COUNTER_MODULE } // _COUNTER_MODULE.complex
                case 0x999b93af { result := _BIG_MODULE } // _BIG_MODULE.quote
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

