//
//  ViewController.m
//  StrategoGame
//
//  Created on 2012-04-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize boardView;
@synthesize boardModel;
@synthesize movingPiece;
@synthesize startPos;
@synthesize movingImage;
@synthesize game;
@synthesize changeBlueState;
@synthesize changeRedState;
@synthesize changeBlueTurn;
@synthesize changeRedTurn;

Piece *startPiece;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [changeBlueTurnButton setAlpha:0.4];
    [changeBlueTurnButton setEnabled:NO];
    [changeRedTurnButton setAlpha:0.4];
    [changeRedTurnButton setEnabled:NO];
    [changeRedStateButton setAlpha:0.4];
    [changeRedStateButton setEnabled:NO];
    boardModel = [[BoardModel alloc] init];
    game = [[strategoGame alloc] init];
	boardView = [[[BoardView alloc] initWithFrame:CGRectMake(0, 0, -60, -400)] init];
    [boardView setup: boardModel];    
    [boardView setCenter:CGPointMake(70, 70)];
    
//creating red bombs    
    Piece *bomb = [self createBomb:Red];
    [boardModel replacePiece:bomb :0 :0];
    bomb = [self createBomb:Red];
    [boardModel replacePiece:bomb :0 :1];
    bomb = [self createBomb:Red];
    [boardModel replacePiece:bomb :0 :2];
    bomb = [self createBomb:Red];
    [boardModel replacePiece:bomb :3 :7];
    bomb = [self createBomb:Red];
    [boardModel replacePiece:bomb :3 :8];
    bomb = [self createBomb:Red];
    [boardModel replacePiece:bomb :3 :9];


//create red spy
    Piece *one = [self create1:Red];
    [boardModel replacePiece:one :0 :3];
    
    //creating Red 2
    Piece *two = [self create2:Red];
    [boardModel replacePiece:two :0 :4];
    two = [self create2:Red];
    [boardModel replacePiece:two :0 :5];
    two = [self create2:Red];
    [boardModel replacePiece:two :0 :6];
    two = [self create2:Red];
    [boardModel replacePiece:two :0 :7];
    two = [self create2:Red];
    [boardModel replacePiece:two :0 :8];
    two = [self create2:Red];
    [boardModel replacePiece:two :0 :9];
    two = [self create2:Red];
    [boardModel replacePiece:two :1 :0];
    two = [self create2:Red];
    [boardModel replacePiece:two :1 :1];
   
    
    //creating Red 3
    
    Piece *three = [self create3:Red];
    [boardModel replacePiece:three :1 :2];
    three = [self create3:Red];
    [boardModel replacePiece:three :1 :3];
    three = [self create3:Red];
    [boardModel replacePiece:three :1 :4];
    three = [self create3:Red];
    [boardModel replacePiece:three :1 :5];
    three = [self create3:Red];
    [boardModel replacePiece:three :1 :6];
    
    //creating Red 4
    
    Piece *four = [self create4:Red];
    [boardModel replacePiece:four :1 :7];
    four = [self create4:Red];
    [boardModel replacePiece:four :1 :8];
    four = [self create4:Red];
    [boardModel replacePiece:four :1 :9];
    four = [self create4:Red];
    [boardModel replacePiece:four :2 :0];
    
    
    //creating Red 5
    
    Piece *five = [self create5:Red];
    [boardModel replacePiece:five :2 :1];
    five = [self create5:Red];
    [boardModel replacePiece:five :2 :2];
    five = [self create5:Red];
    [boardModel replacePiece:five :2 :3];
    five = [self create5:Red];
    [boardModel replacePiece:five :2 :4];
    
    
    //creating Red 6
    Piece *six = [self create6:Red];
    [boardModel replacePiece:six :2 :5];
    six = [self create6:Red];
    [boardModel replacePiece:six :2 :6];
    six = [self create6:Red];
    [boardModel replacePiece:six :2 :7];
    six = [self create6:Red];
    [boardModel replacePiece:six :2 :8];
    
    //creating Red 7    
    Piece *seven = [self create7:Red];
    [boardModel replacePiece:seven :2 :9];
    seven = [self create7:Red];
    [boardModel replacePiece:seven :3 :0];
    seven = [self create7:Red];
    [boardModel replacePiece:seven :3 :1];    

