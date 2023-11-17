//
//  Helicopter.swift
//  ARKitDrone
//
//  Created by Christopher Webb on 1/14/23.
//  Copyright © 2023 Christopher Webb-Orenstein. All rights reserved.
//
/*
import Foundation
import SceneKit
import ARKit
import simd

class Drone {
    
    // MARK: - LocalConstants
    
    private struct LocalConstants {
        static let sceneName = "art.scnassets/drone_custom.scn"
        static let parentModelName = "grpApache"
        static let bodyName = "Body"
        static let frontRotorName = "FrontRotor"
        static let tailRotorName = "TailRotor"
        static let hudNodeName = "hud"
        static let frontIRSteering = "FrontIRSteering"
        
        static let frontIR = "FrontIR"
        static let audioFileName = "audio.m4a"
        
        static let activeEmitterRate: CGFloat = 1000
        static let angleConversion = SCNQuaternion.angleConversion(x: 0, y: 0.002 * Float.pi, z: 0 , w: 0)
        static let negativeAngleConversion = SCNQuaternion.angleConversion(x: 0, y: -0.002 * Float.pi, z: 0 , w: 0)
        static let altitudeAngleConversion = SCNQuaternion.angleConversion(x: 0.001 * Float.pi, y:0, z: 0 , w: 0)
        static let negativeAltitudeAngleConversion = SCNQuaternion.angleConversion(x: -0.001 * Float.pi, y:0, z: 0 , w: 0)
    }
    
    private var droneNode: SCNNode!
    private var parentModelNode: SCNNode!
    
    
    private var rotor: SCNNode!
    private var rotor2: SCNNode!
    private var hud: SCNNode!
    private var front: SCNNode!
    private var frontIR: SCNNode!
    
    private var missilesArmed: Bool = false
    
    private func spinBlades() {
        let rotate = SCNAction.rotateBy(x: 30, y: 0, z: 0, duration: 0.5)
        let moveSequence = SCNAction.sequence([rotate])
        let moveLoop = SCNAction.repeatForever(moveSequence)
        rotor2.runAction(moveLoop)
        let rotate2 = SCNAction.rotateBy(x: 0, y: 0, z: 20, duration: 0.5)
        let moveSequence2 = SCNAction.sequence([rotate2])
        let moveLoop2 = SCNAction.repeatForever(moveSequence2)
        rotor.runAction(moveLoop2)
        let source = SCNAudioSource(fileNamed: LocalConstants.audioFileName)
        source?.volume += 50
        let action = SCNAction.playAudio(source!, waitForCompletion: true)
        let action2 = SCNAction.repeatForever(action)
        droneNode.runAction(action2)
    }
    
    func setup(with scene: SCNScene) {
        let tempScene = SCNScene.nodeWithModelName(LocalConstants.sceneName)
        hud = tempScene.childNode(withName: LocalConstants.hudNodeName, recursively: false)
        parentModelNode = tempScene.childNode(withName: LocalConstants.parentModelName, recursively: true)
        droneNode = parentModelNode?.childNode(withName: LocalConstants.bodyName, recursively: true)
        front = droneNode.childNode(withName: LocalConstants.frontIRSteering, recursively: true)
        frontIR = front.childNode(withName: LocalConstants.frontIR, recursively: true)
        rotor = droneNode?.childNode(withName: LocalConstants.frontRotorName, recursively: true)
        rotor2 = droneNode?.childNode(withName: LocalConstants.tailRotorName, recursively: true)
        parentModelNode.position = SCNVector3(droneNode.position.x, droneNode.position.y, -20)
        hud.position = SCNVector3(x: droneNode.position.x + 0.6, y: droneNode.position.y, z: droneNode.position.z)
        frontIR.pivot = SCNMatrix4MakeTranslation(12.0, 0, 8.0)
        spinBlades()
        scene.rootNode.addChildNode(tempScene)
    }
    
    func positionHUD() {
        hud.scale = SCNVector3(0.4, 0.4, 0.4)
        hud.position = SCNVector3(x: droneNode.position.x, y: droneNode.position.y , z: -4)
        let constraint = SCNLookAtConstraint(target: droneNode)
        constraint.isGimbalLockEnabled = true
        constraint.influenceFactor = 0.1
        hud.constraints = [constraint]
    }
    
    
    func rotate(value: Float) {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.25
        let localAngleConversion = SCNQuaternion.angleConversion(x: 0, y:0, z:  value * Float(Double.pi), w: 0)
        let locationRotation = SCNQuaternion.getQuaternion(from: localAngleConversion)
        droneNode.localRotate(by: locationRotation)
        
        let hudAngleConversion = SCNQuaternion.angleConversion(x: 0, y: -value * Float(Double.pi), z: 0, w: 0)
        let hudRotation = SCNQuaternion.getQuaternion(from: hudAngleConversion)
        hud.rotate(by: hudRotation, aroundTarget: droneNode.worldPosition)
        let constraint = SCNLookAtConstraint(target: droneNode)
        constraint.isGimbalLockEnabled = true
        constraint.influenceFactor = 0.1
        hud.constraints = [constraint]
        SCNTransaction.commit()
    }
    
    func moveForward(value: Float) {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.25
        droneNode.localTranslate(by: SCNVector3(x: 0, y: value, z: 0))
        hud.localTranslate(by:  SCNVector3(x: 0, y: 0, z: (0.01 * value)))
        SCNTransaction.commit()
        let constraint = SCNLookAtConstraint(target: droneNode)
        constraint.isGimbalLockEnabled = true
        constraint.influenceFactor = 0.1
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 3.0
        hud.constraints = [constraint]
        SCNTransaction.commit()
    }
    
    func changeAltitude(value: Float) {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.25
        droneNode.position = SCNVector3(droneNode.position.x, droneNode.position.y, droneNode.position.z + value)
        droneNode.localRotate(by: SCNQuaternion.getQuaternion(from: LocalConstants.altitudeAngleConversion))
        let pos = SCNVector3.positionFromTransform(droneNode.worldTransform.toSimd())
        hud.position = SCNVector3(pos.x + 0.5, pos.y, pos.z + 10)
        SCNTransaction.completionBlock = { [self] in
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.25
            droneNode.localRotate(by: SCNQuaternion.getQuaternion(from: LocalConstants.negativeAltitudeAngleConversion))
            let pos = SCNVector3.positionFromTransform(droneNode.worldTransform.toSimd())
            hud.position = SCNVector3(pos.x + 0.5, pos.y, pos.z + 10)
            SCNTransaction.commit()
        }
        SCNTransaction.commit()
    }
    
    func moveSides(value: Float) {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.25
        droneNode.localTranslate(by: SCNVector3(x: value, y: 0, z: 0))
        let pos = SCNVector3.positionFromTransform(droneNode.worldTransform.toSimd())
        hud.position = SCNVector3(pos.x, pos.y, pos.z + 10)
        if abs(value) != value {
            let localRotation = SCNQuaternion.getQuaternion(from: LocalConstants.negativeAngleConversion)
            droneNode.localRotate(by: localRotation)
            let pos = SCNVector3.positionFromTransform(droneNode.worldTransform.toSimd())
            hud.position = SCNVector3(pos.x, pos.y, pos.z + 10)
        } else {
            let localRotation = SCNQuaternion.getQuaternion(from: LocalConstants.angleConversion)
            droneNode.localRotate(by: localRotation)
            let pos = SCNVector3.positionFromTransform(droneNode.worldTransform.toSimd())
            hud.position = SCNVector3(pos.x, pos.y, pos.z + 10)
        }
        SCNTransaction.completionBlock = { [self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { [self] in
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.25
                if abs(value) != value {
                    let localRotation = SCNQuaternion.getQuaternion(from: LocalConstants.angleConversion)
                    droneNode.localRotate(by: localRotation)
                    let pos = SCNVector3.positionFromTransform(droneNode.worldTransform.toSimd())
                    hud.position = SCNVector3(pos.x, pos.y, pos.z + 10)
                } else {
                    let localRotation = SCNQuaternion.getQuaternion(from: LocalConstants.negativeAngleConversion)
                    droneNode.localRotate(by: localRotation)
                    let pos = SCNVector3.positionFromTransform(droneNode.worldTransform.toSimd())
                    hud.position = SCNVector3(pos.x, pos.y, pos.z + 10)
                }
                SCNTransaction.commit()
            })
        }
        SCNTransaction.commit()
    }
  
    


}
*/
import Foundation
import SceneKit
import ARKit

