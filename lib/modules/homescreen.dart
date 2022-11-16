import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictac/component/component.dart';
import 'package:tictac/cubit/cubit.dart';
import 'package:tictac/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicTacCubit()..index(),
      child: BlocConsumer<TicTacCubit, TicTacStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = TicTacCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: primary,
            ),
            backgroundColor: primary,
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  if (cubit.result == "")
                    RichText(
                        text: TextSpan(
                            text: "It's ".toUpperCase(),
                            style: const TextStyle(fontSize: 48),
                            children: [
                          TextSpan(
                              text: "${cubit.xtap} ",
                              style: TextStyle(
                                  fontSize: 48,
                                  color:
                                      cubit.onTap == false && cubit.xtap == "X"
                                          ? second
                                          : fourth)),
                          TextSpan(
                              text: "turn".toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 48, color: Colors.white)),
                        ])),
                  if (cubit.result != "")
                    RichText(
                        text: TextSpan(
                            text: "game ".toUpperCase(),
                            style: const TextStyle(fontSize: 48, color: second),
                            children: [
                          TextSpan(
                              text: "over".toUpperCase(),
                              style:
                                  const TextStyle(fontSize: 48, color: fourth)),
                        ])),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: GridView.count(
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 3,
                      childAspectRatio: 1 / 1.13,
                      children: List.generate(
                          9,
                          (int index) => InkWell(
                                splashColor: Colors.transparent,
                                onTap: cubit.turn == 9 || cubit.change == true
                                    ? null
                                    : () {
                                        // if (cubit.numberOfTap[index].isNotEmpty) {
                                        //   null;
                                        // } else {
                                        cubit.changeTap(index);
                                        cubit.winner(
                                            player: cubit.xtap, index: index);
                                        // }
                                      },
                                child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Card(
                                    color: second,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                      child: Text(
                                        cubit.numberOfTap[index],
                                        style: TextStyle(
                                            fontSize: 50,
                                            color:
                                                cubit.numberOfTap[index] == "X"
                                                    ? primary
                                                    : fourth),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          growable: true),
                    ),
                  ),
                  if (cubit.change == true ||
                      (cubit.change == false && cubit.turn == 9))
                    const SizedBox(
                      height: 20,
                    ),
                  if (cubit.change == true)
                    Text(
                      cubit.result,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  if (cubit.change == false && cubit.turn == 9)
                    Text(
                      cubit.result,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        color: second, borderRadius: BorderRadius.circular(20)),
                    width: double.infinity,
                    height: 70,
                    child: MaterialButton(
                      child: const Text(
                        "Play Again",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        cubit.reset();
                        cubit.result = "";
                        cubit.change = false;
                        cubit.turn = 0;
                        cubit.scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget card(TicTacCubit mel,index) => InkWell(
  //       onTap: () {
  //         mel.changeTap(index);
  //       },
  //       child: Container(
  //         child: Card(
  //           color: second,
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //           child: Center(
  //             child: Text(
  //               mel.noneTap,
  //               style: const TextStyle(fontSize: 30, color: primary),
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
}
