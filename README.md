# Age Solo Dash

Dashboard View for Lotus Elise GARW dash

###

Inspired by the Ridge Racer 7 tachometer

###

TO DO:

- Full Screen takeover so we can use the qml warning icons instead of the new ones. *** 
- Better animation in onLoad
- 
## Dev Notes:

When working with QML files for GAWR dash, try to make sure you're still running 5.15, as 6.0+ has gotten rid of the QTGraphicalEffects with no backwards import compatibility (Thanks guys!). If you want to do things like color overlays or glows, you will need this.

QTCreator crashes a lot when editing, and will burp when you try to use the designer quite often. Be one with the code, and size assets properly. Related to this, start a blank UI project _then_ open up a QML file as you will run into issues with design mode.

Update 12/5/2023: QT Design Studio is really the app you want to use when visually editing initially. It doesn't crash like QTCreator does, but unfortunately, their free model doesn't support 5.15, so you'll still have to have QTCreator or the GARW simulator to view glows. My suggested flow is Illustration program or Photoshop -> QT Designer -> GARW Preview -> Text editor tweaks -> Preview -> Actual Dashboard for testing.

## Design notes:

Still very much in Beta, might move some of the design around depending on the viewport in the actual car.
