# Code Contest 3: Based Loans
## Code Contest Details
**Pot Size**  
TBD

**Start Time**  
TBD

**Stop Time**   
TBD

**Sponsor**
Ghoul.sol | Ghouls
[GitHub](https://github.com/ghoul-sol)

**Judge(s)**
Zak Cole
[GitHub](https://github.com/zscole)

## About The Code
### Overview
Based Loans is a fork of Compound with unique parameterization that enables new functionality in the marketplace.
The Based Loans protocol is owned and maintained by the community through the Based Loans Ownership ($BLO) token.

### How It Works
Overall, Based Loans works the same way as Compound v2 does. However, there are two quite significant changes that could introduce vulnerabilities to the code base:
1. Implementation of Uniswap TWAP oracle
2. Solidity upgrade

Based Loans replaced OpenPriceOracle with Uniswap TWAP oracle (`./contracts/UniswapOracle/UniswapAnchoredView.sol`). It updates its prices on the fly using 15 min intervals.

As this code conforms to [NatSpec](https://docs.soliditylang.org/en/v0.5.10/natspec-format.html#natspec-format) formatting specifications, lower level details regarding function can be found as comments within the code itself.

### Sharing Vulnerability/Discovery POC
Should you identify a vulnerability or bug and have a POC that demonstrates the exploit, please create a private repository and share the POC with the contest Judge. When you have shared access, please also notify the judge on Discord to let them know you have shared it.
