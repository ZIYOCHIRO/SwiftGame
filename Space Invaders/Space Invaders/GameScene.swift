//
//  GameScene.swift
//  Space Invaders
//
//  Created by 10.12 on 2018/11/30.
//  Copyright © 2018 Rui. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameScore = 0
    let scoreLabel = SKLabelNode(fontNamed: "theBoldFont")
    
    var levelNumber = 0
    var livesNumber = 3
    let livesLabel = SKLabelNode(fontNamed: "theBoldFont")
    
    let player = SKSpriteNode(imageNamed: "playerShip")
    let bulletSound = SKAction.playSoundFileNamed("laser.mp3", waitForCompletion: false)
    let explosionSound = SKAction.playSoundFileNamed("GameOverSound.wav", waitForCompletion: false)
    
    struct PhysicsCategories {
        static let None: UInt32  = 0 //0  (unsigned interger 32 bits)
        static let Player: UInt32 = 0b1 //1
        static let Bullet: UInt32 = 0b10 //2
        static let Enemy: UInt32 = 0b100 //4
        
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    // Game area: An area you can see on every device
    var gameArea: CGRect
    
    override init(size: CGSize) {
        
        let maxAspectRation: CGFloat = 16.0/9.0
        let playableWidth = size.height / maxAspectRation
        let margin = (size.width - playableWidth) / 2
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // This function will run as soon as the scene loads up
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        // Create background
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0 // in which layer
        self.addChild(background)
        // Create a player
        
        player.setScale(1) // want the image(player) to be bigger, increase the number
        player.position = CGPoint(x: self.size.width/2, y: self.size.height*0.2)
        player.zPosition = 2
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody!.affectedByGravity = false
        player.physicsBody!.categoryBitMask = PhysicsCategories.Player
        player.physicsBody!.collisionBitMask = PhysicsCategories.None
        // Contact: player been hitted by enemy
        player.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
        self.addChild(player)
        
        // set score label
        scoreLabel.text = "Score: 0000"
        scoreLabel.fontSize = 70
        scoreLabel.fontColor = UIColor.white
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.position = CGPoint(x: self.size.width*0.2, y: self.size.height*0.9)
        scoreLabel.zPosition = 100  // (on top of everything)
        self.addChild(scoreLabel)
        
        // set lives label
        livesLabel.text = "Lives: 3"
        livesLabel.fontSize = 70
        livesLabel.fontColor = UIColor.white
        livesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        livesLabel.position = CGPoint(x: self.size.width * 0.8, y: self.size.height*0.9)
        livesLabel.zPosition = 100
        self.addChild(livesLabel)
        // add enemy aotumatically
        startNewLevel()
    }
    
    // lose life
    func loseALife() {
        
        livesNumber -= 1
        livesLabel.text = "Lives: \(livesNumber)"
        let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1, duration: 0.2)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        livesLabel.run(scaleSequence)
    }
    
    // Add score to the score number
    func addScore() {
        
        gameScore += 1
        scoreLabel.text = "Score: \(gameScore)"
        // when the score reaches certain level, start new level!
        if gameScore == 10 || gameScore == 5 || gameScore == 50 {
            startNewLevel()
        }
    }
    
    
    // what happens when the contact began
    func didBegin(_ contact: SKPhysicsContact) {
        
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        /* make the body1 has lower category number
             static let Player: UInt32 = 0b1 //1
             static let Bullet: UInt32 = 0b10 //2
             static let Enemy: UInt32 = 0b100 //4
         enemy hit player: body1 will be Player, body2 will be enemy
         bullet hit enemy: body1 will be bullet, body2 will be enemy
        */
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            body1 = contact.bodyA
            body2 = contact.bodyB
        } else {
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        
        // Contact_1: if enemy hit player and the enemy is on the screen
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Enemy && body2.node != nil && body2.node!.position.y < self.size.height {
            
            // delete the player and the enemy
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            // explosion on both of the enemy and the player
            if body1.node != nil {
                spawnExplosion(spawnPosition: body1.node!.position)
            }
            if body2.node != nil {
                spawnExplosion(spawnPosition: body2.node!.position)
            }
            // game over

        }
        
        // Contact_2: if bullet hit enemy
        if body1.categoryBitMask == PhysicsCategories.Bullet && body2.categoryBitMask == PhysicsCategories.Enemy {
            
            
            // delete the bullet and the enemy
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            // explosion the enemy
            if body2.node != nil {
                spawnExplosion(spawnPosition: body2.node!.position)
            }
            // add 1 point to score
            addScore()
        }
        
    }
    
    // happens when an enemy hits a player
    func spawnExplosion(spawnPosition: CGPoint) {
        
        let explosion = SKSpriteNode(imageNamed: "explosition")
        explosion.position = spawnPosition
        explosion.zPosition = 3
        explosion.setScale(0)
        
        self.addChild(explosion)
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        
        let explosionSequence = SKAction.sequence([explosionSound, scaleIn, fadeOut, delete])
        
        explosion.run(explosionSequence)
    }
    
    // make the enemy spawn itself and forever
    func startNewLevel() {
        
        levelNumber += 1
        
        if self.action(forKey: "spawningEnemies") != nil {
            self.removeAction(forKey: "spawningEnemies")
        }
        
        var levelDuration = TimeInterval()
        
        switch levelNumber {
        case 1: levelDuration = 1.2
        case 2: levelDuration = 1
        case 3: levelDuration = 0.8
        case 4: levelDuration = 0.5
        default: levelDuration = 0.5; print("cannot find level info")
        }
        
        // stop the current and restart
        let spawn = SKAction.run(spawnEnemy)
        let waitToSpawn = SKAction.wait(forDuration: levelDuration)
        let spawnSequence = SKAction.sequence([waitToSpawn, spawn])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        self.run(spawnForever, withKey:"spawingEnemies")
        
    }
    
    func fireBullet() {
        
        // spawn a bullet
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.setScale(1)
        bullet.position = player.position
        bullet.zPosition = 1
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        bullet.physicsBody!.affectedByGravity = false
        bullet.physicsBody!.categoryBitMask = PhysicsCategories.Bullet
        bullet.physicsBody!.collisionBitMask = PhysicsCategories.None
        // Contact: bullet hits enemy
        bullet.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
        self.addChild(bullet)
        
        // move and been delete
        let moveBullet = SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 1)
        let deleteBullet = SKAction.removeFromParent()
        // the actions above should happen in order
        let bulletSequence = SKAction.sequence([bulletSound,moveBullet,deleteBullet])
        bullet.run(bulletSequence)
        
    }
    
    func spawnEnemy() {
        
        // generate the random position
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxY)
        let randomXEnd = random(min: gameArea.minY, max: gameArea.maxY)
        
        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: self.size.height * 0.2)
        
        let enemy = SKSpriteNode(imageNamed: "enemyShip")
        enemy.setScale(1)
        enemy.position = startPoint
        enemy.zPosition = 2
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.categoryBitMask = PhysicsCategories.Enemy
        enemy.physicsBody!.collisionBitMask = PhysicsCategories.None
        // Contacts: enemy hits player | enemy been hited by bullet
        enemy.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
        self.addChild(enemy)
        // move down to the screen
        let moveEnemy = SKAction.move(to: endPoint, duration: 1.5)
        let deleteEnemy = SKAction.removeFromParent()
        let loseALifeAction = SKAction.run(loseALife)
        // run in order
        let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy, loseALifeAction])
        enemy.run(enemySequence)
        
        // difference between the startpoint and endPoint
        let dx = endPoint.x - startPoint.x
        let dy = endPoint.y - startPoint.y
        let amountToRotate = atan2(Float(dy), Float(dx))
        enemy.zRotation = CGFloat(amountToRotate)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // run whenever you touch the screen
        fireBullet()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            // where we touches the screen
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            // how big the gap is
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            player.position.x += amountDragged
            
            // make sure the player is in the gameArea
            if player.position.x  > gameArea.maxX - player.size.width/2 {
                player.position.x = gameArea.maxX - player.size.width/2
            }
            if player.position.y > gameArea.maxY + player.size.width/2{
                player.position.y = gameArea.maxY + player.size.width/2
            }
        }
    }
}






