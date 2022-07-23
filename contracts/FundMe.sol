// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FundMe {
    mapping(address => uint256) public addressToBalance;

    // we have 2 datatypes for Doctor persoanl information and Job specific information
    struct Doctor {
        address iD;
        string name;
        string specialisation;
        string location;
    }

    Doctor[] public listofdoctors;

    struct job {
        address doctor;
        address patient;
        string description;
        uint256 donation;
        string location;
    }

    job[] public jobs;

    mapping(address => uint256) doctorTojobId;
    mapping(uint256 => address) jobIdToPatient;

    function addDoctor(
        address iD,
        string memory _name,
        string memory _specialisation,
        string memory _location
    ) public {
        listofdoctors.push(Doctor(iD, _name, _specialisation, _location));
    }

    // payment method
    function payToDoctor(
        address doctor,
        address patient,
        string memory description,
        uint256 donation,
        string memory location
    ) public returns (bool) {
        if (donation > 0) {
            (bool success, ) = payable(doctor).call{value: donation}("");
            require(success, "Payment failed");
        }
        jobs.push(job(doctor, patient, description, donation, location));
        return true;
    }

    //get balance of account
    function getBalance(address person) external view returns (uint256) {
        return addressToBalance[person];
    }
}

// 1. Enum
// 2. Events
// 3. Try / Catch
// 4. Function Selector
// 5. abi.encode / decode
// 6. Hash with keccak256
// 7. Yul / Assembly
