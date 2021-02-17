// SPDX-License-Identifier: None
pragma solidity >=0.7.5;
pragma abicoder v2;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "./Adminable.sol";
import "./lib/Strings.sol";
import "./ModuleRegistry.sol";

interface IWETH is IERC20 {
    function deposit() external payable;
    function balanceOf(uint amount) external returns (uint);
    function withdraw(uint amount) external;
}

 /// @title   Slingshot Trading Contract
 /// @author  DEXAG, Inc.
 /// @notice  This contract serves as the entrypoint for executing
 ///          a Slingshot transaction on-chain.
 /// @dev     The specific logic for each DEX/AMM is defined within its
 ///          own corresponding module that is stored in the module registry.
 ///          Slingshot.sol references these modules to appropriately execute a trade.
 ///          Slingshot.sol also performs some safety checks to account for slippage
 ///          and security. Slingshot.sol depends on the Slingshot backend to provide
 ///          the details of how a given transaction will be executed within a
 ///          particular market.
contract Slingshot is Adminable, Strings {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    address public ETH_ADDRESS;
    IWETH public WETH;

    struct TradeFormat {
        address moduleAddress;
        bytes encodedCalldata;
    }

    ModuleRegistry public moduleRegistry;

    event Trade(
        address indexed user,
        address fromToken,
        address toToken,
        uint fromAmount,
        uint toAmount,
        address recipient
    );
    event NewModuleRegistry(address oldRegistry, address newRegistry);

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
        ETH_ADDRESS = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
        WETH = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    }

    /// @notice Executes multi-hop trades to get the best result
    /// @param fromToken Start token address
    /// @param toToken Target token address
    /// @param fromAmount The initial amount of fromToken to start trading with
    /// @param trades Array of encoded trades that are atomically executed
    /// @param finalAmountMin The minimum expected output after all trades have been executed
    /// @param recipient The address that will receive the output of a trade
    function executeTrades(
        address fromToken,
        address toToken,
        uint fromAmount,
        TradeFormat[] calldata trades,
        uint finalAmountMin,
        address recipient
    ) public payable {
        uint initialBalance = _getTokenBalance(toToken);
        _transferFromOrWrap(fromToken, _msgSender(), fromAmount);
        // Checks to make sure that module exists and is correct
        for(uint i = 0; i < trades.length; i++) {
            require(moduleRegistry.isModule(trades[i].moduleAddress), "Slingshot: not a module");
            // delagatecall message is made on module contract, which is trusted
            (bool success, bytes memory data) = trades[i].moduleAddress.delegatecall(trades[i].encodedCalldata);

            require(success, appendString(prependNumber(i, ", Slingshot: swap failed: "), string(data)));
        }

        uint finalBalance = _getTokenBalance(toToken);
        uint finalAmount = finalBalance.sub(initialBalance);

        require(finalAmount >= finalAmountMin, "Slingshot: result is lower than required min");

        // Send to recipient address. Generally expected to be msg.sender, but can also be defined by user.
        // This allows for more flexibility, but isn't necessary.
        _sendFunds(toToken, recipient, finalAmount);

        emit Trade(_msgSender(), fromToken, toToken, fromAmount, finalAmount, recipient);
    }

    /// @notice Sets module registry used to verify modules
    /// @param _moduleRegistry The address of module registry
    function setModuleRegistry(address _moduleRegistry) external onlyAdmin {
        address oldRegistry = address(moduleRegistry);
        moduleRegistry = ModuleRegistry(_moduleRegistry);
        emit NewModuleRegistry(oldRegistry, _moduleRegistry);
    }

    /// @notice In an unlikely scenario of tokens being send to this contract
    ///         allow adming to rescue them.
    /// @param token The address of the token to rescue
    /// @param to The address of recipient
    /// @param amount The amount of the token to rescue
    function rescueTokens(address token, address to, uint amount) external onlyAdmin {
        if (token == ETH_ADDRESS) {
            (bool success, ) = to.call{value: amount}("");
            require(success, "Slingshot: ETH rescue failed.");
        } else {
            IERC20(token).safeTransfer(to, amount);
        }
    }

    /// @notice Transfer tokens from sender to this contract or wraps ETH
    /// @param fromToken The address of the token
    /// @param from The address of sender that provides token
    /// @param amount The amount of the token to transfer
    function _transferFromOrWrap(address fromToken, address from, uint amount) internal {
        // transfer tokens or wrap ETH
        if (fromToken == ETH_ADDRESS) {
            require(msg.value == amount, "Slingshot: incorect ETH value");
            WETH.deposit{value: amount}();
        } else {
            require(msg.value == 0, "Slingshot: should not send ETH");
            IERC20(fromToken).safeTransferFrom(from, address(this), amount);
        }
    }

    /// @notice Returns balancer of the token
    /// @param token The address of the token
    /// @return balance of the token, defaults to WETH for ETH
    function _getTokenBalance(address token) internal view returns (uint) {
        if (token == ETH_ADDRESS) {
            return WETH.balanceOf(address(this));
        } else {
            return IERC20(token).balanceOf(address(this));
        }
    }

    /// @notice Sends token funds. For ETH, it unwraps WETH
    /// @param token The address of the token to send
    /// @param to The address of recipient
    /// @param amount The amount of the token to send
    function _sendFunds(address token, address to, uint amount) internal {
        if (token == ETH_ADDRESS) {
            WETH.withdraw(amount);
            (bool success, ) = to.call{value: amount}("");
            require(success, "Slingshot: ETH Transfer failed.");
        } else {
            IERC20(token).safeTransfer(to, amount);
        }
    }

    receive() external payable {}
}
