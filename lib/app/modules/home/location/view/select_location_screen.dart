import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/pharma/home/home%20screen/view%20model/theme_provider.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';
import 'package:sophwe_newmodule/app/utils/app_constants.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, bool>(
      selector: (p0, p1) => p1.isDarkModeOn,
      builder: (context, isDarkModeOn, child) => Scaffold(
        backgroundColor: isDarkModeOn ? AppConstants.black : AppConstants.white,
        appBar: AppBar(
          backgroundColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          surfaceTintColor:
              isDarkModeOn ? AppConstants.black : AppConstants.white,
          title: CommonTextWidget(
            color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            text: "Select a location",
            fontSize: 14,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: AppConstants.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppConstants.black10,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 18,
                      color: isDarkModeOn
                          ? const Color(0xFFC1AE97)
                          : AppConstants.black40,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          style: TextStyle(
                              color: isDarkModeOn
                                  ? AppConstants.white
                                  : AppConstants.black),
                          controller: TextEditingController(),
                          onChanged: (content) {},
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search Location',
                            hintStyle: TextStyle(
                              color: AppConstants.tInactive,
                              fontSize: 12,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.my_location,
                  size: 18,
                  color: isDarkModeOn
                      ? const Color(0xFFC1AE97)
                      : const Color(0Xff33705B),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizeBoxH(15),
                    Text(
                      'Use current location',
                      style: TextStyle(
                        color: isDarkModeOn
                            ? Colors.white
                            : const Color(0xFF6A6A6A),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Dubai",
                      style: TextStyle(
                        color: isDarkModeOn ? Colors.white : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizeBoxH(10),
              const Divider(),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Dubai",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: isDarkModeOn
                              ? AppConstants.tInactive
                              : AppConstants.tInactive,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: 3,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
