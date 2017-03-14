//
//  ViewController.m
//  SideScoller
//
//  Created by xumeng on 17/3/1.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    NSLog(@"Performing segue with ID %@, so we can set things up.", identifier);
}

-(IBAction)unwindForSegue:(UIStoryboardSegue *)unwindSegue towardsViewController:(UIViewController *)subsequentVC
{
    NSLog(@"Backing out of the other view controller.");
    // [counterLabel setText:[NSString stringWithFormat:@"Counter: %d", [[Universe sharedInstance] counter]]];
    
}

@end
