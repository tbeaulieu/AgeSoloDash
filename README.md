![image](https://github.com/tbeaulieu/AgeSoloDash/assets/3193399/504a8eac-0621-470f-b5ed-4ab38aba9e31)

# Age Solo Dash

Dashboard View for Lotus Elise GARW dash

###

Inspired by the Ridge Racer 7 tachometer Age 

###

TO DO:

- Full Screen takeover so we can use the qml warning icons instead of the new ones. *** 
- Better animation in onLoad

## Dev Notes:

When working with QML files for GAWR dash, try to make sure you're still running 5.15, as 6.0+ has gotten rid of the QTGraphicalEffects with no backwards import compatibility (Thanks guys!). If you want to do things like color overlays or glows, you will need this.

QTCreator crashes a lot when editing, and will burp when you try to use the designer quite often. Be one with the code, and size assets properly. Related to this, start a blank UI project _then_ open up a QML file as you will run into issues with design mode.

Update 12/5/2023: QT Design Studio is really the app you want to use when visually editing initially. It doesn't crash like QTCreator does, but unfortunately, their free model doesn't support 5.15, so you'll still have to have QTCreator or the GARW simulator to view glows. My suggested flow is Illustration program or Photoshop -> QT Designer -> GARW Preview -> Text editor tweaks -> Preview -> Actual Dashboard for testing.

## Design notes:

Updated water temp gauge to be bigger and easier to read, also to reflect more of an aftermarket Greddy gauge.

# Installation notes:

1) Obtain the GARW dash installer here: https://github.com/dustinsterk/GARWDashUploader
2) You will need to unzip this dashboard file, rename the folder to "AgeSolo_Main" (Don't use the quotes), and recompress it. (I know, it's a pain)
3) Upload the dash via the uploader while connected to the GAWR Wifi.
4) Follow the rest of the aforementioned instructions.

There are some prebuilt releases for the uploader, check with the Discord Channel here: https://discord.gg/36kybUTW
