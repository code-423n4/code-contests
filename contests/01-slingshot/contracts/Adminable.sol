// SPDX-License-Identifier: None
pragma solidity >=0.7.5;
pragma abicoder v2;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "./Initializable.sol";

 /// @title   Admin Role Contract
 /// @author  DEXAG, Inc.
 /// @notice  This contract is a utility for an admin role access.
abstract contract Adminable is Initializable, AccessControl {
    bytes32 public constant SLINGSHOT_ADMIN_ROLE = keccak256("SLINGSHOT_ADMIN_ROLE");

    modifier onlyAdmin() {
        require(hasRole(SLINGSHOT_ADMIN_ROLE, _msgSender()), "Adminable: not an admin");
        _;
    }

    /// @param role role hash
    modifier onlyRole(bytes32 role) {
        require(hasRole(role, _msgSender()), "Adminable: not a role");
        _;
    }

    modifier onlyAdminIfInitialized() {
        if (isInitialized()) {
            // if admin is set, require admin to be msg.sender
            if(getRoleMemberCount(SLINGSHOT_ADMIN_ROLE) > 0) {
                require(hasRole(SLINGSHOT_ADMIN_ROLE, _msgSender()), "Adminable: not an admin");
                _;
            }
            // if no admin is set, just silently skip the execution. Proxy owner
            // and slingshot admin may be two separate wallets so we don't revert
            // the transaction to avoid jeopardizing contract implementation deployemnt
            // - at these gas prices, it'd be almost a crime if we did.
        } else {
            // if not initialized, just let it execute
            _;
        }
    }

    /// @notice Set default admin role
    /// @param _admin Address to control admin functions
    function initializeAdmin(address _admin) internal {
        _setRoleAdmin(SLINGSHOT_ADMIN_ROLE, SLINGSHOT_ADMIN_ROLE);
        _setupRole(SLINGSHOT_ADMIN_ROLE, _admin);
    }
}
