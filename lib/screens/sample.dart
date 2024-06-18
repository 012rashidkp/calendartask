import 'package:calendartask/controller/calendarcontroller.dart';
import 'package:calendartask/screens/dialog/createdialog.dart';
import 'package:calendartask/utility/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../model/datelist.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mwidth=MediaQuery.of(context).size.width;
    final mheight=MediaQuery.of(context).size.height;

    controller.getcurrentdate();
    controller.getAlltasks();





    return Scaffold(
      backgroundColor: bodycolor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: tealcolor,
        title: const Text(
          'Calendar App',
          style: TextStyle(color: Colors.white,fontSize: 16.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: tealcolor,
          child: Icon(Icons.add),
          onPressed: (){
            // controller.timehint.value='Pick Time';
            // controller.title.value='';
            // controller.repeat_type.value='';
            // controller.time.value='';

            adddialog(
                context: context,
                clickeddate: controller.clicked_date.value,
                onchange: (value){
                  print('myvalue.. ${value}');
                  controller.getAlltasks();
                  Navigator.pop(context);

                }
            );

          }
      ),


      body:  Material(
        color: bodycolor,
        child: Obx(
              ()=> Container(
              width: mwidth,
              height: mheight,
              margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            // Moves to the previous page if the current page index is greater than 0

                          },
                        ),
                        // Displays the name of the current month
                        Text(
                          '${DateFormat('MMMM').format(controller.selectedDate)}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        // DropdownButton<int>(
                        //   // Dropdown for selecting a year
                        //   value: controller.currentMonth.year,
                        //   onChanged: (int? year) {
                        //     if (year != null) {
                        //       // Sets the current month to January of the selected year
                        //       controller.currentMonth = DateTime(year, 1, 1);
                        //
                        //       // Calculates the month index based on the selected year and sets the page
                        //       int yearDiff = DateTime
                        //           .now()
                        //           .year - year;
                        //       int monthIndex = 12 * yearDiff + controller.currentMonth.month - 1;
                        //       controller.pageController.jumpToPage(monthIndex);
                        //     }
                        //   },
                        //   items: [
                        //     // Generates DropdownMenuItems for a range of years from current year to 10 years ahead
                        //     for (int year = DateTime.now().year;
                        //     year <= DateTime.now().year + 10;
                        //     year++)
                        //       DropdownMenuItem<int>(
                        //         value: year,
                        //         child: Text(year.toString()),
                        //       ),
                        //   ],
                        // ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            // Moves to the next page if it's not the last month of the year
                            // if (!isLastMonthOfYear) {
                            //
                            //   controller.pageController.nextPage(
                            //     duration: Duration(milliseconds: 300),
                            //     curve: Curves.easeInOut,
                            //   );
                            //
                            // }
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildWeekDay('Mon'),
                        buildWeekDay('Tue'),
                        buildWeekDay('Wed'),
                        buildWeekDay('Thu'),
                        buildWeekDay('Fri'),
                        buildWeekDay('Sat'),
                        buildWeekDay('Sun'),
                      ],
                    ),
                  ),




                ],
              )
          ),
        ),


      ),


    );
  }



  Widget buildWeekDay(String day) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Text(
        day,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget buildCalendar(DateTime month) {
    // Calculating various details for the month's display
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);
    int weekdayOfFirstDay = firstDayOfMonth.weekday;

    DateTime lastDayOfPreviousMonth =
    firstDayOfMonth.subtract(Duration(days: 1));
    int daysInPreviousMonth = lastDayOfPreviousMonth.day;

    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 0.4,
      ),
      // Calculating the total number of cells required in the grid
      itemCount: daysInMonth + weekdayOfFirstDay - 1,
      itemBuilder: (context, index) {
        if (index < weekdayOfFirstDay - 1) {
          // Displaying dates from the previous month in grey
          int previousMonthDay =
              daysInPreviousMonth - (weekdayOfFirstDay - index) + 2;
          return Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide.none,
                left: BorderSide(width: 1.0, color: Colors.grey),
                right: BorderSide(width: 1.0, color: Colors.grey),
                bottom: BorderSide(width: 1.0, color: Colors.grey),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              previousMonthDay.toString(),
              style: TextStyle(color: Colors.grey),
            ),
          );
        } else {
          // Displaying the current month's days
          DateTime date = DateTime(month.year, month.month, index - weekdayOfFirstDay + 2);
          String text = date.day.toString();

          return InkWell(
            onTap: () {
              // Handle tap on a date cell
              // This is where you can add functionality when a date is tapped
            },
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide.none,
                  left: BorderSide(width: 1.0, color: Colors.grey),
                  right: BorderSide(width: 1.0, color: Colors.grey),
                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        text,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: SizedBox(
                      child: Image.network(
                        'https://via.placeholder.com/150', // Sample image URL
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(left: 3.0, right: 3.0),
                      child: Text(
                        'Sample Text', // Sample text
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 127, 126, 126),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}