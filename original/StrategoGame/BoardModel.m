//BoardModel.m

#import "BoardModel.h"

@implementation BoardModel


-(id) init {
    //http://stackoverflow.com/questions/1244833/nested-arrays-in-objective-c-nsmutablearray
    
    rows = [[NSMutableArray alloc] initWithCapacity:10];
    NSMutableArray *col;
    
    for (int rowIndex = 0; rowIndex < 10; rowIndex++)
    {
        col = [NSMutableArray arrayWithCapacity:10];
        [rows insertObject:col atIndex:rowIndex];
    }
    squareImages = [[NSMutableArray alloc] initWithCapacity:10];
    for (int rowIndex = 0; rowIndex < 10; rowIndex++)
    {
        col = [NSMutableArray arrayWithCapacity:10];
        [squareImages insertObject:col atIndex:rowIndex];
    }
    
    pieceLocation = [[NSMutableArray alloc] initWithCapacity:10];
    
    for (int rowIndex = 0; rowIndex < 10; rowIndex++)
    {
        col = [NSMutableArray arrayWithCapacity:10];
        [pieceLocation insertObject:col atIndex:rowIndex];
    }
    
    Piece *emptyPiece = [[Piece alloc] initWithPiece:@"em"];
    [emptyPiece setPlayer:NO_PLAYER];
    for (int r = 0; r < 10; r++) {
        for (int c = 0; c < 10; c++) {
            [self setPiece:emptyPiece :r :c];
        }
    }
    
  	return self;
}


- (void)setImageView:(UIImage *)image: (int) r: (int) c
{
    UIImageView *squareImageView;
    squareImageView = [[UIImageView alloc] initWithImage:image];
    
    NSMutableArray *col = [pieceLocation objectAtIndex:r];
    [col insertObject:squareImageView atIndex:c];
}

-(UIImageView *)getImageView: (int) r: (int) c
{
    //pieceLocation object
    NSMutableArray *col = [pieceLocation objectAtIndex:r];
    UIImageView *p = [col objectAtIndex: c];
    return p;
}


- (void) setSquare: (UIImage *) image: (int)r: (int) c
{    
    NSMutableArray *col = [squareImages objectAtIndex:r];
    [col insertObject:image atIndex:c];

}

- (UIImage *) getSquareImage: (int)r: (int) c
{
    NSMutableArray *col = [squareImages objectAtIndex:r];
    UIImage *p = [col objectAtIndex: c];
    return p;
}

- (void)setPieceTypeAtLocation:(CGPoint )point withType: (NSString *)value
{
    int row = (int) point.y;
    int col = (int) point.x;
    
    NSMutableArray *theCol = [rows objectAtIndex:row];
    Piece *p = [theCol objectAtIndex:col];
    p.type = value; 
}

- (void) setPieceAtLocation:(CGPoint )point withPiece: (Piece *)piece
{
    int row = (int)point.y;
    int col = (int)point.x;
    
    NSMutableArray *theCol = [rows objectAtIndex:row];
    Piece *p = [theCol objectAtIndex: col];
    [piece setOrigImage:[p origImage]];
    [theCol replaceObjectAtIndex:col withObject: piece];
}

- (void)setPiece:(Piece *)piece: (int) r: (int) c
{
    NSMutableArray *col = [rows objectAtIndex:r];
    [col insertObject:piece atIndex:c];
}

- (void)replacePiece:(Piece *)piece: (int) r: (int) c
{
    NSMutableArray *col = [rows objectAtIndex:r];
     Piece *p = [col objectAtIndex: c];
    [piece setOrigImage:[p origImage]];
    [col replaceObjectAtIndex:c withObject: piece];
}

- (Piece *) getPiece:(int)r :(int)c
{
    NSMutableArray *col = [rows objectAtIndex:r];
    Piece *p = [col objectAtIndex: c];
    return p;
}

-(void)switchPiece:(Piece *)piece: (CGPoint)newLocation: (Piece *)newP: (CGPoint) origLocation
{
    //NSLog(@"New Location %@ ", NSStringFromCGPoint(newLocation));
    //NSLog(@"Orig Location %@ ", NSStringFromCGPoint(origLocation));
    //[self setPieceAtLocation:newLocation withPiece:newP];
    [self setPieceAtLocation:newLocation withPiece:piece];
    [self setPieceAtLocation:origLocation withPiece:newP];
}   

-(void)takePiece:(Piece *)piece: (CGPoint)newLocation: (CGPoint) origLocation
    {
   
    //NSLog(@"New Location %@ ", NSStringFromCGPoint(newLocation));
    //NSLog(@"Orig Location %@ ", NSStringFromCGPoint(origLocation));
    Piece *newP = [Piece alloc];
    [newP setType:@"em"];
    [newP setPieceValue:0];
    [newP setPlayer:NO_PLAYER];
    [newP setImage: [self getSquareImage:origLocation.x :origLocation.y]];
    [newP setOrigImage:[piece origImage]];
    //[self setPieceAtLocation:newLocation withPiece:newP];
    [self setPieceAtLocation:newLocation withPiece:piece];
    [self setPieceAtLocation:origLocation withPiece:newP];
}


-(void) printBoard
{
    NSMutableArray *col;
    Piece *thePiece;
    for (int rowIndex = 0; rowIndex < 10; rowIndex++)
    {
        col = [rows objectAtIndex:rowIndex];
        
        for (int colIndex = 0; colIndex < 10; colIndex++)
        {
            thePiece = [col objectAtIndex:colIndex];         
            NSLog(@"%@ (%i,%i)",[thePiece type], rowIndex, colIndex);

        }
    }
}

-(Piece *) checkForPiece: (CGPoint)p
{
    
    NSMutableArray *col = [rows objectAtIndex:p.y];
    Piece *piece = [col objectAtIndex: p.x];
    return piece;
}

@end
