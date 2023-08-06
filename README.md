# Crowdfunding Smart Contract

This Solidity smart contract implements a crowdfunding platform that allows individuals to donate Ether to a cause or project. The contract is designed to manage donation requests, voting, and fund transfers based on specified criteria.

## Features

1. Donation Management: The contract allows users to donate Ether to a crowdfunding campaign within a specified deadline.
2. Target Amount: The contract has a target amount, and once the total donations reach this target, no more donations are accepted.
3. Refund: If the target is not reached by the deadline, donors can request a refund of their donated Ether.
4. Donation Requests: The manager can create multiple donation requests, specifying descriptions, recipients, and amounts needed.
5. Voting System: Donors can vote on donation requests to approve or reject them.
6. Transfer Funds: If the majority of voters approve a donation request and the target is reached, the manager can transfer the funds to the recipient.


## Usage

1. Deploy the smart contract to your preferred Ethereum network, setting the constructor parameters: `_deadline` (campaign duration in seconds) and `_target` (target donation amount in Wei).

2. **Donating:** Users can participate in the crowdfunding campaign by sending a minimum donation of 2 Ether using the `geteth()` function. The contract will only accept donations before the deadline and until the target amount is reached.

3. **Refunding:** In case the target amount is not reached by the deadline, donors can request a refund of their donated Ether using the `refund()` function.

4. **Creating Donation Requests:** Only the manager (contract deployer) can create donation requests using the `generaterequest()` function. Specify the description, recipient address, and the amount needed for each request.

5. **Voting on Requests:** Donors can vote on individual donation requests using the `voting()` function. Each donor can vote only once, and the total number of voters will be tracked.

6. **Transferring Funds:** When the target amount is reached, the manager can use the `transfer()` function to transfer the donated Ether to the recipient address, but only if more than 50% of the donors have voted in favor of the request.

7. **Checking Remaining Amount:** Use the `remainingeth()` function to check the amount needed to reach the target.

## Notes

- The minimum donation amount is set to 2 Ether (change this value as needed).
- The manager (contract deployer) has certain exclusive rights, such as creating donation requests and transferring funds after the campaign ends.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Please remember to customize the usage instructions and any specific notes or requirements for your deployment. Additionally, feel free to add any additional information or features that may be specific to your crowdfunding platform.
