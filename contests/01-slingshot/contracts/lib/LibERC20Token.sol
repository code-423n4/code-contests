// SPDX-License-Identifier: None
pragma solidity >=0.7.5;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";

/// @title LibERC20Token
/// @notice Utility function for ERC20 tokens
library LibERC20Token {
    using SafeERC20 for IERC20;

    /// @param token Token to approve
    /// @param spender Address of wallet to approve spending for
    /// @param amount Amount of token to approve
    function approveIfBelow(IERC20 token, address spender, uint256 amount) internal {
        if (token.allowance(address(this), spender) < amount) {
            token.safeApprove(spender, uint256(0));
            token.safeApprove(spender, uint256(-1));
        }
    }
}
