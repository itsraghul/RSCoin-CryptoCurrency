//RS Coins ICO
pragma solidity ^0.4.11;

contract rscoin_ico {
    // Max No of RSCoins available for sale
    uint public max_rscoins = 10000000;

    // inr to rscoin conversion rate
    uint public inr_to_rscoin =  10;

    //total no of rscoins that have been bought by investors
    uint public total_rscoins_bought = 0;

    //mapping investor address to its equity in rscoins and INR
    mapping(address => uint) equity_rscoins;
    mapping(address => uint) equity_inr;

    //To check if investor can buy rscoins
    modifier can_buy_rscoins(uint inr_invested) {
        require (inr_invested*inr_to_rscoin + total_rscoins_bought <= max_rscoins);
        _;
    }

    //getting equity in rscoins of an investor
    function equity_in_rscoins(address investor) external constant returns (uint) {
        return equity_rscoins[investor];
    }


    //getiing equity in INR of an investor
    function equity_in_inr(address investor) external constant returns (uint) {
        return equity_inr[investor];
    }

    //Buy RSCoins
    function buy_rscoins(address investor,uint inr_invested) external 
    can_buy_rscoins(inr_invested) {
        uint rscoins_bought = inr_invested * inr_to_rscoin;
        equity_rscoins[investor] += rscoins_bought; 
        equity_inr[investor] = equity_rscoins[investor]/inr_to_rscoin;
        total_rscoins_bought += rscoins_bought;
    }

    //Selling RSCoins
    function sell_rscoins(address investor,uint rscoins_sold) external {
        equity_rscoins[investor] -= rscoins_sold; 
        equity_inr[investor] = equity_rscoins[investor]/inr_to_rscoin;
        total_rscoins_bought -= rscoins_sold;
    }
    

}