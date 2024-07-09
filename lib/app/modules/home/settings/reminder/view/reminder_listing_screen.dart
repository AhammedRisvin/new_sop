import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/utils/app_images.dart';

import '../../../../../helpers/app_router.dart';
import '../../../../../helpers/extentions.dart';
import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../../widgets/empty_screen.dart';
import '../view model/reminder_provider.dart';
import '../widget/reminder_details_showing_widget.dart';

class ReminderListingScreen extends StatefulWidget {
  const ReminderListingScreen({super.key});

  @override
  State<ReminderListingScreen> createState() => _ReminderListingScreenState();
}

class _ReminderListingScreenState extends State<ReminderListingScreen> {
  ReminderProvider? provider;
  @override
  void initState() {
    super.initState();
    provider = context.read<ReminderProvider>();
    provider?.loadReminders();
  }

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
            text: "Reminders",
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            CommonInkwell(
              onTap: () {
                context.pushNamed(AppRouter.addReminderScreen);
              },
              child: Container(
                width: 120,
                height: 30,
                decoration: BoxDecoration(
                  color: isDarkModeOn
                      ? AppConstants.transparent
                      : AppConstants.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color:
                        isDarkModeOn ? AppConstants.white : AppConstants.black,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonTextWidget(
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                      text: "Add Reminder",
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizeBoxV(5),
                    Icon(
                      Icons.add,
                      size: 15,
                      color: isDarkModeOn
                          ? AppConstants.commonGold
                          : AppConstants.darkBlue,
                    ),
                  ],
                ),
              ),
            ),
            const SizeBoxV(10)
          ],
        ),
        body: Consumer<ReminderProvider>(builder: (context, snapshot, _) {
          return snapshot.reminderList.isEmpty == true
              ? EmptyScreenWidget(
                  text: "No Reminders Found",
                  image: AppImages.reminderEmpty,
                  height: Responsive.height * 100,
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: snapshot.reminderList.length,
                  itemBuilder: (context, index) {
                    final reminder = snapshot.reminderList[index];
                    return ReminderDetailsShowingWidget(
                      isDarkModeOn: isDarkModeOn,
                      data: reminder,
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) => const SizeBoxH(10),
                );
        }),
      ),
    );
  }
}
