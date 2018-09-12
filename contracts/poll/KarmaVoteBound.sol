pragma solidity ^0.4.24;

import "./BasePollBound.sol";


//All time bound contracts are abstract in nature. They need to be used within action contracts to 
//fulfill OnPollFinish() implementation.
//these poll contracts are independent. Hence, protocol must be passed as a ctor parameter. 
//These contracts will usually be deployed by Action contracts. Hence, these must refer Authorizable
contract KarmaVoteBound is BasePollBound {

    constructor(address _electusProtocol, address _authorizable, bytes32[] _proposalNames, 
    uint _startTime, uint _endTime) public BasePollBound(_electusProtocol, _authorizable, _proposalNames,
    _startTime, _endTime) {
    }

    function calculateVoteWeight(address _to) public view returns (uint) {
        Voter storage sender = voters[_to];
        if(sender.weight == 0) return 1;
        return sender.weight;
    }

    function vote(uint8 proposal) external isValidVoter checkTime {
        Voter storage sender = voters[msg.sender];
        uint voteWeight = calculateVoteWeight(msg.sender);
        emit TriedToVote(msg.sender, _propsal, voteWeight);
        if (canVote(msg.sender) && !sender.voted){
            sender.voted = true;
            sender.vote = _proposal;
            sender.weight = voteWeight;
            proposals[_proposal].voteCount += voteWeight;
            proposals[_proposal].voteCount += 1;
            emit CastVote(msg.sender, _proposal, voteWeight);
        }
    }

    function revokeVote() public isValidVoter checkTime {
        Voter storage sender = voters[msg.sender];
        require(sender.voted, "Hasn't yet voted.");
        uint votedProposal = sender.vote;
        uint voteWeight = sender.voteWeight;
        sender.voted = false;
        proposals[sender.vote].voteWeight -= sender.weight;
        proposals[sender.vote].voteCount -= 1;

        sender.vote = 0;
        if (sender.weight == 1) {
            sender.weight = 0;
        }
        emit RevokedVote(msg.sender, votedProposal, voteWeight);
    }
}