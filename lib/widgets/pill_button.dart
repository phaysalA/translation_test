import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:translation_test/utilities/responsive_size.dart';

class PillButton extends StatelessWidget {
  const PillButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 10.rw(context), vertical: 10.rh(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromARGB(255, 130, 130, 130).withOpacity(0.725),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/list.svg',
            height: 20.rh(context),
            width: 20.rw(context),
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          SizedBox(
            width: 12.rw(context),
          ),
          Text('List of variants',
              style: TextStyle(fontSize: 13.rf(context), color: Colors.white)),
        ],
      ),
    );
  }
}
