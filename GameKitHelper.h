//
//  GameKitHelper.h
//  Marcos Morais Corp -- www.bitjourneygame.com
//
//  Created by Marcos Morais on 25/06/14.
//  Copyright (c) 2014 Marcos Morais. All rights reserved.
//

#import <Foundation/Foundation.h>

@import GameKit;

extern NSString *const PresentAuthenticationViewController;

@interface GameKitHelper : NSObject <GKGameCenterControllerDelegate>
- (void)authenticateLocalPlayer;
@property (nonatomic, readonly)
UIViewController *authenticationViewController;
@property (nonatomic, readonly) NSError *lastError; + (instancetype)sharedGameKitHelper;
- (void)reportAchievements:(NSArray *)achievements;
- (void)presentLeaderboardsOnViewController:(UIViewController *)viewController;
@end