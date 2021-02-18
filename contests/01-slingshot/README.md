# Code Contest 1: Slingshot Trading Contracts 
## Code Contest Details
**Pot Size:** $20,000  
**Start Time:** Feb 17, 1400 UTC  
**Stop TimeWe want to add competitors' links and avatars to the website.

If you're participating in the Slingshot Finance contest, drop a comment here with your:

handle / name
preferred avatar
link
:** Feb 21, 2359 UTC  
## About The Code 
As a system, Slingshot aggregates prices for available token pairs
from a variety of decentralized exchanges and automated market making
protocols. The code contained in this repository is responsible for the execution of transactions based on the received input parameters that it is passed.  
### How It Works
`Slingshot.sol` defines the general logic by which a transaction is 
handled and executed. 

The specific logic for each DEX/AMM is defined within its own corresponding module that is stored in the module registry.

`Slingshot.sol` references these modules to appropriately execute a trade.
`Slingshot.sol` also performs some safety checks to account for slippage 
and security. `Slingshot.sol` expect parameters to be passed from the Slingshot backend that provide the details related to how a given transaction should be executed.

As this code conforms to [NatSpec](https://docs.soliditylang.org/en/v0.5.10/natspec-format.html#natspec-format) formatting specifications, lower level details regarding function can be found as comments within the code itself. 


