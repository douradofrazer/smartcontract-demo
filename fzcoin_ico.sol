
// version of compiler

pragma solidity ^0.4.11;

contract fzcoin_ico {
    
    // Introducing the maximum number of fzcoins available for sale
    uint public max_fzcoins = 1000000;

    // Introducing the USD to fzcoins conversion rate
    uint public usd_to_fzcoin = 1000;

    // Introducing the total number of fzcoins that have been bought by the investors
    uint public total_fzcoins_bought = 0;

    // Mapping from the investor address to its equity in fzcoin to USD
    mapping(address => uint) equity_fzcoins;
    mapping(address => uint) equity_usd;

    //  Checking  if an investor can buy fzcoins
    modifier can_buy_fzcoins(uint usd_invested){
        require (usd_invested * usd_to_fzcoin + total_fzcoins_bought <= max_fzcoins);
        _;
    }

    // Getting the equity in fzcoins of an investor
    function equity_in_fzcoins(address investor) external constant returns (uint) {
        return equity_fzcoins[investor];
    }

    // Getting the equity in USD of an investor
    function equity_in_usd(address investor) external constant returns (uint) {
        return equity_usd[investor];
    }

    // Buying fzcoins
    function buy_fzcoins(address investor, uint usd_invested) external 
    can_buy_fzcoins(usd_invested){
        uint fzcoin_bought = usd_invested * usd_to_fzcoin;
        equity_fzcoins[investor] += fzcoin_bought;
        equity_usd[investor] = equity_fzcoins[investor] / 1000;
        total_fzcoins_bought += fzcoin_bought;
    }

    // Selling fzcoins
    function sell_fzcoins(address investor, uint fzcoin_to_sell) external {
        equity_fzcoins[investor] -= fzcoin_to_sell;
        equity_usd[investor] = equity_fzcoins[investor] / 1000;
        total_fzcoins_bought -= fzcoin_to_sell;
    }
}