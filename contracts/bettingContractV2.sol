pragma solidity ^0.4.11;
import "http://github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract bettingContractV2 is usingOraclize
{
    string public team0name;
    string public team1name;

    address public team0bet;
    address public team1bet;

    uint public matchId;
    string public winner;

    string public oraclizeUrl;

    event LogWinnerUpdated(string winner);
    event LogNewOraclizeQuery(string description);

    function bettingContractV2(uint _matchId, string _teamName, string _url) payable {

        team0bet = msg.sender;
        team0name = _teamName;
        matchId = _matchId;
        oraclizeUrl = _url;
    }

    function makeBet(string _teamName) payable {

        team1bet = msg.sender;
        team1name = _teamName;
    }

    function updateWinner() payable {
        if (oraclize_getPrice("URL") > this.balance) {
            LogNewOraclizeQuery("Oraclize query was NOT sent, please add some ETH to cover for the query fee");
        } else {
            LogNewOraclizeQuery("Oraclize query was sent, standing by for the answer..");
            oraclize_query("URL", oraclizeUrl);
        }
    }

    function __callback(bytes32 myid, string result) {
        require(msg.sender == oraclize_cbAddress());

        winner = result;
        LogWinnerUpdated(winner);

        payout();
    }

    function payout() {
        if(compareStrings(winner, team0name)) {
            team0bet.send(this.balance);
        }

        if(compareStrings(winner, team1name)) {
            team1bet.send(this.balance);
        }
    }

    function compareStrings (string a, string b) view returns (bool){
        return keccak256(a) == keccak256(b);
    }

    function setWinner(string _winner) {
        winner = _winner;
        payout();
    }
}