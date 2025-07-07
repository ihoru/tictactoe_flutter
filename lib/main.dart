// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'TicTacToe Duel';
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[850],
          foregroundColor: Colors.white,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const MainPage(title: appTitle),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Game game = Game();

  @override
  Widget build(BuildContext context) {
    String statusText = game.status;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        leading: const Icon(Icons.hourglass_bottom),
        actions: [
          IconButton(
            onPressed: () => showInfo(context),
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            UpsideDown(
              child: RestartButton(onPressed: gameRestart),
            ),
            UpsideDown(
              child: GameStatusText(statusText: statusText),
            ),
            Expanded(
              child: Center(
                child: CanvasTouchDetector(
                  gesturesToOverride: const [GestureType.onTapDown],
                  builder: (context) => CustomPaint(
                    size: const Size(300, 300),
                    painter: GameFieldPainter(context, game, gameMakeTurn),
                  ),
                ),
              ),
            ),
            GameStatusText(statusText: statusText),
            RestartButton(onPressed: gameRestart),
          ],
        ),
      ),
    );
  }

  void gameRestart() {
    setState(() {
      game.restart();
    });
  }

  void gameMakeTurn(x, y) {
    setState(() {
      game.makeTurn(x, y);
    });
  }

  void showInfo(context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('How to play?'),
          content: const Text('Tap any cell to make a turn'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }
}

class RestartButton extends StatelessWidget {
  const RestartButton({super.key, required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text('Restart'.toUpperCase()),
      ),
    );
  }
}

class GameStatusText extends StatelessWidget {
  GameStatusText({super.key, required this.statusText});

  String statusText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(statusText, style: const TextStyle(fontSize: 20)),
    );
  }
}

class UpsideDown extends RotatedBox {
  const UpsideDown({super.key, required Widget super.child})
      : super(quarterTurns: 2);
}

enum GameWinningLineType { row, column, diagonal }

class Game {
  List<List<String>> field = emptyField();
  String turn = 'X';
  String winner = '';
  GameWinningLineType? winningLineType;
  int winningLineNumber = 0;

  int get fieldSize => field.length;

  static List<List<String>> emptyField() {
    return [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ];
  }

  void makeTurn(x, y) {
    if (field[x][y] != '') {
      throw 'Cell is not empty!';
    }
    field[x][y] = turn;
    turn = turn == 'X' ? 'O' : 'X';
    List? winnerInfo = findWinner();
    if (winnerInfo != null) {
      setWinner(winnerInfo[0], winnerInfo[1], winnerInfo[2] + 1);
    }
  }

  void setWinner(String player, GameWinningLineType type, int line) {
    winner = player;
    turn = '';
    winningLineType = type;
    winningLineNumber = line;
  }

  String? checkWinner(List<String> values) {
    if (values.length != fieldSize) {
      throw 'Wrong values: $values in checkWinner';
    }
    String lastValue = '';
    for (var value in values) {
      if (value.isEmpty) {
        return null;
      }
      if (lastValue.isEmpty) {
        lastValue = value;
      } else if (lastValue != value) {
        return null;
      }
    }
    return lastValue;
  }

  List? findWinner() {
    String? player;
    // check horizontals
    for (var i = 0; i < field.length; ++i) {
      player = checkWinner(field[i]);
      if (player != null) {
        return [player, GameWinningLineType.row, i];
      }
    }
    // check verticals
    List<List<String>> fieldTransposed = transposeField();
    for (var i = 0; i < fieldTransposed.length; ++i) {
      player = checkWinner(fieldTransposed[i]);
      if (player != null) {
        return [player, GameWinningLineType.column, i];
      }
    }
    // check diagonals
    List<String> diagonal1 = [];
    List<String> diagonal2 = [];
    for (var i = 0; i < field.length; ++i) {
      for (var j = 0; j < field[i].length; ++j) {
        if (i == j) {
          diagonal1.add(field[i][j]);
          diagonal2.add(field[fieldSize - 1 - j][i]);
        }
      }
    }
    player = checkWinner(diagonal1);
    if (player != null) {
      return [player, GameWinningLineType.diagonal, 0];
    }
    player = checkWinner(diagonal2);
    if (player != null) {
      return [player, GameWinningLineType.diagonal, 1];
    }
    return null;
  }

