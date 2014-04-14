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

@interface ScrollViewNavigator : UIView <ScrollViewNavigatorDataSource, ScrollViewNavigatorDelegate>

@end
