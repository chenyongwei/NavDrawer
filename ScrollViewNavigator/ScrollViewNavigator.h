//
//  ScrollViewNavigator.h
//  ScrollViewNavigator
//
//  Created by Yongwei on 15/4/14.
//  Copyright (c) 2014 Kingway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollViewNavigatorDataSource.h"
#import "ScrollViewNavigatorDelegate.h"

enum ScrollViewNavigatorTag : NSUInteger {
    ScrollViewNavigatorTagSectionSpliter = 1,
    ScrollViewNavigatorTagSectionIcon = 2,
    ScrollViewNavigatorTagCurrentActivityIndicator = 3,
    ScrollViewNavigatorTagSectionIndexBase = 100,
    ScrollViewNavigatorTagActivityIndexBase = 10000 // assume max section number is 10000-100, that's acceptable in current design.
};

@interface ScrollViewNavigator : UIView

@property (nonatomic, weak) id <ScrollViewNavigatorDataSource> dataSource;
@property (nonatomic, weak) id <ScrollViewNavigatorDelegate> delegate;

@end