  List<List<String>> transposeField() {
    List<List<String>> ret = emptyField();
    for (var i = 0; i < field.length; ++i) {
      for (var j = 0; j < field[i].length; ++j) {
        ret[i][j] = field[j][i];
      }
    }
    return ret;
  }

  void restart() {
    turn = 'X';
    winner = '';
    field = emptyField();
    winningLineType = null;
    winningLineNumber = 0;
  }

  String get status {
    if (turn != '') {
      return '"$turn" turn - tap on an empty cell';
    } else if (winner != '') {
      return '"$winner" won - tap RESTART button';
    }
    return '';
  }
}

class GameFieldPainter extends CustomPainter {
  GameFieldPainter(this.context, this.game, this.makeTurn) : super();

  final BuildContext context;
  final Game game;
  final Function makeTurn;

  Paint get _cellPaint => Paint()
    ..color = Theme.of(context).brightness == Brightness.dark 
        ? Colors.white70 
        : Colors.black87
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  Paint get _valuePaint => Paint()
    ..color = Theme.of(context).brightness == Brightness.dark 
        ? Colors.redAccent 
        : Colors.red
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4;

  Paint get _winPaint => Paint()
    ..color = Theme.of(context).brightness == Brightness.dark
        ? Colors.yellow
        : Colors.black87
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: why does it execute so often on "Restart"
    // log('paint');
    var tCanvas = TouchyCanvas(context, canvas);
    int gameFieldSize = game.fieldSize;
    Size cellSize = size / gameFieldSize.toDouble();
    double radius = cellSize.width / 2 - cellSize.width * 0.1;
    double crossOffset = cellSize.width * 0.2 / 2;
    double w = cellSize.width, h = cellSize.height;
    for (var i = 0; i < gameFieldSize; i += 1) {
      for (var j = 0; j < gameFieldSize; j += 1) {
        // get cell's value
        String value = game.field[j][i];

        // draw a cell
        double x = i * w, y = j * h;
        var rect = Rect.fromLTWH(x, y, w, h);
        canvas.drawRect(rect, _cellPaint);
        if (value == '' && game.turn.isNotEmpty) {
          // draw transparent but tappable Rect
          tCanvas.drawRect(
            rect,
            Paint()..color = Colors.transparent,
            onTapDown: (tapDetail) => makeTurn(j, i),
          );
        }

        // draw contents of the cell: X or O
        if (value == 'X') {
          var path = Path()
            ..moveTo(x + crossOffset, y + crossOffset)
            ..relativeLineTo(w - crossOffset * 2, h - crossOffset * 2)
            ..moveTo(x + crossOffset, y + h - crossOffset)
            ..relativeLineTo(w - crossOffset * 2, -h + crossOffset * 2);
          canvas.drawPath(path, _valuePaint);
        } else if (value == 'O') {
          var offset = Offset(x + w / 2, y + h / 2);
          canvas.drawCircle(offset, radius, _valuePaint);
        }
      }
    }
    if (game.winner != '') {
      Offset p1, p2;
      switch (game.winningLineType) {
        case GameWinningLineType.row:
          p1 = Offset(0, game.winningLineNumber * h * 1.0 - h / 2);
          p2 = Offset(size.width, game.winningLineNumber * h - h / 2);
          break;
        case GameWinningLineType.column:
          p1 = Offset(game.winningLineNumber * w * 1.0 - w / 2, 0);
          p2 = Offset(game.winningLineNumber * w - w / 2, size.height);
          break;
        case GameWinningLineType.diagonal:
          if (game.winningLineNumber == 1) {
            p1 = const Offset(0, 0);
            p2 = Offset(size.width, size.height);
          } else if (game.winningLineNumber == 2) {
            p1 = Offset(0, size.height);
            p2 = Offset(size.width, 0);
          } else {
            throw 'Not implemented diagonal: ${game.winningLineNumber}';
          }
          break;
        default:
          throw 'Not implemented winningLineType: ${game.winningLineType}';
      }
      canvas.drawLine(p1, p2, _winPaint);
    }
  }

  @override
  bool shouldRepaint(GameFieldPainter oldDelegate) {
    return game != oldDelegate.game;
  }
}
