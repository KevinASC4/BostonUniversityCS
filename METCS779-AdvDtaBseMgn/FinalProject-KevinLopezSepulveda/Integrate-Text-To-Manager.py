import mysql.connector
from twilio.rest import Client
import boto3
from datetime import datetime, timedelta

# === CONFIGURATION ===

# MySQL Cloud DB config
DB_CONFIG = {
    'host': 'sql5.freesqldatabase.com',
    'user': 'sql5794428',
    'password': '7qm3Q2ln6Q',
    'database': 'sql5794428'
}


# Inventory threshold
LOW_STOCK_THRESHOLD = 20

# === FUNCTIONS ===

def get_low_inventory_items(cursor):
    query = "SELECT item_name, quantity_in_stock FROM inventory WHERE quantity_in_stock < %s"
    cursor.execute(query, (LOW_STOCK_THRESHOLD,))
    return cursor.fetchall()

#ADD YOUR TWILIO SMS TO Manager here

# === MAIN EXECUTION ===

def main():
    try:
        db = mysql.connector.connect(**DB_CONFIG)
        cursor = db.cursor()

        # Check low inventory and send SMS alert if any
        low_items = get_low_inventory_items(cursor)
        if low_items:
            sms_body = "Low Inventory Alert:\n" + "\n".join([f"- {name}: {qty} left" for name, qty in low_items])
            #send_sms(sms_body)
        else:
            print("No low inventory items.")

    except Exception as e:
        print(f"Error: {e}")

    finally:
        if cursor:
            cursor.close()
        if db:
            db.close()

if __name__ == "__main__":
    main()