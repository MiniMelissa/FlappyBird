//
//  ReadyScene.m
//  SideScoller
//
//  Created by xumeng on 17/3/11.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "ReadyScene.h"

@implementation ReadyScene
@synthesize getReady;
-(id)initWithSize:(CGSize)size{
    if(self=[super initWithSize:size]){
        
        
        SKSpriteNode* back= [SKSpriteNode spriteNodeWithImageNamed:@"background.jpg"];
         back.size=self.size;
        back.position=CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
       
        getReady=[SKSpriteNode spriteNodeWithImageNamed:@"ready.jpg"];
        getReady.position=CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        getReady.position=CGPointMake(self.size.width*.5, self.size.height*.6);
        Bird* bird=[Bird spriteNodeWithImageNamed:@"bird.png"];
        bird.size=CGSizeMake(bird.size.width/3, bird.size.height/3);
        bird.position=CGPointMake(self.size.width*.5, self.size.height*.5);
        
        [self addChild:back];
        [self addChild:getReady];
        [self addChild:bird];
        
    }
    return self;
}

-(void) touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    getReady.hidden=true;
    GameScene* game=[[GameScene alloc]initWithSize:self.size];
    [self.scene.view presentScene:game];
    
}

@end
