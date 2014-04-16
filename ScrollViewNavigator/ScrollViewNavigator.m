//
//  ScrollViewNavigator.m
//  ScrollViewNavigator
//
//  Created by Yongwei on 15/4/14.
//  Copyright (c) 2014 Kingway. All rights reserved.
//

#import "ScrollViewNavigator.h"

@implementation ScrollViewNavigator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    if (!self.delegate || !self.dataSource) {
        return;
    }
    
    // count current tab width first
    CGFloat sectionTabWidth = [self.delegate widthForSectionTab];
    NSInteger sectionsCount = [self.dataSource numberOfSections];
    CGFloat rowTabsContainerWidth = CGRectGetWidth(self.frame) - sectionTabWidth * sectionsCount;
    
    
    CGFloat sectionStartX = 0;
    for (int i = 0; i < sectionsCount; i++) {
        CGFloat sectionWidth = rowTabsContainerWidth + sectionTabWidth;
        CGFloat sectionHeight = CGRectGetHeight(self.frame);
        
        UIButton *sectionTab = [[UIButton alloc] initWithFrame:
                                CGRectMake(sectionStartX, 0, sectionWidth, sectionHeight)];
        sectionTab.backgroundColor = [UIColor blackColor];
        sectionTab.alpha = 0.5f;
        sectionTab.tag = ScrollViewNavigatorTagSectionIndexBase + i;
        // add section touch event handler
//        [sectionTab addTarget:self action:@selector(sectionTabSelected:) forControlEvents:UIControlEventTouchUpInside];
        // add to sectionBar
        [self insertSubview:sectionTab atIndex:i];
        
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

-(void)setDataSource:(id<ScrollViewNavigatorDataSource>)dataSource
{
    _dataSource = dataSource;
    [self setup];
}

-(void)setDelegate:(id<ScrollViewNavigatorDelegate>)delegate
{
    _delegate = delegate;
    [self setup];
}

@end
