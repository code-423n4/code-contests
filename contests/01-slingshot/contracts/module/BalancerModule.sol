// SPDX-License-Identifier: None
pragma solidity >=0.7.5;
pragma abicoder v2;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "../lib/LibERC20Token.sol";

interface IBalancerPool {
    /// @dev Sell `tokenAmountIn` of `tokenIn` and receive `tokenOut`.
    /// @param tokenIn The token being sold
    /// @param tokenAmountIn The amount of `tokenIn` to sell.
    /// @param tokenOut The token being bought.
    /// @param minAmountOut The minimum amount of `tokenOut` to buy.
    /// @param maxPrice The maximum value for `spotPriceAfter`.
    /// @return tokenAmountOut The amount of `tokenOut` bought.
    /// @return spotPriceAfter The new marginal spot price of the given
    ///         token pair for this pool.
    function swapExactAmountIn(
        address tokenIn,
        uint tokenAmountIn,
        address tokenOut,
        uint minAmountOut,
        uint maxPrice
    ) external returns (uint tokenAmountOut, uint spotPriceAfter);
}

/// @title Slingshot Balancer Module
contract BalancerModule {
    using SafeMath for uint256;
    using LibERC20Token for IERC20;

    /// @param pool Balancer pool to trade on
    /// @param tokenIn Address of token sold
    /// @param tokenOut Address of token bought
    /// @param totalAmountIn Amount of token sold
    /// @param tradeAll If true, it overrides totalAmountIn with current token balance
    /// @return Amount of token bought
    function swap(
        address pool,
        address tokenIn,
        address tokenOut,
        uint totalAmountIn,
        bool tradeAll
    ) public payable returns (uint256) {
        if (tradeAll) totalAmountIn = IERC20(tokenIn).balanceOf(address(this));

        IERC20(tokenIn).approveIfBelow(pool, totalAmountIn);

        (uint boughtAmount,) = IBalancerPool(pool).swapExactAmountIn(
            tokenIn,
            totalAmountIn,
            tokenOut,
            1,          // minAmountOut
            uint256(-1) // maxPrice
        );
        return boughtAmount;
    }
}
