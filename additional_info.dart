import 'package:flutter/material.dart';

class Additionalinfoitem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const Additionalinfoitem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          child: Column(
            children: [
              Icon(
                icon,
                size: 50,
              ),
              Text(
                label,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
              Text(
                value,
                style: const TextStyle(fontSize: 15),
              )
            ],
          ),
        ),
        // SizedBox(
        //   width: 22,
        // ),
        // SizedBox(
        //   child: Column(
        //     children: [
        //       Icon(
        //         Icons.wind_power,
        //         size: 70,
        //       ),
        //       Text(
        //         'Wind Speed',
        //         style: TextStyle(
        //             fontWeight: FontWeight.w400, fontSize: 25),
        //       ),
        //       Text(
        //         '300',
        //         style: TextStyle(fontSize: 20),
        //       )
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   width: 22,
        // ),
        // SizedBox(
        // child: Column(
        //   children: [
        //     Icon(
        //       Icons.umbrella_sharp,
        //       size: 70,
        //     ),
        //     Text(
        //       'Pressure',
        //       style: TextStyle(
        //           fontWeight: FontWeight.w400, fontSize: 25),
        //     ),
        //     Text(
        //       '300',
        //       style: TextStyle(fontSize: 20),
        //     )
        //   ],
        // ),
        // ),
      ],
    );
  }
}
