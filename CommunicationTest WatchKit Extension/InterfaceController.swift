//
//  InterfaceController.swift
//  CommunicationTest WatchKit Extension
//
//  Created by Parrot on 2019-10-26.
//  Copyright © 2019 Parrot. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    var Screen2:[Screen2Sample] = []
    var numLoops = 0
    var hunger = 0
    var health = 100
    // MARK: Outlets
    // ---------------------
   
    @IBOutlet var messageLabel: WKInterfaceLabel!
   
    // Imageview for the pokemon
    @IBOutlet var pokemonImageView: WKInterfaceImage!
    // Label for Pokemon name (Albert is hungry)
    @IBOutlet var nameLabel: WKInterfaceLabel!
    // Label for other messages (HP:100, Hunger:0)
    @IBOutlet var outputLabel: WKInterfaceLabel!
    

    // MARK: Delegate functions
    // ---------------------

    // Default function, required by the WCSessionDelegate on the Watch side
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //@TODO
        
    }
    
    // 3. Get messages from PHONE
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
       
        print("WATCH: Got message from Phone")
        // Message from phone comes in this format: ["course":"MADT"]
        let messageBody = message["name"] as! String
        messageLabel.setText(messageBody)
        let name = message["name"] as! String
                print(name)
      

                if(name == "pikachu"){
       
                    pokemonImageView.setImageNamed("pikachu")
                    self.nameLabel.setText("pikachu")
                }
                if(name == "caterpie"){
                    pokemonImageView.setImageNamed("caterpie")
                    self.nameLabel.setText("caterpie")
                }
               
          }
    


    
    // MARK: WatchKit Interface Controller Functions
    // ----------------------------------
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        
        // 1. Check if teh watch supports sessions
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
        
        
    }
   
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
          
        
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    // MARK: Actions
    // ---------------------
    
    // 2. When person presses button on watch, send a message to the phone
    @IBAction func buttonPressed() {
        
        if WCSession.default.isReachable {
            print("Attempting to send message to phone")
            self.messageLabel.setText("Sending msg to watch")
            
            var health1 = String(health)
            var health2 = String(hunger)
            WCSession.default.sendMessage(
               ["name":"name", "State":health1 , "Hungry":health2],
                replyHandler: {
                    (_ replyMessage: [String: Any]) in
                    // @TODO: Put some stuff in here to handle any responses from the PHONE
                    print("Message sent, put something here if u are expecting a reply from the phone")
                    self.messageLabel.setText("Got reply from phone")
            }, errorHandler: { (error) in
                //@TODO: What do if you get an error
                print("Error while sending message: \(error)")
                self.messageLabel.setText("Error sending message")
            })
        }
        else {
            print("Phone is not reachable")
            self.messageLabel.setText("Cannot reach phone")
        }
    }
    
    
    // MARK: Functions for Pokemon Parenting
    @IBAction func nameButtonPressed() {
        print("name button pressed")
        print("Give your pokemon a name")
        
        
    
    }

   
    @IBAction func startButtonPressed() {
        print("Start button pressed")
         
        
     if (numLoops % 5 == 0) {
      hunger = hunger + 10
      print(hunger)
     outputLabel.setText("H: \(hunger), L: \(health)" )
        if(hunger>80)
        {
              if(health>0 && health<=100) {
                health = health - 5
                outputLabel.setText("H: \(hunger), L: \(health)" )
                }
            
              else{
               outputLabel.setText("Pokemon is dead" )
                 }
                }
        }
    
     }
    
    
    @IBAction func feedButtonPressed() {
        print("Feed button pressed")
        
        hunger = hunger - 12
         print(hunger)
         outputLabel.setText("H: \(hunger), L: \(health)" )
        
        
    }
    
    @IBAction func hibernateButtonPressed() {
        print("Hibernate button pressed")
        self.buttonPressed()
}
}
