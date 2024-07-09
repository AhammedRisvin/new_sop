import 'package:flutter/material.dart';
import 'package:sophwe_newmodule/app/modules/home/settings/main/model/get_profile_data.dart';

import '../../../../helpers/extentions.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../widgets/common_widgets.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.isDarkModeOn,
    this.data,
  });

  final bool isDarkModeOn;
  final ProfileData? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextWidget(
          color: isDarkModeOn ? AppConstants.white : AppConstants.black,
          text: "Your Profile",
          fontSize: 16,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w700,
        ),
        const SizeBoxH(10),
        Row(
          children: [
            data?.profileImage == "empty"
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      "assets/images/defaultProfPic.png",
                      height: 30,
                      width: 30,
                    ),
                  )
                : CachedImageWidget(
                    imageUrl: data?.profileImage ??
                        "https://t4.ftcdn.net/jpg/04/95/28/65/240_F_495286577_rpsT2Shmr6g81hOhGXALhxWOfx1vOQBa.jpg",
                    height: Responsive.height * 10,
                    width: Responsive.height * 10,
                    borderRadius: BorderRadius.circular(100),
                  ),
            const SizeBoxV(20),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget(
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  text: "ID ${data?.userId?.substring(18).toUpperCase()}",
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                const SizeBoxH(6),
                CommonTextWidget(
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  text: data?.name ?? "",
                  fontSize: 13,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600,
                ),
                const SizeBoxH(6),
                CommonTextWidget(
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  text: data?.email ?? "example@gmail.com",
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ))
          ],
        )
      ],
    );
  }
}