//creating red 8    
    Piece *eight = [self create8:Red];
    [boardModel replacePiece:eight :3 :2];
    eight = [self create8:Red];
    [boardModel replacePiece:eight :3 :3];
    
//creating red 9    
    Piece *nine = [self create9:Red];
    [boardModel replacePiece:nine :3 :4];

//creating red 10
    Piece *ten = [self create10:Red];
    [boardModel replacePiece:ten :3 :5];
    
//creating red flag    
    Piece *flag = [self createFlag:Red];
    [boardModel replacePiece:flag :3 :6];

//creating blue bombs    
    bomb = [self createBomb:Blue];
    [boardModel replacePiece:bomb :6 :0];
    bomb = [self createBomb:Blue];
    [boardModel replacePiece:bomb :6 :1];
    bomb = [self createBomb:Blue];
    [boardModel replacePiece:bomb :6 :2];
    bomb = [self createBomb:Blue];
    [boardModel replacePiece:bomb :6 :3];
    bomb = [self createBomb:Blue];
    [boardModel replacePiece:bomb :6 :4];
    bomb = [self createBomb:Blue];
    [boardModel replacePiece:bomb :6 :5];

//create blue spy
    one = [self create1:Blue];
    [boardModel replacePiece:one :6 :6];
    
//creating blue 2
    two = [self create2:Blue];
    [boardModel replacePiece:two :6 :7];
    two = [self create2:Blue];
    [boardModel replacePiece:two :6 :8];
    two = [self create2:Blue];
    [boardModel replacePiece:two :6 :9];
    two = [self create2:Blue];
    [boardModel replacePiece:two :7 :0];
    two = [self create2:Blue];
    [boardModel replacePiece:two :7 :1];
    two = [self create2:Blue];
    [boardModel replacePiece:two :7 :2];
    two = [self create2:Blue];
    [boardModel replacePiece:two :7 :3];
    two = [self create2:Blue];
    [boardModel replacePiece:two :7 :4];

//creating blue 3

    three = [self create3:Blue];
    [boardModel replacePiece:three :7 :5];
    three = [self create3:Blue];
    [boardModel replacePiece:three :7 :6];
    three = [self create3:Blue];
    [boardModel replacePiece:three :7 :7];
    three = [self create3:Blue];
    [boardModel replacePiece:three :7 :8];
    three = [self create3:Blue];
    [boardModel replacePiece:three :7 :9];
    
//creating blue 4
    
    four = [self create4:Blue];
    [boardModel replacePiece:four :8 :0];
    four = [self create4:Blue];
    [boardModel replacePiece:four :8 :1];
    four = [self create4:Blue];
    [boardModel replacePiece:four :8 :2];
    four = [self create4:Blue];
    [boardModel replacePiece:four :8 :3];

    
//creating blue 5
    
    five = [self create5:Blue];
    [boardModel replacePiece:five :8 :4];
    five = [self create5:Blue];
    [boardModel replacePiece:five :8 :5];
    five = [self create5:Blue];
    [boardModel replacePiece:five :8 :6];
    five = [self create5:Blue];
    [boardModel replacePiece:five :8 :7];

    
//creating blue 6
    six = [self create6:Blue];
    [boardModel replacePiece:six :8 :8];
    six = [self create6:Blue];
    [boardModel replacePiece:six :8 :9];
    six = [self create6:Blue];
    [boardModel replacePiece:six :9 :0];
    six = [self create6:Blue];
    [boardModel replacePiece:six :9 :1];

//creating blue 7    
    seven = [self create7:Blue];
    [boardModel replacePiece:seven :9 :2];
    seven = [self create7:Blue];
    [boardModel replacePiece:seven :9 :3];
    seven = [self create7:Blue];
    [boardModel replacePiece:seven :9 :4];    
    
//creating blue 8    
    eight = [self create8:Blue];
    [boardModel replacePiece:eight :9 :5];
    eight = [self create8:Blue];
    [boardModel replacePiece:eight :9 :6];
 
