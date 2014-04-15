//
//  ScrollViewNavigator.m
//  ScrollViewNavigator
//
//  Created by Yongwei on 15/4/14.
//  Copyright (c) 2014 Kingway. All rights reserved.
//

#import "ScrollViewNavigator.h"

@implementation ScrollViewNavigator
{
    UIView *navigator;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup:frame];
    }
    return self;
}


-(void)setup:(CGRect)aFrame
{
    navigator = [[UIView alloc] initWithFrame: aFrame];
    navigator.backgroundColor = [UIColor grayColor];
    
    [self addSubview:navigator];
}

#pragma mark - ScrollViewNavigatorDataSource

-(NSInteger)numberOfSections
{
    return 3;
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
