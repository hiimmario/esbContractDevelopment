pragma solidity ^0.4.4;

contract bettingContractV1 {

    address public team1bet;
    address public team2bet;

    uint public amount;
    uint public matchId;

    function bettingContractV1(uint _matchId, address _address, uint _choice, uint _amount) {
        if(_choice == 1) {
            team1bet = _address;
        }
        else {
            team2bet = _address;
        }

        amount = _amount;
        matchId = _matchId;
    }

    function returnMatchId() returns (uint) {
        return matchId;
    }

    function makeBet(address _address, uint _choice, uint _amount) {
        if(_choice == 1) {
            team1bet = _address;
        }
        else {
            team2bet = _address;
        }
    }




}
