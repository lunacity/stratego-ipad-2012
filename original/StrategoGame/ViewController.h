//ViewController.h

#import <UIKit/UIKit.h>
#import "BoardView.h"
#import "BoardModel.h"
#import "strategoGame.h"


@interface ViewController : UIViewController
{
    
    BoardView *boardView;
    BoardModel *boardModel;  
    strategoGame *game;
    UIImageView *movingImage;
    CGPoint startPos;
    Piece *movingPiece;
    IBOutlet UIButton *changeBlueStateButton;
    IBOutlet UIButton *changeRedStateButton;
    IBOutlet UIButton *changeBlueTurnButton;    
    IBOutlet UIButton *changeRedTurnButton;
    IBOutlet UITextView *console;
    IBOutlet UILabel *moveNumber;
    
}
@property (nonatomic, retain) BoardView *boardView;
@property (nonatomic, retain) BoardModel *boardModel;
@property (nonatomic, retain) strategoGame *game;
@property (nonatomic, retain) Piece *movingPiece;
@property (nonatomic) CGPoint startPos;
@property (nonatomic, retain) UIImageView *movingImage;
@property (nonatomic, retain) UIButton *changeBlueState;
@property (nonatomic, retain) UIButton *changeRedState;
@property (nonatomic, retain) UIButton *changeBlueTurn;
@property (nonatomic, retain) UIButton *changeRedTurn;


- (Piece *) createBomb: (Player) p;

- (Piece *) createFlag: (Player) p;

- (Piece *) create10:(Player) p;
- (Piece *) create9: (Player) p;
- (Piece *) create8: (Player) p;
- (Piece *) create7: (Player) p;
- (Piece *) create6: (Player) p;
- (Piece *) create5: (Player) p;
- (Piece *) create4: (Player) p;
- (Piece *) create3: (Player) p;
- (Piece *) create2: (Player) p;
- (Piece *) create1: (Player) p;
-(void) endMove;
-(void) endSetup;
-(void) endGame;


-(IBAction)changeBlueState:(id)sender;
-(IBAction)changeRedState:(id)sender;
-(IBAction)changeBlueTurn:(id)sender;
-(IBAction)changeRedTurn:(id)sender;


@end
