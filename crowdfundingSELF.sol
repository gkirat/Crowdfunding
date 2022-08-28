// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract crowdfundingself{

    address payable public manager;
    uint public deadline;
    uint public target;
    uint public noofcontribuitors;

    constructor(uint _deadline,uint _target){
        deadline = block.timestamp + _deadline;
        target = _target;
        manager = payable(msg.sender);
    }

    struct requestinfo{                         //this function is made to handle all the request that need charity 
        string description;
        address payable whomtotransfer;
        uint amountneeded;
        bool votingcomplete;
        uint noofvoters;                        //this is included to see how many vote did a particular request got
        mapping (address => bool) voters;

    }  
    mapping (uint => requestinfo) public requests;
    uint public numrequests;


    mapping (address => uint) public donars;
    


    // requestinfo[] public requestinarray;        //know the number of contribuitors,this is so that public can see all the requests for charity

    function generaterequest(string memory _description,address payable _whomtotransfer,uint _amountneeded) public {
        require(msg.sender == manager,"You are not the manager of this donation");
        requestinfo storage newrequest = requests[numrequests];
        if(newrequest.whomtotransfer == address(0)){
            numrequests++;
        }
        
        newrequest.description = _description;
        newrequest.whomtotransfer = _whomtotransfer;
        newrequest.amountneeded = _amountneeded;
        newrequest.votingcomplete = false ;


    }

    function geteth() public payable {
        require(msg.value >= 2 ether,"Minimum donation must be paid");
        // require(msg.sender != manager,"Manager can't paricipate");
        require(block.timestamp < deadline,"Donation has ended");
        require(address(this).balance <= target,"Target donation amount has been reached");
        if (donars[msg.sender] == 0){
        noofcontribuitors++;   
        }   
        donars[msg.sender] += uint(msg.value);

    }

   

    function voting(uint _x) public  {
        require(donars[msg.sender] != 0,"You must be a donar first");
        require(block.timestamp < deadline,"Donation has ended");
        requestinfo storage votinginrequest = requests[_x];
        require(votinginrequest.voters[msg.sender] == false,"You have already voted");
        votinginrequest.voters[msg.sender] = true ;
        votinginrequest.noofvoters++;
        

    }
    function remainingeth() public view returns (uint){
        uint getvalue = target - address(this).balance ;
        return getvalue;
    }

    function refund() payable public  {
        require (address(this).balance < target && block.timestamp > deadline ,"You are not eligible for refund");
        require (donars[msg.sender] != 0,"You are not a donar");
        address payable user = payable(msg.sender);
        user.transfer(donars[msg.sender]);
    } 

    function  transfer(uint requesta)  payable public{
        require(msg.sender == manager,"You cannot tranfer the money");
        require(address(this).balance == target,"target not achcieved");
        requestinfo storage client = requests[requesta];
        require(client.noofvoters > noofcontribuitors/2,"Number of voters is less than 50%");
        client.whomtotransfer.transfer(address(this).balance);
        client.votingcomplete =true;

    }

  
}
// 10000000000000000000  
