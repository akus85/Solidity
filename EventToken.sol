pragma solidity ^0.4.18;

contract EventToken {

  // Declare the metadata of the token
  string public constant name = "Event Token";
  string public constant symbol = "EVTKN";

  // Declare decimals of the token
  uint8  public constant decimals = 18;

  // Event that is executed when the transaction is successful
  event Transfer(address _from, address _to, uint256 _value);

  // Total of tokens generated
  uint256 public totalSupply;

  // Mapping of balances
  mapping(address => uint256)  balances;

  // Two-dimensional mapping of allowances
  mapping(address => mapping (address => uint256)) allowances;

  // Event that is executed after approval
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);


  // Costructor of EventToken
  function EventToken(uint256 initSupply) public {
    // Setting totalSupply
    totalSupply = initSupply;

    // Initially all tokens are in the balance of the owner
    balances[msg.sender] = totalSupply;
  }

  // Function to transfer tokens (from owner to buyer)
  function buy(address _to, uint256 _value) public returns (bool success) {
    if(_value > 0  && balances[msg.sender] < _value) {
      return false;
    }

    balances[msg.sender] -= _value;
    balances[_to] += _value;
    Transfer(msg.sender, _to, _value);

    return true;
  }

  // Function that returns the token amount of a certain account
  function balanceOf(address _someone) public constant returns (uint256 balance){
    return balances[_someone];
  }

  // Fallback function
  function() public {
    assert(true == false);
  }

  // Set how many tokens a 'spender' can use
  function allowance(address _owner, address _spender) public constant returns (uint remaining){
    return allowances[_owner][_spender];
  }

  // Function that approves the value of tokens to a certain 'spender'
  function approve(address _spender, uint256 _value) public returns (bool success) {
    if(_value <= 0) return false;

    allowances[msg.sender][_spender] = _value;

    Approval(msg.sender, _spender, _value);

    return true;
  }


  // Transfer tokens from one account to another account
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {

    if(_value <= 0) return false;

    if(allowances[_from][msg.sender] < _value) return false;

    if(balances[_from] < _value) return false;

    balances[_from] -= _value;
    balances[_to] += _value;

    allowances[_from][msg.sender] -= _value;

    Transfer(_from, _to, _value);

    return true;
  }
}
