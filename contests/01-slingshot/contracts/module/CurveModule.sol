// SPDX-License-Identifier: None
pragma solidity >=0.7.5;
pragma abicoder v2;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "../lib/LibERC20Token.sol";

interface ICurvePool {
    function exchange(
        int128 i,
        int128 j,
        uint256 dx,
        uint256 min_dy
    ) external;

    function exchange_underlying(
        int128 i,
        int128 j,
        uint256 dx,
        uint256 min_dy
    ) external;
}

/// @title Slingshot Curve Module
/// @dev   In addition to tradeAll, the only unique logic in this contract calculates post-trade
///        balance because Curve's innovative design choice of not returning an output amount.
contract CurveModule {
    using SafeMath for uint256;
    using LibERC20Token for IERC20;

    /// @notice
    /// @dev
    /// @param curvePool Pool address to trade on
    /// @param iToken Address of token sold
    /// @param jToken Address of token bought
    /// @param i Index array of the token sold
    /// @param j Index array of the token bought
    /// @param dx Amount of the token to sell
    /// @param tradeAll If true, it overrides totalAmountIn with current token balance
    /// @return
    function swap(
        address curvePool,
        address iToken,
        address jToken,
        int128 i,
        int128 j,
        uint256 dx,
        bool tradeAll,
        bool underlyingTokens
    ) public payable returns (uint256) {
        if (tradeAll) dx = IERC20(iToken).balanceOf(address(this));
        IERC20(iToken).approveIfBelow(curvePool, dx);
        // Calculate post-trade balance
        uint256 beforeBalance = IERC20(jToken).balanceOf(address(this));

        underlyingTokens
            ? ICurvePool(curvePool).exchange_underlying(i, j, dx, uint(1))
            : ICurvePool(curvePool).exchange(i, j, dx, uint(1));

        return IERC20(jToken).balanceOf(address(this)).sub(beforeBalance);
    }
}
