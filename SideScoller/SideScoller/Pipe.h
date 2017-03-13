//
//  Pipe.h
//  SideScoller
//
//  Created by xumeng on 17/3/12.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSInteger, PipeType) {
    TopPipe,
    BottomPipe,
};
@interface Pipe : SKSpriteNode
+ (Pipe *)pipeWithHeight:(CGFloat)height withStyle:(PipeType)type;
- (void)setPipeCategory:(uint32_t)pipe playerCategory:(uint32_t)player;

@end
