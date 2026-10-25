//Piece.h

#import <UIKit/UIKit.h>

typedef enum
{
	Red,
	Blue,
	NO_PLAYER
} Player;

@interface Piece : UIView
{
    NSNumber *move;
    NSString *type;
    UIImage *image;
    UIImageView  *imageView;
    UIImage *origImage;
    Player player;
    int pieceValue;
}


- (id)initWithPiece:(NSString *)pieceType;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic,retain) NSNumber *move;
@property (nonatomic, retain) UIImage *origImage;
@property (nonatomic) Player player;
@property (nonatomic) int pieceValue;

@end
