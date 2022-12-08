import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_trip_start/components/app_text.dart';
import 'package:new_trip_start/components/custom_spacer.dart';
import 'package:new_trip_start/components/custom_surfix_icon.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.prefixIcon,
    required this.text,
    this.showsuffixIcon,
    this.onPress,
  });
  final Widget prefixIcon;
  final String text;
  final bool? showsuffixIcon;
  final VoidCallback? onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        height: 60,
        decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: const Color(0xFFD3D3D3)),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Row(
          children: [
            Expanded(child: prefixIcon),
            const CustomSpacer(spaceValue: 10),
            Expanded(
              flex: 6,
              child: AppText(text: text),
            ),
            showsuffixIcon != null
                ? const Expanded(child: Icon(CupertinoIcons.chevron_forward))
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
