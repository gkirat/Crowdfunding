# Crowdfunding Smart Contract

This Solidity smart contract implements a crowdfunding platform that allows individuals to donate Ether to a cause or project. The contract is designed to manage donation requests, voting, and fund transfers based on specified criteria.

## Features

1. **Donation Deadline:** The crowdfunding campaign has a specified deadline after which donations will not be accepted.

2. **Donation Target:** A target amount is set for the campaign, and the contract will stop accepting donations once this target is reached.

3. **Donation Requests:** The manager of the contract can create multiple donation requests specifying the description, the recipient address to transfer funds, and the amount needed.

4. **Donation Voting:** Donors can vote on individual donation requests to approve or reject them.

5. **Refund Mechanism:** If the target amount is not reached by the deadline, donors can request a refund of their donated Ether.

6. **Transfer of Funds:** Once the target is reached, the manager can initiate the transfer of the donated Ether to the recipient address if more than 50% of the donors approve the request.
7. Second Smart Contract

Features (Improvements over the First Contract):

8. Improved Voting System: In this contract, only donors who have contributed are allowed to vote on specific donation requests. This prevents non-contributors from influencing voting outcomes.
   
10. Simplified Request Generation: The second contract uses a generaterequest() function to create new donation requests, which makes it easier to manage multiple requests without specifying a unique identifier (index) for each request.
11. 
12. Voting Completion Flag: The contract includes a votingcomplete flag in each request to keep track of whether voting for a request has been completed.
Request Visibility: The contract uses a numrequests variable to manage the total number of donation requests, which allows the public to access the count of requests.

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
