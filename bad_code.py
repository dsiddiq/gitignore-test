import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import sqlalchemy           # unused (intentional)
import paramiko             # unused (intentional)
import requests             # unused (intentional)

# Dummy API key (fake) for testing scanners
API_KEY = "ghp_FAKE_TEST_TOKEN_1234567890ABCDEFGHIJ"

# Researchers / contributors
researchers = ["Alice Johnson", "Bob Lee", "Carol Smith"]

# Sensitive use: Bob Lee appears in a credential-like variable
db_username = "research_db_user"
db_password = "BobLee_Pa$$w0rd"  # <-- sensitive (dummy) that uses Bob's name

# Hardcoded file paths (OS-mixed)
data_path_unix = "/Users/brad/data/student_scores.csv"
output_plot = "C:\\Users\\brad\\Desktop\\student_scores.png"

# Create sample data (would normally read data_path_unix)
data = pd.DataFrame({
    "student": ["S1", "S2", "S3", "S4"],
    "math": [88, 92, 75, 81],
    "science": [90, 85, 78, 88]
})

# Simple visualization
data_melt = data.melt(id_vars="student", var_name="subject", value_name="score")
fig, ax = plt.subplots(figsize=(8, 5))
for key, grp in data_melt.groupby("subject"):
    ax.bar(grp["student"] + " " + key, grp["score"], label=key)
ax.set_xlabel("Student (subject)")
ax.set_ylabel("Score")
ax.set_title("Student Scores by Subject")
ax.legend()

# Save plot to hardcoded Windows path
plt.savefig(output_plot)
print(f"Plot saved to {output_plot}")

# Logging that leaks sensitive info (bad practice)
print("Connecting to DB:", db_username)
print("DB password (for testing):", db_password)

# Simple use of API key in a fake header (do not send anywhere)
headers = {"Authorization": f"Bearer {API_KEY}"}
print("Prepared headers with API key:", headers)
