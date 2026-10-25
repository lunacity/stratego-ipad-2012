//Piece.m

#import "Piece.h"

@implementation Piece

@synthesize type;
@synthesize imageView;
@synthesize image;
@synthesize move;
@synthesize origImage;
@synthesize player;
@synthesize pieceValue;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithPiece:(NSString *)pieceType
{
    move = [[NSNumber alloc] initWithInt: 0];
    //self = [super initWithFrame:frame];
    player = NO_PLAYER;
    type = pieceType;
    NSString *em = @"em";
    pieceValue = 0;
    if(![pieceType isEqualToString:em])
    {
        NSString *path = [NSString stringWithFormat:@"%@.png", type];
        image = [UIImage imageNamed:path];
    }
    if (self) {
        // Initialization code
    }
    return self;
}

@end
