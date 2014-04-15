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
    
    // count current tab width first
    CGFloat sectionTabWidth = [self.delegate widthForSectionTab];
    NSInteger sectionsCount = [self.dataSource numberOfSections];
    CGFloat rowTabsContainerWidth = CGRectGetWidth(navigator.frame) - sectionTabWidth * sectionsCount;
    
    CGFloat sectionStartX = 0;
    for (int i = 0; i < sectionsCount; i++) {
        CGFloat sectionWidth = rowTabsContainerWidth + sectionTabWidth;
        CGFloat sectionHeight = CGRectGetHeight(navigator.frame);
        
        UIButton *sectionTab = [[UIButton alloc] initWithFrame:
                                CGRectMake(sectionStartX, 0, sectionWidth, sectionHeight)];
        sectionTab.backgroundColor = [UIColor blackColor];
        sectionTab.tag = ScrollViewNavigatorTagSectionIndexBase + i;
        // add section touch event handler
        [sectionTab addTarget:self action:@selector(sectionTabSelected:) forControlEvents:UIControlEventTouchUpInside];
        // add to sectionBar
        [navigator insertSubview:sectionTab atIndex:i];
        
//        [self addIconOnSection:sectionTab withSectionData:sectionData];
        SectionDataBase *sectionData = [self.dataSource dataOfSection:i];
        // add row tabs into current section tab.
        if (sectionData.isCurrent) {
//            NSMutableArray *rowsData = sectionData.rows;
//            [self addRowTabsOnSectionTab:sectionTab withRowsData:rowsData];
        }
        
        // add the split line between tabs
        if (i > 0) {
            UIView *splitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, sectionHeight)];
            splitView.backgroundColor = [UIColor blackColor];
            splitView.tag = ScrollViewNavigatorTagSectionSpliter;
            [sectionTab addSubview:splitView];
        }
        
        sectionStartX += sectionData.isCurrent ? sectionWidth : sectionTabWidth;
    }
}

@end
