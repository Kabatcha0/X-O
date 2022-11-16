import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictac/cubit/states.dart';

class TicTacCubit extends Cubit<TicTacStates> {
  TicTacCubit() : super(TicTacInitialStates());
  static TicTacCubit get(context) => BlocProvider.of(context);
  String xtap = "X";
  String otap = "O";
  String noneTap = "";
  bool onTap = false;
  int? row;
  int? column;
  int? score;
  List<int> scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];
  int gridSize = 3;
  bool change = false;
  String result = "";
  int turn = 0;
  void winner({required String player, required int index}) {
    row = index ~/ 3;
    column = index % 3;
    score = player == "X" ? 1 : -1;
    turn++;
    scoreBoard[row!] += score!;
    scoreBoard[gridSize + column!] += score!;
    if (row == column) {
      scoreBoard[2 * gridSize] += score!;
    }
    if (gridSize - 1 - column! == row) {
      scoreBoard[2 * gridSize + 1] += score!;
    }
    if (scoreBoard.contains(3) || scoreBoard.contains(-3)) {
      change = true;
    } else {
      change = false;
    }
    if (change == true) {
      if (player == "X") {
        result = "O is the winner".toUpperCase();
      } else if (player == "O") {
        result = "X is the winner".toUpperCase();
      }
    } else if (change == false && turn == 9) {
      result = "Draw".toUpperCase();
    }
    emit(TicTacWinner());
  }

  List<String> numberOfTap = [];
  void index() {
    numberOfTap = List.generate(9, (index) => noneTap);
    emit(TicTacIndex());
  }

  void changeTap(int i) {
    if (onTap == false && numberOfTap[i] == "") {
      numberOfTap[i] = xtap;
      xtap = "O";
      onTap = !onTap;
    } else if (onTap == true && numberOfTap[i] == "") {
      numberOfTap[i] = otap;
      xtap = "X";
      onTap = !onTap;
    }
    emit(TicTacNone());
  }

  void reset() {
    numberOfTap = List.generate(9, (index) => noneTap);
    emit(TicTacReset());
  }
}
