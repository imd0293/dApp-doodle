pragma solidity ^0.8.4;

import "owner.sol";

contract Schedule {
    struct Pick{
        uint8 pickDay;
        uint8 pickHour;
        uint8 pickMinute;
        uint8 pickMonth;
        uint8 pickWeekDay;
    }

    address owner;
    mapping(address => Pick) public picks;
    Pick[] public pick;

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

    function getTimestamp(uint timestamp) public view returns (Pick _datetime){
        uint secondsCounted = 0;
        uint8 i;
        uint secondsInMonth;

        for (i = 1; i <= 12; i++){
            secondsInMonth = DAY_IN_SECONDS * getDaysInMonth(i);
            if ((secondsInMonth + secondsCounted) > timestamp){
                _datetime.pickMonth = i;
                Pick storage pickMonth = pick[timestamp];
                break;
            }
            secondsCounted += secondsInMonth;
        }
        for (i = 1; i <= getDaysInMonth(_datetime); i++){
            if ((DAY_IN_SECONDS + secondsCounted) > timestamp){
                _datetime.pickDay = i;
                Pick storage pickDay = pick[timestamp];
                break;
            }
            secondsCounted += DAY_IN_SECONDS;
        }
        _datetime.pickHour = getScheduleHour(timestamp);
        _datetime.pickMinute = getScheduleMinute(timestamp);
        _datetime.pickDay = getScheduleDay(timestamp);
        _datetime.pickWeekDay = getWeekDay(timestamp);
    }
    //Given a unix timestamp, returns the DateTime value for the timestamp.
    function getScheduleDay(uint timestamp) public view returns (uint8){
        return getTimestamp(timestamp).pickDay;
    }
    function getScheduleMonth(uint timestamp) public view returns (uint8) {
        return getTimestamp(timestamp).pickMonth;
    }
    function getScheduleHour(uint timestamp) public view returns (uint8){
        return uint8((timestamp / 60 / 60) % 24);
    }
    function getScheduleMinute(uint timestamp) public view returns (uint8){
        return uint8((timestamp / 60) % 60);
    }
    //Com o algoritmo Zeller, o sábado é usado = 0. Para a conversão, a aritmética modular simples é usada: Dia da semana = ((dia da semana + 5) mod 7) + 1.
    function getWeekDay(uint timestamp) public view returns (uint8){
        return uint8(((timestamp / DAY_IN_SECONDS + 5) % 7) + 1);
    }
    function calculateScheduleTimestamp(uint8 month, uint8 day, uint8 hour, uint8 minute) public returns (uint timestamp) {
        uint16 i;
        uint8[12] memory monthDaysCounts;
        monthDaysCounts = getDaysInMonth(month);

        for (i = 1; i < month; i++) {
            timestamp += DAY_IN_SECONDS * monthDaysCounts[i - 1];
        }
        timestamp += DAY_IN_SECONDS * (day - 1);
        timestamp += HOUR_IN_SECONDS * (hour);
        timestamp += MINUTE_IN_SECONDS * (minute);
        return timestamp;
    }
    function isOwner() public view returns (bool);
}