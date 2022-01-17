import 'package:flutter/material.dart';
import 'package:volt/presentation/shared/shared.dart';

class Oops extends StatelessWidget {
  final String message;
  const Oops({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
         height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
             const CustomSpacer(
            flex: 7,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                )),
          ),
          const CustomSpacer(
            flex: 10,
          ),
            EmptyContainer(message: message),
          ],
        ),
      ),
    );
  }
}

