//BoardView.h

#define SQUARE_SIZE 70
#import "BoardModel.h"
#import "strategoGame.h"
#import <UIKit/UIKit.h>

@interface BoardView : UIView
{
    UIView *squaresView;
    UIView *piecesView;
    NSMutableArray  *squareLocation;
    NSMutableArray  *pieceLocation;
    NSMutableArray  *squareImage;

}

@property(nonatomic, retain)UIView *squaresView;
@property(nonatomic, retain)UIView *piecesView;
@property(nonatomic, retain)NSMutableArray *squareLocation;
@property(nonatomic, retain)NSMutableArray *pieceLocation;
@property(nonatomic, retain)NSMutableArray *squareImage;

- (void)render:(BoardModel *)model;
- (void)show:(BoardModel *)model: (strategoGame *) strategoGame;

- (void) setSquare:(CGPoint)piecePos of: (UIImageView *) image;
- (void) drawSquare:(CGPoint)piecePos of: (UIImageView *) image;
- (void) setup: (BoardModel *) model;
- (int) toRow: (float) y;
- (int) toCol: (float) x;
-(CGPoint)coordinateToPixel: (int)x: (int)y;
-(CGPoint)pixelToCoordinate: (CGPoint)p;

@end
