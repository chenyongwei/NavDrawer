//
//  NavDrawer.h
//  NavDrawer
//
//  Created by Yongwei on 15/4/14.
//  Copyright (c) 2014 Kingway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavDrawerDataSource.h"
#import "NavDrawerDelegate.h"

enum NavDrawerTag : NSUInteger {
    NavDrawerTagSectionSpliter = 10001,
    NavDrawerTagSectionIcon = 10002,
    NavDrawerTagCurrentActivityIndicator = 10003,
    NavDrawerTagSectionIndexBase = 10010,
    NavDrawerTagActivityIndexBase = 10100 // assume max section number is 90, that's acceptable in current design.
};

@interface NavDrawer : UIView

@property (nonatomic, weak) id <NavDrawerDataSource> dataSource;
@property (nonatomic, weak) id <NavDrawerDelegate> delegate;

@end
