pragma solidity 0.4.10;

import "StandardToken.sol";

/// @title Gnosis token contract
/// @author Stefan George - <stefan.george@consensys.net>
contract GnosisToken is StandardToken {

    /*
     *  Token meta data
     */
    string constant public name = "Gnosis Token";
    string constant public symbol = "GNO";
    uint8 constant public decimals = 18;

    /*
     *  Public functions
     */
    /// @dev Contract constructor function sets dutch auction contract address and assigns all tokens to dutch auction.
    /// @param dutchAuction Address of dutch auction contract.
    /// @param owners Array of addresses receiving preassigned tokens.
    /// @param tokens Array of preassigned token amounts.
    function GnosisToken(address dutchAuction, address[] owners, uint[] tokens)
        public
    {
        if (dutchAuction == 0)
            // Address should not be null.
            throw;
        totalSupply = 10000000 * 10**18;
        balances[dutchAuction] = 9000000 * 10**18;
        Transfer(0, dutchAuction, balances[dutchAuction]);
        uint assignedTokens = balances[dutchAuction];
        for (uint i=0; i<owners.length; i++) {
            if (owners[i] == 0)
                // Address should not be null.
                throw;
            balances[owners[i]] += tokens[i];
            Transfer(0, owners[i], tokens[i]);
            assignedTokens += tokens[i];
        }
        if (assignedTokens != totalSupply)
            throw;
    }
}