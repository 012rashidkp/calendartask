
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controller/calendarcontroller.dart';
import '../utility/colors.dart';
import 'dialog/createdialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getcurrentdate();
    controller.getAlltasks();
    final mwidth=MediaQuery.of(context).size.width;
    final mheight=MediaQuery.of(context).size.height;
  print('getnextmonthday.. ${controller.getNextmonthday(mydate: '28-5-2024', months: 1)}');



    return Scaffold(
      backgroundColor: bodycolor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: tealcolor,
        title: const Text(
          'Calendar App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: tealcolor,
          child: Icon(Icons.add),
          onPressed: (){
            controller.timehint.value='Pick Time';
            controller.title.value='';
            controller.repeat_type.value='';
            controller.time.value='';
if(controller.clicked_date!=''){
  adddialog(
      context: context,
      clickeddate: '${controller.clicked_date.value}-${controller.selectedDate.month}-${controller.selectedDate.year}',
      onchange: (value){
        controller.getAlltasks();
        controller.clicked_date.value='';
        print('myvalue.. ${value}');

        if(value=='success'){
          controller.getAlltasks();

          Navigator.pop(context);
        }




      }
  );
}
else{
  var snackBar = SnackBar(
      content: Text('please choose date'),
    backgroundColor: tealcolor,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}



          }
      ),


      body:  Material(
          color: bodycolor,
          child: Obx(
            ()=> Container(
              width: mwidth,
              height: mheight,
              margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),

              child:    Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     SizedBox(
                      height: mheight*0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: (){
                            controller.previousMonth();
                            controller.getAlltasks();
                            controller.clicked_date.value='';





                          },
                        ),
                        Text(
                          '${controller.displaydate.value}',
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),

                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          onPressed: (){
                            controller.nextMonth();
                            controller.getAlltasks();
                            controller.clicked_date.value='';


                          },
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildWeekDay('Mon'),
                          _buildWeekDay('Tue'),
                          _buildWeekDay('Wed'),
                          _buildWeekDay('Thu'),
                          _buildWeekDay('Fri'),
                          _buildWeekDay('Sat'),
                          _buildWeekDay('Sun'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: mheight*0.41,
                      child: _gridviewcontent()
                    ),
                     SizedBox(
                       height: mheight*0.01,
                     ),
                    Text(
                        controller.clicked_date!=''?
                        'Date : ${controller.clicked_date.value}-${controller.selectedDate.month}-${controller.selectedDate.year}'
                         :''
                    ),


                     SizedBox(
                      height: mheight*0.01,
                    ),
                    Container(
                      height: mheight*0.25,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.alltasksbyid.length,
                        itemBuilder: (BuildContext context,int index){
                          final datas =controller.alltasksbyid.value[index];
                          return  Card(
                            color: tealcolor,
                            margin: EdgeInsets.only(top: 15.0),
                            shape: RoundedRectangleBorder(
                                borderRadius:BorderRadius.circular(12.0)
                            ),
                            child:  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${datas?.title}',
                                    style: const TextStyle(color: Colors.white,fontSize: 16.0),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [



                                      Text(
                                          '${datas.time} ${datas.time}',
                                        style: TextStyle(color: Colors.white),
                                      )

                                    ],
                                  ),

                                ],
                              ),
                            ),

                          );

                        },

                      ),
                    )

                  ]
              ),
            ),
          ),


        ),


    );
  }


  Widget _buildWeekDay(String day) {

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Text(
        day,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );



  }

  Widget  _gridviewcontent() {
controller.getAlltasks();
    return GridView.builder(
     padding: EdgeInsets.zero,
     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
       childAspectRatio: 0.8,
),
itemCount: controller.daysInMonth(controller.selectedDate.year, controller.selectedDate.month)+controller.weekdayOfFirstDay(controller.selectedDate.month, controller.selectedDate.year)-1,
itemBuilder: (context,index){
if (index < controller.weekdayOfFirstDay(controller.selectedDate.month, controller.selectedDate.year) - 1) {

int previousMonthDay = controller.daysInPreviousMonth(controller.selectedDate.month,controller.selectedDate.year) - (controller.weekdayOfFirstDay(controller.selectedDate.month, controller.selectedDate.year) - index) + 2;
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




}else{


DateTime date = DateTime(controller.selectedDate.year, controller.selectedDate.month, index - (controller.weekdayOfFirstDay(controller.selectedDate.month, controller.selectedDate.year)) + 2);
String text = date.day.toString();
return GestureDetector(
onTap: (){
  controller.clicked_date.value=text;
  controller.mytype.value=controller.getrepeat_type(date:'${text}-${controller.selectedDate.month}-${controller.selectedDate.year}');
  if(controller.mytype.value=='All'){

    controller.getAlltasksbydate(date: '${text}-${controller.selectedDate.month}-${controller.selectedDate.year}');

  }
  else{
    controller.getAlltasksbytype(type: controller.mytype.value);

  }





},
child: controller.clicked_date.value==text ?Container(
decoration:  const BoxDecoration(
border: Border(
top: BorderSide(width: 2.0, color: tealcolor),
left: BorderSide(width: 2.0, color: tealcolor),
right: BorderSide(width: 2.0, color: tealcolor),
bottom: BorderSide(width: 2.0, color: tealcolor),
),

),
alignment: Alignment.center,
child: Text(
text.toString(),
style: const TextStyle(
color: tealcolor,
fontSize: 15.0,
fontWeight: FontWeight.bold
),
),

):

'${controller.todaydate.day}-${controller.todaydate.month}-${controller.todaydate.year}'=='${date.day.toString()}-${controller.selectedDate.month}-${controller.selectedDate.year}'
?Container(
decoration: const BoxDecoration(


border: Border(
top: BorderSide.none,
left: BorderSide(width: 1.0, color: tealcolor),
right: BorderSide(width: 1.0, color: tealcolor),
bottom: BorderSide(width: 1.0, color: tealcolor),
),
color: tealcolor

),
alignment: Alignment.center,
child: Text(
text.toString(),
style: TextStyle(color: Colors.white),
),

):
controller.isdateexist(date: '${text}-${controller.selectedDate.month}-${controller.selectedDate.year}') ?
Container(
decoration:  const BoxDecoration(
border: Border(
top: BorderSide(width: 2.0, color: tealcolor),
left: BorderSide(width: 2.0, color: tealcolor),
right: BorderSide(width: 2.0, color: tealcolor),
bottom: BorderSide(width: 2.0, color: tealcolor),
),

),
alignment: Alignment.center,
child: Column(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Text(
text.toString(),
style: const TextStyle(
color: tealcolor,
fontSize: 15.0,
fontWeight: FontWeight.bold
),
),
Container(
height: 10.0,
width: 10.0,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(25.0),
color: tealcolor
),
)
],
),

):
Container(
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
text.toString(),
style: TextStyle(color: black),
),






),
);




}






},


);




  }


}
