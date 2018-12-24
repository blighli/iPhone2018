#import "GameViewController.h"

@interface GameViewController ()

@end

int birdPositionX, birdPositionY;
int birdFlight;
int randomTopTunnelPosition;
int randomBottomTunnelPosition;
int score;
NSInteger highScore;

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topTunnel.hidden = YES;
    self.bottomTunnel.hidden = YES;
    self.exitButton.hidden = YES;
    score = 0;
    highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScore"];
    birdPositionX = self.bird.center.x;
    birdPositionY = self.bird.center.y;
}

- (IBAction)startGame:(id)sender {
    self.topTunnel.hidden = NO;
    self.bottomTunnel.hidden = NO;
    self.startButton.hidden = YES;
    
    score = 0;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", score];
    
    self.birdMovement = [NSTimer scheduledTimerWithTimeInterval:0.045 target:self selector:@selector(birdMoving) userInfo:nil repeats:YES];
    
    [self placeTunnels];
    
    self.tunnelMovement = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(tunnelsMoving) userInfo:nil repeats:YES];
}

- (void)birdMoving {
    self.bird.center = CGPointMake(self.bird.center.x, self.bird.center.y - birdFlight);
    birdFlight = birdFlight - 5;
  
    if(birdFlight < -15) {
        birdFlight = -15;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    birdFlight = 20;
}

- (void)tunnelsMoving {
    self.topTunnel.center = CGPointMake(self.topTunnel.center.x - 1, self.topTunnel.center.y);
    self.bottomTunnel.center = CGPointMake(self.bottomTunnel.center.x - 1, self.bottomTunnel.center.y);
    
    if(self.topTunnel.center.x < -28) {
        [self placeTunnels];
    }
    
    if(self.topTunnel.center.x == 30){
        [self score];
    }
    
    if(CGRectIntersectsRect(self.bird.frame, self.topTunnel.frame)) {
        [self gameOver];
    }
    
    if(CGRectIntersectsRect(self.bird.frame, self.topTunnel.frame)) {
        [self gameOver];
    }
    
    if(CGRectIntersectsRect(self.bird.frame, self.top.frame)) {
        [self gameOver];
    }
    
    if(CGRectIntersectsRect(self.bird.frame, self.bottom.frame)) {
        [self gameOver];
    }
}

- (void) placeTunnels {
    randomTopTunnelPosition = arc4random() % 350;
    randomTopTunnelPosition = randomTopTunnelPosition - 228;
    randomBottomTunnelPosition = randomTopTunnelPosition + 800;
    self.topTunnel.center = CGPointMake(340, randomTopTunnelPosition);
    self.bottomTunnel.center = CGPointMake(340, randomBottomTunnelPosition);
}

- (void) score {
    score = score + 1;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", score];
}

- (void)gameOver {
    if(score > highScore) {
        [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"HighScore"];
    }
    [self.birdMovement invalidate];
    [self.tunnelMovement invalidate];
    
    self.bird.center = CGPointMake(birdPositionX, birdPositionY);
    
    self.exitButton.hidden = NO;
    self.topTunnel.hidden = YES;
    self.bottomTunnel.hidden = YES;
    self.startButton.hidden = NO;
}

@end
