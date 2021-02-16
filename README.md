# Code 423n4
![banner](images/c4-logo.png)
## Code Contests
C4 code contests present a novel methodology for the future of DeFi security. By leveraging a community of security researchers and smart contract experts, C4's mission is to provide a reliable and cost effective method for organizations and decentralized protocols to acquire rigorous code review in a gamified manner which incentivizes participants to thoroughly analyze and uncover potential vulnerabilities or attack vectors within a given code base.

There are three actors in Code 423n4:

**WARDENS**  
Wardens hunt for bugs in the smart contracts of decentralized protocols.

**SPONSORS**  
Sponsors create bounty pools to attract wardens to their contests.

**JUDGES**  
Judges are responsible for allocating bounty pools to wardens based on their performance.

### Traditional Audits Are Constrained By:
*Cost*  
Auditing firms must be compensated for maintaining their brand, effectively training or recruiting qualified smart contract security experts, and finding clients in need of audits. This operational overhead makes audits expensive and also, to some extent, incentivizes auditing firms to cut corners.

*Time*  
Audits must be scheduled sequentially, so each individual engineer working at the firm has not too much nor too little, work. This constraint creates scheduling inflexibility that present obstacles and inefficiencies for teams racing to go to market.

*Depth*  
Audit teams (or individuals) must be somewhat aware of all the different types of vulnerabilities a smart contract can present. As the complexity in the space grows, the vulnerability space grows with it, and the knowledge that any one person can have for any one type of vulnerability becomes diluted.

> C4 presents a competitive and open code review process where all participants eat what they kill as they compete to become the champion of the arena.

### Code 423n4 Security Reviews Offer:
*Cost Flexibility*  
Sponsor projects can determine the size of their bounty pot. The larger the pot, the more attention a contest will attract.

*Time Flexibility*  
C4 can accommodate multiple concurrent audits, and startups are free to start and end their Review Period whenever they choose. The players in the arena are free to participate in multiple overlapping Reviews.

*Specialization*  
Since the goal of each participant is to find any security bugs, rather than find all the security bugs, C4 code reviews are ideal for highly specialized security researchers. The more rare or novel the identified bug, the higher the reward for finding it.

## Scoring
The scoring system has two primary goals: rewarding contestants for finding unique bugs and making the contest resistant to sybil attacks. A secondary goal of the scoring system is to incentivize contestants to form squads and encourage coordination. 

Bugs are divided into 3 classes:   
- Low Risk  
- Medium Risk  
- High Risk    

## Rewards  
Wardens are awarded shares for bugs discovered, and those shares give the owner a pro rata piece of the pot.  
  
Low Risk Bounty Shares  
`1 * (0.9 ^ discovery count) / discovery count`  
  
Medium Risk Bounty Shares  
`3 * (0.9 ^ discovery count) / discovery count`  

High Risk Bounty Shares  
`10 * (0.9 ^ discovery count) / discovery count`  

Critical Risk Bounty Shares  
`20 * (0.9 ^ discovery count) / discovery count`  
  
At the end of the contest, each bounty share is redeemable for:   
`Bounty Pot / number of Bounty Shares.`

# Participating In A Code Contest
## Sponsors
To sponsor a code contest, please join the [C4 Discord](https://discord.gg/EY5dvm3evD) and DM an organizer.

## Wardens
To participate in a code contest as a C4 Warden, please check the active contests in the [contests directory](contests/README.md). To find a team or apply for a bounty, please join the [C4 Discord](https://discord.gg/EY5dvm3evD) and stay up to date with new contests by following the [C4 Twitter](https://twitter.com/code423n4).

## Judges
Judges are community curated participants that are selected by the C4 organizers. Judges must demonstrate a proven track record of experience working within the DeFi and smart contract space. If you qualify and would like to volunteer as a judge, please join the [C4 Discord](https://discord.gg/EY5dvm3evD)and DM an organizer.

