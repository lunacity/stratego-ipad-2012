//
//  strategoGame.m
//  StrategoGame
//
//  Created by Mike Dugan on 4/30/12.
//  Copyright (c) 2012 Oracle. All rights reserved.
//

#import "strategoGame.h"
#import "BoardModel.h"

@implementation strategoGame

@synthesize moveCount;
@synthesize player_turn;
@synthesize setupPhase;
@synthesize boardModel;

- (id)init {
    boardModel = [[BoardModel alloc] init];
    self = [super init];
    if (self) {
        moveCount = 0;
        setupPhase = TRUE;
        player_turn = Blue;
    }
    return self;
}

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

-(BOOL) checkForOwnPiece: (CGPoint ) startPoint: (CGPoint) endPoint
{


    Piece *startPiece = [boardModel checkForPiece:startPoint];
    Piece *endPiece = [boardModel checkForPiece:endPoint];
    if([startPiece player] == [endPiece player])
    {
        return FALSE;
    }
    return TRUE;
}

-(BOOL) checkPieceInMovePath: (CGPoint ) startPoint: (CGPoint) endPoint: (NSString *) axis: (NSString *) direction
{
    
    bool pieceAtLocation = false;
    NSString * em = @"em";
    NSString * possibleAxis = @"x";
    NSString * possibleDir = @"Left";
    if([axis isEqualToString:possibleAxis])
    {
        if ([direction isEqualToString:possibleDir]) 
        {
            for(int movedSquares = startPoint.x; movedSquares > endPoint.x; movedSquares--)
            {
                CGPoint currentPos = CGPointMake(movedSquares, startPoint.y);
                if (!CGPointEqualToPoint(currentPos,startPoint))
                {
                    Piece *foundPiece = [boardModel checkForPiece:currentPos];
                    if (![[foundPiece type] isEqualToString:em]) 
                    {
                        pieceAtLocation = TRUE;
                    }
                }
            }
        }
        else
        {
            for(int movedSquares = startPoint.x; movedSquares < endPoint.x; movedSquares++)
            {
                CGPoint currentPos = CGPointMake(movedSquares, startPoint.y);
                if (!CGPointEqualToPoint(currentPos,startPoint))
                {
                    Piece *foundPiece = [boardModel checkForPiece:currentPos];
                    if (![[foundPiece type] isEqualToString:em]) 
                    {
                        pieceAtLocation = TRUE;
                    }
                }
            }
        }
        
        
    }
    else
    {
        possibleDir = @"Down";
        if ([direction isEqualToString:possibleDir]) 
        {
            for(int movedSquares = startPoint.y; movedSquares < endPoint.y; movedSquares++)
            {
                CGPoint currentPos = CGPointMake(startPoint.x, movedSquares);
                if (!CGPointEqualToPoint(currentPos,startPoint))
                {
                    Piece *foundPiece = [boardModel checkForPiece:currentPos];
                    if (![[foundPiece type] isEqualToString:em]) 
                    {
                        pieceAtLocation = TRUE;
                    } 
                }
            }
        }
        else
        {
            for(int movedSquares = startPoint.y; movedSquares > endPoint.y; movedSquares--)
            {
                CGPoint currentPos = CGPointMake(startPoint.x, movedSquares);
                if (!CGPointEqualToPoint(currentPos,startPoint))
                {
                    Piece *foundPiece = [boardModel checkForPiece:currentPos];
                    if (![[foundPiece type] isEqualToString:em]) 
                    {
                        pieceAtLocation = TRUE;
                    }
                }
            }
        }
        
    }
    return pieceAtLocation;
}

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



@end
