import time
import random
import logging
from datetime import datetime

# Setup basic logging to file
logging.basicConfig(filename='fx_trading_system.log', level=logging.INFO, 
                    format='[%(asctime)s] [%(levelname)s] %(message)s', datefmt='%Y-%m-%d %H:%M:%S')

COMPONENTS = ['PricingEngine', 'OrderGateway', 'RiskValidator', 'MarketDataFeed']
PRODUCTS = ['EUR/USD', 'USD/JPY', 'GBP/USD', 'OAT_10Y', 'BUND_10Y']
USERS = ['TRADER_A', 'TRADER_B', 'SALES_PARIS', 'ALGO_BOT_1']

def generate_log():
    component = random.choice(COMPONENTS)
    product = random.choice(PRODUCTS)
    user = random.choice(USERS)
    
    # 85% chance of normal operation, 15% chance of incident
    scenario = random.random()
    
    if scenario > 0.15:
        msg = f"[{component}] [{user}] [{product}] Action: ORDER_ACKNOWLEDGED - Status: SUCCESS - Latency: {random.randint(5, 45)}ms"
        logging.info(msg)
    else:
        # Simulate specific functional and technical incidents
        error_type = random.choice(['REJECT', 'LATENCY', 'DISCONNECT'])
        
        if error_type == 'REJECT':
            msg = f"[{component}] [{user}] [{product}] Action: ORDER_REJECTED - Reason: LIMIT_EXCEEDED - ErrorCode: FUNC_401"
            logging.warning(msg)
        elif error_type == 'LATENCY':
            latency = random.randint(500, 2500)
            msg = f"[{component}] [{user}] [{product}] Action: ORDER_FILLED - Warning: HIGH_LATENCY - Latency: {latency}ms"
            logging.warning(msg)
        elif error_type == 'DISCONNECT':
            msg = f"[{component}] [SYSTEM] [ALL] Alert: CONNECTION_LOST - Server: PRICING_NODE_01 - ErrorCode: TECH_503"
            logging.error(msg)

if __name__ == "__main__":
    print("Starting FX/FI Trading Simulator... Press Ctrl+C to stop.")
    try:
        while True:
            generate_log()
            time.sleep(random.uniform(0.1, 1.5)) # Random interval between logs
    except KeyboardInterrupt:
        print("\nSimulator stopped.")
