//BoardView.m

#import "BoardView.h"
#import "BoardModel.h"
#import "Piece.h"
#import "strategoGame.h"
@implementation BoardView

@synthesize squareLocation;
@synthesize squaresView;
@synthesize piecesView;
@synthesize pieceLocation;
@synthesize squareImage;

- (void)render:(BoardModel *)model
{
    for (int i=0; i<100; i++) 
    {
        float fx = (float) ( i % 10 ) * SQUARE_SIZE;//630 max
		float fy = floor( i / 10 ) * SQUARE_SIZE;// 693
        int r = [self toRow: fy];
        int c = [self toCol: fx];
        Piece *p = [model getPiece:r :c];
        UIImageView *image = [model getImageView:r :c];
        [image setImage:[p image]];
     }
    [squaresView setNeedsDisplay];
}


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
    
    /*
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
            if([p player] == Blue)
            {
                NSString *path =  @"bluecover.png";
                pieceAtPlace = [UIImage imageNamed:path];
            } 
        }
        UIImageView *image = [model getImageView:r :c];
        [image setImage:pieceAtPlace];
    }
     */
    [squaresView setNeedsDisplay];
}

-(void) setSquare:(CGPoint)piecePos of: (UIImageView *) image 
{
	//NSLog(@"woof");
    float fx = piecePos.x * SQUARE_SIZE;
	float fy = piecePos.y * SQUARE_SIZE;
    [image setCenter:CGPointMake(fx,fy)];
    [squaresView addSubview:image];
}

-(void) drawSquare:(CGPoint)piecePos of: (UIImageView *) image 
{
    float fx = piecePos.x -70;
	float fy = piecePos.y - 70;
    [image setCenter:CGPointMake(fx,fy)];
    [squaresView addSubview:image];
    
}

-(int) toCol: (float) x
{
    int c = 0;
    if(x != 0)  
        c  = x/SQUARE_SIZE;
    return c;
}

-(int) toRow: (float) y
{
    int r = 0;
    if(y != 0) 
        r = y/SQUARE_SIZE;
    return r;
}

-(void)setup:(BoardModel *)model
{
    squaresView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self addSubview:squaresView];
    
	UIImage *whitesquare = [UIImage imageNamed:@"lightsquare.png"];
	UIImage *blacksquare = [UIImage imageNamed:@"darksquare.png"];
    UIImage *pieceImage;
	UIImageView *squareImageView;
    squareLocation = [[NSMutableArray alloc] initWithCapacity:10];
    //this is for the coordinate array
    NSMutableArray *y_arr;
    for (int rowIndex = 0; rowIndex < 10; rowIndex++)
    {
        y_arr = [[NSMutableArray alloc]  initWithCapacity:10];
        [squareLocation addObject:y_arr];
    }
    //creating the pieces location array on the view
 
    
    //creating the squares location array on the view
   
    
	for (int i=0; i<100; i++) 
    {
		float fx = (float) ( i % 10 ) * SQUARE_SIZE;//630 max
		float fy = floor( i / 10 ) * SQUARE_SIZE;// 693
		if((int)floor(i/10)%2) 
        {
			if( i%2 ) {
				squareImageView = [[UIImageView alloc] initWithImage:blacksquare];
                pieceImage = blacksquare;
			}
			else {
				squareImageView = [[UIImageView alloc] initWithImage:whitesquare];
                pieceImage = whitesquare;
			}
		}
		else 
        {
			if( i%2 ) {
				squareImageView = [[UIImageView alloc] initWithImage:whitesquare];
                pieceImage = whitesquare;
			}
			else {
				squareImageView = [[UIImageView alloc] initWithImage:blacksquare];
                pieceImage = blacksquare;
			}
		}
        //adding coordinate to the squareLocation arrray
        int x_coord = floor(i/10);
        assert(0 <= x_coord && x_coord < 10);
        NSMutableArray *y_arr = [squareLocation objectAtIndex:x_coord];
        [y_arr addObject:[NSValue valueWithCGPoint: CGPointMake(fx,fy)]];
        [squareImageView setCenter:CGPointMake(fx,fy)];
		[squaresView addSubview:squareImageView];
        Piece *p = [Piece alloc];
        [p setMove: [[NSNumber alloc] initWithInt: 0]];
        [p setType: @"em"];
        [p setImage:pieceImage];
        //NSLog (@"black: %@", blacksquare);
        //NSLog (@"white: %@", whitesquare);
        [p setOrigImage:[p image]];
        int r = [self toRow: fy];
        int c = [self toCol: fx];
        [model setPiece:p :r :c];
        [model setSquare:pieceImage: r: c];
        [model setImageView:[p image] :r :c];
        UIImageView *imageView = [model getImageView:r :c];
        [imageView setCenter:CGPointMake(fx,fy)];
		[squaresView addSubview:imageView];
        
    }
}

-(CGPoint)coordinateToPixel: (int)r: (int)c
{
    NSMutableArray *col = [squareLocation objectAtIndex:r];
    CGPoint p = [[col objectAtIndex: c] CGPointValue];
    return p;
}

-(CGPoint)pixelToCoordinate: (CGPoint)p
{
    //subtract 35 to account for margins
    int pixel_x = p.x -35;
    int pixel_y = p.y - 35;
    int x_pos = 0;
    int y_pos = 0;
    bool flag = false;
    for(int i = 0; i <10; i++)
    {
       NSMutableArray *y_arr = [squareLocation objectAtIndex:i];
        for(int k = 0; k <10; k++)
        {
            flag = false;
            CGPoint square_pixel = [[y_arr objectAtIndex:k] CGPointValue];
            if(square_pixel.y < pixel_y && square_pixel.y+70  > pixel_y)
            {
                flag = true;
                y_pos = i;
            }
            if(flag == true)
            {
                if(square_pixel.x < pixel_x && square_pixel.x+70  > pixel_x)
                {
                    
                    x_pos = k;
                }
                
            }
        }
    }
    CGPoint coord = CGPointMake(x_pos, y_pos);
    return coord;
}

@end
