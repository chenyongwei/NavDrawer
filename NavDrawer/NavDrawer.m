//
//  NavDrawer.m
//  NavDrawer
//
//  Created by Yongwei on 15/4/14.
//  Copyright (c) 2014 Kingway. All rights reserved.
//

#import "NavDrawer.h"

@implementation NavDrawer
{
    NSInteger currentSection, currentActivity;
}

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
    CGFloat activityTabsContainerWidth = CGRectGetWidth(self.frame) - sectionTabWidth * sectionsCount;
    
    
    CGFloat sectionStartX = 0;
    for (int i = 0; i < sectionsCount; i++) {
        CGFloat sectionWidth = activityTabsContainerWidth + sectionTabWidth;
        CGFloat sectionHeight = CGRectGetHeight(self.frame);
        
        UIButton *sectionTab = [[UIButton alloc] initWithFrame:
                                CGRectMake(sectionStartX, 0, sectionWidth, sectionHeight)];
        
#if DEBUG
        sectionTab.backgroundColor = [UIColor greenColor];
#endif
        sectionTab.tag = NavDrawerTagSectionIndexBase + i;
        // add section touch event handler
        [sectionTab addTarget:self action:@selector(sectionTabSelected:) forControlEvents:UIControlEventTouchUpInside];
        // add to sectionBar
        [self insertSubview:sectionTab atIndex:i];
        
        //        [self addIconOnSection:sectionTab withSectionData:sectionData];
        SectionDataBase *sectionData = [self.dataSource dataOfSection:i];
        // add activity tabs into current section tab.
        if (sectionData.isCurrent) {
            currentSection = i;
            [self addActivityTabsOnSection:i];
        }
        
        // add the split line between tabs
        if (i > 0) {
            UIView *splitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, sectionHeight)];
            splitView.backgroundColor = [UIColor blackColor];
            splitView.tag = NavDrawerTagSectionSpliter;
            [sectionTab addSubview:splitView];
        }
        
        sectionStartX += sectionData.isCurrent ? sectionWidth : sectionTabWidth;
    }
 
}

- (void)addActivityTabsOnSection:(NSInteger)section {
    CGFloat sectionTabWidth = [self.delegate widthForSectionTab];
    NSInteger activityCount = [self.dataSource numberOfActivitiesInSection:section];

    CGFloat activityTabWidth = [self.delegate widthForActivityTab];
    CGFloat activityTabHeight = CGRectGetHeight(self.frame);
    CGFloat activityTabY = 0;
    
    NSInteger tag = NavDrawerTagSectionIndexBase + section;
    UIView *sectionTab = [self viewWithTag:tag];
    
    for (int j = 0; j < activityCount; j++)
    {
        ActivityDataBase *activityData = [self.dataSource dataOfActivity:j atSection:section];
        
        // calculate the activityTab Rect
        CGFloat activityTabX = sectionTabWidth + activityTabWidth * j;

        UIButton *activityTab = [[UIButton alloc] initWithFrame:CGRectMake(activityTabX,
                                                                      activityTabY,
                                                                      activityTabWidth,
                                                                      activityTabHeight)];
        activityTab.tag = NavDrawerTagActivityIndexBase + j;
        
#if DEBUG
        activityTab.backgroundColor = [UIColor redColor];
        
        UIView *splitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, activityTabHeight)];
        splitView.backgroundColor = [UIColor blackColor];
        splitView.tag = NavDrawerTagSectionSpliter;
        [activityTab addSubview:splitView];
