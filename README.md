# BASS iPad class project

Written by Sean and Brian as a class project, under the studio name BASS (Brian and Sean Studios). This archive holds that iPad app and a small web recreation so the board can be played without an iPad. It is their class project. It is not a commercial release, and it is not an official product of the board game whose rules it follows.

The Xcode target is named `StrategoGame`. Its bundle id prefix is `BAS` (`StrategoGame/StrategoGame-Info.plist`). The target is iPad-only (`TARGETED_DEVICE_FAMILY = 2`), deployment target iOS 5.0, 32-bit armv7, with ARC turned on (`CLANG_ENABLE_OBJC_ARC = YES` in `original/StrategoGame.xcodeproj/project.pbxproj`). Dates below are the ones written in the files. `AppDelegate`, `main.m`, and `ViewController` headers are dated 2012-04-27, with the copyright placeholder `__MyCompanyName__`. `strategoGame.h` and `strategoGame.m` are dated 4/30/12, with a copyright line for 2012.

The app is a two-player game on one iPad. There is no computer opponent, no saved game, and no undo. One person arranges a side, hands the device over, and the other person does the same. During play the board is covered between turns so the opponent's ranks stay hidden. The sprites are original PNGs: red and blue ranks 1–10, bombs, flags, cover tiles, and light and dark grass squares.

## License

The license is TBD by Sean. Until he sets one, do not assume a license for the original game, the sprites, or the recreation.

## What is in this tree

`original/` is the project folder with the source and assets left as written, apart from account names removed from file headers before publication. Dropped, because they are not the game: `__MACOSX` AppleDouble files, `.DS_Store`, the `build/` output, `xcuserdata`, and the per-user `.pbxuser` / `.perspectivev3` files. Those user files named another person and stored a home-directory path. The rest of `StrategoGame.xcodeproj` is kept, including `project.pbxproj` and the workspace. A few Finder-style `-1` duplicates were already in the folder (some byte-identical, and older copies of `darksquare.png`, `lightsquare.png`, `ViewController.xib`, and `project.pbxproj`). They are kept.

`SNIPPETS.md` is six verbatim excerpts for a portfolio page. `recreation/` is a self-contained static page that plays the same rules with the original sprites. `recreation/NOTES.md` lists every way that page differs from the app. `screenshots/` is the page captured at iPad resolution.

## How the app starts

`main.m` calls `UIApplicationMain`. `AppDelegate` builds a `UIWindow` from the screen bounds, loads `ViewController` from `ViewController.xib`, and makes it the root (`AppDelegate.m` lines 18–25). The xib is an iPad view, 768×1004, origin `(0, 20)`, under a simulated black-opaque status bar. Its background is the custom blue stored in the xib, about `rgb(7, 16, 212)`. The plist allows portrait, upside-down, and both landscapes. `shouldAutorotateToInterfaceOrientation:` returns YES (`ViewController.m` lines 942–946). Nothing in the controller lays the board or the buttons out again, and every control has a fixed portrait frame, so the designed screen is portrait.

## Architecture

Four objects do the work.

`Piece` (`Piece.h`, `Piece.m`) is a `UIView` subclass used as a data record: `type` (an `NSString` such as `@"red3"` or `@"em"`), `pieceValue`, `move` (an `NSNumber`), `player` (`Red`, `Blue`, or `NO_PLAYER`), plus `image`, `origImage`, and `imageView`. `initWithPiece:` stores the type and, for anything other than `@"em"`, loads `"<type>.png"`. It never calls `[super init]`. The factories in the controller do not use that initializer either. They `[Piece alloc]` and set properties. `imageView` is never assigned anywhere in the project.

`BoardModel` holds three parallel 10×10 `NSMutableArray`s (`BoardModel.h` lines 8–10):

- `rows` — the `Piece` at each square. `checkForPiece:` treats a `CGPoint` as column in `x` and row in `y` (`BoardModel.m` lines 163–169).
- `squareImages` — the grass `UIImage` for that square.
- `pieceLocation` — the `UIImageView` that draws whatever piece is currently on that square.

`strategoGame` (the class name is lowercase) owns the turn: `player_turn`, `moveCount`, `setupPhase`, and a `boardModel`. Its `init` (`strategoGame.m` lines 19–28) allocates a `BoardModel`, sets `moveCount` to 0, `setupPhase` to YES, and `player_turn` to `Blue`. The controller then replaces that model with its own (`ViewController.m` line 281). Rules live here: `validMove::::`, `validSetUpMove::::`, `checkPieceInMovePath:::::`, `checkForOwnPiece::`, and `action::`. Selectors are written with no external parameter names, so a call reads `[game validMove:piece :start :end]`.

