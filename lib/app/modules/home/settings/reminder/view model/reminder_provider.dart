// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sophwe_newmodule/app/modules/widgets/common_widgets.dart';
import 'package:sophwe_newmodule/app/utils/app_constants.dart';
import 'package:sophwe_newmodule/background_nt.dart';

import '../model/reminder_model.dart';

class ReminderProvider extends ChangeNotifier {
  String selectedDate = '';
  String selectedTime = '';
  String time2 = '';
  DateTime? reminderDate;

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2500),
    );
    reminderDate = picked;
    if (picked != null) {
      selectedDate = "${picked.day}/${picked.month}/${picked.year}";
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(FocusNode());
      notifyListeners();
    }
  }

  void selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      selectedTime = picked.format(context);
      time2 =
          "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(FocusNode());
      notifyListeners();
    }
  }

  // REMINDER CHECKBOX
  bool isRepeat = false;
  void toggleRepeat() {
    isRepeat = !isRepeat;
    notifyListeners();
  }

  // -----------ADD REMINDER USING HIVE------------- //
  Future<void> saveReminder({
    required String title,
    required String description,
    required BuildContext context,
  }) async {
    debugPrint(
        "saveReminder called with title: $title, description: $description");

    if (title.isEmpty) {
      debugPrint("Title is empty");
      toast(context, title: "Title is Empty");
    } else if (description.isEmpty) {
      debugPrint("Description is empty");
      toast(context, title: "Description is Empty");
    } else if (selectedDate.isEmpty) {
      debugPrint("Date not selected");
      toast(context, title: "Please select Date");
    } else if (selectedTime.isEmpty) {
      debugPrint("Time not selected");
      toast(context, title: "Please select Time");
    } else {
      try {
        debugPrint("All fields filled, attempting to save reminder");
        var box = await Hive.openBox<Reminder>('remindersBox');
        final reminder = Reminder(
          title: title,
          description: description,
          date: selectedDate,
          time: selectedTime,
          id: (DateTime.now().millisecondsSinceEpoch % 2147483647).toString(),
        );
        int success = await box.add(reminder);
        debugPrint("Reminder added to Hive box. Success: $success");

        await loadReminders();

        final hours = int.parse(time2.split(":")[0]);
        final minutes =
            time2.split(":").length > 1 ? int.parse(time2.split(":")[1]) : 0;
        DateTime reminderTime = DateTime(
          reminderDate!.year,
          reminderDate!.month,
          reminderDate!.day,
          hours,
          minutes,
        );
        debugPrint("Scheduling reminder for: ${reminderTime.toString()}");

        await BackgroundNt().scheduleReminder(
          title: title,
          body: description,
          reminderDate: reminderTime,
          isRepeat: isRepeat,
        );
        debugPrint("Reminder scheduled");

        context.pop();
        toast(
          context,
          title: "Reminder saved successfully",
          backgroundColor: AppConstants.stepperGreen,
        );
        selectedDate = '';
        selectedTime = '';
        isRepeat = false;
        notifyListeners();
        debugPrint("Reminder process completed successfully");
      } catch (e) {
        debugPrint("Error saving reminder: $e");
        toast(context, title: "Failed to save reminder");
      }
    }
  }

  // ----------- REMINDER LIST ------------- //
  List<Reminder> reminderList = [];

  Future<void> loadReminders() async {
    var box = await Hive.openBox<Reminder>('remindersBox');
    reminderList.clear();
    reminderList.addAll(box.values.toList());
    notifyListeners();
  }

  Future<void> deleteReminder(int index) async {
    var box = await Hive.openBox<Reminder>('remindersBox');
    box.deleteAt(index);
    loadReminders();
  }
}
