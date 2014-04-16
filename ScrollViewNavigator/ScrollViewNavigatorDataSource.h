//
//  ScrollViewNavigatorDataSource.h
//  ScrollViewNavigator
//
//  Created by Yongwei on 15/4/14.
//  Copyright (c) 2014 Kingway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SectionDataBase.h"
#import "ActivityDataBase.h"

@protocol ScrollViewNavigatorDataSource <NSObject>

@required
- (NSInteger)numberOfActivitiesInSection:(NSInteger)section;

-(SectionDataBase *)dataOfSection:(NSInteger)section;
-(ActivityDataBase *)dataOfActivity:(NSInteger)activity atSection:(NSInteger)section;

@optional
- (NSInteger)numberOfSections;              // Default is 1 if not implemented

@end