//creating blue 9
    nine = [self create9:Blue];
    [boardModel replacePiece:nine :9 :7];    

//creating blue 10
    ten = [self create10:Blue];
    [boardModel replacePiece:ten :9:8];
    
//creating blue flag
    flag = [self createFlag:Blue];
    [boardModel replacePiece:flag :9 :9];  
    
//render the board    
    Piece *emptyPiece = [[Piece alloc] initWithPiece:@"em"];
    [emptyPiece setPlayer:NO_PLAYER];
    for (int r = 0; r < 10; r++) {
        for (int c = 0; c < 10; c++) {
            Piece * piece = [boardModel getPiece:r :c];
            if([piece type] == @"em" )
            {
                [piece setPlayer:NO_PLAYER];
            }
        }
    }
    [game setBoardModel:boardModel];
    [boardView show:boardModel :game];
	[self.view addSubview:boardView];
	// Do any additional setup after loading the view, typically from a nib.
      
}

- (Piece *) createBomb:(Player) player
{
    NSString *path;
    NSString *type;
    Piece *p = [Piece alloc];
    if(player == Red)
    {
        [p setPlayer: Red];
        path = [NSString stringWithFormat:@"redbomb.png"];
        type = @"redbomb";
        
    }
    else 
    {
        [p setPlayer: Blue];
        path = [NSString stringWithFormat:@"bluebomb.png"];
        type = @"bluebomb";
    }
    
    
    [p setImage: [UIImage imageNamed:path]];
    [p setMove: [[NSNumber alloc] initWithInt:0]];
    [p setType: type];
    [p setPieceValue:11];
    return p;

}



- (Piece *) createFlag:(Player) player
{
    NSString *path;
    NSString *type;
    Piece *p = [Piece alloc];
    if(player == Red)
    {
        [p setPlayer: Red];
        path = [NSString stringWithFormat:@"redflag.png"];
        type = @"redflag";
    
    }
    else 
    {
        [p setPlayer: Blue];
        path = [NSString stringWithFormat:@"blueflag.png"];
        type = @"blueflag";
    }
    
    [p setImage: [UIImage imageNamed:path]];
    [p setMove: [[NSNumber alloc] initWithInt:0]];
    [p setType: type];
    [p setPieceValue:0];
    return p;
}

- (Piece *) create10:(Player) player
{
    NSString *path;
    NSString *type;
    Piece *p = [Piece alloc];
    if(player == Red)
    {
        [p setPlayer: Red];
        path = [NSString stringWithFormat:@"red10.png"];
        type = @"red10";
        
    }
    else 
    {
        [p setPlayer: Blue];
        path = [NSString stringWithFormat:@"blue10.png"];
        type = @"blue10";
    }
    
    [p setImage: [UIImage imageNamed:path]];
    [p setMove: [[NSNumber alloc] initWithInt:1]];
    [p setType: type];
    [p setPieceValue:10];
    return p;
}


- (Piece *) create9:(Player) player
{
    NSString *path;
    NSString *type;
    Piece *p = [Piece alloc];
    if(player == Red)
    {
        [p setPlayer: Red];
        path = [NSString stringWithFormat:@"red9.png"];
        type = @"red9";
        
    }
    else 
    {
        [p setPlayer: Blue];
        path = [NSString stringWithFormat:@"blue9.png"];
        type = @"blue9";
    }
    
    [p setImage: [UIImage imageNamed:path]];
    [p setMove: [[NSNumber alloc] initWithInt:1]];
    [p setType: type];
    [p setPieceValue:9];
    return p;
}

- (Piece *) create8:(Player) player
{
    NSString *path;
    NSString *type;
    Piece *p = [Piece alloc];
    if(player == Red)
    {
        [p setPlayer: Red];
        path = [NSString stringWithFormat:@"red8.png"];
        type = @"red8";
        
    }
    else 
    {
        [p setPlayer: Blue];
        path = [NSString stringWithFormat:@"blue8.png"];
        type = @"blue8";
    }
    
    [p setImage: [UIImage imageNamed:path]];
    [p setMove: [[NSNumber alloc] initWithInt:1]];
    [p setType: type];
    [p setPieceValue:8];
    return p;
}

