# Code Contest 1: Slingshot Trading Contracts 
## Code Contest Details
**Pot Size**  
$20,000  
    
**Start Time**  
Feb 17, 1400 UTC  

**Stop Time**   
Feb 21, 2359 UTC  
  
**Judge(s)**  
Zak Cole  
[GitHub](https://github.com/zscole)

## About The Code 
As a system, Slingshot aggregates prices for available token pairs
from a variety of decentralized exchanges and automated market making
protocols.  

### How It Works
`Slingshot.sol` defines the general logic by which a transaction is 
handled and executed. 

The specific logic for each DEX/AMM is defined within its own corresponding module that is stored in the module registry.

`Slingshot.sol` references these modules to appropriately execute a trade.
`Slingshot.sol` also performs some safety checks to account for slippage 
and security. `Slingshot.sol` expect parameters to be passed from the Slingshot backend that provide the details related to how a given transaction should be executed.

As this code conforms to [NatSpec](https://docs.soliditylang.org/en/v0.5.10/natspec-format.html#natspec-format) formatting specifications, lower level details regarding function can be found as comments within the code itself.

### Sharing Vulnerability/Discovery POC
Should you identify a vulnerability or bug and have a POC that demonstrates the exploit, please create a private repository and share the POC with the contest Judge. When you have shared access, please also notify the judge on Discord to let them know you have shared it.