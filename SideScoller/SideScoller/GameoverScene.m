//
//  GameoverScene.m
//  SideScoller
//
//  Created by xumeng on 17/3/13.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "GameoverScene.h"

@implementation GameoverScene{
//    GameScene* game;
}
@synthesize finalscore;

-(id)initWithSize:(CGSize)size{
    if(self=[super initWithSize:size]){
        
        SKSpriteNode* back= [SKSpriteNode spriteNodeWithImageNamed:@"background.jpg"];
        back.size=self.size;
        back.position=CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        SKSpriteNode* gameover=[SKSpriteNode spriteNodeWithImageNamed:@"gameover.jpg"];
        gameover.position=CGPointMake(self.size.width*.5, self.size.height*.6);
        
        
        finalscore = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
        [finalscore setPosition:CGPointMake(self.size.width/2, self.size.height/2)];
        finalscore.fontSize=20;
        finalscore.fontColor= [SKColor yellowColor];
        [finalscore setText:[NSString stringWithFormat:@"Score:%@", [NSNumber numberWithInteger:[GameScene passScore]]]];
        
        SKSpriteNode* play= [SKSpriteNode spriteNodeWithImageNamed:@"play.jpg"];
        play.size=CGSizeMake(play.size.width/3, play.size.height/3);
        play.position=CGPointMake(self.size.width*.5, self.size.height*.4);
        play.name = @"playbutton";
        
        [self addChild:back];
        [self addChild:gameover];
        [self addChild:finalscore];
        [self addChild:play];
    }
    return self;
}


-(void) touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    //if fire button touched, bring the rain
    if ([node.name isEqualToString:@"playbutton"]) {
        ReadyScene* newgame=[[ReadyScene alloc]initWithSize:self.size];
        [self.scene.view presentScene:newgame];
    }

}

@end
