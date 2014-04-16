//
//  NavDrawerDelegate.h
//  NavDrawer
//
//  Created by Yongwei on 15/4/14.
//  Copyright (c) 2014 Kingway. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NavDrawerDelegate <NSObject>

@required
- (CGFloat)widthForSectionTab;
- (CGFloat)widthForActivityTab;

@end
