//
//  DroneView.swift
//  ARKitDrone
//
//  Created by Christopher Webb-Orenstein on 10/7/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class Drone: SCNNode {
    func carregarModelo() {
        guard let objetoVirtual = SCNScene(named: "art.scnassets/Drone.scn") else { return }
        let no = SCNNode()
        for noFilho in objetoVirtual.rootNode.childNodes {
            no.addChildNode(noFilho)
        }
        addChildNode(no)
    }
}
