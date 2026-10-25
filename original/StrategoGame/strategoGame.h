//
//  strategoGame.h
//  StrategoGame
//
//  Created by Mike Dugan on 4/30/12.
//  Copyright (c) 2012 Oracle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Piece.h"
#import "BoardModel.h"

@interface strategoGame : NSObject
{
    Player player_turn;
    int moveCount;
    BOOL setUpPhase;
    BoardModel *boardModel;
}

@property(nonatomic)Player player_turn;
@property(nonatomic)int moveCount;
@property(nonatomic)BOOL setupPhase;
@property (nonatomic, retain) BoardModel *boardModel;

-(BOOL) validMove:(Piece *) piece: (CGPoint) start: (CGPoint) end;
-(BOOL) validSetUpMove:(Piece *) piece: (CGPoint) start: (CGPoint) end;
-(int) action:(Piece *) attacker: (Piece *) defender;
-(BOOL) checkPieceInMovePath: (CGPoint) startPoint: (CGPoint) endPoint: (NSString *) axis: (NSString *) direction;
-(BOOL) checkForOwnPiece: (CGPoint ) startPoint: (CGPoint) endPoint;

@end
