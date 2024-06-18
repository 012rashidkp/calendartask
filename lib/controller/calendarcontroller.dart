
import 'package:calendartask/model/task.dart';
import 'package:calendartask/repository/calendarRepository.dart';
import 'package:calendartask/utility/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/datelist.dart';
import '../utility/colors.dart';
final controller=Get.put(CalendarCOntroller());
class CalendarCOntroller extends GetxController{
  RxString title=''.obs;
  RxString time=''.obs;
  RxString timehint='Pick Time'.obs;
  RxString repeat_type=''.obs;
  RxString clicked_date=''.obs;
  RxBool isvalidated=false.obs;
  RxBool dateisclicked=false.obs;
  RxString mytype=''.obs;










  DateTime selectedDate = DateTime.now();

  DateTime todaydate=DateTime.now();



  RxBool selectedcurrentyear = false.obs;





  RxString displaydate=''.obs;

  final repository=CalendarRepository();
  final RxList<Task> alltasks = <Task>[].obs;
  final RxList<Task> alltasksbyid = <Task>[].obs;


  final RxList<String> datelist = <String>[].obs;
  final RxList<Datelist> getdatelist = <Datelist>[].obs;




  void getcurrentdate(){

    displaydate.value= DateFormat('MMMM yyyy').format(selectedDate);



  }

  void previousMonth() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month - 1, 1);

    displaydate.value= DateFormat('MMMM yyyy').format(selectedDate);

  }

  void nextMonth() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month + 1, 1);
      displaydate.value=DateFormat('MMMM yyyy').format(selectedDate);


  }


  DateTime firstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }
  int getNumberOfDays(int month, int year) {
    return DateTime(year, month + 1, 0).day;
  }

  int weekdayOfFirstDay(int month, int year){
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    return firstDayOfMonth.weekday;
  }



  int daysInMonth(int year, int month) {
   return DateTime(year, month + 1, 0).day;
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  int daysInPreviousMonth(int month, int year){
    DateTime firstDayOfMonth = DateTime(year, month, 1);

    DateTime lastDayOfPreviousMonth =
    firstDayOfMonth.subtract(Duration(days: 1));
  return lastDayOfPreviousMonth.day;




  }


  Future<void>addTask({Task? data})async{
    repository.addTask(value: data);
    getAlltasks();

    update();



    // Get.snackbar('success', 'Added successfully',backgroundColor: tealcolor);
  }


  void getAlltasks()async{
    alltasks.clear();
    alltasks.value= await repository.getAlltasks();
    datelist.clear();
    getdatelist.clear();


    for(var data in alltasks){
      List<String>? dateParts = data.date?.split('-');
      int day = int.parse(dateParts![0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);
        if(data.repeat_type==Daily){
          DateTime inputDateTime = DateTime(year, month, day);

          DateTime endOfYear = DateTime(year, 12, 31);
          int remainingDays = endOfYear.difference(inputDateTime).inDays;
          for (int i = 1; i <= remainingDays; i++) {
            datelist.add(getNextday(mydate: data.date??'', dayparam: i));
            getdatelist.add(Datelist(getNextday(mydate: data.date??'', dayparam: i), Daily));
          }

        }
       else if(data.repeat_type==Weekly){

          DateTime givenDate = DateTime(year, month, day);

          DateTime endOfYear = DateTime(2024, 12, 31);

          int remainingDays = endOfYear.difference(givenDate).inDays;

          int remainingWeeks = (remainingDays / 7).ceil();

          for (int i = 1; i <= remainingWeeks; i++) {
            datelist.add(getNextweekday(mydate: data.date??'', weeks:i ));

            getdatelist.add(Datelist(getNextweekday(mydate: data.date??'', weeks:i ), Weekly));

          }

        }
       else if(data.repeat_type==Monthly){
          DateTime now = DateTime.now();

          int remainingmonth = 12 - now.month;
         for (int i = 0; i <= remainingmonth; i++) {
           datelist.add(getNextmonthday(mydate: data.date??'', months:i ));

           getdatelist.add(Datelist(getNextmonthday(mydate: data.date??'', months:i ), Monthly));

         }

        }
      datelist.add(data.date ?? '');
      getdatelist.add(Datelist(data.date, 'All')) ;

    }
    datelist.refresh();
    update();
  }





  void getAlltasksbydate({String? date})async{
    alltasksbyid.value= await repository.getAlltasksbydate(date: date);
    update();
  }
  void getAlltasksbytype({String? type})async{
    alltasksbyid.value= await repository.getAlltasksbytype(type: type);
    update();
  }


  void remove({required int index})async{

    await repository.deletetask(index: index);
    getAlltasks();
    update();
  }
  void updatedata({required int index, required Task data})async{
    await repository.updatedata(index: index, data: data);
    getAlltasks();
    update();
  }

  bool isdateexist({String? date}){
    print('getdate... ${date}');
    bool elementExists = getdatelist.any((number) => number.date == date);
     if(elementExists){
       print('status... true');
       update();
       return true;
     }
     else{
       print('status... false');
       update();
       return false;
     }
  }

  String getrepeat_type({String? date}){
     var myrepeatType='';
    List<String> types = getdatelist
        .where((element) => element.date == date)
        .map((e) => e.type!)
        .toList();

    for (String type in types) {
      myrepeatType=type;
    }
  return myrepeatType;


  }

  void loadhomescreen(){




  }




  String getNextweekday({required String mydate, required int weeks}) {
    List<String> dateParts = mydate.split('-');
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);
    DateTime givenDate = DateTime(year, month, day);
    DateTime nextWeekdayDate = givenDate.add(Duration(days: 7 * weeks));
    while (nextWeekdayDate.weekday >= 6) {
      nextWeekdayDate = nextWeekdayDate.add(Duration(days: 1));
    }
    return '${nextWeekdayDate.day}-${nextWeekdayDate.month}-${nextWeekdayDate.year}';
  }

  String getNextmonthday({required String mydate, required int months}){
    List<String> dateParts = mydate.split('-');

    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);


    DateTime givenDate = DateTime(year, month, day);

    DateTime nextWeekdayDate = givenDate.add(Duration(days: 1));
    while (nextWeekdayDate.weekday >= 6) { // If the day is Saturday (6) or Sunday (7)
      nextWeekdayDate = nextWeekdayDate.add(Duration(days: 1)); // Move to the next day
    }

    DateTime nextMonthDate = givenDate.add(Duration(days: 30 * months));
    while (nextMonthDate.month == month) {
      nextMonthDate = nextMonthDate.add(Duration(days: 1));
    }

    return '${nextMonthDate.day}-${nextMonthDate.month}-${nextMonthDate.year}';

  }

  String getNextday({required String mydate, required int dayparam}){
    List<String> dateParts = mydate.split('-');
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);
    DateTime givenDate = DateTime(year, month, day);
    DateTime nextDayDate = givenDate.add(Duration(days: dayparam));
    return '${nextDayDate.day}-${nextDayDate.month}-${nextDayDate.year}';

}














}