`BoardView` is the 10×10 of image views. `SQUARE_SIZE` is 70 (`BoardView.h` line 3). `setup:` (`BoardView.m` lines 190–263) loops `i` from 0 to 99, with `x = (i % 10) * 70` and `y = floor(i / 10) * 70`. Even rows start on `darksquare.png`, odd rows on `lightsquare.png`, alternating across the row, so the top-left square is dark. For each cell it adds a square `UIImageView`, builds an empty `Piece`, and asks the model to `insert` that piece, the grass image, and a second `UIImageView` for the piece. Both image views are centered on `(column * 70, row * 70)`. `show:model:` (lines 31–100) does not move those views. It walks the same 100 cells and sets each piece image view's image from the `Piece` now stored at that index. `render:` exists and is never called. A commented-out earlier copy of the cover loop sits in `show:` under the live one (lines 102–152).

The controller creates the board like this (`ViewController.m` lines 43–47):

```objc
boardModel = [[BoardModel alloc] init];
game = [[strategoGame alloc] init];
boardView = [[[BoardView alloc] initWithFrame:CGRectMake(0, 0, -60, -400)] init];
[boardView setup: boardModel];
[boardView setCenter:CGPointMake(70, 70)];
```

`UIView`'s `init` calls `initWithFrame:` with a zero rect, so the negative frame is wiped before it can matter. `setCenter:(70, 70)` on that zero-size view puts the view's origin at `(70, 70)`. `clipsToBounds` stays off, and the image views hang outside the zero bounds. A 70-point view centered on `(0, 0)` inside the board view occupies `(-35, -35)`–`(35, 35)` in board coordinates, which is `(35, 35)`–`(105, 105)` in the controller's view. The opposite corner lands at `(735, 735)`. The board is 700 points square, inset by 35 points from the top and left of the 768-point-wide view. The controls, all in the xib, start at y = 776, just under the board.

| Control | xib frame | Starting text | Outlet |
| --- | --- | --- | --- |
| Blue label | `{{20, 776}, {136, 41}}` | Blue Controls: | — |
| Console | `{{218, 776}, {333, 44}}` | Setup Phase | `console` |
| Red label | `{{612, 776}, {136, 41}}` | Red Controls: | — |
| Moves label | `{{328, 828}, {77, 32}}` | Moves: | — |
| Move count | `{{400, 828}, {41, 32}}` | 1 | `moveNumber` |
| Blue state button | `{{20, 841}, {225, 53}}` | Start Game | `changeBlueStateButton` |
| Red state button | `{{523, 841}, {225, 53}}` | Start Game | `changeRedStateButton` |
| Blue turn button | `{{20, 930}, {225, 54}}` | Change Turn | `changeBlueTurnButton` |
| Red turn button | `{{523, 930}, {225, 54}}` | Change Turn | `changeRedTurnButton` |

Labels are white Helvetica 21. The console is a non-editable, centered `UITextView` with a white background. Buttons are `UIButtonTypeRoundedRect`, Helvetica Bold 21. `viewDidLoad` dims and disables both turn buttons and the red state button (`ViewController.m` lines 37–42). The blue "Start Game" button is left on. The xib connects the `changeBlueStateButton` ivars. The declared properties are named `changeBlueState` and friends (`ViewController.h` lines 32–35), and `@synthesize` creates a second set of ivars that the xib does not use. The methods talk to the outlet ivars directly.

`pixelToCoordinate:` (`BoardView.m` lines 272–305) subtracts 35 from the touch, which lines the hit rectangles up with those tiles, and scans `squareLocation`. If no tile contains the point, `x_pos` and `y_pos` stay 0, so a miss is reported as square `(0, 0)`.

## The board and the armies

`viewDidLoad` places both armies by hand. There is no shuffle. Red occupies rows 0–3, the top of the screen. Blue occupies rows 6–9, the bottom. Rows 4 and 5 stay empty. The placement is a long run of `replacePiece:row:column:` calls (lines 49–267); the opening of that list is in `SNIPPETS.md`. Each side is the classic set of 40:

| `type` | `pieceValue` | `move` | Count | Name used in the comments |
| --- | --- | --- | --- | --- |
| `red1` / `blue1` | 1 | 1 | 1 | spy |
| `red2` / `blue2` | 2 | 10 | 8 | only the digit |
| `red3` / `blue3` | 3 | 1 | 5 | miner, in the bomb test |
| `red4`–`red9` / blue | 4–9 | 1 | 4, 4, 4, 3, 2, 1 | the digit only |
| `red10` / `blue10` | 10 | 1 | 1 | marshall (their spelling) |
| `redbomb` / `bluebomb` | 11 | 0 | 6 | bomb |
| `redflag` / `blueflag` | 0 | 0 | 1 | flag |

