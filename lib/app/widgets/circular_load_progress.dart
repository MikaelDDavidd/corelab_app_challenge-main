import 'package:flutter/material.dart';
import 'package:logger/logger.dart';


class CircularLoadProgress extends StatelessWidget {
  final ValueNotifier<bool> state;
  final ValueNotifier<String> error;
  final ValueNotifier <List> data;
  final Widget itsChild;
  const CircularLoadProgress({
    super.key,
    required this.state,
    required this.data,
    required this.error,
    required this.itsChild,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([state, error, data]),
        builder: (context, child) {
          if (state.value) {
            return const Center(child:  CircularProgressIndicator());
          }

          if (error.value.isNotEmpty) {
            return Center(
              child: Text(
                error.value,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (data.value.isEmpty) {
            Logger().d('empity');
            return const Center(
              child: Text(
                'Nenhum Item na Lista',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return itsChild;
          }
        });
  }
}
