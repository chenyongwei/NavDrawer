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

@end
