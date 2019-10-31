This example demonstrates how to do bidirectional communication between the watch and phone.

The code is written in **Swift 4**. 

* If you are re-creating the code from home, you may find other functions to that are available in Swift 5.

This code is tested to work on:

*  XCode 9.2
*  iPhone 8 Plus + Apple watch series 3, 42 mm
*  iPhone deployment target 11.2
*  watchOS deployment target 4.2


How it works:
-----

Communication between watch and phone is performed by `WatchConnectivity`, a built in library that handles the connection and communication between the two paired devices.  

WatchConnectivity has two main functions:

* `WCSession.default.sendMessage(message, replyHandler)`:   This function SENDS a message to the other device
* `session(_, didReceiveMessage, replyHandler)`:  This function RECEIVES a message from another device


You must include the appropriate function in your code to make communication happen.

For example, suppose you want to send messages from PHONE -> WATCH.

* PHONE: WCSession.default.sendMessage(...):  This goes in `ViewController.swift` 
* WATCH: session(_, didReceiveMessage, ...):  This goes in `InterfaceController.swift`

If you want to send messages from WATCH --> PHONE:

* PHONE: session(_, didReceiveMessage, ...):  This goes in `ViewController.swift`
* WATCH: WCSession.default.sendMessage(...):  This goes in `InterfaceController.swift` 


How to view debug messages:
--------

The phone and watch have separate consoles.  

* When the watch app is running, you cannot see debug messages from the Phone
* Whent he phone app is running, you cannot see debug messages from the Watch

Therefore, you need to test both watch and phone separately - instructions here:
https://docs.google.com/document/d/1pXChE-BwGNNE6JLN8CP8FaFo8LXoAsJPqNZ2j_4q5A8/edit

How to make the Phone output debug messages to console
-----

1. Start the PHONE+WATCH emulator
2. Wait for both apps to load 
3. Go back to XCode
4. Change the emulator to PHONE only (make sure the PHONE emulator you choose matches the same phone that you selected in the PHONE+WATCH emulator)
5. Wait for the phone app to load
6. Manually open the watch app
7. Do whatever you need in the app. 
8. You will be able to see the phone's debug messages in the Terminal.  




