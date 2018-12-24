//
//  SuccessViewController.m
//  DontTouchWhiteBlock
//
//  Created by Marveliu on 18/11/20.
//  Copyright © 2018年 Marveliu. All rights reserved.


#import "SuccessViewController.h"

@interface SuccessViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestScoreLabel;

@end

@implementation SuccessViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.timeLabel.text = _score;
    self.titleLabel.text = _titleName;
    [self.timeLabel sizeToFit];
    [self.view layoutIfNeeded];
    
    if([self.titleLabel.text isEqualToString:@"经典"]){
        [self updateClassicBestScore];
    } else if([self.titleLabel.text isEqualToString:@"街机"]){
        [self updateJiejiBestScore];
    }
}

- (void)updateClassicBestScore{
    NSString *bestScore = app.defaults.classScore;
    NSString *newScore = self.timeLabel.text;

    if(bestScore == nil){
        app.defaults.classScore = newScore;
        self.bestScoreLabel.text = [NSString stringWithFormat:@"新纪录: %@", newScore];
    }
    switch ([bestScore compare:newScore]) {
        case NSOrderedAscending:
            self.bestScoreLabel.text = [NSString stringWithFormat:@"最佳纪录: %@", bestScore];
            break;
        case NSOrderedDescending:
            self.bestScoreLabel.text = [NSString stringWithFormat:@"新纪录: %@", newScore];
            app.defaults.classScore = newScore;
            break;
        default:
            break;
    }
}
- (void)updateJiejiBestScore{
    
    NSString *bestScore = app.defaults.jiejiScore;
    
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    NSNumber *bestnum = [format numberFromString:bestScore];
    
    NSString *newScore = self.timeLabel.text;
    NSNumber *newnum = [format numberFromString:self.timeLabel.text];
    
    if(bestScore == nil){
        app.defaults.jiejiScore = newScore;
        self.bestScoreLabel.text = [NSString stringWithFormat:@"新纪录: %@", newScore];
    }

    if(bestnum > newnum){
        self.bestScoreLabel.text = [NSString stringWithFormat:@"最佳纪录: %d", [bestnum intValue]];
    } else {
        self.bestScoreLabel.text = [NSString stringWithFormat:@"新纪录: %d", [newnum intValue]];
        app.defaults.jiejiScore = newScore;
    }
}

- (IBAction)again {
    self.buttonClick(YES);
    [self dismissViewControllerAnimated:NO completion:^{
    }];
}

- (IBAction)back {
    [self dismissViewControllerAnimated:NO completion:^{
        self.buttonClick(NO);
    }];
}

@end
