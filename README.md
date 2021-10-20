# Instructions:
This is my submission for the mandatory assignment 2 for the 'Blockchain theory and usage' course at SDU.
To run this project you will need:

  - A local Ethereum blockchain (I used Ganache)
  - A way to deploy the smart contract to the locally running Ethereum network (Truffle, or deployed vie remix.ethereum.org)
  - An Ethereum wallet like MetaMask for the browser. This is to allow you to change the state on the EVM and paying gas fees.
  - Visual studio code with the 'live server' extension, or another way to run a local website with a Javascript runtime environment.

These tools will let you run deploy the smart contract on the Ehtereum blockchain, which the website will interact with.

To start out, simply register a user, with a fake name and fake password, this will take you to the user page. From here you can withdraw (take money out) and deposit (put money in) to this virtual DApp bank. Naturally this is nothing like real money and are generated from nothing. You can also transfer funds from the current user to another user, in order to use this feature, simply log out and create another user - this is now registered and can receive and send funds. The tranfer function works when two or more users are registered in the system, and you can transfer between them simply by names, given you have sufficient funds.

This edition still lacks a JS test, but has been manually tested so far.
