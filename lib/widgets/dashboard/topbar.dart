import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  static const _values = ["CF Cruz Azul", "Monarcas FC"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            "Choose Wisely",
            style: TextStyle(color: Colors.teal, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _values
                .map(
                  (value) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      child: OutlinedButton(
                        child: Column(
                          children: [
                            FlutterLogo(
                              size: MediaQuery.of(context).size.height * .15,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Text(value),
                            )
                          ],
                        ),
                        onPressed: () => Navigator.pop(context, value),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
