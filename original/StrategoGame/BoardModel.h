//BoardModel.h

#import <Foundation/Foundation.h>
#import "Piece.h"


@interface BoardModel : NSObject {
	NSMutableArray *rows;
    NSMutableArray *squareImages;
    NSMutableArray *pieceLocation;
}

- (void)setImageView:(UIImage *)image: (int) r: (int) c;
-(UIImageView *)getImageView: (int) r: (int) c;
- (void) replacePiece: (Piece *) p: (int) r: (int) c;
- (Piece *) getPiece: (int) r: (int) c;
- (void) setPiece: (Piece *) p: (int) r: (int) c;
-(void)switchPiece:(Piece *)piece: (CGPoint)newLocation: (Piece *)newP: (CGPoint) origLocation;
- (void)takePiece:(Piece *)piece:(CGPoint)newLocation: (CGPoint) origLocation;
- (void)setPieceTypeAtLocation:(CGPoint )point withType: (NSString *)value;
- (void) setPieceAtLocation:(CGPoint )point withPiece: (Piece *)value;
- (void) printBoard;
- (Piece *) checkForPiece: (CGPoint)p;
- (void) setSquare: (UIImage *) image: (int)r: (int) c;
- (UIImage *) getSquareImage: (int)r: (int) c;

@end
