//
//  GameScene.m
//  SideScoller
//
//  Created by xumeng on 17/3/11.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "GameScene.h"

static const CGFloat pipeGap= 70;
static const uint32_t playerCategory = 0x1 << 0;
static const uint32_t pipeCategory = 0x1 << 1;
static const CGFloat pipeSpeed = 3.5;
static const CGFloat pipeFrequency = pipeSpeed/2;


static const CGFloat randomFloat(CGFloat Min, CGFloat Max){
    return floor(((rand() % RAND_MAX) / (RAND_MAX * 1.0)) * (Max - Min) + Min);
}

@implementation GameScene
@synthesize bird ;
@synthesize pipeTimer,scoreTimer;
@synthesize scoreLabel;
@synthesize score;
//_player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_player.size];
//[_player.physicsBody setDensity:kDensity];
//[_player.physicsBody setAllowsRotation:NO];
//
//[_player.physicsBody setCategoryBitMask:kPlayerCategory];
//[_player.physicsBody setContactTestBitMask:kPipeCategory | kGroundCategory];
//[_player.physicsBody setCollisionBitMask:kGroundCategory | kPipeCategory];

-(id)initWithSize:(CGSize)size{
    if(self=[super initWithSize:size]){
        //set up backgrouond
        SKSpriteNode* back= [SKSpriteNode spriteNodeWithImageNamed:@"background.jpg"];
        back.size=self.size;
        back.position=CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:back];

        [self addBird];
        
        pipeTimer=[NSTimer scheduledTimerWithTimeInterval:pipeFrequency target:self selector:@selector(addPipe) userInfo:nil repeats:YES];
        
        [NSTimer scheduledTimerWithTimeInterval:pipeFrequency target:self selector:@selector(startScoreTimer) userInfo:nil repeats:NO];

    }
    return self;
}


-(void)addBird{
    
    //set up bird
    bird = [Bird spriteNodeWithImageNamed:@"flappybird.gif"];
    bird.position=CGPointMake(self.size.width/2, self.size.height/2);
    bird.size=CGSizeMake(bird.size.width/3, bird.size.height/3);
    NSLog(@"bird height:%f\n",bird.size.height/2);
    NSLog(@"bird width:%f\n",bird.size.width/2);
    
    
    //        bird.size.width/=2;
    //        bird.size.height/=2;
    [self addChild:bird];
    //set edge when falling down
    self.physicsBody= [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.size.width, self.size.height)];
    NSLog(@"frame.x:%f frame.y:%f\n",self.frame.origin.x,self.frame.origin.y);
    NSLog(@"self.width:%f self.height:%f\n",self.size.width,self.size.height);
    
    bird.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:bird.size.width/2];
    [bird.physicsBody setAllowsRotation:false];

}

-(void)addPipe{
    CGFloat centerY = randomFloat(pipeGap, self.size.height-pipeGap);
    NSLog(@"centerY:%f",centerY);
    CGFloat pipeTopHeight = centerY - pipeGap;
    CGFloat pipeBottomHeight = self.size.height - (centerY + pipeGap);
    NSLog(@"pipeTopHeight:%f",pipeTopHeight);
    NSLog(@"pipeBottomHeight:%f",pipeBottomHeight);

    
    //add top pipe
    Pipe *pipeTop = [Pipe pipeWithHeight:pipeTopHeight withStyle:TopPipe];
    [pipeTop setPipeCategory:pipeCategory playerCategory:playerCategory];
    [self addChild:pipeTop];
    
    // Bottom Pipe
    Pipe *pipeBottom = [Pipe pipeWithHeight:pipeBottomHeight withStyle:BottomPipe];
    [pipeBottom setPipeCategory:pipeCategory playerCategory:playerCategory];
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

@end
