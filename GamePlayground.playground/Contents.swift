//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit

class GameScene: SKScene {
    private var spinnyNode : SKShapeNode!
    
    override func didMove(to view: SKView) {
        
        // Create shape node to use during mouse interaction
        let w = (size.width + size.height) * 0.05
        
        spinnyNode = SKShapeNode(rectOf: CGSize(width: w, height: w), cornerRadius: w * 0.1)
        spinnyNode.lineWidth = 8.5
        
        let fadeAndRemove = SKAction.sequence([.wait(forDuration: 0.5),
                                               .fadeOut(withDuration: 0.5),
                                               .removeFromParent()])
        spinnyNode.run(.repeatForever(.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
        spinnyNode.run(fadeAndRemove)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        guard let n = spinnyNode.copy() as? SKShapeNode else { return }
        print("touch down")
        n.position = pos
        n.lineWidth = 20
        n.strokeColor = SKColor.green
        addChild(n)
    }
    
    
    func touchMoved(toPoint pos : CGPoint) {
        guard let n = self.spinnyNode.copy() as? SKShapeNode else { return }
        print("touch moved")
        
        n.position = pos
        n.strokeColor = SKColor.blue
        addChild(n)
    }
    
    func touchUp(atPoint pos : CGPoint) {
        guard let n = spinnyNode.copy() as? SKShapeNode else { return }
        print("touch up")
        
        n.position = pos
        n.strokeColor = SKColor.red
        addChild(n)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }
    
    // when the OS needs to interrupt the user
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
if let scene = GameScene(fileNamed: "GameScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
