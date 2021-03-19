# Contract description

This document explains how the `Oracle` contract works.

## 1. Variables

### Public variables

#### Numeric variables (uint256)

- `decimal`: decimal for the price
- `intervalBlocks`: number of blocks between each price gap

#### Mappings

- `tokenList (address => TokenInfo)`: maps the token `address` to the structure `TokenInfo`

### Structures

#### TokenInfo

```
struct TokenInfo {
    uint256 price;
    uint256 lastUpdatedBlock;
    // TODO: protect the price via pancakeswap
    bool protection; // default false
}
```


## 2. Functions

### Call by Admin

#### setDecimal

```
function setDecimal(uint256 decimalNumber) public onlyAdmin
```

#### setInternal

```
function setInternal(uint256 blocks) public onlyAdmin 
```

#### put

```
function put(address tokenAddress, uint256 price) public onlyAdmin
```

Put the token price by relayer serivice

### View functions (external)

#### getPrice

```
function getPrice(address tokenAddress) external view returns(uint256) {
```

#### newestPrice
```
function newestPrice(address tokenAddress) public view returns(bool)
```

## 3. Events

- `PutPrice(address indexed ta, uint256 price)`

