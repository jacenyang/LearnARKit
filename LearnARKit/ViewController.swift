//
//  ViewController.swift
//  LearnARKit
//
//  Created by Jason Yang on 04/09/20.
//  Copyright © 2020 Jason Yang. All rights reserved.
//

import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController, ARSessionDelegate {
    
    @IBOutlet var arView: ARView!
    
    var added = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = ARReferenceImage.referenceImages(inGroupNamed: "Books", bundle: nil)
        configuration.maximumNumberOfTrackedImages = 1
        
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        arView.session.delegate = self
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        
        for anchor in anchors {
            
            guard let imageAnchor = anchor as? ARImageAnchor
                else { continue }
            
            var entity: ModelEntity!
            
            if (imageAnchor.referenceImage.name == "Book") {
            
                if (added) {
                continue
                }
                
                added = true
                entity = try! Entity.loadModel(named: "fender_stratocaster")
                
            }
            
            let anchorEntity = AnchorEntity(anchor: imageAnchor)
            anchorEntity.addChild(entity)
            
            arView.scene.addAnchor(anchorEntity)
            
        }
            
    }
    
}
