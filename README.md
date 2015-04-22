# GameKitHelper
This guide is for learning purposes. Here, you’ll learn how to send your score to a Game Center Leaderboard.

Make sure you’ve created a new leaderboard on iTunes Connect and have your Leaderboard ID. With you.

First of all: Import GameKitHelper.h where you’ll use GameCenter. Example: GameScene.m or GameViewController.h

/* This method goes right where you want to send the highscore to the Game Center Server Example: GameScene.m or GameLayer.m
Call it where you want to send your score. Example: Game Over.
*/
-(void)reportScore{
    GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:kHighScoreLeaderboardID]; //Here goes your Leaderboard ID from Game Center.
    score.value = [GameState sharedInstance].highScore; // Replace this with your current HighScore!
    
    [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

————————————————

/* GAMEVIEWCONTROLLER — Just place this at the bottom of your GameViewController or ViewController */
#pragma mark - GAME CENTER
- (void)showAuthenticationViewController {
    GameKitHelper *gameKitHelper = [GameKitHelper sharedGameKitHelper];
    [self presentViewController: gameKitHelper.authenticationViewController
                       animated:YES completion:nil];
}

-(void)showGameCenterLeaderBoard{
    GameKitHelper *gameKitHelper = [GameKitHelper sharedGameKitHelper];
    [gameKitHelper presentLeaderboardsOnViewController:self];
    
}

-(void) showNotificationView:(NSNotification *) notification{
    [_notificationView showAndDismissWithTime:2]; //You need to create an UINotificationView in your viewController.
}

————————————————

/* Inside your viewDidLoad method in GameViewController — Just before you present your Scene */

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAuthenticationViewController) name:PresentAuthenticationViewController object:nil];
        [[GameKitHelper sharedGameKitHelper] authenticateLocalPlayer];

————————————————

AND YOU’RE DONE! Just go to your Project > Capabilities and turn on Game Center!
