# Slingshot Trading Contracts 
## v0.0.1

## About 
As a system, Slingshot aggregates prices for available token pairs
from a variety of decentralized exchanges and automated market making
protocols.  

### How It Works
`Slingshot.sol` defines the general logic by which a transaction is 
handled and executed. The specific logic for each DEX/AMM is defined
within its own corresponding module that is stored in the module registry.
`Slingshot.sol` references these modules to appropriately execute a trade.
`Slingshot.sol` also performs some safety checks to account for slippage 
and security. `Slingshot.sol` depends on the Slingshot backend to provide 
the details related to how a given transaction should be executed.



