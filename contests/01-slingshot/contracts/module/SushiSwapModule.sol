// SPDX-License-Identifier: None
pragma solidity >=0.7.5;
pragma abicoder v2;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "../lib/LibERC20Token.sol";
import "hardhat/console.sol";

/// @title Slingshot SushiSwap Module
/// @dev   tradeAll is the only unique logic in this module. If true, the remaining
///        portion of a trade is filled in this hop. This addresses the issue of dust
///        to account for slippage and ensure that the user can only receive more of an
///        asset than expected.
contract SushiSwapModule {
    using SafeMath for uint256;
    using LibERC20Token for IERC20;

    address public constant sushiSwapRouter = 0xd9e1cE17f2641f24aE83637ab66a2cca9C378B9F;

    /// @param amount Amount of the token being exchanged
    /// @param path Array of token addresses to swap
    /// @param amountOutMin Minimum accepted amount of token bought
    /// @param amountInMax Maximum accpeted amount of token sold
    /// @param swapExactTokensForTokens Indicates which side of trade should be a fixed amount
    /// @param tradeAll If true, it overrides totalAmountIn with current token balance
    /// @return
    function swap(
        uint amount,
        address[] memory path,
        uint amountOutMin,
        uint amountInMax,
        bool swapExactTokensForTokens,
        bool tradeAll
    ) public payable returns (uint256){
        require(path.length > 0, "SushiSwapModule: path length must be >0");

        if (tradeAll) amount = IERC20(path[0]).balanceOf(address(this));
        IERC20(path[0]).approveIfBelow(sushiSwapRouter, amount);

        if (swapExactTokensForTokens) {
            amountOutMin = amountOutMin == 0 ? 1 : amountOutMin;
            uint256[] memory amounts =
                IUniswapV2Router02(sushiSwapRouter).swapExactTokensForTokens(
                    amount,
                    amountOutMin,
                    path,
                    address(this),
                    block.timestamp
                );
            return amounts[amounts.length - 1];
        } else {
            amountInMax = amountInMax == 0 ? uint(-1) : amountInMax;
            uint256[] memory amounts =
                IUniswapV2Router02(sushiSwapRouter).swapTokensForExactTokens(
                    amount,
                    amountInMax,
                    path,
                    address(this),
                    block.timestamp
                );
            return amounts[amounts.length - 1];
        }
    }
}
