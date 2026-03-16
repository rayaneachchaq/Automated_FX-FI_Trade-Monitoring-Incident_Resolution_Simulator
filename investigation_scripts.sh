#!/bin/bash
# Collection of Bash commands used for daily Level 1 / Level 2 Support investigations

LOG_FILE="fx_trading_system.log"

echo "--- 1. Real-time monitoring for technical errors (Tech_503) ---"
# Used to watch the system live and alert if the pricing engine drops
tail -f $LOG_FILE | grep --color=always "TECH_503"

echo "--- 2. Extracting all rejected trades for today ---"
# Used when a trader complains their orders are not passing
grep "ORDER_REJECTED" $LOG_FILE > rejected_trades.log
cat rejected_trades.log

echo "--- 3. Counting incidents by Product (FI/FX) ---"
# Used to identify recurrent functional issues per currency pair or bond
grep "WARNING\|ERROR" $LOG_FILE | awk -F'[][]' '{print $8}' | sort | uniq -c | sort -nr

echo "--- 4. Finding High Latency spikes (>500ms) for Algo Bots ---"
# Used to investigate execution delays affecting automated trading
grep "HIGH_LATENCY" $LOG_FILE | grep "ALGO_BOT_1"
