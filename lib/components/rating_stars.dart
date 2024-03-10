import 'package:flutter/material.dart';

import 'package:new_trip_start/constants.dart';

class RatingStars extends StatelessWidget {
  const RatingStars(
      {super.key, required this.count, this.size, this.width, this.alignment});
  final double count;
  final double? size;
  final double? width;
  final MainAxisAlignment? alignment;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment ?? MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: width ?? 20,
          child: Icon(
            Icons.star_rounded,
            color: count >= 1 ? kPrimaryColor : kSecondaryColor,
            size: size ?? 25,
          ),
        ),
        SizedBox(
          width: width ?? 20,
          child: Icon(
            count >= 1.5 && count < 2
                ? Icons.star_half_rounded
                : Icons.star_rounded,
            color: count >= 1.5 ? kPrimaryColor : kSecondaryColor,
            size: size ?? 25,
          ),
        ),
        SizedBox(
          width: width ?? 20,
          child: Icon(
            count >= 2.5 && count < 3
                ? Icons.star_half_rounded
                : Icons.star_rounded,
            color: count >= 2.5 ? kPrimaryColor : kSecondaryColor,
            size: size ?? 25,
          ),
        ),
        SizedBox(
          width: width ?? 20,
          child: Icon(
            count >= 3.5 && count < 4
                ? Icons.star_half_rounded
                : Icons.star_rounded,
            color: count >= 3.5 ? kPrimaryColor : kSecondaryColor,
            size: size ?? 25,
          ),
        ),
        SizedBox(
          width: width ?? 20,
          child: Icon(
            count >= 4.5 && count < 5
                ? Icons.star_half_rounded
                : Icons.star_rounded,
            color: count >= 4.5 ? kPrimaryColor : kSecondaryColor,
            size: size ?? 25,
          ),
        ),
      ],
    );
  }
}
