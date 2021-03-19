// SPDX-License-Identifier: MIT
pragma solidity >=0.4.25 <0.7.0;


contract Oracle {

  // info of each token.
  struct TokenInfo {
      uint256 price;
      uint256 lastUpdatedBlock;
      // TODO: protect the price via pancakeswap
      bool protection; // default false
  }

  // token info list
  mapping (address => TokenInfo) public tokenList;
  // admin address
  address public adminAddress;
  // the decimal of the price
  uint256 public decimal;
  // price update interval blocks
  uint256 public intervalBlocks;

  event PutPrice(address indexed ta, uint256 price);

  modifier onlyAdmin() {
    require(msg.sender == adminAddress, "admin: wut?");
    _;
  }

  constructor(
    address _adminAddress
  ) public {
    adminAddress = _adminAddress;
    decimal = 6;
    intervalBlocks = 200;
  }

  /**
   * @dev Set the price Decimal
   */
  function setDecimal(uint256 decimalNumber) public onlyAdmin {
    decimal = decimalNumber;
  }

  /**
   * @dev Set the internal to update the price
   */
  function setInternal(uint256 blocks) public onlyAdmin {
    intervalBlocks = blocks;
  }

  /**
   * @dev Set the price by token address
   */
  function put(address tokenAddress, uint256 price) public onlyAdmin {
    tokenList[tokenAddress].price = price;
    tokenList[tokenAddress].lastUpdatedBlock = block.number;
    emit PutPrice(tokenAddress, price);
  }

  /**
   * @dev Get the price by token address
   */
  function getPrice(address tokenAddress) external view returns(uint256) {
    return tokenList[tokenAddress].price;
  }

  /**
   * @dev Judge if the price is newest
   */
  function newestPrice(address tokenAddress) public view returns(bool) {
    if (block.number - tokenList[tokenAddress].lastUpdatedBlock < intervalBlocks) {
      return true;
    }
    return false;
  }

}