#endif
        
        [sectionTab insertSubview:activityTab atIndex:j];

        
        if (activityData.isCurrent) {
            currentActivity = j;
            // add current activity indicator
            UIView *currActivityIndicator = [[UIView alloc] initWithFrame:
                                             CGRectMake(activityTabX,
                                                        activityTabY,
                                                        activityTabWidth,
                                                        activityTabHeight)];
            currActivityIndicator.backgroundColor = [UIColor yellowColor];
            currActivityIndicator.tag = NavDrawerTagCurrentActivityIndicator;
            [sectionTab insertSubview:currActivityIndicator aboveSubview:activityTab];
        }
        // add touch up inside event handler for activity icon
        [activityTab addTarget:self action:@selector(activityTabSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)sectionTabSelected:(id)sender
{
    UIView *srcView = (UIView *)sender;
    NSInteger selectedSection = srcView.tag - NavDrawerTagSectionIndexBase;
    [self gotoSection:selectedSection];
}

-(void)activityTabSelected:(id)sender
{
    UIView *srcView = (UIView *) sender;
    NSInteger selectedActivity = srcView.tag - NavDrawerTagActivityIndexBase;
    [self gotoActivity:selectedActivity];
}

-(void)gotoSection:(NSInteger)targetSection
{
    if  (currentSection != targetSection)
    {
        // do section tab switch animation
        [self doSectionChangeAnimationFromIndex:currentSection toIndex:targetSection];
        // update current section
        currentSection = targetSection;
    }
}

-(void)gotoActivity:(NSInteger)targetActivity
{
    if (currentActivity != targetActivity) {
        // do current activity tab animation
        [self doActivityTabChangeAnimationFromIndex:currentActivity toIndex:targetActivity];
        // update data
        currentActivity = targetActivity;
    }
}

#pragma Animations

- (void)doSectionChangeAnimationFromIndex:(int)fromIndex toIndex:(int)toIndex {
    if (fromIndex == toIndex)
    {
        return;
    }
    NSInteger minIndex = MIN(fromIndex,toIndex);
    NSInteger maxIndex = MAX(fromIndex,toIndex);
    
    BOOL moveToLeft = toIndex == maxIndex;
    NSInteger activityTabsContainerWidth = CGRectGetWidth(self.frame)
            - ([self.delegate widthForSectionTab] * [self.dataSource numberOfSections]);
    
    [UIView beginAnimations:@"Move" context:nil];
    [UIView setAnimationDuration:0.1];
    
    for (int i=maxIndex; i>minIndex; i--) {
        UIView *v = [self viewWithTag:i + NavDrawerTagSectionIndexBase];
        CGRect frame = v.frame;
        frame.origin.x += moveToLeft ? -activityTabsContainerWidth : activityTabsContainerWidth;
        v.frame = frame;
    }
    //code to be executed on the main queue after delay
    UIView *currSectionView = [self viewWithTag:fromIndex + NavDrawerTagSectionIndexBase];

    [self removeActivitiesOnSection:currSectionView];
    [self addActivityTabsOnSection:toIndex];
    
    [UIView commitAnimations];
    
}

- (void)doActivityTabChangeAnimationFromIndex:(int)fromIndex toIndex:(int)toIndex {
    if (fromIndex == toIndex)
    {
        return;
    }
    
    [UIView beginAnimations:@"Move" context:nil];
    [UIView setAnimationDuration:0.1];
    
    UIView *fromView = [self viewWithTag:NavDrawerTagCurrentActivityIndicator];
    UIView *toView = [self viewWithTag:toIndex + NavDrawerTagActivityIndexBase];
    CGRect frame = fromView.frame;
    frame.origin.x = toView.frame.origin.x;
    fromView.frame = frame;
    
    [UIView commitAnimations];
}


- (void)removeActivitiesOnSection:(UIView *)sectionTab
{
    NSArray *subVs = sectionTab.subviews;
    for (int i = 0; i < subVs.count; i++) {
        UIView *v = [subVs objectAtIndex:i];
        if (!(v.tag == NavDrawerTagSectionSpliter || v.tag == NavDrawerTagSectionIcon)) {
            [v removeFromSuperview];
        }
    }
}

-(void)nextActivity
{
    NSLog(@"goto next activity");
    NSInteger activitiesCount = [self.dataSource numberOfActivitiesInSection:currentSection];
    if (currentActivity == activitiesCount - 1) {
        // last activity of current section,
        // should move to first activity of next section
        NSInteger sectionsCount = [self.dataSource numberOfSections];
        if (currentSection == sectionsCount - 1) {
            // last section
            // do nothing
            NSLog(@"!!!!!! in last section, last activity, can't move to next");
        }
        else {
            [self gotoSection: currentSection + 1];
            //TODO: should go to firt activity of next section, not implemented
        }
    }
    else {
        [self gotoActivity: currentActivity + 1];
    }
}

-(void)previousActivity
{
    NSLog(@"goto previous activity");
    if (currentActivity == 0) {
        // first activity of current section,
        // should move to last activity of previous section
        if (currentSection == 0) {
            // first section
            // do nothing
            NSLog(@"!!!!!! in first section, first activity, can't move to previous");
        }
        else {
            [self gotoSection:currentSection - 1];
            //TODO: should go to last activity of previous section, not implemented
        }
    }
    else {
        [self gotoActivity:currentActivity - 1];
    }
}

-(void)setDataSource:(id<NavDrawerDataSource>)dataSource
{
    _dataSource = dataSource;
    [self setup];
}

-(void)setDelegate:(id<NavDrawerDelegate>)delegate
{
    _delegate = delegate;
    [self setup];
}


@end
