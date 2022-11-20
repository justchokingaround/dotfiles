#!/usr/bin/env python3
from pypresence import Presence # The simple rich presence client in pypresence
import time

client_id = "959612994214592583"  # Put your Client ID in here
RPC = Presence(client_id)  # Initialize the Presence client
RPC.connect() # Start the handshake loop
IMAGE="https://static.zerochan.net/Youkoso.Jitsuryoku.Shijou.Shugi.no.Kyoushitsu.e%3A.2-Nensei-hen.full.2958821.jpg"
CHAPTER='Chapter 3: "Summer is Almost Here, a Premonition of a Fierce Battle"'

while True:  # The presence will stay on as long as the program is running
    RPC.update(
        details="2nd Year Volume 2",
        state=CHAPTER,
        large_image=IMAGE,
        start=int(time.time()),
        buttons=[{"label": "read it here :)", "url": "https://readlightnovels.net/youkoso-jitsuryoku-shijou-shugi-no-kyoushitsu-e.html"},],
    )
    time.sleep(60) #Wait a wee bit
