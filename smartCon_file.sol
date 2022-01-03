//SPDX-License-Identifier: MIT 

pragma solidity >=0.6.0 <0.9.0;
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract Fund{

       constructor() public{
        owner = msg.sender;
    }

    //maped each address to an unsigned variable
    mapping(address => uint) public Funders;
    address public owner;
    address[] public funder; 

    //Fundme allows each sender to be saved in FundMe array
    function FundMe() public payable{
        //minimum value must  be this 
        uint MoneyValue = 50 * 10 **18;
        //we require the msg.value of the convertrate to be equal/above MoneyValue!
        require (CovertRate(msg.value) >= MoneyValue, 'You need more Money!');
        //we call see the amount each funder sent to the contract 
        Funders[msg.sender] += msg.value;
        funder.push(msg.sender);
    }

    //we get the price by calling an external function from an external contract!
    function GetPrice() public view returns(uint){
        //we pick the function-We give our name "ValuePrice" ==> address
        AggregatorV3Interface ValuePrice = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        //we get the tuple = Ourname.function from external function 
        (,int answer,,,) = ValuePrice.latestRoundData();
        return uint(answer);
    }
    //we convert the value of ether by calling the GetPrice function 
    function CovertRate(uint ethA) public view returns (uint) {
        uint ethAmount = GetPrice();
        //since we are using gwai we divide by 18^0
        uint ethAmountUSD = (ethAmount * ethA) / 10000000000000;
        return ethAmountUSD;
    }

    modifier Onlyowner(){
        require(msg.sender == owner);
        _;
    }

    //withdraw fucntion allows us withdraw our money
    function Withdraw()public Onlyowner payable{ 
        msg.sender.transfer(address(this).balance);
        funder = new address[](0);
    }
}
