contract ScheduleAPI {
    function getDaysInMonth(uint8 month) public returns (uint8);
    function getScheduleDay(uint timestamp) public constant returns (uint8);
    function getScheduleHour(uint timestamp) public constant returns (uint8);
    function getScheduleMinute(uint timestamp) public constant returns (uint8);
    function getScheduleMonth(uint timestamp) public pure returns (uint8);
}