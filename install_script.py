#!/usr/bin/python3

import subprocess
import time
from tqdm import tqdm
import requests
import random
import sys

def celebratory_confetti():
    confetti_symbols = [ "✨",]

    for _ in range(35):
        symbol = random.choice(confetti_symbols)
        print(symbol, end='', flush=True)
        time.sleep(0.1)
    print()

def is_installed(package_name):
    """ Check if a package is already installed. """
    result = subprocess.run(["dpkg", "-s", package_name], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    return 'install ok installed' in result.stdout.decode()

def install_packages(packages_str, fun_facts):
    packages_list = packages_str.split()  
    fun_facts_list = fun_facts.split(',') 

    for pkg in tqdm(packages_list, desc="Setting up your workstation...."):
        if is_installed(pkg):
            print(f"{pkg} is already installed. Skipping...")
            continue
        
        print(f"Attempting to install: {pkg}")
        try:
            subprocess.run(["sudo", "apt-get", "install", "-y", pkg], check=True)  
            time.sleep(1)
            print(random.choice(fun_facts_list))
        except subprocess.CalledProcessError as e:
            print(f"Error installing {pkg}: {e}")

    print("\nDevOps Mode: ACTIVATED!")
    celebratory_confetti()

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: script.py '<packages>' '<fun_facts_separated_by_comma>'")
        sys.exit(1)
    install_packages(sys.argv[1], sys.argv[2])
