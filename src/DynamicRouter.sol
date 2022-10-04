// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { ICounter } from './ICounter.sol';

import { Data } from './Data.sol';
import { BigModule } from './BigModule.sol';

struct ModuleDefinition {
    address implementation;
    bytes4[] selectors;
}

struct VTableStore {
    mapping (bytes4 => address) modules;
}

contract DynamicRouter {
    error UnknownSelector(bytes4 sel);


     bytes32 private constant _VTABLE_SLOT = 0x13f1d5ea37b1d7aca82fcc2879c3bddc731555698dfc87ad6057b416547bc657;

    fallback() external payable {
        _forward();
    }

    receive() external payable {
        _forward();
    }

    function _store() internal pure returns (VTableStore storage store) {
      assembly {
        store.slot := _VTABLE_SLOT
      }
    }

    function updateModules(ModuleDefinition[] calldata modules) public {
        VTableStore storage vtable = _store();

        for (uint256 i = 0; i < modules.length; ++i) {
            ModuleDefinition memory module = modules[i];
            for (uint256 j = 0; j < module.selectors.length; ++j) {
                vtable.modules[module.selectors[j]] = module.implementation;
            }
        }
    }

    function _forward() internal {
        bytes4 sig4 = msg.sig;
        VTableStore storage vtable = _store();

        address implementation = vtable.modules[msg.sig];

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
