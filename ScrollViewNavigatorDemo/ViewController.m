//
//  ViewController.m
//  ScrollViewNavigator
//
//  Created by Yongwei on 15/4/14.
//  Copyright (c) 2014 Kingway. All rights reserved.
//

#import "ViewController.h"
#import "ScrollViewNavigator.h"
#import "ScrollViewNavigatorDelegate.h"
#import "ScrollViewNavigatorDataSource.h"
#import "SectionDataBase.h"

@interface ViewController () <ScrollViewNavigatorDelegate, ScrollViewNavigatorDataSource>

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
    navigator.backgroundColor = [UIColor redColor];
    navigator.dataSource = self;
    navigator.delegate = self;
    
    [self.view addSubview:navigator];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ScrollViewNavigatorDataSource

-(NSInteger)numberOfSections
{
    return 3;
}

-(SectionDataBase *)dataOfSection:(NSInteger)section
{
    return nil;
}

-(NSInteger)numberOfActivitiesInSection:(NSInteger)section
{
    return 5;
}

#pragma mark - ScrollViewNavigatorDelegate

-(CGFloat)heightForSectionBar
{
    return 30;
}

-(CGFloat)widthForSectionTab
{
    return 30;
}

-(CGFloat)widthForRowTab
{
    return 15;
}


@end
