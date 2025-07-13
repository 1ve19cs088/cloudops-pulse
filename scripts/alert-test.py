import time
import random

print("Simulating high CPU load...")
while True:
    x = [random.random() * random.random() for _ in range(1000000)]
    time.sleep(1)
