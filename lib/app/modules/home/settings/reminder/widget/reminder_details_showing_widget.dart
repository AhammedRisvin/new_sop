import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/extentions.dart';
import '../../../../../helpers/size_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../widgets/common_widgets.dart';
import '../model/reminder_model.dart';
import '../view model/reminder_provider.dart';

class ReminderDetailsShowingWidget extends StatefulWidget {
  const ReminderDetailsShowingWidget({
    super.key,
    required this.isDarkModeOn,
    required this.data,
    required this.index,
  });

  final bool isDarkModeOn;
  final Reminder data;
  final int index;

  @override
  State<ReminderDetailsShowingWidget> createState() =>
      _ReminderDetailsShowingWidgetState();
}

class _ReminderDetailsShowingWidgetState
    extends State<ReminderDetailsShowingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width * 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppConstants.transparent,
        border: Border.all(
          color: AppConstants.black10,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                "assets/icons/reminderIcon.png",
                height: 50,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: CommonTextWidget(
                    align: TextAlign.start,
                    color: widget.isDarkModeOn
                        ? AppConstants.white
                        : AppConstants.black,
                    text: widget.data.title,
                    fontSize: 12,
                    maxLines: 2,
                    overFlow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              CommonInkwell(
                onTap: () {
                  context.read<ReminderProvider>().deleteReminder(
                        widget.index,
                      );
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffe8391c).withOpacity(0.2),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.delete_rounded,
                      color: Color(0xffe8391c),
                      size: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizeBoxH(10),
          CommonTextWidget(
            align: TextAlign.start,
            color: widget.isDarkModeOn
                ? AppConstants.black40
                : AppConstants.black40,
            text: widget.data.description,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          const SizeBoxH(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/icons/clockIcon.png",
                    height: 20,
                    color: AppConstants.commonGold,
                  ),
                  const SizeBoxV(5),
                  CommonTextWidget(
                    color: widget.isDarkModeOn
                        ? AppConstants.white
                        : AppConstants.black,
                    text: widget.data.time,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              Row(
                children: [
                  CommonTextWidget(
                    color: widget.isDarkModeOn
                        ? AppConstants.white
                        : AppConstants.black,
                    text: widget.data.date,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizeBoxV(5),
                  Image.asset(
                    "assets/icons/calenderIcon.png",
                    height: 20,
                    color: AppConstants.commonGold,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
