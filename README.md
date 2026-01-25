# EventTicket

Blockchain-based event ticketing with resale controls on Base and Stacks blockchains.

## Features

- Create events with ticket supply and pricing
- Mint tickets as NFTs
- Transfer tickets to other users
- Mark tickets as used for entry
- Prevent double-spending and fraud

## Smart Contract Functions

### Base (Solidity)
- `createEvent(uint256 eventId, uint256 supply, uint256 price)` - Create event
- `mint(uint256 eventId)` - Purchase ticket
- `transfer(uint256 ticketId, address to)` - Transfer ticket
- `useTicket(uint256 ticketId)` - Mark ticket as used
- `getTicket(uint256 ticketId)` - Get ticket details

### Stacks (Clarity)
- `(create-event (event-id uint) (supply uint) (price uint))` - Create event
- `(mint-ticket (event-id uint))` - Mint ticket
- `(get-ticket (ticket-id uint))` - Get ticket info

## Tech Stack

- **Frontend**: Next.js 14, TypeScript, Tailwind CSS
- **Base**: Solidity 0.8.20, Foundry, Reown wallet
- **Stacks**: Clarity v4, Clarinet, @stacks/connect

## Getting Started

```bash
pnpm install
pnpm dev
```

## License

MIT License
