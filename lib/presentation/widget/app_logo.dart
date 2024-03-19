import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_task_manager/presentation/utils/assets_path.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetsPath.logoSvg,
      width: 120,
      fit: BoxFit.scaleDown,
    );
  }
}
