// Playable recreation of the 2012 iPad class project.
// Rules and the on-screen strings follow ViewController.m, strategoGame.m, and BoardView.m.
// Sprites are the original PNGs, referenced with relative paths.

(function () {
  "use strict";

  var RED = 0;
  var BLUE = 1;
  var NONE = 2;

  var screen = document.getElementById("screen");
  var boardEl = document.getElementById("board");
  var consoleEl = document.getElementById("console");
  var moveNumberEl = document.getElementById("move-number");
  var buttons = {
    blueState: document.getElementById("blue-state"),
    redState: document.getElementById("red-state"),
    blueTurn: document.getElementById("blue-turn"),
    redTurn: document.getElementById("red-turn")
  };

  var board = [];
  var playerTurn = BLUE;
  var moveCount = 0;
  var setup = true;
  var gameOver = false;
  var selected = null;
  var downCell = null;
  var cells = [];

  function makeEmpty() {
    return { player: NONE, type: "em", value: 0, move: 0 };
  }

  function makePiece(player, kind) {
    var stats = {
      bomb: [11, 0],
      flag: [0, 0],
      "10": [10, 1],
      "9": [9, 1],
      "8": [8, 1],
      "7": [7, 1],
      "6": [6, 1],
      "5": [5, 1],
      "4": [4, 1],
      "3": [3, 1],
      "2": [2, 10],
      "1": [1, 1]
    };
    var pair = stats[kind];
    var color = player === RED ? "red" : "blue";
    return { player: player, type: color + kind, value: pair[0], move: pair[1] };
  }

  function paintButton(btn, title, enabled, alpha) {
    if (title !== null) btn.textContent = title;
    btn.disabled = !enabled;
    btn.style.opacity = String(alpha);
  }

  function setBackground(color) {
    screen.style.background = color;
  }

  function buildBoard() {
    var r, c;
    board = [];
    for (r = 0; r < 10; r++) {
      board[r] = [];
      for (c = 0; c < 10; c++) board[r][c] = makeEmpty();
    }
    place(RED, "bomb", [[0, 0], [0, 1], [0, 2], [3, 7], [3, 8], [3, 9]]);
    place(RED, "1", [[0, 3]]);
    place(RED, "2", [[0, 4], [0, 5], [0, 6], [0, 7], [0, 8], [0, 9], [1, 0], [1, 1]]);
    place(RED, "3", [[1, 2], [1, 3], [1, 4], [1, 5], [1, 6]]);
    place(RED, "4", [[1, 7], [1, 8], [1, 9], [2, 0]]);
    place(RED, "5", [[2, 1], [2, 2], [2, 3], [2, 4]]);
    place(RED, "6", [[2, 5], [2, 6], [2, 7], [2, 8]]);
    place(RED, "7", [[2, 9], [3, 0], [3, 1]]);
    place(RED, "8", [[3, 2], [3, 3]]);
    place(RED, "9", [[3, 4]]);
    place(RED, "10", [[3, 5]]);
    place(RED, "flag", [[3, 6]]);
    place(BLUE, "bomb", [[6, 0], [6, 1], [6, 2], [6, 3], [6, 4], [6, 5]]);
    place(BLUE, "1", [[6, 6]]);
    place(BLUE, "2", [[6, 7], [6, 8], [6, 9], [7, 0], [7, 1], [7, 2], [7, 3], [7, 4]]);
    place(BLUE, "3", [[7, 5], [7, 6], [7, 7], [7, 8], [7, 9]]);
    place(BLUE, "4", [[8, 0], [8, 1], [8, 2], [8, 3]]);
    place(BLUE, "5", [[8, 4], [8, 5], [8, 6], [8, 7]]);
    place(BLUE, "6", [[8, 8], [8, 9], [9, 0], [9, 1]]);
    place(BLUE, "7", [[9, 2], [9, 3], [9, 4]]);
    place(BLUE, "8", [[9, 5], [9, 6]]);
    place(BLUE, "9", [[9, 7]]);
    place(BLUE, "10", [[9, 8]]);
    place(BLUE, "flag", [[9, 9]]);
    var placed = 0;
    var r, c;
    for (r = 0; r < 10; r++) {
      for (c = 0; c < 10; c++) if (board[r][c].type !== "em") placed += 1;
    }
    if (placed !== 80) throw new Error("army setup placed " + placed + " pieces");
  }

  function place(player, kind, spots) {
    for (var i = 0; i < spots.length; i++) {
      board[spots[i][0]][spots[i][1]] = makePiece(player, kind);
    }
  }

  function squareName(row, col) {
    var evenRow = row % 2 === 0;
    var evenCol = col % 2 === 0;
    var dark = evenRow ? evenCol : !evenCol;
    return dark ? "sprites/darksquare.png" : "sprites/lightsquare.png";
  }

  function createCells() {
    var r, c, cell, square, piece;
    for (r = 0; r < 10; r++) {
      cells[r] = [];
      for (c = 0; c < 10; c++) {
        cell = document.createElement("div");
        cell.className = "cell";
        cell.style.left = (c * 70) + "px";
        cell.style.top = (r * 70) + "px";
        cell.dataset.row = String(r);
        cell.dataset.col = String(c);
        square = document.createElement("img");
        square.className = "square";
        square.alt = "";
        square.src = squareName(r, c);
        piece = document.createElement("img");
        piece.className = "piece";
        piece.alt = "";
        cell.appendChild(square);
        cell.appendChild(piece);
        boardEl.appendChild(cell);
        cells[r][c] = cell;
      }
    }
  }

  function coverFor(player) {
    if (playerTurn === RED) {
      if (player === BLUE) return "sprites/bluecover.png";
      if (player === NONE) return null;
      return true;
    }
    if (playerTurn === BLUE) {
      if (player === RED) return "sprites/redcover.png";
      if (player === NONE) return null;
      return true;
    }
    if (player === RED) return "sprites/redcover.png";
    if (player === BLUE) return "sprites/bluecover.png";
    return null;
  }

  function show() {
    var r, c, piece, img, shown, src;
    for (r = 0; r < 10; r++) {
      for (c = 0; c < 10; c++) {
        piece = board[r][c];
        img = cells[r][c].querySelector(".piece");
        shown = coverFor(piece.player);
        if (shown === null) {
          img.hidden = true;
          img.removeAttribute("src");
        } else {
          src = shown === true ? ("sprites/" + piece.type + ".png") : shown;
          img.hidden = false;
          if (img.getAttribute("src") !== src) img.src = src;
        }
        cells[r][c].classList.toggle(
          "selected",
          selected !== null && selected.row === r && selected.col === c
        );
      }
    }
  }

  function destinationIsNotOwn(start, end) {
    var a = board[start.y][start.x];
    var b = board[end.y][end.x];
    return a.player !== b.player;
  }

  function pieceInPath(start, end, axis, direction) {
    var blocked = false;
    var x, y;
    if (axis === "x") {
      if (direction === "Left") {
        for (x = start.x; x > end.x; x--) {
          if (x !== start.x && board[start.y][x].type !== "em") blocked = true;
        }
      } else {
        for (x = start.x; x < end.x; x++) {
          if (x !== start.x && board[start.y][x].type !== "em") blocked = true;
        }
      }
    } else if (direction === "Down") {
      for (y = start.y; y < end.y; y++) {
        if (y !== start.y && board[y][start.x].type !== "em") blocked = true;
      }
    } else {
      for (y = start.y; y > end.y; y--) {
        if (y !== start.y && board[y][start.x].type !== "em") blocked = true;
      }
    }
    return blocked;
  }

  function validMove(piece, start, end) {
    var allowed = piece.move;
    var n, axis, direction, clear, notOwn;
    for (n = 1; n <= allowed; n++) {
      axis = null;
      direction = null;
      if (start.x + n === end.x && start.y === end.y) {
        direction = "Right";
        axis = "x";
      } else if (start.x - n === end.x && start.y === end.y) {
        direction = "Left";
        axis = "x";
      } else if (start.x === end.x && start.y + n === end.y) {
        direction = "Down";
        axis = "y";
      } else if (start.x === end.x && start.y - n === end.y) {
        direction = "Up";
        axis = "y";
      }
      if (axis) {
        clear = !pieceInPath(start, end, axis, direction);
        notOwn = destinationIsNotOwn(start, end);
        if (clear && notOwn) return true;
      }
    }
    return false;
  }

  function validSetupMove(piece, end) {
    var valid = false;
    if (end.y === 4 || end.y === 5) valid = false;
    if (piece.player === RED && (end.y === 0 || end.y === 1 || end.y === 2 || end.y === 3)) valid = true;
    if (piece.player === BLUE && (end.y === 6 || end.y === 7 || end.y === 8 || end.y === 9)) valid = true;
    return valid;
  }

  function action(attacker, defender) {
    if (attacker.value === 3 && defender.value === 11) return 1;
    if (attacker.value === 1 && defender.value === 10) return 1;
    if (attacker.value === 10 && defender.value === 1) return 2;
    if (attacker.value > defender.value) {
      if (defender.type === "redflag" || defender.type === "blueflag") return -1;
      return 1;
    }
    if (attacker.value < defender.value) return 2;
    return 0;
  }

  function takePiece(piece, end, start) {
    board[end.y][end.x] = piece;
    board[start.y][start.x] = makeEmpty();
  }

  function switchPiece(piece, end, other, start) {
    board[end.y][end.x] = piece;
    board[start.y][start.x] = other;
  }

  function canAct(piece) {
    if (gameOver || !piece || piece.type === "em") return false;
    if (playerTurn !== piece.player) return false;
    if (setup) return true;
    if (playerTurn === RED && moveCount % 2 === 1) return true;
    if (playerTurn === BLUE && moveCount % 2 === 0) return true;
    return false;
  }

  function endMove() {
    show();
    moveCount += 1;
    moveNumberEl.textContent = String(moveCount);
  }

  function endSetup() {
    show();
  }

  function endGame() {
    var nodes, i;
    // The original endGame updates the console, the background, and the buttons.
    // It does not call show:, so whichever ranks are on screen stay there.
    gameOver = true;
    selected = null;
    nodes = boardEl.querySelectorAll(".cell.selected");
    for (i = 0; i < nodes.length; i++) nodes[i].classList.remove("selected");
    if (playerTurn === BLUE) {
      consoleEl.textContent = "Blue has won!";
      setBackground("rgb(0, 0, 255)");
    }
    if (playerTurn === RED) {
      consoleEl.textContent = "Red has won!";
      setBackground("rgb(255, 0, 0)");
    }
    paintButton(buttons.blueTurn, null, false, 0.4);
    paintButton(buttons.blueState, null, false, 0.4);
    paintButton(buttons.redTurn, null, false, 0.4);
    paintButton(buttons.redState, null, false, 0.4);
  }

  function tryMove(from, to) {
    var piece, dest, start, end, result, empty, destType;
    if (gameOver) return false;
    piece = board[from.row][from.col];
    dest = board[to.row][to.col];
    if (!canAct(piece)) return false;
    start = { x: from.col, y: from.row };
    end = { x: to.col, y: to.row };
    if (setup) {
      if (!validSetupMove(piece, end)) return false;
    } else if (!validMove(piece, start, end)) {
      return false;
    }
    if (dest.type === "em") {
      takePiece(piece, end, start);
      if (setup) endSetup();
      else endMove();
      return true;
    }
    if (setup) {
      switchPiece(piece, end, dest, start);
      endSetup();
      return true;
    }
    result = action(piece, dest);
    if (result === 1) {
      consoleEl.textContent = piece.type + " has defeated " + dest.type;
      takePiece(piece, end, start);
      endMove();
    } else if (result === 2) {
      consoleEl.textContent = piece.type + " lost attacking " + dest.type;
      takePiece(dest, end, start);
      endMove();
    } else if (result === 0) {
      empty = makeEmpty();
      destType = dest.type;
      takePiece(empty, end, start);
      consoleEl.textContent = empty.type + " and " + destType + " defeated ";
    } else {
      endGame();
      return true;
    }
    if (result === 0) endMove();
    return true;
  }

  function cellFromPoint(clientX, clientY) {
    var rect = boardEl.getBoundingClientRect();
    var x = (clientX - rect.left) / rect.width * 700;
    var y = (clientY - rect.top) / rect.height * 700;
    var col = Math.floor(x / 70);
    var row = Math.floor(y / 70);
    if (row < 0 || col < 0 || row > 9 || col > 9) return null;
    if (x < 0 || y < 0) return null;
    return { row: row, col: col };
  }

  function onPointerDown(event) {
    if (event.button !== undefined && event.button !== 0) return;
    downCell = cellFromPoint(event.clientX, event.clientY);
    if (!downCell) return;
    event.preventDefault();
  }

  function onPointerUp(event) {
    var up, start;
    if (!downCell) return;
    start = downCell;
    downCell = null;
    up = cellFromPoint(event.clientX, event.clientY);
    if (gameOver) return;
    if (up && (up.row !== start.row || up.col !== start.col)) {
      if (tryMove(start, up)) {
        selected = null;
        show();
        return;
      }
    }
    if (selected && up && (selected.row !== up.row || selected.col !== up.col)) {
      if (tryMove(selected, up)) {
        selected = null;
        show();
        return;
      }
    }
    if (up && canAct(board[up.row][up.col])) selected = up;
    else if (!up) selected = selected;
    else selected = null;
    show();
  }

  function changeBlueState() {
    if (setup) {
      playerTurn = RED;
      paintButton(buttons.blueState, null, false, 0.4);
      paintButton(buttons.redState, null, true, 1);
      setBackground("rgb(255, 0, 0)");
      selected = null;
      show();
    } else {
      playerTurn = RED;
      endGame();
    }
  }

  function changeRedState() {
    if (setup) {
      playerTurn = NONE;
      setup = false;
      paintButton(buttons.blueState, "Resign Game", false, 1);
      paintButton(buttons.redState, "Resign Game", false, 0.4);
      paintButton(buttons.blueTurn, null, true, 1);
      paintButton(buttons.redTurn, null, false, 0.4);
      setBackground("rgb(128, 128, 128)");
      consoleEl.textContent = "Game Start";
      selected = null;
      show();
    } else {
      playerTurn = BLUE;
      endGame();
    }
  }

  function changeBlueTurn() {
    if (setup) {
      paintButton(buttons.blueTurn, null, false, buttons.blueTurn.style.opacity || 0.4);
      return;
    }
    if (moveCount % 2 === 0) {
      playerTurn = BLUE;
      setBackground("rgb(0, 0, 255)");
      paintButton(buttons.blueTurn, " Set Move", true, 1);
      paintButton(buttons.blueState, null, true, 1);
      paintButton(buttons.redTurn, null, false, 0.4);
      paintButton(buttons.redState, null, false, 0.4);
    } else {
      playerTurn = NONE;
      setBackground("rgb(128, 128, 128)");
      paintButton(buttons.redTurn, " Show Pieces", true, 1);
      paintButton(buttons.redState, null, false, 0.4);
      paintButton(buttons.blueTurn, null, false, 0.4);
      paintButton(buttons.blueState, null, false, 0.4);
    }
    selected = null;
    show();
  }

  function changeRedTurn() {
    if (setup) {
      paintButton(buttons.redTurn, null, false, 0.4);
      return;
    }
    if (moveCount % 2 === 1) {
      playerTurn = RED;
      setBackground("rgb(255, 0, 0)");
      paintButton(buttons.redTurn, " Set Move", true, 1);
      paintButton(buttons.redState, null, true, 1);
      paintButton(buttons.blueState, null, false, 0.4);
      paintButton(buttons.blueTurn, null, false, 0.4);
    } else {
      playerTurn = NONE;
      setBackground("rgb(128, 128, 128)");
      paintButton(buttons.blueTurn, " Show Pieces", true, 1);
      paintButton(buttons.redTurn, null, false, 0.4);
      paintButton(buttons.redState, null, false, 0.4);
    }
    selected = null;
    show();
  }

  function fit() {
    var footer = document.querySelector("footer");
    var availW = document.documentElement.clientWidth;
    var availH = window.innerHeight - footer.offsetHeight;
    var scale = Math.min(1, availW / 768, availH / 1024);
    var device = document.getElementById("device");
    var fitEl = document.getElementById("fit");
    if (scale < 0.05) scale = 0.05;
    device.style.transform = "scale(" + scale + ")";
    fitEl.style.height = Math.ceil(1024 * scale) + "px";
  }

  buttons.blueState.addEventListener("click", changeBlueState);
  buttons.redState.addEventListener("click", changeRedState);
  buttons.blueTurn.addEventListener("click", changeBlueTurn);
  buttons.redTurn.addEventListener("click", changeRedTurn);
  screen.addEventListener("pointerdown", onPointerDown);
  window.addEventListener("pointerup", onPointerUp);
  window.addEventListener("resize", fit);

  buildBoard();
  createCells();
  paintButton(buttons.blueTurn, null, false, 0.4);
  paintButton(buttons.redTurn, null, false, 0.4);
  paintButton(buttons.redState, null, false, 0.4);
  paintButton(buttons.blueState, null, true, 1);
  setBackground("rgb(7, 16, 212)");
  show();
  fit();
})();
