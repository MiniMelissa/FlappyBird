//
//  GameViewController.m
//  SideScoller
//
//  Created by xumeng on 17/3/9.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (void)loadView
{
    self.view  = [[SKView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    
//    https://onevcat.com/2013/06/sprite-kit-start/
    //configure view
    SKView * skview=(SKView *)self.view;
    skview.showsFPS=YES;
    skview.showsNodeCount=YES;
    
    //create and configure scene
    SKScene * scene=[ReadyScene sceneWithSize:skview.bounds.size ];
    scene.scaleMode=SKSceneScaleModeFill;
    
    //present scene
    [skview presentScene:scene];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
