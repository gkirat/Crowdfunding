// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Crowdfunding{
    address public manager;
    uint public deadline;
    uint public target;
    uint public noofcontribuitors;

    struct Request{
        string description;  //description for donation like why do we want donation or funding
        address payable whomtogive;  //for whom do we require the money like which person
        uint value;          //how much money is required
        bool completed;      //this is for whether the voting is complete or not
        uint noofvoters;     //to get the number of voters that have voted 
        mapping(address => bool) voters;
    }
    mapping (uint => Request) public requests;
    uint public numRequests;                        //total number of request for charity

    mapping (address => uint) public funders;

    

    constructor(uint _target,uint _deadline)  {
        manager = (msg.sender);
        target=_target;
        deadline=block.timestamp + _deadline; //10sec + 3600sec (60*60) if you want contract to go for 1hour for two hours (60*60*2)

    }

    modifier owner(){
        require(msg.sender == manager,"You are not the owner");
        _;
    }

   
    function sendeth() payable  public {
        require(block.timestamp < deadline,"Funding has ended" );
        require(msg.sender != manager,"Manager can't donate");
        require(address(this).balance <= target,"Funding has been completed");

        if (funders[msg.sender]==0){  //this is very important because now the person cannot increase the percentage of its votes by contribuiting multiple times , he will be registred once only and can make as donations multiple times
        noofcontribuitors++;
        }
        
        funders[msg.sender] +=uint(msg.value);

    }

    

    function raisedfunds() public view returns(uint){

        return address(this).balance;
    }

    function refund() public {
        require (block.timestamp > deadline && raisedfunds() < target,"You are not eligible to ask for refund");
        require (funders[msg.sender] != 0,"you didn't donate" );
        address payable user = payable(msg.sender);
        user.transfer(funders[msg.sender]);
        funders[msg.sender]=0;   //this is for when the money is refunded the donation balance of that person should be zero
    }
    //we can't use this function because we have mapping inside struct and inside struct we have another mapping
    //so that's why we have to save that in storage 

    // function createrequests(string memory _description ,address payable _whomtogive,uint _value)  public   owner{
        
    //     requests[numRequests] = Request(_description,_whomtogive,_value,false,0);
    //     numRequests++;
    //  }

       //Function for votes for manager to get votes
   function createrequests(string memory _description ,address payable _whomtogive,uint _value) public owner {
            Request storage newrequest = requests[numRequests];
            numRequests++;
            newrequest.description = _description;
            newrequest.whomtogive  = _whomtogive;
            newrequest.value       = _value;
            newrequest.completed   = false;
            newrequest.noofvoters  = 0;
    }

    function voterequest(uint _requestno)  public{
        require(funders[msg.sender] > 0,"you must be a funder");
        Request storage thisrequest = requests[_requestno];
        require (thisrequest.voters[msg.sender] == false ,"you have already voted"); //bool default value is false
        thisrequest.voters[msg.sender] =true;  //this means now after voting you have voted so now the value is true

        thisrequest.noofvoters++;
    }

    function transfermoney(uint _requestno) payable public owner {
        require( raisedfunds() >= target,"raised value is less");
        Request storage thisrequest = requests[_requestno];
        require (thisrequest.completed == false ,"the request has  been completed");
        require (thisrequest.noofvoters > noofcontribuitors/2,"minimum 50% of votes should be casted");  //we are checking if  minimum number of votes have been made or not
        thisrequest.whomtogive.transfer(thisrequest.value);
        thisrequest.completed =true;
    }
} 
//10000000000000000000 10 ethers












 
