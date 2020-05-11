//
//  Message Board.swift
//  AltruisMaze
//
//  Created by iphone on 5/6/20.
//  Copyright © 2020 Bomar-Pradhan. All rights reserved.
//

import SpriteKit
import GameplayKit
import Firebase
import FirebaseFirestore



class MessageBoard: SKScene{
      


    public var PreviousRoom: String = "Room 1N"
    override func didMove(to view: SKView) {
        backgroundColor = SKColor(red: 0.15, green:0.15, blue:0.3, alpha: 1.0)
        
        //Frame Measurements for Positioning
        let refX = self.frame.size.width, refY = self.frame.size.height
        
    
        //Banner
        let title = SKLabelNode()
        title.text = "Message Board"
        title.fontColor = UIColor.yellow
        title.fontSize = 76
        title.position = CGPoint(x: refX/2, y:refY - (refY/10))
        title.name = "title"
        self.addChild(title)
        
        //FromFirebasePhoto
        let photo = SKSpriteNode(imageNamed: "FBDL.png")
        photo.position = CGPoint(x: refX/2, y: refY/2)
        photo.size = CGSize(width: 1000, height: 500)
        photo.name = "photo"
        self.addChild(photo)
        
        
        print("hello",messagePosts)
        for message in messagePosts{
            let postname = SKLabelNode()
            postname.text = message["name"]
            postname.fontColor = UIColor.yellow
            postname.fontSize = 50
            postname.position = CGPoint(x: refX/2, y: refY - (refY/2))
            postname.name = "name"
            
            
            let post = SKLabelNode()
            post.text = message["post"]
            post.fontColor = UIColor.yellow
            post.fontSize = 60
            post.position = CGPoint(x: refX/2, y: refY - (refY/4))
            post.name = "post"
            
            self.addChild(postname)
            self.addChild(post)
            break
        }
    
        //Exit Button
        //Icon from freeicon.com
        let exitButton = SKSpriteNode(imageNamed: "exitButton.png")
        exitButton.position = CGPoint(x: refX/10, y: refY/10)
        exitButton.name = "exitButton"
        self.addChild(exitButton)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesarray = nodes(at: location)
            for node in nodesarray {
                if node.name == "exitButton"{
                    let returnScene = GameScene(fileNamed: PreviousRoom)
                    let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.45)
                    returnScene!.scaleMode = .aspectFill
                    scene?.view?.presentScene(returnScene!, transition: transition)
                }
            }
        }
    }
}
