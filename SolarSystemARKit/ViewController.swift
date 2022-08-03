//
//  ViewController.swift
//  SolarSystemARKit
//
//  Created by Enes Kaya on 3.08.2022.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
       
       // let mySphere = createSphere(radius: 0.1, content: "grass", vector: SCNVector3(0, 0.2, -1))
        
        let earth = createSphere(radius: 0.1, content: "earthday.jpg", vector: SCNVector3(0, 0.1, -1))
        let moon = createSphere(radius: 0.04, content: "moon.jpg", vector: SCNVector3(0.25, 0.1, -1))
        let sun = createSphere(radius: 1, content: "sun.jpg", vector: SCNVector3(-2,0.1,-1))
        
        
        let moonParentNode = SCNNode()
        moonParentNode.position = SCNVector3(0, 0.1, -1)
             let moonParentRotaion = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 5)
             let moonParentRotationRepeat = SCNAction.repeatForever(moonParentRotaion)
             moonParentNode.runAction(moonParentRotationRepeat)

      
        let nodeMoon = SCNNode()
             nodeMoon.position = SCNVector3(0, 0, -0.3)
       
      
        
             let moonRotaion = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 8)
             let moonRotaionRepeat = SCNAction.repeatForever(moonRotaion)
             nodeMoon.runAction(moonRotaionRepeat)
             moonParentNode.addChildNode(nodeMoon)
        
             earth.addChildNode(moonParentNode)
        
        
        
        
        let earthAction = SCNAction.rotate(by: 360 * CGFloat((Double.pi)/180), around: SCNVector3(x: 0, y: 1, z: 0), duration: 8)
        let moonAction = SCNAction.rotate(by: 360 * CGFloat((Double.pi)/180), around: SCNVector3(x: 0, y: 1, z: 0), duration: 8)
        let sunAction = SCNAction.rotate(by: 360 * CGFloat((Double.pi)/180), around: SCNVector3(x: 0, y: 1, z: 0), duration: 8)
        
        let repeatAction = SCNAction.repeatForever(earthAction)
        let repeatActionMoon = SCNAction.repeatForever(moonAction)
        let repeatActionSun = SCNAction.repeatForever(sunAction)
        
        
        let action2 = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 5)
               let repeatAction2 = SCNAction.repeatForever(action2)
               moon.runAction(repeatAction2)
        
        
        //moon.runAction(repeatActionMoon)
        earth.runAction(repeatAction)
        sun.runAction(repeatActionSun)
        
        
        
        sceneView.scene.rootNode.addChildNode(earth)
        sceneView.scene.rootNode.addChildNode(moon)
        sceneView.scene.rootNode.addChildNode(sun)

        sceneView.automaticallyUpdatesLighting = true
       
    }
    
    func createSphere(radius: CGFloat, content:String, vector:SCNVector3) -> SCNNode{
        
        let mySphere = SCNSphere(radius: radius)
        let boxMaterial = SCNMaterial()
        
        boxMaterial.diffuse.contents = UIImage(named: "art.scnassets/\(content)")
        
        mySphere.materials = [boxMaterial]
        
        let node = SCNNode()
        
        node.position = vector
        
        node.geometry = mySphere
        
        return node
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
