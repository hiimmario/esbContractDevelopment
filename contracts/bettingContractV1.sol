pragma solidity ^0.4.4;

contract bettingContractV1 {

    address public team0bet;
    address public team1bet;

    uint public matchId;

    function bettingContractV1(uint _matchId, uint _choice) payable {
        if(_choice == 0) {
            team0bet = msg.sender;
        }
        else {
            team1bet = msg.sender;
        }

        matchId = _matchId;
    }

    function makeBet(uint _choice) payable {
        if(_choice == 0) {
            team0bet = msg.sender;
        }
        else {
            team1bet = msg.sender;
        }
    }

    function getMatchId() returns (uint) {
        return matchId;
    }

    function getFunds() returns (uint) {
        return this.balance;
    }

    function setWinner(uint winner) returns (bool) {
        if(winner == 0) {
            team0bet.send(this.balance);
        }
        else if (winner == 1) {
            team1bet.send(this.balance);
        }
        else {
            team0bet.send(this.balance/2);
            team1bet.send(this.balance/2);
        }

        return true;
    }
}
