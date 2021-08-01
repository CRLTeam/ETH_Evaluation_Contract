// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

/**
 * @title A smart contract for evaluating blockchain interoperability of Ethereuem state data 
 * @author Dave McKay - Ryerson Cybersecurity Research Lab
 * @notice This is available for use in any system and is under the MIT licnece
*/

contract Evaluation {
   
    address public owner;
    uint public stateData;
    uint public createBlock;


    /** @dev Create a new Evaluation contract */
    constructor() {
        owner = msg.sender;
        stateData = 0;
        createBlock = block.number;
    }

    /** @dev Allows execution by owner only */
    modifier ownerOnly {
        require(msg.sender == owner, "This can only be called by the contract owner!");
        _;
    }

    /** @dev Notification of change of data */
    event watchState(
        uint _stateData   
    );
    
    /** @dev Notification of interop call */
    event interopCall(
        string interopDID, 
        string func, 
        string value, 
        string callerDID, 
        uint nonce,
        string sig,
        uint block,
        address sender,
        address origin
    );
    
    /** 
     * @dev readState 
     * @return returns the current value of the state data
    */
    function readState() public view returns (uint) {
        return stateData;
    }
    
    /** 
     * @dev writeState 
     * @param _newState the new value to set the state data to
    */
    function writeState(uint _newState) public ownerOnly {
        stateData = _newState;
        emit watchState(stateData);
    }
    
    /** 
     * @dev callInterop 
     * @param interopDID - DID of the system and smart contract to call 
     * @param func - function to call on smart contract
     * @param value - value to pass
     * @param callerDID - DID of caller
     * @param nonce - unique number
     * @param sig - encrypted hash of preceeding values
    */
    function callInterop(string memory interopDID, string memory func, string memory value, string memory callerDID, uint nonce, string memory sig) public ownerOnly {
        emit interopCall(interopDID, func, value, callerDID, nonce, sig, block.number, msg.sender, tx.origin);
    }
}
    
    
    

