//
//  ViewController.swift
//  WorldTracking
//
//  Created by 児新治紀 on 2021/11/07.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet var Xslider: UISlider!
    @IBOutlet var Yslider: UISlider!
    @IBOutlet var Zslider: UISlider!

    let configuration = ARWorldTrackingConfiguration()

    @IBAction func addButton(_ sender: UIButton) {
        showShape()
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        sceneView.session.pause()
        
        sceneView.scene.rootNode.enumerateChildNodes{
            (node, _) in
            if node.name == "shape"{
                node.removeFromParentNode()
            }
        }
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        showShape()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sceneView.delegate = self
        sceneView.showsStatistics = true
        //display the world origin
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        showShape()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sceneView.session.run(configuration)
    }
    
    func showShape(){
        let sphere = SCNSphere(radius: 0.05)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "earth.jpg")
        sphere.materials = [material]
        
        let node = SCNNode()
        node.geometry = sphere
        node.position = SCNVector3(Xslider.value, Yslider.value, Zslider.value)
        node.name = "shape"
        
        let rotateOne = SCNAction.rotateBy(x: 0, y: CGFloat(Float.pi), z: 0, duration: 5.0)
        let repeatForever = SCNAction.repeatForever(rotateOne)
        node.runAction(repeatForever)
        
        sceneView.scene.rootNode.addChildNode(node)
        
    }


}

