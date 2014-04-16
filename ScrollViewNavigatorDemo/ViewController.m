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
                            CGRectGetHeight(self.view.frame) - 30,
                            CGRectGetWidth(self.view.frame),
                            30)];
    navigator.backgroundColor = [UIColor grayColor];
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
    SectionDataBase *sectionData = [[SectionDataBase alloc] init];
    if (section == 0) {
        sectionData.isCurrent = YES;
    }

    return sectionData;
}

-(ActivityDataBase *)dataOfActivity:(NSInteger)activity atSection:(NSInteger)section
{
    ActivityDataBase *activityData = [[ActivityDataBase alloc] init];
    if (activity == 3) {
        activityData.isCurrent = YES;
    }
    return activityData;
}

-(NSInteger)numberOfActivitiesInSection:(NSInteger)section
{
    return 5;
}

#pragma mark - ScrollViewNavigatorDelegate

-(CGFloat)widthForSectionTab
{
    return 30;
}

-(CGFloat)widthForRowTab
{
    return 15;
}


@end
