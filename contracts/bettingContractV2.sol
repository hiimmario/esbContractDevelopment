pragma solidity ^0.4.11;
import "http://github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract bettingContractV2 is usingOraclize
{
    string public winner;

    string public team0name;
    string public team1name;

    address public team0bet;
    address public team1bet;

    uint public matchId;

    event LogWinnerUpdated(string winner);
    event LogNewOraclizeQuery(string description);

    function bettingContractV2(uint _matchId, uint _choice, string _winner) payable {
        if(_choice == 0) {
            team0bet = msg.sender;
            team0name = _winner;
        }
        else {
            team1bet = msg.sender;
            team1name = _winner;
        }

        matchId = _matchId;
    }

    function __callback(bytes32 myid, string result) {
        require(msg.sender == oraclize_cbAddress());

        winner = result;
        LogWinnerUpdated(winner);
    }

    function updateWinner() payable {
        if (oraclize_getPrice("URL") > this.balance) {
            LogNewOraclizeQuery("Oraclize query was NOT sent, please add some ETH to cover for the query fee");
        } else {
            LogNewOraclizeQuery("Oraclize query was sent, standing by for the answer..");
            oraclize_query("URL", "json(https://api.pandascore.co/matches?filter[id]=" + matchId + "&token=xFEMHt5iIXzTaDydesV2fk01-L-YKp7OFLcZcWZJ4tav2Og-7jA).0.winner.name");
        }
    }

    function makeBet(uint _choice, string _winner) payable {
        if(_choice == 0) {
            team0bet = msg.sender;
            team0name = _winner;
        }
        else {
            team1bet = msg.sender;
            team1name = _winner;
        }
    }

    function setWinner(uint winner) {
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
    }
}