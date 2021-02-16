# C4 Judging Criteria
## Submission Review Process
C4 strives to ensure a deliberate and transparent process for reviewing and judging submissions. 

At the end of a given contest period, all reports will be reviewed and categorized based on criteria. Pending sponsor review, final reports will be added to the appropriate [contests](contests/README.md) directory within this repository. Results will then be shared on the C4 Discord and winers will be announced on the C4 Twitter page.

## Scoring
The scoring system has two primary goals: rewarding Wardens for finding unique bugs and hardening C4 code contests to sybil attacks. A secondary goal of the scoring system is to incentivize contestants to form squads and encourage coordination. 

## Estimating Risk
C4 judges refer to the standard model as presented in the OWASP approach to risk analysis where:  
  
`Risk = Likelihood * Impact`  
  
The Warden's submission should include provisional classification. Their report should also include information concerning impact, the threat agent involved, the attack that will be used, the vulnerability involved, and the impact of a successful exploit on the protocol. 

The measurement of risk is partially based on the rating submitted by the Warden, but is also subject to the judge's discretion. Should the judge determine a particular bug to be a lower risk than the Warden has rated it, this judgement will include a thorough description to justify this measurement.

### Risk Categories
Bugs are divided into 3 risk categories:   
- Low Risk  
- Medium Risk  
- High Risk    

## Estimating Likelihood
The first set of factors are related to the threat agent involved. The goal here is to estimate the likelihood of a successful attack by this group of threat agents. Use the worst-case threat agent.

Skill Level - How technically skilled is this group of threat agents? No technical skills (1), some technical skills (3), advanced computer user (5), network and programming skills (6), security penetration skills (9),

Motive - How motivated is this group of threat agents to find and exploit this vulnerability? Low or no reward (1), possible reward (4), high reward (9)

Opportunity - What resources and opportunities are required for this group of threat agents to find and exploit this vulnerability? Full access or expensive resources required (0), special access or resources required (4), some access or resources required (7), no access or resources required (9)

Size - How large is this group of threat agents? Developers (2), system administrators (2), intranet users (4), partners (5), authenticated users (6), anonymous Internet users (9)

## Estimating Vulnerability
The next set of factors are related to the vulnerability involved. The goal here is to estimate the likelihood of the particular vulnerability involved being discovered and exploited. Assume the threat agent selected above.

Ease of Discovery - How easy is it for this group of threat agents to discover this vulnerability? Practically impossible (1), difficult (3), easy (7), automated tools available (9)

Ease of Exploit - How easy is it for this group of threat agents to actually exploit this vulnerability? Theoretical (1), difficult (3), easy (5), automated tools available (9)

Awareness - How well known is this vulnerability to this group of threat agents? Unknown (1), hidden (4), obvious (6), public knowledge (9)

## Estimating Impact
The goal is to estimate the magnitude of the impact on the system if the vulnerability were to be exploited.  
  
Loss of Access - How liike is it that a specific requests can be overridden? Minimal non-sensitive data disclosed (2), minimal critical data disclosed (6), extensive non-sensitive data disclosed (6), extensive critical data disclosed (7), all data disclosed (9)  
  
Loss of Funds - Can funds be stolen or removed without the knowledge of the owner? This is a critical bug with that warrants the highest rating (9).  

Loss of Availability - How much service could be lost and how vital is it? Minimal secondary services interrupted (1), minimal primary services interrupted (5), extensive secondary services interrupted (5), extensive primary services interrupted (7), all services completely lost (9)

### High-Level Considerations
Malicious Input Handling - Are function parameters passed in a safe and predictable manner?

Arithmetic - Are mathematical operations and variable values handled in a predictable and safe manner?

Gas Limitations - Is the use of gas optimized in a way that prevents unecessary losses?

## Duplicate Submissions
Should the same bug be submitted by multiple Wardens, Judges have the discretion to place these bugs into the same bucket, in which case, the award will be shared among those who submitted.
 
## Credits
The C4 judging criteria references the [OWASP Risk Rating Methodology](https://owasp.org/www-community/OWASP_Risk_Rating_Methodology) to score the severity and relevence of submitted reports from C4 Wardens.
