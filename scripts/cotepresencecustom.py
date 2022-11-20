#!/usr/bin/env python3
from pypresence import Presence # The simple rich presence client in pypresence
import time

CHAPTER = input("Enter Chapter: ")

x=input("Enter Cover Image: ")
if x:
    IMAGE=x
else:
    IMAGE="https://static.wikia.nocookie.net/youkoso-jitsuryoku-shijou-shugi-no-kyoushitsu-e/images/5/5f/LN_2nd_Year_Vol_4.5_cover.jpg/revision/latest?cb=20210616124247"

client_id = "959612994214592583"  # Put your Client ID in here
RPC = Presence(client_id)  # Initialize the Presence client
RPC.connect() # Start the handshake loop
# CHAPTER='Chapter 3: "Summer is Almost Here, a Premonition of a Fierce Battle"'

while True:  # The presence will stay on as long as the program is running
    RPC.update(
        details="2nd Year Volume 4.5",
        state=CHAPTER,
        large_image=IMAGE,
        start=int(time.time()),
        buttons=[{"label": "read it here :)", "url": "https://readlightnovels.net/youkoso-jitsuryoku-shijou-shugi-no-kyoushitsu-e.html"},],
    )
    time.sleep(60) #Wait a wee bit
