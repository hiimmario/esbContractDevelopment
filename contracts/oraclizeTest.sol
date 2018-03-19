pragma solidity ^0.4.11;
import "http://github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract bettingContractV2 is usingOraclize
{
  string public winner;

  event LogWinnerUpdated(string winner);
  event LogNewOraclizeQuery(string description);

  function bettingContractV2() payable {
    updateWinner();
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
      oraclize_query("URL", "json(https://api.pandascore.co/matches?filter[id]=21835&token=xFEMHt5iIXzTaDydesV2fk01-L-YKp7OFLcZcWZJ4tav2Og-7jA).0.winner.name");
    }
  }

  function getWinner() returns (string) {
    return winner;
  }
}

