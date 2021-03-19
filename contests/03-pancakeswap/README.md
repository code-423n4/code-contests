# Code Contest 3: Pancakeswap Prediction Contract

## Code Contest Details

**Pot Size**  
$9,000 - Vulnerabilities
$1,000 - Gas improvements

**Start Time**
TBD
**Stop Time**
TBD

**Judge(s)**  
Your name
[GitHub](https://github.com/Chef-Chungus)

## About The Code

Pancakeswap Prediction allows users to bet if the price of BNB increases or decreases.

### How It Works

There are 3 phases in each round:

- Bet phase
  Each account is allowed to bet once per round, on whether the price of BNB will increase or decrease.

- Lock phase
  Betting is no longer allowed, and the lock price is obtained.

- End phase
  The end price is obtained and compared against the lock price to determine if the price has increased or decreased. Winners are able to claim their share of the winnings.

The price is determined using Chainlink's oracle.

Each round interval is 5 minutes (100 blocks)

### Sharing Vulnerability/Discovery POC

Should you identify a vulnerability or bug and have a POC that demonstrates the exploit, please create a private repository and share the POC with the contest Judge. When you have shared access, please also notify the judge on Discord to let them know you have shared it.
