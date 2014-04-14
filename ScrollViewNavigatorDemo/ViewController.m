//
//  ViewController.m
//  ScrollViewNavigator
//
//  Created by Yongwei on 15/4/14.
//  Copyright (c) 2014 Kingway. All rights reserved.
//

#import "ViewController.h"
#import "ScrollViewNavigator.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setup];
}

-(void)setup
{
    ScrollViewNavigator *navigator = [[ScrollViewNavigator alloc] initWithFrame:
                 CGRectMake(0,
                            CGRectGetHeight(self.view.frame) - 44,
                            CGRectGetWidth(self.view.frame),
                            44)];
    navigator.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:navigator];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
