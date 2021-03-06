pragma solidity ^0.4.25;

import "./BasePoll.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "../Token/FreezableToken.sol";


//these poll contracts are independent. Hence, protocol must be passed as a ctor parameter. 
//These contracts will usually be deployed by Action contracts. Hence, these must refer Authorizable
contract TokenProportionalCapped is BasePoll {

    FreezableToken public token;
    uint public capPercent;
    uint public capWeight;

    constructor(address[] _protocolAddresses, bytes32[] _proposalNames, address _tokenAddress, uint _capPercent, 
    bytes32 _voterBaseLogic, bytes32 _pollName, bytes32 _pollType, uint _startTime, uint _duration) public BasePoll
    (_protocolAddresses, _proposalNames, _voterBaseLogic, _pollName, _pollType, _startTime, _duration) {
        token = FreezableToken(_tokenAddress);
        capPercent = _capPercent;
        capWeight = SafeMath.div(SafeMath.mul(_capPercent, token.getTotalMintableSupply()), 100);
        require(_capPercent < 1000, "Percentage must be less than 10");
    }

    function vote(uint8 _proposal) external isPollStarted {
        Voter storage sender = voters[msg.sender];
        uint voteWeight = calculateVoteWeight(msg.sender);
        //vote weight is multiplied by 100 to account for decimals
        
        if (canVote(msg.sender) && !sender.voted && _proposal < proposals.length) {
            sender.voted = true;
            sender.vote = _proposal;
            sender.weight = voteWeight;
            proposals[_proposal].voteWeight += sender.weight;
            proposals[_proposal].voteCount += 1;
            emit CastVote(msg.sender, _proposal, sender.weight);
            //Need to check whether we can freeze or not.!
            token.freezeAccount(msg.sender);
        } else {
            emit TriedToVote(msg.sender, _proposal, voteWeight);
        }
    }

    function revokeVote() external isValidVoter {
        Voter storage sender = voters[msg.sender];
        require(sender.voted, "Hasn't yet voted.");
        uint8 votedProposal = sender.vote;
        uint voteWeight = sender.weight;
        sender.voted = false;
        proposals[sender.vote].voteWeight -= sender.weight;
        proposals[sender.vote].voteCount -= 1;
        sender.vote = 0;
        sender.weight = 0;
        emit RevokedVote(msg.sender, votedProposal, voteWeight);
        token.unFreezeAccount(msg.sender);
    }

    function calculateVoteWeight(address _to) public view returns (uint) {
        uint currentWeight = SafeMath.mul(token.balanceOf(_to), 100);
        return currentWeight > capWeight ? capWeight : currentWeight;
    }
}