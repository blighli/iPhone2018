//
//  ViewController.m
//  My2048
//
//  Created by yang on 2018/11/17.
//  Copyright © 2018 yang. All rights reserved.
//

#import "ViewController.h"

#import "Square.h"
#import "KTStopwatch.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize textLabel, resetLabel, scoreLabel;
@synthesize Label1,Label2,Label3,Label4,Label5,Label6,Label7,Label8,Label9,Label10,Label11,Label12,Label13,Label14,Label15,Label16;
@synthesize timerLabel;

NSMutableArray *array;
NSMutableArray *viewArr;
int score;


- (void)updateView {
    int x = 0;
    for(int i = 0; i<4; i++){
        for (int j = 0; j < 4; j++){
            if( [array[i][j] getValue] != -1) [viewArr[x] setText:[NSString stringWithFormat:@"%d" ,[array[i][j] getValue] ] ];
            else [viewArr[x] setText:@""];
            x++;
        }
    }
    scoreLabel.text = [NSString stringWithFormat:@"Score: %d", score];
    printf("Score: %d\n", score);
}
- (void)onTimer
{
    
    [timerLabel setText:[stopwatch elapsedTime]];
    
}

- (IBAction)stopTimer
{
    [stopwatch stop];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    viewArr = [[NSMutableArray alloc] initWithObjects: Label1,Label2,Label3,Label4,Label5,Label6,Label7,Label8,Label9,Label10,Label11,Label12,Label13,Label14,Label15,Label16, nil ];
    [self newGame];
    [timerLabel setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:52.0]];
    
    
    
    stopwatch = [[KTStopwatch alloc] init];
    // Use a timer to update the display once a second.
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    [stopwatch start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetGame:(id)sender{
    [stopwatch reset];
    [stopwatch start];
    [self newGame];
}


-(void)checkIfGameOver {
    bool retVal = YES;
    for(int y = 3; y >= 0; y--){
        for (int x = 3; x >= 0; x--){
            int curVal = [array[y][x] getValue];
            if (curVal == -1) { retVal = NO; break;} // there exists an empty space.
            else{
                //check left
                if(x>0){ if([array[y][x-1] getValue] == curVal) { retVal = NO; break;} }
                //check right
                if(x<3){ if([array[y][x+1] getValue] == curVal) { retVal = NO; break;} }
                //check up
                if(y>0){ if([array[y-1][x] getValue] == curVal) { retVal = NO; break;} }
                //check down
                if(y<3){ if([array[y+1][x] getValue] == curVal) { retVal = NO; break;} }
                
            }
        }
    }
    if(retVal==YES){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"You Lose"
                                                                       message:[NSString stringWithFormat:@"Score: %d", score]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        UIAlertAction* resetAction = [UIAlertAction actionWithTitle:@"Reset"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {[self newGame];}];
        [alert addAction:defaultAction];
        [alert addAction:resetAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)newGame{
    array = [self get4x4Array];
    for(int i = 0; i<2; i++){ // init arr with 2 sq
        [self addNewSquare];
    }
//    [self printArray];
    [self updateView];
    score = 0;
}

-(NSMutableArray*)get4x4Array {
    NSMutableArray* arr = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        NSMutableArray* subarr = [NSMutableArray array];
        for (int j = 0; j < 4; j++)
            [subarr addObject:[[Square alloc] init]];
        [arr addObject:subarr];
    }
    return arr;
}

-(void)printArray {
    for(int i = 0; i<4; i++){
        for (int j = 0; j < 4; j++){
            int x = [array[i][j] getValue];
            if (x == -1) printf("*\t");
            else printf("%i\t", x );
        }
        printf("\n");
    }
    printf("\n");
}

-(void)addNewSquare{
    NSMutableArray * selectArray = [[NSMutableArray alloc] initWithObjects:@0,@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,nil];
    NSMutableSet *randomSet = [[NSMutableSet alloc] init];
    
    while ([randomSet count] < 16) {
        int r = arc4random() % [selectArray count];
        [randomSet addObject:[selectArray objectAtIndex:r]];
        [selectArray removeObjectAtIndex:r];
    }
    
    NSArray *randomArray = [randomSet allObjects];
    int t_begin = [[randomArray objectAtIndex: 1] intValue];
    int x = t_begin % 4;
    int y = t_begin / 4;
    int count = 1;//temorary check to make sure all sq are not full
    while(count<16 && [array[x][y] getValue] != -1){
        int temp = [[randomArray objectAtIndex: count] intValue];
        x = temp % 4;
        y = temp / 4;
        count++;
    }
    if(count <16) [array[x][y] initValue];
    else {
        printf("Game Over/Unable to find free space \n");
    }
}


- (IBAction)swipeDetectedLeft:(id)sender {
    bool moved = NO;
    for(int y = 0; y < 4; y++){
        for (int x = 0; x < 4; x++){
            if([array[y][x] getValue] != -1){
                int storedVal = [array[y][x] getValue];
                int tmpx = x;
                if( x-1 >= 0 ){
                    while(tmpx > 0 && [array[y][tmpx-1] getValue] == -1){//move down y axis until end/non empty block
                        --tmpx;
                        
                    }
                    if(tmpx > 0 && [array[y][tmpx-1] getValue] == storedVal){//check if next block is the same as current.
                        storedVal *= 2;
                        score += storedVal;
                        --tmpx;
                        [array[y][tmpx] setVal:-1];
                    }
                    [array[y][tmpx] setVal:storedVal];
                }
                if( tmpx != x ){
                    [array[y][x] setVal:-1];
                    moved = YES;
                }
            }
        }
    }
    textLabel.text = @"Left";
    if(moved==YES)[self addNewSquare];
    [self printArray];
    [self updateView];
    [self checkIfGameOver];
    [scoreLabel setNeedsLayout];
}

- (IBAction)swipeDetectedUp:(id)sender {
    bool moved = NO;
    for(int y = 0; y < 4; y++){
        for (int x = 0; x < 4; x++){
            if([array[y][x] getValue] != -1){
                int storedVal = [array[y][x] getValue];
                int tmpy = y;
                if( y-1 >= 0 ){
                    while(tmpy > 0 && [array[tmpy-1][x] getValue] == -1){//move down y axis until end/non empty block
                        --tmpy;
                        
                    }
                    if(tmpy > 0 && [array[tmpy-1][x] getValue] == storedVal){//check if next block is the same as current.
                        storedVal *= 2;
                        score += storedVal;
                        --tmpy;
                        [array[tmpy][x] setVal:-1];
                    }
                    [array[tmpy][x] setVal:storedVal];
                }
                if( tmpy != y ){
                    [array[y][x] setVal:-1];
                    moved = YES;
                }
            }
        }
    }
    textLabel.text = @"Up";
    if(moved==YES)[self addNewSquare];
    [self printArray];
    [self updateView];
    [self checkIfGameOver];
    [[self view] setNeedsLayout];
}


- (IBAction)swipeDetectedRight:(id)sender { //TODO
    bool moved = NO;
    for(int y = 3; y >= 0; y--){
        for (int x = 3; x >= 0; x--){
            if([array[y][x] getValue] != -1){
                int storedVal = [array[y][x] getValue];
                int tmpx = x;
                if( x+1 <= 3 ){
                    while(tmpx < 3 && [array[y][tmpx+1] getValue] == -1){//move down y axis until end/non empty block
                        ++tmpx;
                        
                    }
                    if(tmpx < 3 && [array[y][tmpx+1] getValue] == storedVal){//check if next block is the same as current.
                        storedVal *= 2;
                        score += storedVal;
                        ++tmpx;
                        [array[y][tmpx] setVal:-1];
                    }
                    [array[y][tmpx] setVal:storedVal];
                }
                if( tmpx != x ){
                    [array[y][x] setVal:-1];
                    moved = YES;
                }
            }
        }
    }
    textLabel.text = @"Right";
    if(moved==YES)[self addNewSquare];
    [self printArray];
    [self updateView];
    [self checkIfGameOver];
    [[self view] setNeedsLayout];
}

- (IBAction)swipeDetectedDown:(id)sender {
    bool moved = NO;
    for(int y = 3; y >= 0; y--){
        for (int x = 3; x >= 0; x--){
            if([array[y][x] getValue] != -1){
                int storedVal = [array[y][x] getValue];
                int tmpy = y;
                if( y+1 <= 3 ){
                    while(tmpy < 3 && [array[tmpy+1][x] getValue] == -1){//move down y axis until end/non empty block
                        ++tmpy;
                    }
                    if(tmpy < 3 && [array[tmpy+1][x] getValue] == storedVal){//check if next block is the same as current.
                        storedVal *= 2;
                        score += storedVal;
                        ++tmpy;
                        [array[tmpy][x] setVal:-1];
                    }
                    [array[tmpy][x] setVal:storedVal];
                }
                if( tmpy != y ){
                    [array[y][x] setVal:-1];
                    moved =YES;
                }else{}
            }
        }
    }
    textLabel.text = @"Down";
    if(moved==YES)[self addNewSquare];
    [self printArray];
    [self updateView];
    [self checkIfGameOver];
    [[self view] setNeedsLayout];
}


@end
