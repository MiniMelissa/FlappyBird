//
//  Pipe.m
//  SideScoller
//
//  Created by xumeng on 17/3/12.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "Pipe.h"

@implementation Pipe

/*+ (Pipe *)pipeWithHeight:(CGFloat)height withStyle:(PipeStyle)style
{
    NSString *pipeImageName;
    CGFloat offset;
    
    if (style == PipeStyleTop) {
        pipeImageName = @"PipeTop";
        offset = -([[UIScreen mainScreen] applicationFrame].size.height-2);
    } else {
        pipeImageName = @"PipeBottom";
        offset = -2;
    }
    
    Pipe *pipe = [[Pipe alloc] initWithImageNamed:pipeImageName];
    
    pipe.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pipe.size];
    [pipe.physicsBody setAffectedByGravity:NO];
    [pipe.physicsBody setDynamic:NO];
    
    [pipe setCenterRect:CGRectMake(26.0/kPipeWidth, 26.0/kPipeWidth, 4.0/kPipeWidth, 4.0/kPipeWidth)];
    [pipe setYScale:height/(pipe.size.height)];
    [pipe setPosition:CGPointMake(320+(pipe.size.width/2), abs(offset+(pipe.size.height/2)))];
    
    return pipe;
}*/

+ (Pipe *)pipeWithHeight:(CGFloat)height withStyle:(PipeType)type{
    CGFloat offset;
    NSString *pipeName;
    if(type==TopPipe){
        pipeName=@"TopPipe.png";
        offset= -([[UIScreen mainScreen] applicationFrame].size.height-2);
    }else{
        pipeName=@"BottomPipe.png";
//        offset=-([[UIScreen mainScreen] applicationFrame].size.height-300);
        NSLog(@"frame.height:%f",[[UIScreen mainScreen] applicationFrame].size.height);
        offset=-30;
        
    }

    Pipe* pipe=[[Pipe alloc] initWithImageNamed:pipeName];
    pipe.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pipe.size];
    //avoid toppipe fall down
    [pipe.physicsBody setAffectedByGravity:NO];
    //avoid bottonpipe fall down
    [pipe.physicsBody setDynamic:NO];

    [pipe setCenterRect:CGRectMake(26.0 /56.0 , 26.0/56.0, 4.0/100.0, 4.0/100.0)];
    //resizing the height of each pipe
    [pipe setYScale:height/(pipe.size.height)];
    pipe.size=CGSizeMake(pipe.size.width/2, pipe.size.height);
    NSLog(@"pipe.width:%f",pipe.size.width);
    if(type==BottomPipe){
        [pipe setPosition:CGPointMake(320+pipe.size.width, abs(offset+(pipe.size.height/2)))];
    }else{
//
        [pipe setPosition:CGPointMake(320+pipe.size.width, abs(offset+(pipe.size.height/2)))];
    }

  

    NSLog(@"pipe.x:%f",pipe.size.width);
    NSLog(@"pipe.y:%f",pipe.size.height);
    
    NSLog(@"offset:%f",offset);
    return pipe;
}

- (void)setPipeCategory:(uint32_t)pipe playerCategory:(uint32_t)player
{
    [self.physicsBody setCategoryBitMask:pipe];
    [self.physicsBody setCollisionBitMask:player];
}



@end
