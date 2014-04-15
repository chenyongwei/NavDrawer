//
//  ScrollViewNavigatorDelegate.h
//  ScrollViewNavigator
//
//  Created by Yongwei on 15/4/14.
//  Copyright (c) 2014 Kingway. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ScrollViewNavigatorDelegate <NSObject>

@required
- (CGFloat)heightForSectionBar;
- (CGFloat)widthForSectionTab;
- (CGFloat)widthForRowTab;

@end
