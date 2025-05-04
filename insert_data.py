import sqlite3
import csv
import sys
from datetime import datetime

# Increase field size limit
csv.field_size_limit(sys.maxsize)

# Connect to SQLite DB
conn = sqlite3.connect("storage/development.sqlite3")
cursor = conn.cursor()

# Open the CSV
with open("data.csv", newline='', encoding='utf-8') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        # Map and insert values
        cursor.execute("""
            INSERT INTO scrapper_dbs
            (id, url, meta_data, source_provider, sub_type, response, created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """, (
            int(row['id'])+ 5,
            row['scrapped_url'],
            row['tags_array'],      # meta_data
            row['provider'],        # source_provider
            row['id_slug'],         # sub_type
            row['raw_json_data'],   # response
            datetime.now().isoformat(),  # created_at
            datetime.now().isoformat()   # updated_at
        ))

conn.commit()
conn.close()
print("Rows inserted successfully.")