Ranks 4 through 9 are never given words in the source. The rank-2 piece is the only one whose move allowance is 10 (`create2:`, lines 554–578). Every other mobile rank gets 1. Bombs and flags get 0, so `validMove::::` cannot move them once play has started. The factories are twelve copies of the same method (`createBomb:` through `create1:`, lines 288–604).

`validSetUpMove::::` (`strategoGame.m` lines 188–206) allows a drop on any square of your own four rows, at any distance, including a swap with one of your own pieces. Rows 4 and 5 are rejected. Those rows are not lakes. `validMove::::` has no water test, so once the game starts a piece walks straight through the middle.

## A move

A touch is one gesture. `touchesBegan:` (`ViewController.m` lines 606–632) records the piece under the finger when it belongs to `player_turn` and, outside setup, when the move counter's parity matches that player (even for blue, odd for red). `touchesMoved:` has its body commented out (lines 635–644). `touchesEnded:` (lines 646–737) converts the lift into a square and asks the rules object.

`validMove::::` (lines 30–93) allows a destination one to `move` squares away in a straight horizontal or vertical line. Diagonals fail. `checkPieceInMovePath:::::` (lines 108–186) walks the squares strictly between the two points and rejects the move if any of them is not `@"em"`. The landing square is allowed to be occupied, which is how an attack happens. `checkForOwnPiece::` (lines 95–106) returns NO when both pieces have the same `player`, and the caller stores that in a local named `ownPiece`. Landing on your own piece fails. An empty square is `NO_PLAYER`, so it is legal.

On an empty destination the controller calls `takePiece:::`, which writes the moving piece into the new square and an `@"em"` piece into the old one (`BoardModel.m` lines 129–143). During setup, an occupied destination is a `switchPiece::::` swap and `endSetup` only refreshes the board. During play, an occupied destination calls `action::`.

`show:` then repaints images in place. The `UIImageView`s never travel. Which image you see depends on `player_turn`:

- Blue's turn: blue pieces show their rank PNG, red pieces show `redcover.png`, empty squares get a NULL image so the grass shows.
- Red's turn: the mirror, with `bluecover.png` on blue pieces.
- `NO_PLAYER`: both colors are covered. That is the neutral screen.

## Turns, including handing the iPad over

Setup starts on blue, with red covered and the console reading "Setup Phase". Blue can rearrange inside rows 6–9, then presses the blue "Start Game" button. `changeBlueState:` (lines 793–808) sets `player_turn` to red, enables the red button, disables the blue one, paints the view `[UIColor redColor]`, and calls `show:`. Setup is still on. Red arranges rows 0–3.

Red's "Start Game" button, `changeRedState:` (lines 811–840), is the one that leaves setup. It sets `setupPhase` to NO, renames both state buttons "Resign Game", sets `player_turn` to `NO_PLAYER`, paints the view `[UIColor grayColor]`, writes "Game Start" into the console, enables the blue turn button (still titled "Change Turn"), and covers both armies. That gray, fully covered board is the pass-the-device screen.

From then on, each side's turn button is used twice, and `endMove` does not change `player_turn`. It only refreshes the board and adds one to `moveCount` (lines 739–759). The commented-out block in `endMove` is an earlier idea that would have swapped the background on every move.

`changeBlueTurn:` (lines 842–878), when `moveCount` is even, reveals blue, paints the view `[UIColor blueColor]`, enables blue's Resign button, and sets this button's title to `" Set Move"`, including the leading space. Blue makes one move. The parity check then stops a second move, but the ranks stay face up. Pressing `" Set Move"` takes the other branch: `player_turn` becomes `NO_PLAYER`, the view goes gray, both armies are covered, and red's button is enabled with the title `" Show Pieces"`. `changeRedTurn:` (lines 880–913) is the same machine on odd move counts. Play is: tap to reveal your side, move once, tap again to hide the board, hand the iPad over.

The move label is the xib string "1" until the first `endMove`, which writes `1` again. The second move writes `2`.

Resign is the state button, and it is only enabled while it is your revealed turn. Blue's resign stores `Red` in `player_turn` and calls `endGame`. Red's resign stores `Blue`. `endGame` (lines 767–790) writes "Blue has won!" or "Red has won!" from `player_turn`, paints the view that player's color, and dims and disables all four buttons. It does not call `show:`, so the sprites stay as they were on the turn that just ended.

