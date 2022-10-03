// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Data } from './Data.sol';
import { Fat } from './Fat.sol';

contract Router {
    error UnknownSelector(bytes4 sel);

    address private constant _SETTINGS_MODULE = 0x5FbDB2315678afecb367f032d93F642f64180aa3;

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
                case 0xd1b6c504 { result := _SETTINGS_MODULE } // SNXTokenModule.getSNXTokenAddress()
                case 0xf4c4dc31 { result := _SETTINGS_MODULE } // SynthsModule.getSynthsModuleSatellites()
                case 0xf5d6f068 { result := _SETTINGS_MODULE } // SNXTokenModule.initializeSNXTokenModule()
                case 0xfbc6aa6f { result := _SETTINGS_MODULE } // SynthsModule.initializeSynthsModule()
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

contract SettingsStorage {
  function _settingsStore() internal pure returns (Data storage store) {
    bytes32 slot = bytes32(uint(keccak256("io.synthetix.settings")) - 1);
    assembly {
      store.slot := slot
    }
  }
}

contract SettingsModule is SettingsStorage {
    function set(uint value)
        external
    {
        _settingsStore().counter = value;
    }

    function get()
        external
        view
        returns (uint)
    {
        return _settingsStore().counter;
    }
}
