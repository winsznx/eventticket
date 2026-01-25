// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title EventTicket
 * @notice Blockchain ticketing with resale controls
 */
contract EventTicket {
    error SoldOut();
    error NotOwner();
    error InvalidPrice();

    event TicketMinted(uint256 indexed ticketId, address indexed buyer);
    event TicketTransferred(uint256 indexed ticketId, address indexed from, address indexed to);

    struct Ticket {
        uint256 eventId;
        address owner;
        uint256 price;
        bool used;
    }

    mapping(uint256 => Ticket) public tickets;
    mapping(uint256 => uint256) public eventSupply;
    mapping(uint256 => uint256) public eventPrice;
    uint256 public ticketCounter;

    function createEvent(uint256 eventId, uint256 supply, uint256 price) external {
        eventSupply[eventId] = supply;
        eventPrice[eventId] = price;
    }

    function mint(uint256 eventId) external payable returns (uint256) {
        if (eventSupply[eventId] == 0) revert SoldOut();
        if (msg.value < eventPrice[eventId]) revert InvalidPrice();
        
        uint256 ticketId = ticketCounter++;
        tickets[ticketId] = Ticket({
            eventId: eventId,
            owner: msg.sender,
            price: msg.value,
            used: false
        });
        
        eventSupply[eventId]--;
        emit TicketMinted(ticketId, msg.sender);
        return ticketId;
    }

    function transfer(uint256 ticketId, address to) external {
        if (tickets[ticketId].owner != msg.sender) revert NotOwner();
        tickets[ticketId].owner = to;
        emit TicketTransferred(ticketId, msg.sender, to);
    }

    function useTicket(uint256 ticketId) external {
        if (tickets[ticketId].owner != msg.sender) revert NotOwner();
        tickets[ticketId].used = true;
    }

    function getTicket(uint256 ticketId) external view returns (uint256, address, uint256, bool) {
        Ticket memory t = tickets[ticketId];
        return (t.eventId, t.owner, t.price, t.used);
    }
}
