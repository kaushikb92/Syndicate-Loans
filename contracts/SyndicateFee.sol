pragma solidity ^0.4.8;

contract SyndicateFee{
/*Taking structure to store each amount as history*/
    struct FeeStatement{
        uint256 AgentBankFeeAmount;
        uint256 participantBank1FeeAmount;
        uint256 participantBank2FeeAmount;
        uint256 participantBank3FeeAmount;
        uint256 TotalFeeSubmitted;
        uint256 currentSessionFee;
        bytes32 transactionType; 
        uint countOfTransactionNumber;
        uint timeStamp;
    }
 
/*mapping the structure value to index tocheck how many times borrower paid the amount*/
    mapping(uint => FeeStatement) public index; 
          
/*Local Variables declared*/
        uint counter;
        uint256 AgentShareRatioForFacilityFee;
        uint256 P1_ShareRatioForFacilityFee;
        uint256 P2_ShareRatioForFacilityFee;
        uint256 P3_ShareRatioForFacilityFee;
        uint256 AgentShareRatioForAgentFee;
        uint256 P1_ShareRatioForAgentFee;
        uint256 P2_ShareRatioForAgentFee;
        uint256 P3_ShareRatioForAgentFee;

/*set contribution ratio in constructor as it is predefined */
    function SyndicateFee(){
        AgentShareRatioForFacilityFee = 40;
        P1_ShareRatioForFacilityFee = 15;
        P2_ShareRatioForFacilityFee = 25;
        P3_ShareRatioForFacilityFee = 20;
        AgentShareRatioForAgentFee = 70;
        P1_ShareRatioForAgentFee = 15;
        P2_ShareRatioForAgentFee = 10;
        P3_ShareRatioForAgentFee = 5;
       // FeeStatement.TotalFeeSubmitted = 0;
        counter = 0;
    }

    FeeStatement[] public FeeStatements; 

    function getCounterVal() constant returns(uint _counterVal){
        return (FeeStatements.length);
    }

    function submitFacilityFee(uint256 _currentSessionFee) returns(bool success) {
        counter += 1;
        FeeStatement memory newFee;
        newFee.AgentBankFeeAmount = ((_currentSessionFee * AgentShareRatioForFacilityFee)/100);
        newFee.participantBank1FeeAmount = ((_currentSessionFee * P1_ShareRatioForFacilityFee)/100);
        newFee.participantBank2FeeAmount = ((_currentSessionFee * P2_ShareRatioForFacilityFee)/100);
        newFee.participantBank3FeeAmount = ((_currentSessionFee * P3_ShareRatioForFacilityFee)/100);
        newFee.TotalFeeSubmitted += _currentSessionFee;
        newFee.currentSessionFee = _currentSessionFee;
        newFee.transactionType = "Facility Fee";
        newFee.timeStamp = block.timestamp;
        newFee.countOfTransactionNumber = counter;
        FeeStatements.push(newFee);
        index[counter] = newFee;
        return true;
    }

    function submitAgentFee(uint256 _currentSessionFee) returns(bool success) {
        counter += 1;
        FeeStatement memory newFee;
        newFee.AgentBankFeeAmount = ((_currentSessionFee * AgentShareRatioForAgentFee)/100);
        newFee.participantBank1FeeAmount = ((_currentSessionFee * P1_ShareRatioForAgentFee)/100);
        newFee.participantBank2FeeAmount = ((_currentSessionFee * P2_ShareRatioForAgentFee)/100);
        newFee.participantBank3FeeAmount = ((_currentSessionFee * P3_ShareRatioForAgentFee)/100);
        newFee.TotalFeeSubmitted += _currentSessionFee;
        newFee.currentSessionFee = _currentSessionFee;
        newFee.transactionType ="Agency Fee";
        newFee.timeStamp = block.timestamp;
        newFee.countOfTransactionNumber = counter;
        FeeStatements.push(newFee);
        index[counter] = newFee;
        return true;
    }

    function getAllocation() constant returns(uint256[], uint256[], uint256[], uint256[], uint[],uint256[],bytes32[]){

        uint256[] memory A1_shares = new uint256[](FeeStatements.length);
        uint256[] memory P1_shares = new uint256[](FeeStatements.length);
        uint256[] memory P2_shares = new uint256[](FeeStatements.length);
        uint256[] memory P3_shares = new uint256[](FeeStatements.length);
        //uint256[] memory TotalFeeSubmitteds = new uint256[](FeeStatements.length);
        uint[] memory dates = new uint[](FeeStatements.length);
        //uint[] memory indexes = new uint[](FeeStatements.length);
        uint256[] memory CurrentFeeSubmitteds = new uint256[](FeeStatements.length);
        bytes32[] memory transactionTypes = new bytes32[](FeeStatements.length);

            for (var i = 0; i < FeeStatements.length; i++) {
                FeeStatement memory currentFee;
                currentFee = FeeStatements[i];
                A1_shares[i] = currentFee.AgentBankFeeAmount;  
                P1_shares[i] = currentFee.participantBank1FeeAmount;  
                P2_shares[i] = currentFee.participantBank2FeeAmount;  
                P3_shares[i] = currentFee.participantBank3FeeAmount; 
                //TotalFeeSubmitteds[i] = currentFee.TotalFeeSubmitted;
                dates[i] = currentFee.timeStamp;
                //indexes[i] = currentFee.countOfTransactionNumber;
                CurrentFeeSubmitteds[i] = currentFee.currentSessionFee;
                transactionTypes[i] = currentFee.transactionType;
            }

        return(A1_shares,P1_shares,P2_shares, P3_shares,dates,CurrentFeeSubmitteds,transactionTypes);
        }

        function getResultsByIndex(uint _counterVal) constant returns(uint256,uint256,uint256,uint256,uint256,bytes32,uint){
            return(index[_counterVal].AgentBankFeeAmount,index[_counterVal].participantBank1FeeAmount,index[_counterVal].participantBank2FeeAmount,index[_counterVal].participantBank3FeeAmount,index[_counterVal].currentSessionFee,index[_counterVal].transactionType,index[_counterVal].timeStamp);
        }

        function getTotalFeeSubmitted() constant returns(uint256){
            uint len = FeeStatements.length;
            return (FeeStatements[len-1].TotalFeeSubmitted);

        }
}

  