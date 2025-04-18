import 'package:flutter/material.dart';
import 'package:translation_test/utilities.dart';
import 'package:translation_test/utilities/responsive_size.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CircleAvatar(
        radius: 20.rw(context),
        backgroundColor: orangeDark,
        child: Image.asset(
          'assets/images/profile.png',
          fit: BoxFit.contain,
          height: 39.rh(context),
          width: 39.rw(context),
        ),
      ),
    );
  }
}