- (Piece *) create7:(Player) player
{
    NSString *path;
    NSString *type;
    Piece *p = [Piece alloc];
    if(player == Red)
    {
        [p setPlayer: Red];
        path = [NSString stringWithFormat:@"red7.png"];
        type = @"red7";
        
    }
    else 
    {
        [p setPlayer: Blue];
        path = [NSString stringWithFormat:@"blue7.png"];
        type = @"blue7";
    }
    
    [p setImage: [UIImage imageNamed:path]];
    [p setMove: [[NSNumber alloc] initWithInt:1]];
    [p setType: type];
    [p setPieceValue:7];
    return p;
}

- (Piece *) create6:(Player) player
{
    NSString *path;
    NSString *type;
    Piece *p = [Piece alloc];
    if(player == Red)
    {
        [p setPlayer: Red];
        path = [NSString stringWithFormat:@"red6.png"];
        type = @"red6";
        
    }
    else 
    {
        [p setPlayer: Blue];
        path = [NSString stringWithFormat:@"blue6.png"];
        type = @"blue6";
    }
    
    [p setImage: [UIImage imageNamed:path]];
    [p setMove: [[NSNumber alloc] initWithInt:1]];
    [p setType: type];
    [p setPieceValue:6];
    return p;
}

- (Piece *) create5:(Player) player
{
    NSString *path;
    NSString *type;
    Piece *p = [Piece alloc];
    if(player == Red)
    {
        [p setPlayer: Red];
        path = [NSString stringWithFormat:@"red5.png"];
        type = @"red5";
        
    }
    else 
    {
        [p setPlayer: Blue];
        path = [NSString stringWithFormat:@"blue5.png"];
        type = @"blue5";
    }
    
    [p setImage: [UIImage imageNamed:path]];
    [p setMove: [[NSNumber alloc] initWithInt:1]];
    [p setType: type];
    [p setPieceValue:5];
    return p;
}

- (Piece *) create4:(Player) player
{
    NSString *path;
    NSString *type;
    Piece *p = [Piece alloc];
    if(player == Red)
    {
        [p setPlayer: Red];
        path = [NSString stringWithFormat:@"red4.png"];
        type = @"red4";
        
    }
    else 
    {
        [p setPlayer: Blue];
        path = [NSString stringWithFormat:@"blue4.png"];
        type = @"blue4";
    }
    
    [p setImage: [UIImage imageNamed:path]];
    [p setMove: [[NSNumber alloc] initWithInt:1]];
    [p setType: type];
    [p setPieceValue:4];
    return p;
}


- (Piece *) create3:(Player) player
{
    NSString *path;
    NSString *type;
    Piece *p = [Piece alloc];
    if(player == Red)
    {
        [p setPlayer: Red];
        path = [NSString stringWithFormat:@"red3.png"];
        type = @"red3";
        
    }
    else 
    {
        [p setPlayer: Blue];
        path = [NSString stringWithFormat:@"blue3.png"];
        type = @"blue3";
    }
    
    [p setImage: [UIImage imageNamed:path]];
    [p setMove: [[NSNumber alloc] initWithInt:1]];
    [p setType: type];
    [p setPieceValue:3];
    return p;
}

- (Piece *) create2:(Player) player
{
    NSString *path;
    NSString *type;
    Piece *p = [Piece alloc];
    if(player == Red)
    {
        [p setPlayer: Red];
        path = [NSString stringWithFormat:@"red2.png"];
        type = @"red2";
        
    }
    else 
    {
        [p setPlayer: Blue];
        path = [NSString stringWithFormat:@"blue2.png"];
        type = @"blue2";
    }
    
    [p setImage: [UIImage imageNamed:path]];
    [p setMove: [[NSNumber alloc] initWithInt:10]];
    [p setType: type];
    [p setPieceValue:2];
    return p;
}

