//
//  GameOverScene..m
//  NinjaBreakout
//
//  Created by lvliang on 2018/12/12.
//  Copyright © 2018 lvliang. All rights reserved.
//

#import "GameOverScene.h"
#import "GameScene.h"
#import "StartScene.h"

@implementation GameOverScene

-(id)initWithSize:(CGSize)size won:(BOOL)won {
    if (self = [super initWithSize:size]) {
        
        // 1
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        // 2
        NSString * message;
        if (won) {
            message = @"You Won!";
        } else {
            message = @"You Lose :[";
        }
        
        // 3
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label.text = message;
        label.fontSize = 40;
        label.fontColor = [SKColor blackColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:label];
        
        // 4
        [self runAction:
         [SKAction sequence:@[
                              [SKAction waitForDuration:3.0],
                              [SKAction runBlock:^{
             // 5
             SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
             SKScene * startScene = [[StartScene alloc] initWithSize:self.size];
             [self.view presentScene:startScene transition: reveal];
         }]
                              ]]
         ];
        
    }
    return self;
}

@end

