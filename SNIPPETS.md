# Snippets from the 2012 iPad game

Six excerpts, copied verbatim from `original/StrategoGame/`. The line numbers are the lines in those files. The code is as it was written, including spelling, spacing, and the leading space in the button titles.

## Combat resolution

`original/StrategoGame/strategoGame.m`, lines 208–241.

This is the whole fight table. A miner (piece value 3) attacking a bomb (value 11) wins, which has to be tested before the plain numeric comparison or the bomb would win. A spy (value 1) attacking the marshall (value 10) wins, and the marshall attacking the spy loses. The comment spells it "marshall." Any other strictly higher value wins. The flag is stored as value 0, so a higher attacker also enters that branch; if the defender's type pointer is the literal `@"redflag"` or `@"blueflag"`, the method returns -1 and the controller ends the game instead of capturing normally. Equal values return 0, a tie. The last `return -1` cannot be reached.

```objc
//returns an int 0 -2 0 = tie; 1 = attacker; 2 = defender; -1 if it messes up
-(int) action:(Piece *) attacker: (Piece *) defender
{
    
    if([attacker pieceValue] == 3 && [defender pieceValue] == 11)//bomb and miner condition
    {
     // attacker wins       
        return 1;
    }
    else if (([attacker pieceValue] == 1 && [defender pieceValue] == 10))// spy and marshall cond
    {
        return 1;
    }
    else if([attacker pieceValue] == 10 && [defender pieceValue] == 1) // marshall and spy cond
    {
        return 2;   
    }
    else if([attacker pieceValue] > [defender pieceValue]) // attacker wins cond
    {
        if ( [defender type] == @"redflag" || [defender type] == @"blueflag") {
            return -1; 
        }
        return 1;   
    }
    else if ([attacker pieceValue] < [defender pieceValue]) // defender wins cond
    {
        return 2;
    }
    else//tie condition
    {
        return 0;
    }
    return -1;
}
```

## Move validation

`original/StrategoGame/strategoGame.m`, lines 30–93.

A piece may move from 1 up to its `move` allowance, in a straight horizontal or vertical line. The rank-2 piece is the only one constructed with an allowance of 10. Every other mobile rank gets 1, and bombs and flags get 0, so this loop never runs for them. The destination has to fail `checkForOwnPiece:` (that method returns NO when both squares hold the same player, and the local that stores the opposite is still named `ownPiece`). `checkPieceInMovePath:` has to find only empty squares strictly between the two points. The square you land on may be occupied, which is what starts a fight. Diagonals never match one of the four tests.

```objc
-(BOOL) validMove:(Piece *) piece: (CGPoint) start: (CGPoint) end
{
    BOOL validSquare = FALSE;
    BOOL valid = FALSE;
    BOOL pieceInPath = FALSE;
    BOOL ownPiece = FALSE;
    NSString *axis;
    NSString *direction;
    NSInteger allowedMove = [[piece move] intValue];
    for(int moveNum = 1; moveNum <= allowedMove; moveNum++)
    {
        if(start.x+moveNum == end.x && start.y == end.y)
        {
            validSquare = TRUE;
            direction = @"Right";
            axis = @"x";
            pieceInPath = ![self checkPieceInMovePath :start :end :axis :direction];
            ownPiece = [self checkForOwnPiece:start :end];
            if (validSquare && ownPiece && pieceInPath)
            {
                valid = TRUE;
            }
            
        }
        if(start.x-moveNum == end.x && start.y == end.y)
        {
            validSquare = TRUE;
            direction = @"Left";
            axis = @"x";
            pieceInPath = ![self checkPieceInMovePath :start :end :axis :direction];
            ownPiece = [self checkForOwnPiece:start :end];
            if (validSquare && ownPiece && pieceInPath)
            {
                valid = TRUE;
            }
        }    
        if(start.x == end.x && start.y+moveNum == end.y)
        {
            validSquare = TRUE;
            direction = @"Down";
            axis = @"y";
            pieceInPath = ![self checkPieceInMovePath :start :end :axis :direction];
            ownPiece = [self checkForOwnPiece:start :end];
            if (validSquare && ownPiece && pieceInPath)
            {
                valid = TRUE;
            }
        }
        if(start.x == end.x && start.y-moveNum == end.y)
        {
            validSquare = TRUE;
            direction = @"Up";
            axis = @"y";
            pieceInPath = ![self checkPieceInMovePath :start :end :axis :direction];
            ownPiece = [self checkForOwnPiece:start :end];
            if (validSquare && ownPiece && pieceInPath)
            {
                valid = TRUE;
            }
        }
        
    }
    return valid;
}
```

## Board setup

`original/StrategoGame/ViewController.m`, lines 49–84.

