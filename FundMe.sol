//SPDX-License-Identifier: MIT 

//this line of code was created to fund account 
//show the value of fund in the address

pragma solidity ^0.8.0;
// the fundMe contract should be able to accept payment 

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe{
// i am trying to track the address from which the funds was receieved
// while making the address public 
    mapping(address => uint256) public addresstoAmountFunded;
    address public owner; 

    // i created an owner that gets called up when the contract is triggered 

    constructor()public{
        owner = msg.sender; 
    }

    function fund() public payable {
        //minimul value of $50
        uint256 minimulUSD = 50 * 10 * 18; 
        require(getConversionRate(msg.value) >= minimulUSD, "You need More ETH for Tran to pull thru!");
        addresstoAmountFunded[msg.sender] += msg.value;
        //we are not about to convert to another rate
    }

    function getVersion() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer);
    }
    // converting to USD equivellent and tagged against $50
    function getConversionRate(uint256 ethAmount) public view returns(uint256){
        uint256 ethprice = getPrice();
        uint256 ethAmountInUsd = (ethprice * ethAmount)/100000000000000000;
        return ethAmountInUsd;
    }
// withdrew function but i added that before one can withdrew 
//one has to be the owner or the caller of the smart contract
    function withdraw()payable public {
        require(msg.sender == owner);
        payable (msg.sender).transfer(address(this).balance);
    }

}
