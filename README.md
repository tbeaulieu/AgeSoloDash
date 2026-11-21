<img width="1027" height="615" alt="image" src="https://github.com/user-attachments/assets/aabcda13-0633-4fc8-8b0f-0e6631b87311" />

# Age Solo Dash

Dashboard View for Lotus Elise GARW dash

###

Inspired by the Ridge Racer 7 Age (pronounced Ah-dge, it's *French*) tachometer for the Age cars. I might make an alternate view mode where one can use the indiglo blue numbers instead of an orange. 

This dash will require you to update your gear settings (under settings -> gears) for the calculated gear (unless you're very fancy and running a sequential with a canbus output), the following works decently for me currently with a stock C64 transmission:

(1st) 123 (2nd) 83 (3rd) 60 (4th) 47 (5th) 37 (6th) 33

###

TO DO:

- Full Screen takeover so we can use the qml warning icons instead of the new ones. 
- Better animation in onLoad
- Integrate a second mode with the down button to allow an alternative view for more information (eg wideband/pressure/air temp)

## Design notes:

- Updated water temp gauge to be bigger and easier to read, also to reflect more of an aftermarket circa late 90's/early 2000's period correct Greddy gauge.

- Changed the numbers for better legibility on the tachometer. The Roland Font just wasn't working out for me on extended testing.

- Added Shift indicator and improved gauge edge legibility.

## Settings

Oil temperature, oil pressure and battery voltage can each be hidden with their Show row in the settings menu. Coolant High (Celsius) lights the water warning lamp; 0 turns it off.

Settings are saved as JSON in `/opt/IC7/screen_configs/AgeSolo_config.json`. An existing `AgeSolo_config.txt` is imported once on first run.

# Installation notes:

1) Install via GARW Genie at:  https://github.com/dustinsterk/GARWGenie

There are some prebuilt releases for the uploader, check with the Discord Channel here: [https://discord.gg/36kybUTW](https://discord.gg/bmKFrt8XP6)
