# Code Contest 2: ElasticDAO Contracts 
## Code Contest Details
**Pot Size**
22 ETH TOTAL (~$35,000)  
20 ETH for Vulerabilities
2 ETH for Gas Improvements (not related to the storage pattern)

**Start Time**  
Feb 25, 1600 UTC

**Stop Time**   
March 3, 2359 UTC  
  
**Sponsor**  
LSDan | ElasticDAO
[GitHub](https://github.com/dmvt)

**Judges**
Zak Cole  
[GitHub](https://github.com/zscole)

## About The Code 
Elastic DAO is a governance protocol that attempts to balance the competing interests between the different participants in a decentralized ecosystem. Elastic DAO achieves this by reducing the overall influence that money and early adopters have in existing DAO governance models.

ElasticDAO relies on Snapshot for it's voting approach (due to gas prices) pending implementation with a
layer 2 solution after launch. For this reason, most functions which would be performed by voting are
actually executed by a multisig. This multisig will be the owner of the proxy contracts, the ElasticDAO
controller, the burner, and the minter.

Code with tests and tooling is available at https://github.com/elasticdao/contracts/tree/c657b84469ba33efd8914c7e847830d82cb0f3ca
Docs are available at https://docs.elasticdao.org

### How It Works
`core/ElasticDAO.sol` defines the logic for deploying, initializing, summoning, joining, and exiting a DAO. 
`core/ElasticDAOFactory.sol` provides a singular approach for deploying DAOs and is meant to be managed
by the first DAO, ElasticDAO.
`tokens/ElasticGovernanceToken.sol` is a rebasing token that conforms to the ERC20 spec.

Storage contracts follow a version of the Eternal Storage pattern and are found in `src/models`.

As this code conforms to [NatSpec](https://docs.soliditylang.org/en/v0.7.2/natspec-format.html#natspec-format) formatting specifications, lower level details regarding function can be found as comments within the code itself.

### Sharing Vulnerability/Discovery POC
Should you identify a vulnerability or bug and have a POC that demonstrates the exploit, please create a private repository and share the POC with the contest Judge. When you have shared access, please also notify the judge on Discord to let them know you have shared it.