//
//  GameScene.m
//  SideScoller
//
//  Created by xumeng on 17/3/11.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene
@synthesize bird ;

//if (self = [super initWithSize:size]) {
//    /* Setup your scene here */
//    
//    //1 Set background color for this scene
//    self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
//    
//    //2 Create a new sprite
//    SKSpriteNode *player = [SKSpriteNode spriteNodeWithImageNamed:@"player"];
//    
//    //3 Set it's position to the center right edge of screen
//    player.position = CGPointMake(player.size.width/2, size.height/2);
//    
//    //4 Add it to current scene
//    [self addChild:player];
//}
//return self;

-(id)initWithSize:(CGSize)size{
    if(self=[super initWithSize:size]){
        //set up bird
        
        bird = [Bird spriteNodeWithImageNamed:@"flappybird.gif"];
        bird.position=CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:bird];
        
        
        
        
        
    }
    return self;
}



@end
