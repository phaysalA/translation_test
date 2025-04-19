import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:translation_test/utilities/responsive_size.dart';
import 'package:translation_test/utilities/utilities.dart';

class OptionsTile extends StatelessWidget {
  const OptionsTile({
    super.key,
    required this.dismiss,
  });

  final VoidCallback dismiss;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 9.rw(context), vertical: 10.rh(context)),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OptionsRow(
            color: Color.fromARGB(255, 130, 130, 130),
            text: 'Cosy areas',
            icon: 'assets/icons/verified.svg',
          ),
          const OptionsRow(
            color: orange,
            text: 'Price',
            icon: 'assets/icons/wallet.svg',
          ),
          const OptionsRow(
            color: Color.fromARGB(255, 130, 130, 130),
            text: 'Infrastructure',
            icon: 'assets/icons/basket.svg',
          ),
          GestureDetector(
            onTap: dismiss,
            child: const OptionsRow(
              color: Color.fromARGB(255, 130, 130, 130),
              text: 'Without any layer',
              icon: 'assets/icons/layers.svg',
            ),
          ),
        ],
      ),
    );
  }
}

class OptionsRow extends StatelessWidget {
  const OptionsRow({
    super.key,
    required this.color,
    required this.text,
    required this.icon,
  });
  final Color color;
  final String text;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.rh(context)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            icon,
            height: 20.rh(context),
            width: 20.rw(context),
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          SizedBox(
            width: 12.rw(context),
          ),
          Text(text, style: TextStyle(fontSize: 13.rf(context), color: color)),
        ],
      ),
    );
  }
}
