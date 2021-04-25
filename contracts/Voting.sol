pragma solidity ^0.7.0;;

contract Schedule {
    struct Pick{
        uint8 pickDay;
        uint8 pickHour;
        uint8 pickMinute;
        uint8 pickMonth;
    }

    uint constant DAY_IN_SECONDS = 86400;
    uint constant HOUR_IN_SECONDS = 3600;
    uint constant MINUTE_IN_SECONDS = 60;

    function getDaysInMonth(uint8 month) public returns (uint8){
        if (month == 2){
            return 29;
        } 
        else if (month % 2 == 0){
            return 30;
        }
        else{
            return 31;
        }
    }

    function getTimestamp(uint timestamp) public returns (Schedule datetime){
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

    function getScheduleDay(uint timestamp) public constant returns (uint8){
        return getTimestamp(timestamp).pickDay;
    }
    function getScheduleHour(uint timestamp) public constant returns (uint8){
        return uint8((timestamp / 60 / 60) % 24);
    }
    function getScheduleMinute(uint timestamp) public constant returns (uint8){
        return uint8((timestamp / 60) % 60);
    }
    function getScheduleMonth(uint timestamp) public pure returns (uint8) {
        return getTimestamp(timestamp).pickMonth;
    }
}