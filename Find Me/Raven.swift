//
//  Raven.swift
//  Find Me
//
//  Created by Elsa B on 11/1/20.
//

import ARKit

class Raven: SCNNode {
    
    func loadModal() {
        guard let virtualOjectScene = SCNScene(named: "art.scnassets/openRaven.scn") else {return}
        
        let wrapperNode = SCNNode()
        
        for child in virtualOjectScene.rootNode.childNodes {
            wrapperNode.addChildNode(child)
        }
        
        self.addChildNode(wrapperNode)
        
    }
    
}