class Drone {
    
    // MARK: - LocalConstants
    
    private struct LocalConstants {
        static let sceneName = "art.scnassets/drone_custom.scn"
        static let audioFileName = "audio.m4a"
        
        static let activeEmitterRate: CGFloat = 1000
        static let angleConversion = SCNQuaternion.angleConversion(x: 0, y: 0.002 * Float.pi, z: 0, w: 0)
        static let negativeAngleConversion = SCNQuaternion.angleConversion(x: 0, y: -0.002 * Float.pi, z: 0, w: 0)
        static let altitudeAngleConversion = SCNQuaternion.angleConversion(x: 0.001 * Float.pi, y: 0, z: 0, w: 0)
        static let negativeAltitudeAngleConversion = SCNQuaternion.angleConversion(x: -0.001 * Float.pi, y: 0, z: 0, w: 0)
    }
    
    private var droneNode: SCNNode!
    
    // MARK: - Public Methods
    
    init() {
        loadScene()
        setup()
    }
    
    func setup(with scene: SCNScene) {
        guard let droneNode = droneNode else {
            print("드론 노드를 찾을 수 없습니다.")
            return
        }

        // 필요한 경우 여기에 설정 코드 추가
        scene.rootNode.addChildNode(droneNode)
    }
    
    func positionHUD() {
        // 필요한 경우 HUD 위치 조정 코드 추가
    }
    
    func rotate(value: Float) {
        // 주어진 값 사용하여 회전 코드 추가
    }
    
    func moveForward(value: Float) {
        // 주어진 값 사용하여 전진 코드 추가
    }
    
    func changeAltitude(value: Float) {
        // 주어진 값 사용하여 고도 변경 코드 추가
    }
    
    func moveSides(value: Float) {
        // 주어진 값 사용하여 좌우 이동 코드 추가
    }

    // MARK: - Private Methods
    
    private func loadScene() {
        guard let tempScene = SCNScene.nodeWithModelName(LocalConstants.sceneName) else {
            print("씬을 불러오는 데 실패했습니다.")
            return
        }

        droneNode = tempScene.rootNode
    }
    
    private func spinBlades() {
        // 필요한 경우 회전하는 날개 애니메이션 코드 추가
    }
}
