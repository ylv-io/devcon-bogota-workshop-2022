// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Fat } from './Fat.sol';

contract Router {
    error UnknownSelector(bytes4 sel);

    address private constant _OWNER_MODULE = 0x5FbDB2315678afecb367f032d93F642f64180aa3;
    address private constant _SNXTOKEN_MODULE = 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512;
    address private constant _SYNTHS_MODULE = 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0;
    address private constant _UPGRADE_MODULE = 0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9;

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
                if lt(sig,0x81d49b75) {
                    if lt(sig,0x53a47bb7) {
                        switch sig
                        case 0x0f36a2de { result := _SYNTHS_MODULE } // SynthsModule.createSynth()
                        case 0x1627540c { result := _OWNER_MODULE } // OwnerModule.nominateNewOwner()
                        case 0x2d6b3a6b { result := _SYNTHS_MODULE } // SynthsModule.getBeacon()
                        case 0x35eb2824 { result := _OWNER_MODULE } // OwnerModule.isOwnerModuleInitialized()
                        case 0x3659cfe6 { result := _UPGRADE_MODULE } // UpgradeModule.upgradeTo()
                        case 0x51456061 { result := _SYNTHS_MODULE } // SynthsModule.getSynth()
                        leave
                    }
                    switch sig
                    case 0x53a47bb7 { result := _OWNER_MODULE } // OwnerModule.nominatedOwner()
                    case 0x57d7995a { result := _SYNTHS_MODULE } // SynthsModule.createSynthImplementation()
                    case 0x624bd96d { result := _OWNER_MODULE } // OwnerModule.initializeOwnerModule()
                    case 0x7104fba5 { result := _SYNTHS_MODULE } // SynthsModule.getSynthImplementation()
                    case 0x718fe928 { result := _OWNER_MODULE } // OwnerModule.renounceNomination()
                    case 0x79ba5097 { result := _OWNER_MODULE } // OwnerModule.acceptOwnership()
                    leave
                }
                if lt(sig,0xd1b6c504) {
                    switch sig
                    case 0x81d49b75 { result := _SNXTOKEN_MODULE } // SNXTokenModule.getSNXTokenModuleSatellites()
                    case 0x8da5cb5b { result := _OWNER_MODULE } // OwnerModule.owner()
                    case 0xa44896e7 { result := _SYNTHS_MODULE } // SynthsModule.isSynthsModuleInitialized()
                    case 0xaaf10f42 { result := _UPGRADE_MODULE } // UpgradeModule.getImplementation()
                    case 0xc6253216 { result := _SYNTHS_MODULE } // SynthsModule.upgradeSynthImplementation()
                    case 0xc7f62cda { result := _UPGRADE_MODULE } // UpgradeModule.simulateUpgradeTo()
                    leave
                }
                switch sig
                case 0xd1b6c504 { result := _SNXTOKEN_MODULE } // SNXTokenModule.getSNXTokenAddress()
                case 0xdaac1198 { result := _SNXTOKEN_MODULE } // SNXTokenModule.upgradeSNXImplementation()
                case 0xe040da24 { result := _SNXTOKEN_MODULE } // SNXTokenModule.isSNXTokenModuleInitialized()
                case 0xf4c4dc31 { result := _SYNTHS_MODULE } // SynthsModule.getSynthsModuleSatellites()
                case 0xf5d6f068 { result := _SNXTOKEN_MODULE } // SNXTokenModule.initializeSNXTokenModule()
                case 0xfbc6aa6f { result := _SYNTHS_MODULE } // SynthsModule.initializeSynthsModule()
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
  struct SettingsStore {
    uint someSetting;
  }

  function _settingsStore() internal pure returns (SettingsStore storage store) {
    bytes32 slot = bytes32(uint(keccak256("io.synthetix.settings")) - 1);
    assembly {
      store.slot := slot
    }
  }
}

contract SettingsModule is SettingsStorage {
  function setSomeSetting(uint newValue) external {
    _settingsStore().someSetting = newValue;
  }

  function getSomeSetting() external view returns (uint) {
    return _settingsStore().someSetting;
  }
}
