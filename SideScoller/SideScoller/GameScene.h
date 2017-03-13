//
//  GameScene.h
//  SideScoller
//
//  Created by xumeng on 17/3/11.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Bird.h"
#import "Pipe.h"

@interface GameScene : SKScene
@property (strong,nonatomic) Bird* bird;
@property (strong,nonatomic) NSTimer* pipeTimer,*scoreTimer;
@property (nonatomic) NSInteger score;
@property(strong,nonatomic)  SKLabelNode *scoreLabel;
@end