- (Piece *) create1:(Player) player
{
    NSString *path;
    NSString *type;
    Piece *p = [Piece alloc];
    if(player == Red)
    {
        [p setPlayer: Red];
        path = [NSString stringWithFormat:@"red1.png"];
        type = @"red1";
        
    }
    else 
    {
        [p setPlayer: Blue];
        path = [NSString stringWithFormat:@"blue1.png"];
        type = @"blue1";
    }
    
    [p setImage: [UIImage imageNamed:path]];
    [p setMove: [[NSNumber alloc] initWithInt:1]];
    [p setType: type];
    [p setPieceValue:1];
    return p;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
	if([[event allTouches] count] == 1)
	{
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        CGPoint newPoint = [boardView pixelToCoordinate:point];
        startPiece = [boardModel checkForPiece:newPoint];
        NSLog(@"Start Piece: %@", [startPiece type]);
        NSLog(@"Coord: %f,%f", newPoint.x, newPoint.y);
        if(startPiece == NULL) {
            NSLog(@"Coordinates: %@", newPoint);
        }
        
        if(([game player_turn] == [startPiece player]) || ([game setupPhase] && [game player_turn] == [startPiece player]))
        {
            if(([game player_turn] == Red && [game moveCount]%2 == 1) ||([game player_turn] == Blue && [game moveCount]%2 == 0) || [game setupPhase])
            {
                if(![[startPiece type] isEqual: @"em"])
                {
                    startPos = newPoint;
                    movingImage = [startPiece imageView];
                    [boardView drawSquare:point of:movingImage];
                }
            }
        }
    }
 }


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event  {
	if([[event allTouches] count] == 1 && startPiece != NULL)
    {   
        /*  
        UITouch *touch = [touches anyObject];
            CGPoint point = [touch locationInView:self.view];
            [boardView drawSquare:point of:movingImage];
        */
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event  
{
	
    if([[event allTouches] count] == 1 && startPiece != NULL && [startPiece type] != @"em")
	{
        if((([game player_turn] == [startPiece player]) || ([game setupPhase] && [game player_turn] == [startPiece player])) && (([game player_turn] == Red && [game moveCount]%2 == 1) ||([game player_turn] == Blue && [game moveCount]%2 == 0) || [game setupPhase]))
        {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        CGPoint endPoint = [boardView pixelToCoordinate:point];
        
        Piece *endPiece = [boardModel checkForPiece:endPoint];
        if(startPiece == NULL || endPiece == NULL) 
        {
            NSLog(@"Coord: %f,%f", endPoint.x, endPoint.y);
        }
        NSLog(@"End Piece: %@", [endPiece type]);
        NSLog(@"Coord: %f,%f", endPoint.x, endPoint.y);
            NSString *moveDescription = @"";
            if([[endPiece type] isEqual: @"em"])
            {
                [endPiece setPlayer: NO_PLAYER];
            }
            if(([game validMove:startPiece :startPos :endPoint] && (![game setupPhase])) || ([game setupPhase] && [game validSetUpMove:startPiece :startPos :endPoint]))
            {
                if([[endPiece type] isEqual: @"em"])
                {
                    [boardModel takePiece:startPiece :endPoint: startPos];
                    [boardView setSquare:endPoint of:[startPiece imageView]];
                    startPiece = NULL;
                    [self endMove];
                } else 
                {
                    //do battle 
                    //for now go back to orig position
                    //if gamesetup run this
                    
                    //-(void)takePiece:(Piece *)piece: (CGPoint)newLocation: (CGPoint) origLocation
                    if([game setupPhase])
                    {
                        
                        //[boardModel setPiece:startPiece :endPoint.x :endPoint.y];
                        //[boardModel setPiece:endPiece :startPos.x :startPos.y];
                        [boardModel switchPiece:startPiece :endPoint :endPiece :startPos];
                        startPiece = NULL;
                         [self endSetup];
                    }
                    else
                    {
                        int actionCase = [game action:startPiece :endPiece];
                        if(actionCase == 1)// attacker wins
                        {
                            [boardModel takePiece:startPiece :endPoint :startPos];
                            moveDescription = [moveDescription stringByAppendingString:[startPiece type]];
                            moveDescription = [moveDescription stringByAppendingString:@" has defeated "];
                            moveDescription = [moveDescription stringByAppendingString:[endPiece type]];
                            [console setText:moveDescription];
                            [self endMove];
                            
                        }
                        else if(actionCase == 2)// defender wins
                        {
                            [boardModel takePiece:endPiece :endPoint :startPos];
                            moveDescription = [moveDescription stringByAppendingString:[startPiece type]];
                            moveDescription = [moveDescription stringByAppendingString:@" lost attacking "];
                            moveDescription = [moveDescription stringByAppendingString:[endPiece type]];
                            [console setText:moveDescription];
                            [self endMove];
                            
                        }
                        else if (actionCase == 0)// both lose
                        {
                            startPiece = [[Piece alloc] initWithPiece:@"em"];
                            [boardModel takePiece:startPiece :endPoint :startPos];
                            moveDescription = [moveDescription stringByAppendingString:[startPiece type]];
                            moveDescription = [moveDescription stringByAppendingString:@" and "];
                            moveDescription = [moveDescription stringByAppendingString:[endPiece type]];
                            moveDescription = [moveDescription stringByAppendingString:@" defeated "];
                            [console setText:moveDescription];
                            [self endMove];
                        }
                        else // negative returned. that's bad.
                        {
                            [self endGame];
                            
                        }
                    }
                }
            }
        }
    }
}

-(void) endMove
{
    [game setBoardModel:boardModel];
    [boardView show:boardModel :game];
    int newMoveCount = [game moveCount] +1;
    NSString *moveString = [NSString stringWithFormat:@"%d", newMoveCount];
    [moveNumber setText:moveString];
    [game setMoveCount: newMoveCount];
     /*   if([game moveCount] % 2 == 0)
        {
            newPlayerTurn = Blue;
            self.view.backgroundColor = [UIColor blueColor];
        }
        else
        {
            newPlayerTurn = Red;
            self.view.backgroundColor = [UIColor redColor];
        }
        [game setPlayer_turn:newPlayerTurn];
    */
}

-(void) endSetup
{
    [game setBoardModel:boardModel];
    [boardView show:boardModel :game];
}

-(void) endGame
{
    NSString *moveDescription;
    if([game player_turn] == Blue)
        moveDescription = @"Blue has won!";
    if ([game player_turn] == Red) {
        moveDescription = @"Red has won!";
    }
    [console setText:moveDescription];
    if([game player_turn] == Blue)
       self.view.backgroundColor = [UIColor blueColor];
    if ([game player_turn] == Red) {
       self.view.backgroundColor = [UIColor redColor];
    }
    [changeBlueTurnButton setAlpha:0.4];
    [changeBlueTurnButton setEnabled:NO];
    [changeBlueStateButton setAlpha:0.4];
    [changeBlueStateButton setEnabled:NO];
    [changeRedTurnButton setAlpha:0.4];
    [changeRedTurnButton setEnabled:NO];
    [changeRedStateButton setAlpha:0.4];
    [changeRedStateButton setEnabled:NO];

}


-(IBAction)changeBlueState:(id)sender {
    if([game setupPhase]) {
        //Start Game Blue
        [game setPlayer_turn:Red];
        [changeBlueStateButton setAlpha:0.4];
        [changeBlueStateButton setEnabled: NO];
        [changeRedStateButton setAlpha:1.0];
        [changeRedStateButton setEnabled:YES];
        self.view.backgroundColor = [UIColor redColor];
        [boardView  show:boardModel :game];

    } else {
        [game setPlayer_turn:Red];
        [self endGame];
    }
}

//handles setting up game and changing from setup to a play state
-(IBAction)changeRedState:(id)sender {

    if([game setupPhase]) {
        //Start Game Red
        [game setPlayer_turn:Red];
        [changeRedStateButton setAlpha:0.4];
        [changeBlueStateButton setEnabled: NO];
        [game setSetupPhase:FALSE];
        [changeBlueTurnButton setEnabled:YES];
        [changeBlueStateButton setAlpha:1.0];
        [changeRedTurnButton setEnabled:YES];
        [changeRedStateButton setAlpha:1.0];
        [changeBlueStateButton setTitle:@"Resign Game" forState:UIControlStateNormal];
        [changeRedStateButton setTitle:@"Resign Game" forState:UIControlStateNormal];
        [game setPlayer_turn:NO_PLAYER];
        [changeBlueTurnButton setAlpha:1.0];
        [changeBlueTurnButton setEnabled:YES];
        [changeRedTurnButton setAlpha:0.4];
        [changeRedTurnButton setEnabled:NO];
        [changeRedStateButton setAlpha:0.4];
        [changeRedStateButton setEnabled:NO];
        self.view.backgroundColor = [UIColor grayColor];
        [console setText:@"Game Start"];
        [boardView  show:boardModel :game];

    } else {
        [game setPlayer_turn:Blue];
        [self endGame];
    }
}

-(IBAction)changeBlueTurn:(id)sender {
    Player newPlayerTurn = NO_PLAYER;
    if([game setupPhase]) {
        [changeBlueTurnButton setEnabled:NO];
    }
    if([game moveCount] % 2 == 0)//beginning of blue turn
    {
        newPlayerTurn = Blue;
        self.view.backgroundColor = [UIColor blueColor];
        [changeBlueTurnButton setAlpha:1.0];
        [changeBlueTurnButton setEnabled:YES];
        [changeBlueStateButton setAlpha:1.0];
        [changeBlueStateButton setEnabled:YES];
        [changeRedTurnButton setAlpha:0.4];
        [changeRedTurnButton setEnabled:NO];
        [changeRedStateButton setAlpha:0.4];
        [changeRedStateButton setEnabled:NO];
        [changeBlueTurnButton setTitle:@" Set Move" forState:UIControlStateNormal];
    }
    else// end of blue turn
    {
        newPlayerTurn = NO_PLAYER;
        self.view.backgroundColor = [UIColor grayColor];
        [changeRedTurnButton setAlpha:1.0];
        [changeRedTurnButton setEnabled:YES];
        [changeRedStateButton setAlpha:0.4];
        [changeRedStateButton setEnabled:NO];
        [changeBlueTurnButton setAlpha:0.4];
        [changeBlueTurnButton setEnabled:NO];
        [changeBlueStateButton setAlpha:0.4];
        [changeBlueStateButton setEnabled:NO];
         [changeRedTurnButton setTitle:@" Show Pieces" forState:UIControlStateNormal];

    }
    [game setPlayer_turn:newPlayerTurn];
    [boardView show:boardModel :game];
}

-(IBAction)changeRedTurn:(id)sender {
    Player newPlayerTurn = NO_PLAYER;
    if([game setupPhase]) {
        [changeRedTurnButton setEnabled:NO];
    }
    if([game moveCount] % 2 == 1)// beginning of red turn
    {
        newPlayerTurn = Red;
        self.view.backgroundColor = [UIColor redColor];
        [changeRedTurnButton setAlpha:1.0];
        [changeRedTurnButton setEnabled:YES];
        [changeRedStateButton setAlpha:1.0];
        [changeRedStateButton setEnabled:YES];
        [changeBlueStateButton setAlpha:0.4];
        [changeBlueStateButton setEnabled:NO];
        [changeBlueTurnButton setAlpha:0.4];
        [changeBlueTurnButton setEnabled:NO];
        [changeRedTurnButton setTitle:@" Set Move" forState:UIControlStateNormal];
    }
    else// end of red turn
    {
        newPlayerTurn = NO_PLAYER;
        self.view.backgroundColor = [UIColor grayColor];
        [changeBlueTurnButton setAlpha:1.0];
        [changeBlueTurnButton setEnabled:YES];
        [changeRedTurnButton setAlpha:0.4];
        [changeRedTurnButton setEnabled:NO];
        [changeRedStateButton setAlpha:0.4];
        [changeRedStateButton setEnabled:NO];
        [changeBlueTurnButton setTitle:@" Show Pieces" forState:UIControlStateNormal];
    }
    [game setPlayer_turn:newPlayerTurn];
    [boardView show:boardModel :game];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
