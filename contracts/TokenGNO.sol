pragma solidity ^0.4.21;

import "openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol";

contract TokenGNO is StandardToken {
    string public constant symbol = "GNO";
    string public constant name = "Gnosis";
    uint8 public constant decimals = 18;

    function TokenGNO(
    	uint amount
    )
    	public 
    {
        totalSupply_ = amount;
    	balances[msg.sender] = amount;
    }
}
