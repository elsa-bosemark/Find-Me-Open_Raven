//
//  ViewController.swift
//  Find Me
//
//  Created by Elsa B on 11/1/20.
//

import UIKit
import SceneKit
import ARKit
import QuartzCore


class ViewController: UIViewController, ARSCNViewDelegate {
    

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var timeLabel: UILabel!
    


      
let alertService = AlertService()
    
var timer:Timer?
var seconds = 10
var counter:Int = 0 {
    didSet {
        counterLabel.text = "\(counter)"
    }
}

override func viewDidLoad() {
    super.viewDidLoad()

    let scene = SCNScene()

    sceneView.scene = scene
    sceneView.autoenablesDefaultLighting = true
    updateTimeLabel()
    
    let alertVCView = storyboard?.instantiateViewController(withIdentifier: "AlertVC")
    self.view.addSubview((alertVCView?.view)!)
    self.addChild(alertVCView!)
    

}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    
override func viewDidAppear(_ animated: Bool) {
    GameStartAlert()
}

override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let configuration = ARWorldTrackingConfiguration()

    sceneView.session.run(configuration)

    addObject()
    
}

func GameStartAlert(){
//        
//    let alert = UIAlertController(title: "Welcome To \"Find Me\"!", message: "Try and find the raven and click it as many times as possible, before the time runs out! ", preferredStyle: .alert)
//
//    alert.addAction(UIAlertAction(title: "Let's Start", style: .default, handler: nil))
//
//    let alertImage = UIImage(named: "Launch")
//    let alertImageView = UIImageView(frame: CGRect(x: 0, y: 0, width:842, height: 332))
//   alertImageView.image = alertImage
//
//
//    self.present(alert, animated: true, completion: nil)
    
   
    let alertVC=alertService.alert(title: "Welcome To Find Me!", body: "Try and find the raven and click it as many times as possible, before the time runs out!", buttonTitle: "Let's Start")
    //addChild(alertVC)
    present(alertVC,animated: true)
}

func addObject() {
    let spotLight = SCNNode()
    spotLight.light = SCNLight()
    spotLight.light?.type = .directional

    sceneView.scene.rootNode.addChildNode(spotLight)

    let raven = Raven()
    raven.loadModal()

    let xPos = randomPosition(lowerBound: -1.5, upperBound: 1.5)
    let yPos = randomPosition(lowerBound: -1.5, upperBound: 1.5)

    raven.position = SCNVector3(xPos, yPos, -1)

    sceneView.scene.rootNode.addChildNode(raven)

}

func randomPosition (lowerBound lower:Float, upperBound upper:Float) -> Float {
    return Float(arc4random()) / Float(UInt32.max) * (lower - upper) + upper
}


override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    if let touch = touches.first {
       //print("screen tapped")

        let location = touch.location(in: sceneView)

        let hitList = sceneView.hitTest(location, options: nil)

        if let hitObject = hitList.first {
            let node = hitObject.node
          print("passed if")
            if node.name == "VRRaven" {                      counter += 1
                node.removeFromParentNode()
                addObject()
            }
        }

    }
  if timer == nil {
      timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
          if self.seconds == 0 {
                 self.finishGame()
             } else if self.seconds <= 60 {
                 self.seconds -= 1
                 self.updateTimeLabel()
             }
      }
  }
}
func updateTimeLabel() {

  let min = (seconds / 60) % 60
  let sec = seconds % 60

  timeLabel?.text = String(format: "%02d", min) + ":" + String(format: "%02d", sec)
}

func finishGame(){
      timer?.invalidate()
      timer = nil

  let alert = UIAlertController(title: "Time's Up!", message: "Your time is up! You got a score of \(counter) points. Awesome!", preferredStyle: .alert)
  alert.addAction(UIAlertAction(title: "OK, start new game", style: .default, handler: nil))

  self.present(alert, animated: true, completion: nil)
//        let alertVC=alertService.alert(title:"Time's Up!", body: "Your time is up! You got a score of \(counter) points. Awesome!", buttonTitle:  "OK, start new game")
//        present(alertVC,animated: true)
    
  counter = 0
  seconds = 10
  updateTimeLabel()
}
    }

