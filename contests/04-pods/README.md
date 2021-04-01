# Code Contest 4: Pods Finance's Contracts 
## Code Contest Details
**Pot Size**  
tbd  
    
**Start Time**  
tbd UTC  

**Stop Time**   
tbd UTC  
  
**Judge(s)**  
tbd

## About The Code 
Pods’ system is composed of two main elements: 
- **The financial instrument (Options)**:
    Inside the `contracts/options/` folder you will find the contracts that represent Put and Call options.
- **The AMM**:
  Inside the `contracts/amm` folder you will find the code for our single-sided AMM and its price discovery for options using Black Scholes. It adds other elements, in addition to the product constant formula, aiming to reduce impermanent loss for liquidity providers. 

### How It Works
`AMM.sol` is an abstract that defines the general logic and structure that a basic AMM should follow. It lacks the `_getABPrice` function implementation responsible for the price discovery.

`OptionAMMPool.sol` is responsible for setting the custom `_getABPrice` function. Also, it handles the pool fees and sigma update (AKA implied volatility).

`BlackScholes.sol` responsible for the BlackScholes formulation. 

`SigmaGuesser.sol` responsible for finding a new sigma given a targetPrice using a numeric method mechanism.

`PriceProvider.sol` responsible for returning the current underlying asset spot price.

`NormalDistribution.sol` responsible for returning the probabilities that BlackScholes formula will use.

As this code conforms to [NatSpec](https://docs.soliditylang.org/en/v0.5.10/natspec-format.html#natspec-format) formatting specifications, lower level details regarding function can be found as comments within the code itself.

### Sharing Vulnerability/Discovery POC
Should you identify a vulnerability or bug and have a POC that demonstrates the exploit, please create a private repository and share the POC with the contest Judge. When you have shared access, please also notify the judge on Discord to let them know you have shared it.