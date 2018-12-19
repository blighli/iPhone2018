//
//  PEViewController.m
//  PE-2048
//
//  Created by Peng&Ethan on 13/12/2018.
//  Copyright © 2018 Peng&Ethan. All rights reserved.
//

#import "PEViewController.h"
#import "PEGameViewController.h"
@interface PEViewController ()

@end

@implementation PEViewController

- (IBAction)playGameButtonTapped6:(id)sender {
    PEGameViewController *c = [PEGameViewController numberBlockGameWithDimension:6
                                                                                         winThreshold:8192
                                                                                      backgroundColor:[UIColor whiteColor]
                                                                                          scoreModule:NO];
    [self presentViewController:c animated:YES completion:nil];
}

- (IBAction)playGameButtonTapped5:(id)sender {
    PEGameViewController *c = [PEGameViewController numberBlockGameWithDimension:5
                                                                     winThreshold:4096
                                                                  backgroundColor:[UIColor whiteColor]
                                                                      scoreModule:NO];
    [self presentViewController:c animated:YES completion:nil];
}

- (IBAction)playGameButtonTapped4:(id)sender {
    PEGameViewController *c = [PEGameViewController numberBlockGameWithDimension:4
                                                                     winThreshold:2048
                                                                  backgroundColor:[UIColor whiteColor]
                                                                      scoreModule:NO];
    [self presentViewController:c animated:YES completion:nil];
}
@end
