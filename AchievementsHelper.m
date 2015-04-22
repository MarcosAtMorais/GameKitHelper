//
//  AchievementsHelper.m
//  Marcos Morais Corp -- www.bitjourneygame.com
//
//  Created by Marcos Morais on 25/06/14.
//  Copyright (c) 2014 Marcos Morais. All rights reserved.
//

#import "AchievementsHelper.h"

@implementation AchievementsHelper

static const NSInteger tenMissions = 10;

+ (GKAchievement *)tenMissions: (NSUInteger)mission
{
    CGFloat percent = (mission/tenMissions) * 100;
    GKAchievement *tenMissions = [[GKAchievement alloc] initWithIdentifier:
                                           @"br.com.marcosmorais.ShootEmAll.TenMissions"];
    tenMissions.percentComplete = percent;
    tenMissions.showsCompletionBanner = YES;
    return tenMissions;
}

@end
