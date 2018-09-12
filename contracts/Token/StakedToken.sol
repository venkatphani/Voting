pragma solidity ^0.4.24;

import "./ERC20Token.sol";
import "../ownership/Authorizable.sol";
import "./IStakeableToken.sol";
import "openzeppelin-solidity/contracts/AddressUtils.sol";
import "electusprotocol/contracts/Protocol/IElectusProtocol.sol";


//Authorizable because contracts(poll) can freeze funds
//Note that poll contract must be added into Authorizable
//This can be inherited because Authorizable is deployed with Freezable Token
//contract StakedToken is ERC20Token, Authorizable, IStakeable {

    // uint[8] public timePeriods;

    // uint public minStakeAmount;
    // uint public maxStakePeriod;
    // uint public minStakePeriod;

    // struct Stake {
    //     uint amount;
    //     uint endTime;
    // }

    // struct StakeBalance {
    //     uint stakedBalance; //stakedbalance + spendablebalance = balanceOfUser
    //     uint transferableBalance;
    //     mapping(uint => uint) stakedAgainstBalance;
    //     uint stakeWeight;  //token * time
    //     uint lastStakedAt;
    // }

    // event Staked(address indexed from, address indexed target, uint indexed endTime, uint amount, bytes32 data);

    // mapping(address => mapping(address => Stake[3])) stakedTokens; //stake[].length <= 3

    // //Transfer / stake - we check prev stakes and delete expired ones delete arr[]

    // mapping(address => address[15]) stakedAddresses; //stake for 15 addresses

    // mapping(address => StakeBalance) stakedBalances;

    // function getCurrentStakeWeight(address _user) external returns (uint){
        
    // }

    // function getTotalStakedFor(address _to) external returns (uint){
    //     uint TotalStakedFor = 0;
    //     address[15] storage addresses = stakedAddresses[_to];
    //     for (uint index = 0; index < addresses.length; index++){
    //         addresse = adresses[index];
    //         if (addresse == msg.sender){
    //             for (uint index = 0; index< stakedTokens[_to][addresse].length){
    //                 if (stakedTokens[_to][addresse].endTime > now){
    //                     TotalStakedFor += 1
    //                 }
    //             }
    //         }
    //     }
    //     return TotalStakedFor;
    // }

    // function getStakedToAddresses(address _user) external returns (address[15]){
    //     address[15] storage addresses = stakedAddresses[_user];
    //     address[] stakedToAddresses;
    //     for (uint index = 0; index < addresses.length; index++){
    //         address addresse = adresses[index];
    //         stake[3] storage tokens = stakedTokens[_user][addresse];
    //         for (uint index = 0; index < tokens.length; index++){
    //             if (tokens[index].endTime > now){
    //                 stakedToAddresses.push(addresse);
    //                 continue;
    //             }
    //         }
    //     }
    //     return stakedToAddresses;
    // }

    // function getStakeableBalance(address _user) external returns (uint){
    //     uint stakeableBalance = balanceOf(_user) - getTotalStakedBalance(_user) + getTotalStakedAgainstBalance(_user);
    //     return stakeableBalance;
    // }

    // function getTransferableBalance(address _user) external returns (uint){
    //     uint transferableBalance = balanceOf(_user) - getTotalStakedBalance(_user);
    //     return transferableBalance;
    // }

    // function getTotalStakedAgainstBalance(address _user) external returns (uint){
    //     uint stakedAgainstBalance = 0;
    //     for (uint8 index = 0; index < timePeriods.length; index++){
    //         if (timeperiods[index] > now){
    //             stakedAgainstBalance += stakedBalances[_user].stakedAgainstBalance[timeperiods[index]];
    //         }
    //     }
    //     return stakedAgainstBalance;
    // }

    // function getTotalStakedBalance(address _user) external returns (uint) {
    //     address[15] storage addresses = stakedAddresses[_user];
    //     require(addresses[0] != address(0),"You dont have any stakes");
    //     uint stakedBalance = 0;
    //     for (uint8 index = 0; index < addresses.length; index++){
    //         Stake[3] storage stakeArray = stakedTokens[_user][addresses[index]];
    //         for (uint8 index = 0; index < stakeArray.length; index++){
    //             if (stakeArray[index].endTime > now) {
    //                 stakedBalance += stakeArray[index].amount;
    //             }
    //         }
    //     }
    //     return stakedBalance;
    // }

    // constructor(uint _minStakeAmount, uint _minStakePeriod, uint _maxStakePeriod) public {
    //     minStakeAmount = _minStakeAmount;
    //     maxStakePeriod = _maxStakePeriod;
    //     minStakePeriod = _minStakePeriod;
    // }

    // function stakeFor(address _to, uint _amount, uint _endTime, bytes32 data) external {
    //     require(to != address(0), "Don't stake to zero address");
    //     require(_amount >= minStakeAmount, "Amount less than Minimum Stake amount of (in ether) " + SafeMath.mul(minStakeAmount * 10^-18));
    //     require(AddressUtils.isContract(_to), "Must only stake to contracts and not EOA's");
    //     IElectusProtocol protocolContract = IElectusProtocol(_to);
    //     require(protocolContract.isCurrentMember(msg.sender), "User doesn't hold a membership from entity he wants to stake against");
    //     require(_endTime > now && _endTime - now > minStakePeriod && _endTime - now < maxStakePeriod, "Time period doesn't satisfy the requirements");

        
        
    //     Stake[] storage currentStakes = stakedTokens[msg.sender][_to];
    //     bool isVacant = false;
    //     for (uint8 index = 0; index < currentStakes.length; index++) {
    //         //handle same endtime -- increase amount
    //         if(currentStakes[index].amount == 0) {
    //             currentStakes[index] = Stake({amount: _amount, endTime: _endTime});
    //         }
    //     }
    //     if(!isOldAddress) stakedAddresses.push(_to);

    //     emit Staked(msg.sender, _to, _endTime, _amount, data);
    // }

    // function stake(uint _amount, uint _endTime, bytes32 data) external;
    // function increaseStake(uint _amount, uint _endTime, bytes32 data) external;
    // function increaseStakeFor(address _to, uint _amount, uint _endTime, bytes32 data) external;
    // function getTotalStakedBalance(address _user) external returns (uint) {

    // }
    // function getTotalStakedAgainstBalance(address _user) external returns (uint);
    // function getTransferableBalance(address _user) external returns (uint);
    // function getStakeableBalance(address _user) external returns (uint);
    // function getCurrentStakeWeight(address _user) external returns (uint);
    // function getStakedToAddresses(address _user) external returns (address[15]);
    // function getTotalStakedFor(address _to) external returns (uint);



    // //No Unstake

    // //When user stakes a token, the amount becomes frozen and non-transferable. Need to modify 
    // //Freezable Token to.. not freeze account but account + balance. 
    // //Need some sort of transferableBalance check

    // //Need calculation for totalTransferable Balance at this moment
    // //Need calculation for totalStaked Balance at this moment
    // //Sum of both must be user balance

    // //Query for staked against you + balances
    
    // //Query to return all stakes you made for others. Cum balances

    // //Vote weightage calculation based on this.


    // function stakeBalance(address target, uint amount, uint endTime) external onlyAuthorized {

    //      freezeAccount(target);
        
    // }

    // // @dev Limit token transfer if _sender is frozen.
    // modifier canTransfer(address _sender) {
    //     require(!frozenAccounts[_sender]); //&& stake period end
    //     _;
    // }

    // function transfer(address _to, uint256 _value) public canTransfer(msg.sender) returns (bool success) {
    //     // Call StandardToken.transfer()
    //     //Check if staked
    //     return super.transfer(_to, _value);
    // }

    // function transferFrom(address _from, address _to, uint256 _value) public canTransfer(_from) 
    // returns (bool success) {
    //     // Call StandardToken.transferForm()
    //     //Check if staked
    //     return super.transferFrom(_from, _to, _value);
    // }
//}


