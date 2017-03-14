//
//  Pipe.m
//  SideScoller
//
//  Created by xumeng on 17/3/12.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "Pipe.h"

@implementation Pipe

+ (Pipe *)pipeWithHeight:(CGFloat)height withStyle:(PipeType)type{
    CGFloat offset;
    NSString *pipeName;
    if(type==TopPipe){
        pipeName=@"TopPipe.png";
        offset= -([[UIScreen mainScreen] applicationFrame].size.height);
    }else{
        pipeName=@"BottomPipe.png";
//        offset=-([[UIScreen mainScreen] applicationFrame].size.height-300);
//        NSLog(@"frame.height:%f",[[UIScreen mainScreen] applicationFrame].size.height);
        offset=-2;
        
    }

    Pipe* pipe=[[Pipe alloc] initWithImageNamed:pipeName];
    pipe.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pipe.size];
    //avoid toppipe fall down
    [pipe.physicsBody setAffectedByGravity:NO];
    //avoid bottonpipe fall down
    [pipe.physicsBody setDynamic:NO];

    [pipe setCenterRect:CGRectMake(26.0 /56.0 , 26.0/56.0, 4.0/56.0, 4.0/56.0)];
    //resizing the height of each pipe
    [pipe setYScale:height/(pipe.size.height)];
    pipe.size=CGSizeMake(pipe.size.width/2, pipe.size.height);
//    NSLog(@"pipe.width:%f",pipe.size.width);
//    if(type==BottomPipe){
//        [pipe setPosition:CGPointMake(320+pipe.size.width, 675.0)];
//    }else{
//
        [pipe setPosition:CGPointMake(320+pipe.size.width, abs(offset+(pipe.size.height/2)))];
//    }

//    pipe.physicsBody.usesPreciseCollisionDetection=true;
//
//    NSLog(@"pipe.x:%f",pipe.size.width);
//    NSLog(@"pipe.y:%f",pipe.size.height);
//    NSLog(@"offset:%f",offset);
    return pipe;
}

- (void)setPipeCategory:(uint32_t)pipe playerCategory:(uint32_t)bird
{
    [self.physicsBody setCategoryBitMask:pipe];
    [self.physicsBody setCollisionBitMask:bird];
    //[self.physicsBody setContactTestBitMask:bird];
}



@end
