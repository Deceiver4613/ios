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

class DroneSceneView: ARSCNView {
    
    private var drone = Drone()
    
    func setup(scene: SCNScene) {
        drone.setup(with: scene)
    }
}

// MARK: - 헬기Capable

extension DroneSceneView: droneCapable  {
    

    func rotate(value: Float) {
        drone.rotate(value: value)
    }
    
    func moveForward(value: Float) {
        drone.moveForward(value: value)
    }
    
    func changeAltitude(value: Float) {
        drone.changeAltitude(value: value)
    }
    
    func moveSides(value: Float) {
        drone.moveSides(value: value)
    }
    
    func positionHUD() {
        drone.positionHUD()
    }
    
   
}
