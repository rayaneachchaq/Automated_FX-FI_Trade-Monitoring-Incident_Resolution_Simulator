## About This Project
I built this project to replicate the day-to-day technical reality of a Pre-Trade Functional Support Analyst working with Global Markets (FOREX and Fixed Income). 

Instead of just reading about support workflows, I wanted a hands-on way to practice. I created a mock trading engine in Python that generates realistic trade traffic and occasionally injects errors. I then use standard Linux command-line tools to investigate these raw logs and SQL queries to track recurring incidents, mimicking the exact environment of a trading floor support desk.

## Tech Stack
* Log Generation: Python
* Log Analysis: Linux / Bash (grep, awk, tail, sed)
* Incident Tracking & Monitoring: SQL

## Support Runbook (Fiches Réflexes)

This section acts as my personal knowledge base. It outlines the standard operating procedures for the Level 1 and Level 2 support team to ensure we resolve trading incidents quickly and accurately.

### Incident 1: Pricing Engine Disconnection (Error: TECH_503)
* What the user sees: Traders will usually call in or raise a ticket saying prices have suddenly stopped updating or disappeared from their UI.
* How to investigate: Run a quick `grep` for "TECH_503" in the `fx_trading_system.log` to pinpoint exactly when the disconnect happened and which node failed.
* How to resolve: 
  1. Verify network connectivity to PRICING_NODE_01.
  2. If the primary node is unresponsive, failover the feed to the secondary pricing server.
  3. Immediately escalate the specific log snippets to the Infrastructure/Production team so they can investigate the hardware or network root cause.

### Incident 2: Trade Rejection due to Limits (Error: FUNC_401)
* What the user sees: A Salesperson or Trader gets a "Limit Exceeded" warning when attempting to book a trade.
* How to investigate: Filter the logs by "ORDER_REJECTED" and the specific user's ID to confirm the exact timestamp and error code.
* How to resolve: 
  1. Verify the current market limits set for the requested product (e.g., EUR/USD).
  2. Explain to the user that their risk limit has been breached.
  3. If they need a temporary limit increase to process a critical client order, secure explicit approval from the Middle Office or Risk team before making any manual adjustments in the database.

### Incident 3: Execution Latency Spikes (Warning: >500ms)
* What the user sees: Algorithmic trading bots or traders start experiencing slippage because orders are taking too long to execute on the market.
* How to investigate: Run the latency extraction bash script to see if the delay is isolated to a single product or affecting the entire global system.
* How to resolve: 
  1. Cross-reference the timeline with the MarketDataFeed logs to see if we are simply handling a massive spike in market activity (like a major news release).
  2. If the latency stays above 500ms for more than 5 minutes without a clear market reason, open a high-priority ticket with the core development team to investigate system performance.