## Combat

`action::` (`strategoGame.m` lines 208–241) returns 1 when the attacker wins, 2 when the defender wins, 0 for a tie, and -1 when the game should end. The tests, in order:

- Attacker value 3 against defender value 11: the miner removes the bomb. This is checked before the numeric comparison, which would otherwise let the bomb win.
- Attacker 1 against defender 10: the spy removes the marshall.
- Attacker 10 against defender 1: the marshall loses to the spy. The comment calls this the "marshall and spy cond".
- Otherwise a strictly higher `pieceValue` wins. If that defender's `type` is the literal `@"redflag"` or `@"blueflag"`, the method returns -1 instead of a normal capture. The flag's value is 0, so any higher attacker reaches this test. The comparison is pointer equality, `==`, not `isEqualToString:`. It holds here because `createFlag:` assigns the literal itself.
- A lower attacker loses.
- Equal values tie. Both pieces are removed.

The controller (`touchesEnded:`, lines 694–731) applies that number. Attacker wins: `takePiece:` moves the attacker onto the square, and the console gets `"<attacker> has defeated <defender>"`. Defender wins: `takePiece:` is called with the defender, which leaves the defender in place and clears the attacker's square, and the console gets `"<attacker> lost attacking <defender>"`. A tie replaces `startPiece` with a fresh `@"em"` piece *before* the message is built, so the text is `"em and <defender type> defeated "` (the attacker type has already been overwritten, and the grammar is the string in the source). A -1 calls `endGame` with no move and no change to `moveCount`. The winner is whoever `player_turn` already is, which is the attacker.

Nothing else ends the game. The code never asks whether a player has a legal move left.

## What stands out in the source

It is hand-written UIKit from the ARC era, and a lot of it is the first shape that worked, left in place.

The army, the twelve factories, and the four turn methods are unrolled copy-and-paste. `BoardModel`'s `init` fills `rows` by inserting an empty piece at every index, and `BoardView`'s `setup:` inserts *again* (`setPiece:`, lines 99–103, is `insertObject:atIndex:`). After setup, each row array holds 20 objects. Only indexes 0–9 are ever read. `setSquare:` and `setImageView:` insert too, which is harmless only because those arrays started empty. `strategoGame` allocates a model its `init` immediately orphans. `startPiece` is a file-scope global under the `@implementation` (`ViewController.m` line 24), not an ivar.

`Piece` is declared as a `UIView` and then used as a bag of properties. The drag path was abandoned in place: `movingImage` is set from an `imageView` that is always nil, and `touchesMoved:` is a comment. The board still works because `show:` repaints stationary image views. `takePiece:` asks `getSquareImage:` for `(origLocation.x, origLocation.y)`, which is transposed relative to `setSquare:::` (row, column). `show:` never paints an empty piece's image — empty squares are NULL — so the swapped grass image is stored and ignored.

String equality is whatever was nearby. The flag test and one `@"em"` test (`ViewController.m` line 275) use `==`. Other tests use `isEqual:` or `isEqualToString:`. `checkPieceInMovePath:::::` mixes `bool` and `BOOL`. The two middle rows are guarded in setup and forgotten in movement. `endMove` updates a label and leaves the real turn change to a pair of buttons whose titles grow a leading space. A whole previous cover-loop and a previous turn-color idea stay in the file as comments. That is student code that plays, written directly against `UIImageView`, `touchesBegan:`, and a nib, without a board framework underneath it.

## Playing the recreation

`recreation/` has no build step and no external assets. From that directory, open `index.html`, or serve the folder:

```bash
cd recreation
python3 -m http.server 8731
```

Then open `http://127.0.0.1:8731/`. Two people play on one screen, with the same reveal / move / cover turn the app uses. `NOTES.md` is the list of differences. Screenshots, at 768×1024:

| File | What it shows |
| --- | --- |
| `screenshots/01-setup.png` | Blue's setup. Blue ranks are face up, red is covered, the console says "Setup Phase". |
| `screenshots/02-midgame-hidden.png` | Red's revealed turn after a blue scout has stepped forward. Blue is behind cover tiles. |
| `screenshots/03-combat.png` | That scout attacks. The console reads `blue2 lost attacking redbomb`. |
| `screenshots/04-pass-device.png` | The gray neutral screen, both armies covered, right after "Game Start". |
| `screenshots/05-win.png` | Blue resigns. The console says "Red has won!" and the background turns red. The sprites stay as they were. |
