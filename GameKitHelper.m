//
//  GameKitHelper.m
//  Marcos Morais Corp -- www.bitjourneygame.com
//
//  Created by Marcos Morais on 25/06/14.
//  Copyright (c) 2014 Marcos Morais. All rights reserved.
//

#import "GameKitHelper.h"

NSString *const PresentAuthenticationViewController = @"present_authentication_view_controller";

@implementation GameKitHelper

BOOL _enableGameCenter;

- (id)init {
    self = [super init]; if (self) {
        _enableGameCenter = YES;
    }
    return self;
}

+ (instancetype)sharedGameKitHelper {
    static GameKitHelper *sharedGameKitHelper; static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGameKitHelper = [[GameKitHelper alloc] init];
    });
    return sharedGameKitHelper;
}

- (void)authenticateLocalPlayer {
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    localPlayer.authenticateHandler =
    ^(UIViewController *viewController, NSError *error) {
        [self setLastError:error];
        if(viewController != nil) {
            [self setAuthenticationViewController:viewController]; } else if([GKLocalPlayer localPlayer].isAuthenticated) {
                _enableGameCenter = YES;
            } else {
                    _enableGameCenter = NO;
            }
    };
}
- (void)setAuthenticationViewController: (UIViewController *)authenticationViewController
{
    if (authenticationViewController != nil) {
        _authenticationViewController = authenticationViewController;
        [[NSNotificationCenter defaultCenter]postNotificationName:PresentAuthenticationViewController object:self];
    }
}
- (void)setLastError:(NSError *)error {
    _lastError = [error copy];
    if (_lastError) {
        NSLog(@"GameKitHelper ERROR: %@", [[_lastError userInfo] description]);
    }
}

- (void)reportAchievements:(NSArray *)achievements {
    if (!_enableGameCenter) {
        NSLog(@"Local play is not authenticated");
    }
    [GKAchievement reportAchievements:achievements
                withCompletionHandler:^(NSError *error){
                    [self setLastError:error];
                }];
}

- (void)presentLeaderboardsOnViewController:(UIViewController *)viewController {
    GKGameCenterViewController *leaderboardViewController = [[GKGameCenterViewController alloc] init];
    leaderboardViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
    leaderboardViewController.gameCenterDelegate = self;
    [viewController presentViewController:leaderboardViewController animated:YES completion:nil];
}

- (void)gameCenterViewControllerDidFinish: (GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES
                                                 completion:nil];
}

@end
