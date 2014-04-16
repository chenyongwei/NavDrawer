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
        
#if DEBUG
        sectionTab.backgroundColor = [UIColor greenColor];
#endif
        sectionTab.tag = ScrollViewNavigatorTagSectionIndexBase + i;
        // add section touch event handler
        [sectionTab addTarget:self action:@selector(sectionTabSelected:) forControlEvents:UIControlEventTouchUpInside];
        // add to sectionBar
        [self insertSubview:sectionTab atIndex:i];
        
        //        [self addIconOnSection:sectionTab withSectionData:sectionData];
        SectionDataBase *sectionData = [self.dataSource dataOfSection:i];
        // add row tabs into current section tab.
        if (sectionData.isCurrent) {
            //            NSMutableArray *rowsData = sectionData.rows;
            //            [self addRowTabsOnSectionTab:sectionTab withRowsData:rowsData];
            [self addActivityTabsOnSection:i];
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

- (void)addActivityTabsOnSection:(NSInteger)section {
    CGFloat sectionTabWidth = [self.delegate widthForSectionTab];
    NSInteger activityCount = [self.dataSource numberOfActivitiesInSection:section];

    CGFloat rowTabWidth = [self.delegate widthForRowTab];
    CGFloat rowTabHeight = CGRectGetHeight(self.frame);
    CGFloat rowTabY = 0;
    
    NSInteger tag = ScrollViewNavigatorTagSectionIndexBase + section;
    UIView *sectionTab = [self viewWithTag:tag];
    
    for (int j = 0; j < activityCount; j++)
    {
        ActivityDataBase *activityData = [self.dataSource dataOfActivity:j atSection:section];
        
        // add row icon
//        UIImage *rowIcon = [UIImage imageNamed:rowData.icon];
        // calculate the rowTab Rect
        CGFloat rowTabX = sectionTabWidth + rowTabWidth * j;

        UIButton *rowTab = [[UIButton alloc] initWithFrame:CGRectMake(rowTabX,
                                                                      rowTabY,
                                                                      rowTabWidth,
                                                                      rowTabHeight)];
//        [rowTab setImage:rowIcon forState:UIControlStateNormal];
        rowTab.tag = ScrollViewNavigatorTagRowIndexBase + j;
        
#if DEBUG
        rowTab.backgroundColor = [UIColor redColor];
        
        UIView *splitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, rowTabHeight)];
        splitView.backgroundColor = [UIColor blackColor];
        splitView.tag = ScrollViewNavigatorTagSectionSpliter;
        [rowTab addSubview:splitView];
#endif
        
        [sectionTab insertSubview:rowTab atIndex:j];

        
        if (activityData.isCurrent) {
            // add current row indicator
//            UIImageView *currRowIndicator = [[UIImageView alloc] initWithFrame:
//                                             CGRectMake(rowTabX,
//                                                        rowTabY,
//                                                        rowTabW,
//                                                        rowTabH)];
//            currRowIndicator.image = [UIImage imageNamed:@"activityicon-mask"];
//            currRowIndicator.tag = KWTableViewTagCurrentRowIndicator;
//            [sectionTab insertSubview:currRowIndicator aboveSubview:rowTab];
        }
        // add touch up inside event handler for activity icon
        [rowTab addTarget:self action:@selector(rowTabSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)sectionTabSelected:(id)sender
{
    NSLog(@"section tab selected: tag - %d", ((UIView *)sender).tag);
}

-(void)rowTabSelected:(id)sender
{
    NSLog(@"row tab selected: tag - %d", ((UIView *)sender).tag);
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
