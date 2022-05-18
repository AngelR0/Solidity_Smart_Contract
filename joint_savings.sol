/* From using two user addesses that can be able to control a joint savings account, the smart contract will use ether management functions requirements from the financial institution to provide the features of the joint savings account.

We will run the application on a local blockchain environment (JavaScript VM) provided by the Remix IDE.
*/

pragma solidity ^0.5.0;		//the version we will use

contract JointSavings {
	address payable accountOne;
	address payable accountTwo;
	address public lastToWithdraw;
	uint public lastWithdrawAmount;
	uint public contractBalance;
	
	
	function withdraw(uint amount, address payable recipient) public {
		require(recipient == accountOne || recipient == accountTwo,"You don't own this account!");	// Checks if recipient is either accountOne or accountTwo
		require(contractBalance > amount, "Insufficient funds!");	//Checking if the balance has sufficient funds for the withdrawal operation
		
		if (lastToWithdraw != recipient){
			lastToWithdraw = recipient;
		}
		recipient.transfer(amount)
		// Set lastWithdrawAmount equal amount
		lastWithdrawAmount = amount;
		
		contractBalance = address(this).balance;	//Reflects the new balance of the contract
	}
	function deposit() public payable {
		contractBalance = address(this).balance;
		}

	function setAccounts(address payable account1, address payable account2) public{
		//Setting the accounts 1 and 2 to account one and two,
		accountOne = account1;
		accountTwo = account2;
		}
	
	// Setting the fallback
	function() external payable {}
}
