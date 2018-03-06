pragma solidity ^0.4.4;

contract bettingContractV1 {

    address public team1bet;
    address public team2bet;

    uint public matchId;

    function bettingContractV1(uint _matchId, uint _choice) payable {
        if(_choice == 1) {
            team1bet = msg.sender;
        }
        else {
            team2bet = msg.sender;
        }

        matchId = _matchId;
    }

    function makeBet(uint _choice) payable {
        if(_choice == 1) {
            team1bet = msg.sender;
        }
        else {
            team2bet = msg.sender;
        }
    }

    function getMatchId() returns (uint) {
        return matchId;
    }

    function getFunds() returns (uint) {
        return this.balance;
    }

    function setWinner(uint winner) returns (bool) {
        if(winner == 1) {
            team1bet.send(this.balance);
        }
        else if (winner == 2) {
            team2bet.send(this.balance);
        }
        else {
            team1bet.send(this.balance/2);
            team2bet.send(this.balance/2);
        }

        return true;
    }
}
