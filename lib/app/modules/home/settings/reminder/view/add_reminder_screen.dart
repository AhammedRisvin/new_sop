import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sophwe_newmodule/app/helpers/extentions.dart';
import 'package:sophwe_newmodule/app/helpers/size_box.dart';
import 'package:sophwe_newmodule/app/modules/home/settings/reminder/view%20model/reminder_provider.dart';

import '../../../../../utils/app_constants.dart';
import '../../../../pharma/home/home screen/view model/theme_provider.dart';
import '../../../../widgets/common_widgets.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
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
          title: CommonTextWidget(
            color: isDarkModeOn ? AppConstants.white : AppConstants.black,
            text: "Add Reminder",
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
            TextButton(
              onPressed: () {
                context.read<ReminderProvider>().saveReminder(
                      title: titleController.text,
                      description: descriptionController.text,
                      context: context,
                    );
              },
              child: CommonTextWidget(
                color: isDarkModeOn
                    ? AppConstants.commonGold
                    : AppConstants.darkBlue,
                text: "Save",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizeBoxV(5)
          ],
        ),
        body: Consumer<ReminderProvider>(
          builder: (context, provider, child) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget(
                  color: isDarkModeOn
                      ? AppConstants.commonGold
                      : AppConstants.darkBlue,
                  text: "Tittle",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SizeBoxH(10),
                CommonTextFormField(
                  bgColor: AppConstants.transparent,
                  hintText: 'Enter Title',
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  controller: titleController,
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  borderColor:
                      isDarkModeOn ? AppConstants.white : AppConstants.black10,
                ),
                const SizeBoxH(20),
                CommonTextWidget(
                  color: isDarkModeOn
                      ? AppConstants.commonGold
                      : AppConstants.darkBlue,
                  text: "Description",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SizeBoxH(10),
                CommonTextFormField(
                  bgColor: AppConstants.transparent,
                  hintText: 'Enter Description',
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  controller: descriptionController,
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  borderColor:
                      isDarkModeOn ? AppConstants.white : AppConstants.black10,
                ),
                const SizeBoxH(20),
                CommonTextWidget(
                  color: isDarkModeOn
                      ? AppConstants.commonGold
                      : AppConstants.darkBlue,
                  text: "Date",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SizeBoxH(10),
                CommonInkwell(
                  onTap: () {
                    provider.selectDate(context);
                  },
                  child: Container(
                    height: Responsive.height * 6,
                    width: Responsive.width * 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppConstants.black10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        CommonTextWidget(
                          color: isDarkModeOn
                              ? provider.selectedDate == ""
                                  ? AppConstants.black40
                                  : AppConstants.white
                              : provider.selectedDate == ""
                                  ? AppConstants.black40
                                  : AppConstants.black,
                          text: provider.selectedDate == ""
                              ? "Select Date"
                              : provider.selectedDate,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        const Spacer(),
                        Image.asset(
                          "assets/icons/calenderIcon.png",
                          height: 20,
                          color: isDarkModeOn
                              ? AppConstants.commonGold
                              : AppConstants.darkBlue,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizeBoxH(20),
                CommonTextWidget(
                  color: isDarkModeOn
                      ? AppConstants.commonGold
                      : AppConstants.darkBlue,
                  text: "Time",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SizeBoxH(10),
                CommonInkwell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    provider.selectTime(context);
                  },
                  child: Container(
                    height: Responsive.height * 6,
                    width: Responsive.width * 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppConstants.black10,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        CommonTextWidget(
                          color: isDarkModeOn
                              ? provider.selectedTime == ""
                                  ? AppConstants.black40
                                  : AppConstants.white
                              : provider.selectedTime == ""
                                  ? AppConstants.black40
                                  : AppConstants.black,
                          text: provider.selectedTime == ""
                              ? "Select Time"
                              : provider.selectedTime,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        const Spacer(),
                        Image.asset(
                          "assets/icons/clockIcon.png",
                          height: 20,
                          color: isDarkModeOn
                              ? AppConstants.commonGold
                              : AppConstants.darkBlue,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizeBoxH(20),
                CommonTextWidget(
                  color: isDarkModeOn ? AppConstants.white : AppConstants.black,
                  text: "Repeat",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                Transform.scale(
                  scale: 1.5,
                  child: Checkbox(
                    value: provider.isRepeat,
                    onChanged: (value) {
                      provider.toggleRepeat();
                    },
                    activeColor: isDarkModeOn
                        ? AppConstants.commonGold
                        : AppConstants.darkBlue,
                    side: BorderSide(
                      color: isDarkModeOn
                          ? AppConstants.white
                          : AppConstants.black,
                    ),
                    checkColor:
                        isDarkModeOn ? AppConstants.black : AppConstants.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
