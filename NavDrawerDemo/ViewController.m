//
//  ViewController.m
//  ScrollViewNavigator
//
//  Created by Yongwei on 15/4/14.
//  Copyright (c) 2014 Kingway. All rights reserved.
//

#import "ViewController.h"
#import "NavDrawer.h"
#import "NavDrawerDelegate.h"
#import "NavDrawerDataSource.h"
#import "SectionDataBase.h"

@interface ViewController () <NavDrawerDelegate, NavDrawerDataSource>

-(IBAction)next:(id)sender;
-(IBAction)previous:(id)sender;

@end

@implementation ViewController
{
    NavDrawer *navigator;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setup];
}

-(void)setup
{
    navigator = [[NavDrawer alloc] initWithFrame:
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


-(void)next:(id)sender
{
    [navigator nextActivity];
}

-(void)previous:(id)sender
{
    [navigator previousActivity];
}


#pragma mark - NavDrawerDataSource

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


#pragma mark - NavDrawerDelegate

-(CGFloat)widthForSectionTab
{
    return 30;
}

-(CGFloat)widthForActivityTab
{
    return 15;
}

@end