`viewDidLoad` does not deal an army. It builds each piece with `createBomb:`, `create1:`, `create2:`, and so on, and writes it with `replacePiece:row:column:`. This is the start of red's side: six bombs are not all in one row, the spy is `create1:`, and the eight rank-2 pieces begin here. The same unrolled list continues through red's flag and all 40 blue pieces, down to line 267. Red is rows 0–3, the top of the board. Blue is rows 6–9. Rows 4 and 5 are left as the empty pieces the board was created with.

```objc
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
```

## Where setup will let a piece land

`original/StrategoGame/strategoGame.m`, lines 188–206.

During setup the only question is the destination row. Red may use rows 0–3 and blue may use rows 6–9, at any distance, so two of your own pieces can swap. The assignment that rejects rows 4 and 5 is overwritten a few lines later if the row is also one of yours, and those middle rows are not yours, so they stay illegal. Nothing in `validMove:` later treats the middle as water. Once play starts, pieces walk through it.

```objc
-(BOOL) validSetUpMove:(Piece *) piece: (CGPoint) start: (CGPoint) end
{
    BOOL valid = false;
    if(end.y == 4 || end.y == 5)
        valid = false;
    if([piece player] == Red)
    {
        if (end.y == 0 || end.y == 1 || end.y == 2 || end.y == 3)
            valid = true;
    }
    if([piece player] == Blue)
    {
        if (end.y == 6 || end.y == 7 || end.y == 8 || end.y == 9)
            valid = true; 
    }
    
            
    return valid;
}
```

## Hiding the other army

`original/StrategoGame/BoardView.m`, lines 31–100.

`show:` is what actually puts sprites on the board. It walks all 100 squares. On red's turn, blue pieces are drawn as `bluecover.png` and red pieces keep their rank image. Blue's turn is the mirror, using `redcover.png`. When `player_turn` is `NO_PLAYER`, both colors are covered, which is the neutral pass-the-iPad screen. An empty square is a piece whose player is `NO_PLAYER`, and it gets a NULL image so the grass `UIImageView` underneath shows through. The views stay where `setup:` put them. This excerpt ends at the close of that loop. Still inside the method, a commented-out earlier copy of the same walk follows, and then `setNeedsDisplay`.

```objc
-(void)show: (BoardModel *) model: (strategoGame *) game
{
    UIImage *pieceAtPlace = [UIImage alloc]; 
    
    for (int i=0; i<100; i++) 
    {
        float fx = (float) ( i % 10 ) * SQUARE_SIZE;//630 max
		float fy = floor( i / 10 ) * SQUARE_SIZE;// 693
        int r = [self toRow: fy];
        int c = [self toCol: fx];
        Piece *p = [model getPiece:r :c];
        if([game player_turn] == Red)
        {
            if ([p player] == Blue) 
            {
                NSString *path =  @"bluecover.png";
                pieceAtPlace = [UIImage imageNamed:path];
            }
            else if([p player] == NO_PLAYER)
            {
                pieceAtPlace = NULL;
                
            }
            else
            {
                pieceAtPlace = [p image];
                
            }
        }
        else if ([game player_turn] == Blue)  
        {
            if ([p player] == Red) 
            {
                NSString *path =  @"redcover.png";
                pieceAtPlace = [UIImage imageNamed:path];
            }
            else if([p player] == NO_PLAYER)
            {
                pieceAtPlace =  NULL;
                
            }
            else
            {
                pieceAtPlace = [p image];
                
            }
        }
        else
        {
            if ([p player] == Red) 
            {
                NSString *path =  @"redcover.png";
                pieceAtPlace = [UIImage imageNamed:path];
            }
            else if([p player] == Blue)
            {
                NSString *path =  @"bluecover.png";
                pieceAtPlace = [UIImage imageNamed:path];
            } 
            else if([p player] == NO_PLAYER)
            {
                pieceAtPlace = NULL;
                
            }
        }


        UIImageView *image = [model getImageView:r :c];
        [image setImage:pieceAtPlace];
    }
```

## Blue's half of the turn button

`original/StrategoGame/ViewController.m`, lines 842–878.

One button both reveals blue and, after the move, hides the board again. `endMove` adds one to `moveCount` and does not change `player_turn`, so the ranks stay face up until this runs. When the count is even the method shows blue, paints the view `[UIColor blueColor]`, enables blue's Resign button, and renames this button `" Set Move"`, leading space included. When the count is odd it sets `player_turn` to `NO_PLAYER`, paints the view gray, covers both armies, and enables red's button under the title `" Show Pieces"`. `changeRedTurn:` is the same machine on odd counts. That gray `NO_PLAYER` state is the handoff.

```objc
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
```
