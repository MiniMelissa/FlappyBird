//
//  GameScene.m
//  SideScoller
//
//  Created by xumeng on 17/3/11.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "GameScene.h"

static const CGFloat pipeGap= 60;
static const uint32_t birdCategory = 0x1 << 0 ;
//static const uint32_t birdCollisionBitMask=0x1;
static const uint32_t pipeCategory = 0x1<<1;
//static const uint32_t pipeCollisionBitMask=0x1;

static const CGFloat pipeSpeed =4;
static const CGFloat pipeFrequency = pipeSpeed/2;
static const CGFloat birdSpeed=300;


static const CGFloat randomFloat(CGFloat Min, CGFloat Max){
    return floor(((rand() % RAND_MAX) / (RAND_MAX * 1.0)) * (Max - Min) + Min);
}

@implementation GameScene
@synthesize bird ;
@synthesize pipeTimer,scoreTimer;
@synthesize scoreLabel;
@synthesize score;


-(id)initWithSize:(CGSize)size{
    if(self=[super initWithSize:size]){
        //set up backgrouond
        SKSpriteNode* back= [SKSpriteNode spriteNodeWithImageNamed:@"background.jpg"];
        back.size=self.size;
        back.position=CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:back];
        scoreLabel = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
        [scoreLabel setPosition:CGPointMake(100, self.size.height-20)];
        scoreLabel.fontSize=20;
        scoreLabel.fontColor= [SKColor yellowColor];
        [scoreLabel setText:[NSString stringWithFormat:@"%@", [NSNumber numberWithInteger:score]]];
       
        [self addChild:scoreLabel];

        [self addBird];
        
        pipeTimer=[NSTimer scheduledTimerWithTimeInterval:pipeFrequency target:self selector:@selector(addPipe) userInfo:nil repeats:YES];
        
        [NSTimer scheduledTimerWithTimeInterval:pipeFrequency target:self selector:@selector(startScoreTimer) userInfo:nil repeats:NO];
        
//        NSLog(@"frame.width size: %f",self.frame.size.width);
//        NSLog(@"frame.height size: %f",self.frame.size.height);

    }
    return self;
}


-(void)addBird{
    
    //set up bird
    bird = [Bird spriteNodeWithImageNamed:@"bird.png"];
    bird.position=CGPointMake(self.size.width/2, self.size.height/2);
    
    //        bird.size.width/=2;
    //        bird.size.height/=2;
    bird.size=CGSizeMake(bird.size.width/3, bird.size.height/3);
//    NSLog(@"bird height:%f\n",bird.size.height/2);
//    NSLog(@"bird width:%f\n",bird.size.width/2);

    [self addChild:bird];
    
    //set edge when falling down http://www.jianshu.com/p/0cc657becbe9
    self.physicsBody= [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(self.frame.origin.x, (self.frame.origin.y), self.size.width, self.size.height)];
//    NSLog(@"frame.x:%f frame.y:%f\n",self.frame.origin.x,self.frame.origin.y);
//    NSLog(@"self.width:%f self.height:%f\n",self.size.width,self.size.height);

//    bird.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:bird.size.height/16];
    bird.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bird.size];

    bird.physicsBody.affectedByGravity=true;
    [bird.physicsBody setDensity:1.15];

    [bird.physicsBody setAllowsRotation:false];
    bird.physicsBody.usesPreciseCollisionDetection=true;
    //deal with collision
    [bird.physicsBody setCategoryBitMask:birdCategory];
    [bird.physicsBody setCollisionBitMask:pipeCategory];
    [bird.physicsBody setContactTestBitMask:pipeCategory];

}

-(void)addPipe{
    CGFloat centerY = randomFloat(pipeGap, self.size.height-pipeGap);
//    NSLog(@"centerY:%f",centerY);
    CGFloat pipeTopHeight = centerY - pipeGap;
    CGFloat pipeBottomHeight = self.size.height - (centerY + pipeGap);
    while(pipeTopHeight==0.0 || pipeBottomHeight==0.0){
        centerY = randomFloat(pipeGap, self.size.height-pipeGap);
//        NSLog(@"centerY:%f",centerY);
        pipeTopHeight = centerY - pipeGap;
        pipeBottomHeight = self.size.height - (centerY + pipeGap);
    }

//    NSLog(@"pipeTopHeight:%f",pipeTopHeight);
//    NSLog(@"pipeBottomHeight:%f",pipeBottomHeight);

    
    //add top pipe
    Pipe *pipeTop = [Pipe pipeWithHeight:pipeTopHeight withStyle:TopPipe];
    [pipeTop setPipeCategory:pipeCategory playerCategory:birdCategory];
    [self addChild:pipeTop];
    
    // Bottom Pipe
    Pipe *pipeBottom = [Pipe pipeWithHeight:pipeBottomHeight withStyle:BottomPipe];
    [pipeBottom setPipeCategory:pipeCategory playerCategory:birdCategory];
    [self addChild:pipeBottom];
    
    // Move top pipe
    SKAction *pipeTopAction = [SKAction moveToX:-(pipeTop.size.width/2) duration:pipeSpeed];
    SKAction *pipeTopSequence = [SKAction sequence:@[pipeTopAction, [SKAction runBlock:^{
        [pipeTop removeFromParent];
    }]]];
    [pipeTop runAction:[SKAction repeatActionForever:pipeTopSequence]];
    
    // Move bottom pipe
    SKAction *pipeBottomAction = [SKAction moveToX:-(pipeBottom.size.width/2) duration:pipeSpeed];
    SKAction *pipeBottomSequence = [SKAction sequence:@[pipeBottomAction, [SKAction runBlock:^{
        [pipeBottom removeFromParent];
    }]]];
    [pipeBottom runAction:[SKAction repeatActionForever:pipeBottomSequence]];
    
}

- (void)startScoreTimer
{
    scoreTimer = [NSTimer scheduledTimerWithTimeInterval:pipeFrequency target:self selector:@selector(incrementScore) userInfo:nil repeats:YES];
}

- (void)incrementScore
{
    score++;
    [scoreLabel setText:[NSString stringWithFormat:@"%@", [NSNumber numberWithInteger:score]]];
//    [self runAction:_pipeSound];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [bird.physicsBody setVelocity:CGVectorMake(bird.physicsBody.velocity.dx, birdSpeed)];
    //the position is only fly-up,cannot upside and down
//    CGFloat rotation = ((bird.physicsBody.velocity.dy + birdSpeed) / (2*birdSpeed)) * M_2_PI;
//    [bird setZRotation:rotation-M_1_PI/2];
}

- (void)update:(NSTimeInterval)currentTime
{
    if (bird.physicsBody.velocity.dy > birdSpeed) {
        [bird.physicsBody setVelocity:CGVectorMake(bird.physicsBody.velocity.dx, birdSpeed)];
    }
    
    //rotate bird to simulate bird-flying
    CGFloat rotation = ((bird.physicsBody.velocity.dy + birdSpeed) / (2*birdSpeed)) * M_2_PI;
    [bird setZRotation:rotation-M_1_PI/2];
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    //detect collision
    NSLog(@"contact detected");

}
-(void)handleContact:(SKPhysicsContact*)contact {
    NSLog(@"contact detected");

}
    @end
