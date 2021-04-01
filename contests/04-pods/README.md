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

## Learn about the system

- You can find our full documentation [here](https://docs.pods.finance)

- If you want to use our deployment scripts, or check our test suite and coverage, you can check our repo [here](https://github.com/pods-finance/contracts) 

## About The Code 
Pods's system is composed by two main elements: 
- **The financial instrument (Options)**:
    Inside the `contracts/options/` folder you wll find the contracts that represents Put and Call options.
- **The AMM**:
  Inside the `contracts/amm` folder you will find the code for our single-sided AMM and it's price discovery for options using Black Scholes. 

   It adds other elements in addition to the product constant formula, aiming less impermanent loss for liquidity providers."

### How It Works
`AMM.sol` It is an abstract that defines the general logic and structure that a basic AMM should follow. It lacks the `_getABPrice` function implementation, responsible for the price discovery.

`OptionAMMPool.sol` It will be responsible for setting the custom `_getABPrice` function. Also it will handle the pool fees and sigma update (also known as implied volatility). 

As this code conforms to [NatSpec](https://docs.soliditylang.org/en/v0.5.10/natspec-format.html#natspec-format) formatting specifications, lower level details regarding function can be found as comments within the code itself.

### Sharing Vulnerability/Discovery POC
Should you identify a vulnerability or bug and have a POC that demonstrates the exploit, please create a private repository and share the POC with the contest Judge. When you have shared access, please also notify the judge on Discord to let them know you have shared it.