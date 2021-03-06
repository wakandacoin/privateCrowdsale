pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/WhitelistCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/distribution/PostDeliveryCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/IndividuallyCappedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/PausableCrowdsale.sol";


contract WakandaCoinPrivateCrowdsale is Crowdsale,CappedCrowdsale, IndividuallyCappedCrowdsale, TimedCrowdsale, WhitelistCrowdsale, PausableCrowdsale, PostDeliveryCrowdsale{

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
        Crowdsale(_rate, wallet, token) 
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
