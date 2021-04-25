pragma solidity ^0.7.0;;

contract Schedule {
    struct Pick{
        uint8 pickDay;
        uint8 pickHour;
        uint8 pickMinute;
        uint8 pickMonth;

        mapping (address => Pick) public picks;
        address[] picksAddress;
    }

    uint constant DAY_IN_SECONDS = 86400;
    uint constant HOUR_IN_SECONDS = 3600;
    uint constant MINUTE_IN_SECONDS = 60;

    event CreatedPickEvent();

    address public dateTimeAddr = xxxxxxx;
    DateTime dateTime = DateTime(dateTimeAddr);

    function getDaysInMonth(uint8 month) public returns (uint8){
        if (month == 2){
            return 29;
        } 
        else if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12){
            return 31;
        }
        else{
            return 30;
        }
    }

    function getTimestamp(uint timestamp) public returns(_DateTime datetime){
        uint secondsCounted = 0;
        uint8 i;
        uint secondsInMonth;

        for (i = 1; i <= 12; i++){
            secondsInMonth = DAY_IN_SECONDS * getDaysInMonth(i);
            if (secondsInMonth + secondsCounted) > timestamp){
                datetime.pickMonth = i;
                break;
            }
            secondsCounted += secondsInMonth;
        }
        for (i = 1; i <= getDaysInMonth(datetime); i++){
            if (DAY_IN_SECONDS + secondsCounted > timestamp){
                datetime.pickDay = i;
                break;  
            }
            secondsCounted += DAY_IN_SECONDS;
        }

        datetime.pickHour = getScheduleHour(timestamp);
        datetime.pickMinute = getScheduleMinute(timestamp);
        datetime.pickDay = getScheduleDay(timestamp);
    }


    function pickDay() public {
        pickDay = dayAvaliable;
    }

    function getScheduleDay(uint timestamp) public constant returns (uint8){
        return getTimestamp(timestamp).pickDay;
    }
    function getScheduleHour(uint timestamp) public constant returns (uint8){
        return uint8((timestamp / 60 / 60) % 24);
    }
    function getScheduleMinute(uint timestamp) public constant returns (uint8){
        return uint8((timestamp / 60) % 60);
    }
}