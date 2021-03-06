//
//  GameViewController.swift
//  AltruisMaze
//
//  Created by Bomar, Shawn L on 2/23/20.
//  Copyright © 2020 Bomar-Pradhan. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import FirebaseFirestore

// The entire class can use the database
let db = Firestore.firestore()
class GameViewController: UIViewController {
// create buttons for delete, collect data from teh collection in Firebase
    override func viewDidLoad() {
        super.viewDidLoad()
    
        getCollection(collection: "users")

        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "Room 1N") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    // Adding data into Firbase, has to be triggered for this to work. Use button
    private func createUsers(){
        let usersRef = db.collection("users")
        usersRef.document().setData([
            "name" : "R"
        ])
        
        usersRef.document().setData([
            "name" : "T"
        ])
        
        usersRef.document().setData([
            "name" : "K"
        ])
    }
    
    //update the Firebase
    private func updateUsers(){
         let usersRef = db.collection("users")
         usersRef.document().setData([
             "name" : "R"
         ])
         
         usersRef.document().setData([
             "name" : "T"
         ])
         
         usersRef.document().setData([
             "name" : "K"
         ])
     }
    
    // Get data from the Firebase
    private func getCollection(collection: String){
        db.collection("users").getDocuments() {
            (QuerySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
            } else {
                for document in QuerySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
// Deletes entire collection
    // Use this with care, not used in Production Mode
    private func deleteCollection(collection: String){
        db.collection(collection).getDocuments() { (QuerySnapshot, err) in
            if let err = err {
                print("Error getting documents : \(err)")
            } else{
                for document in QuerySnapshot!.documents {
                    print("Deleting \(document.documentID) => \(document.data())")
                    document.reference.delete()
                }
                
            }
        }
    }
    
    func rotation(){
        
    }
    
    
    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
