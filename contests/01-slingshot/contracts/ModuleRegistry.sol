// SPDX-License-Identifier: None
pragma solidity >=0.7.5;

import "./Adminable.sol";

 /// @title   Module Registry Contract
 /// @author  DEXAG, Inc.
 /// @notice  This contract provides the logic for querying, maintaining, and updating Slingshot modules.
 /// @dev     When a new module is deployed, it must be registered. If the logic for a particular
 ///          DEX/AMM changes, a new module must be deployed and registered.
contract ModuleRegistry is Adminable {
    /// @notice This is an index which indicates the validity of a module
    mapping(address => bool) public modulesIndex;

    /// @notice Slingshot.sol address
    address public slingshot;

    event ModuleRegistered(address moduleAddress);
    event ModuleUnregistered(address moduleAddress);
    event NewSlingshot(address oldAddress, address newAddress);

    /// @notice Use this function for post upgrade setup
    /// @param _admin Address to control admin functions
    function postUpgrade(address _admin) external onlyAdminIfInitialized {
        // skip when initialized
        if (!isInitialized()) initialize(_admin);
        // all other post upgrade setup below
    }

    /// @notice Initialization function for proxy setup
    /// @param _admin Address to control admin functions
    function initialize(address _admin) internal initializer {
        initializeAdmin(_admin);
    }

    /// @notice Checks if given address is a module
    /// @param _moduleAddress Address of the module in question
    /// @return true if address is module
    function isModule(address _moduleAddress) external view returns (bool) {
        return modulesIndex[_moduleAddress];
    }

    /// @param _moduleAddress Address of the module to register
    function registerSwapModule(address _moduleAddress) external onlyAdmin {
        modulesIndex[_moduleAddress] = true;
        emit ModuleRegistered(_moduleAddress);
    }

    /// @param _moduleAddress Address of the module to unregister
    function unregisterSwapModule(address _moduleAddress) external onlyAdmin {
        delete modulesIndex[_moduleAddress];
        emit ModuleRegistered(_moduleAddress);
    }

    /// @param _slingshot Slingshot.sol address implementation
    function setSlingshot(address _slingshot) external onlyAdmin {
        address oldAddress = slingshot;
        slingshot = _slingshot;
        emit NewSlingshot(oldAddress, _slingshot);
    }
}
