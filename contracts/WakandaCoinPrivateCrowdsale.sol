pragma solidity ^0.5.0;

import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/v2.5.1/contracts/token/ERC20/IERC20.sol";
import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/v2.5.1/contracts/crowdsale/Crowdsale.sol";
import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/v2.5.1/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/v2.5.1/contracts/crowdsale/validation/WhitelistCrowdsale.sol";
import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/v2.5.1/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/v2.5.1/contracts/crowdsale/distribution/PostDeliveryCrowdsale.sol";
import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/v2.5.1/contracts/crowdsale/validation/IndividuallyCappedCrowdsale.sol";
import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/v2.5.1/contracts/crowdsale/validation/PausableCrowdsale.sol";

contract WakandaCoinPrivateCrowdsale is Crowdsale,CappedCrowdsale, IndividuallyCappedCrowdsale, TimedCrowdsale, WhitelistCrowdsale, PausableCrowdsale, PostDeliveryCrowdsale{

	string internal constant _wallet = '0x06f6d9d14EA5Bb788CcD0e83e102758986eFbbBA';
	string internal constant _token = '0x8447A658adD00193aE43DE330f2EA7524cE65B75';

    uint256 internal constant tokenUnit = 10**18;
    uint256 internal constant oneQuadrillion = 10**15;
    uint256 internal constant oneBillion = 10**9;
    uint256 internal constant maxSupply = oneQuadrillion * tokenUnit;

    uint256 internal constant _cap = ( (oneQuadrillion/100) * 5 ) * tokenUnit;
    
    uint256 internal constant _rate = oneBillion - 471666667;
    
    uint256 internal constant _minCap = 2 * tokenUnit;
    
    uint256 internal constant _openingTime = 1626604390;
    uint256 internal constant _closeingTime = 1629073772;

    constructor(
        address payable wallet, 
        IERC20 token
    )  
        Crowdsale(_rate, _wallet, _token) 
        CappedCrowdsale(_cap)
        TimedCrowdsale(_openingTime, _closeingTime)
    public {
        
    }
    
    function _preValidatePurchase(
        address _beneficiary, 
        uint256 _weiAmount
    ) internal view {

        super._preValidatePurchase(_beneficiary, _weiAmount);
        require(_weiAmount >= _minCap, "Investment is lower than the set minimum" );
    }
    
    function extendClosingTime(uint256 newClosingTime) public {
        
        _extendTime(newClosingTime);
        
    }
    
    
}
