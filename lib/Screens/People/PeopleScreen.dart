import 'package:flutter/cupertino.dart';


class PeopleScreen extends StatelessWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('People')
      ],
    );
  }
}
