pragma solidity ^0.7.0;;

contract Schedule {
    struct Proposal{
        string scheduleName;
        uint dayAvaliable;
        uint hourAvaliable;
    }

    struct Pick{
        uint pickDay;
        uint pickHour;
        uint pickCout;
        mapping (address => Pick) public picks;
        address[] picksAddress;
    }

    Proposal[] public proposals;

    event CreatedProposalEvent();
    event CreatedPickEvent();

    address public dateTimeAddr = xxxxxxx;
    DateTime dateTime = DateTime(dateTimeAddr);

    function pickDay() public {
        pickDay = dayAvaliable;
    }

    function getScheduleDay(uint timestamp) public constant returns (uint8){
        return dateTime.pickDay(pick);
    }
    function getScheduleHour(uint timestamp) public constant returns (uint8){
        return dateTime.pickHour(pick);
    }
}