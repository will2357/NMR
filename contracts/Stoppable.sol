pragma solidity ^0.4.10;

import "Sharable.sol";

/*
 * Stoppable
 * Abstract contract that allows children to implement an
 * emergency stop mechanism.
 */
contract Stoppable is Sharable {
  bool public stopped;

  modifier stopInEmergency { if (!stopped) _; }
  modifier onlyInEmergency { if (stopped) _; }

  function Stoppable(address[] _owners, uint _required) Sharable(_owners, _required) {
  }

  // called by the owner on emergency, triggers stopped state
  function emergencyStop() external onlyOwner {
    stopped = true;
  }

  // called by the owner on end of emergency, returns to normal state
  function release() external onlyManyOwners(sha3(msg.data)) onlyInEmergency {
    stopped = false;
  }
}