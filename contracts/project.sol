// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract MicrofinanceLendingPlatform {
    address public owner;
    uint256 public loanCount;
    uint256 public platformFeePercent = 2;

    struct Loan {
        uint256 id;
        address payable borrower;
        address payable lender;
        uint256 amount;
        uint256 interestRate;
        uint256 duration; // in seconds
        uint256 startTime;
        bool isFunded;
        bool isRepaid;
    }

    mapping(uint256 => Loan) public loans;

    event LoanRequested(
        uint256 indexed id,
        address indexed borrower,
        uint256 amount,
        uint256 interestRate,
        uint256 duration
    );

    event LoanFunded(
        uint256 indexed id,
        address indexed lender,
        uint256 amount
    );

    event LoanRepaid(
        uint256 indexed id,
        address indexed borrower,
        uint256 totalAmount
    );

    event OwnerChanged(address indexed oldOwner, address indexed newOwner);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function requestLoan(
        uint256 _amount,
        uint256 _interestRate,
        uint256 _duration
    ) public {
        require(_amount > 0, "Amount must be greater than zero");
        require(_duration > 0, "Invalid duration");

        loanCount++;
        loans[loanCount] = Loan({
            id: loanCount,
            borrower: payable(msg.sender),
            lender: payable(address(0)),
            amount: _amount,
            interestRate: _interestRate,
            duration: _duration,
            startTime: 0,
            isFunded: false,
            isRepaid: false
        });

        emit LoanRequested(loanCount, msg.sender, _amount, _interestRate, _duration);
    }

    function fundLoan(uint256 _loanId) public payable {
        Loan storage loan = loans[_loanId];
        require(_loanId > 0 && _loanId <= loanCount, "Invalid loan ID.");
        require(!loan.isFunded, "Loan already funded");
        require(msg.value == loan.amount, "Incorrect amount sent");

        uint256 fee = (msg.value * platformFeePercent) / 100;
        payable(owner).transfer(fee);

        uint256 amountAfterFee = msg.value - fee;
        loan.borrower.transfer(amountAfterFee);

        loan.lender = payable(msg.sender);
        loan.isFunded = true;
        loan.startTime = block.timestamp;

        emit LoanFunded(_loanId, msg.sender, msg.value);
    }

    function repayLoan(uint256 _loanId) public payable {
        Loan storage loan = loans[_loanId];
        require(loan.isFunded, "Loan not funded");
        require(!loan.isRepaid, "Already repaid");
        require(msg.sender == loan.borrower, "Only borrower can repay");

        uint256 interest = (loan.amount * loan.interestRate) / 100;
        uint256 totalAmount = loan.amount + interest;

        require(msg.value == totalAmount, "Incorrect repayment amount");

        loan.lender.transfer(msg.value);
        loan.isRepaid = true;

        emit LoanRepaid(_loanId, msg.sender, msg.value);
    }

    function getLoanDetails(uint256 _loanId)
        public
        view
        returns (
            uint256,
            address,
            address,
            uint256,
            uint256,
            uint256,
            bool,
            bool
        )
    {
        Loan memory l = loans[_loanId];
        return (
            l.id,
            l.borrower,
            l.lender,
            l.amount,
            l.interestRate,
            l.duration,
            l.isFunded,
            l.isRepaid
        );
    }

    function changeOwner(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Invalid address");
        emit OwnerChanged(owner, _newOwner);
        owner = _newOwner;
    }

    function updatePlatformFee(uint256 _newFeePercent) public onlyOwner {
        require(_newFeePercent <= 10, "Fee too high");
        platformFeePercent = _newFeePercent;
    }

    receive() external payable {}
}

