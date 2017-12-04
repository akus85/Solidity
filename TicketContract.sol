pragma solidity ^0.4.18;

// Contract to purchase tickets for live events
contract TicketContract {
  // Address of the 'owner'
  address owner;
  // Number of tickets available
  uint public tickets;
  // Array of purchasers
  mapping (address => uint) public purchasers;

  // Constructor of the contract
  function TicketContract() public {
    owner = msg.sender;
    tickets = 10;
  }

  // Fallback function
  function() public payable { }

  // Function to purchase the tickets
  function buyTickets(uint amount) public payable {
    purchasers[msg.sender] += amount;
    tickets -= amount;

    owner.transfer(msg.value);

  }
}
