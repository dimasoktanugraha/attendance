import 'package:flutter/material.dart';

Widget locationItem(double lat, double long) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Latitude",
              style: TextStyle(fontSize: 10),
            ),
            (lat.toString().isEmpty) ? const SizedBox(
              height: 12,
              width: 12,
              child: CircularProgressIndicator(
                strokeWidth: 1,),
            ): Text(
              lat.toString(),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                "Longitude",
                style: TextStyle(fontSize: 10)
            ),
            (long.toString().isEmpty) ? const SizedBox(
              height: 12,
              width: 12,
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            ): Text(
                long.toString(),
                style: const TextStyle(fontSize: 12)
            ),
          ],
        ),
        Container()
      ],
    ),
  );
}