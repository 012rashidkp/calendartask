
import 'package:calendartask/controller/calendarcontroller.dart';
import 'package:calendartask/model/atributes.dart';
import 'package:calendartask/model/task.dart';
import 'package:calendartask/screens/components/dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../utility/colors.dart';
import '../components/inputfield.dart';

adddialog({
  required BuildContext context,
  required String clickeddate,
  final Function(String)?onchange
}
    ) {
   final List<Attributes> _listitems=[];

   _listitems.clear();
   _listitems.add(Attributes(id: 1,attribute: 'Daily'));
   _listitems.add(Attributes(id: 2,attribute: 'Weekly'));
   _listitems.add(Attributes(id: 3,attribute: 'Monthly'));

  // set up the button
  Widget okButton = TextButton(
    child: const Text(
      "Cancel",
      style: TextStyle(
          color: tealcolor
      ),

    ),
    onPressed: () {
      Navigator.of(context!).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Input Details",textAlign: TextAlign.center,),

    content:  Obx(
          ()=> Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Inputfield(
            hintvalue: 'Enter Title',
            textInputType: TextInputType.text,
            readonly: false,
            onchange: (value){
             // controller.addName(pname: value);
              controller.title.value=value??'';

            },
          ),

          const SizedBox(
            height: 25.0,
          ),

          ElevatedButton(

            style: ElevatedButton.styleFrom(
              primary:bodycolor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),

              ),
              elevation: 0.0,
            ),


              onPressed: () async {
                TimeOfDay selectedtime=TimeOfDay.now();

                final TimeOfDay? timeofday=await showTimePicker(
                    context: context,
                    initialTime: selectedtime
                );

                controller.timehint.value='${timeofday?.hour}:${timeofday?.minute}';
                controller.time.value='${timeofday?.hour}:${timeofday?.minute}';


              }, child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 16.0),
                child: Text(
            '${controller.timehint}',
            style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15.0
            ),
          ),
              ),
          ),


          const SizedBox(
            height: 25.0,
          ),

          Mydropdown(
              items: _listitems,
              hintText: 'Repeat Type',

              onChanged: (value){
                controller.repeat_type.value=value ?? '';
              }
          ),



          const SizedBox(
            height: 35.0,
          ),






          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: controller.title.value.isNotEmpty && controller.time.value.isNotEmpty && controller.repeat_type.value.isNotEmpty ?tealcolor:greytextcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),

                ),
                elevation: 0.0,
              ),
              onPressed: (){




                if(controller.title.value.isNotEmpty&& controller.time.value.isNotEmpty && controller.repeat_type.value.isNotEmpty){



                  Task? datas=Task(controller.title.value, controller.time.value,controller.repeat_type.value,clickeddate);
                  print('creating data... title:${datas.title}, time:${datas.time}, repeattype:${datas.repeat_type}, date:${datas.date}');
                  controller.addTask(data: datas);
                  controller.getAlltasks();
                  controller.update();
                  controller.alltasks.refresh();
                  onchange!('success');



                }





              }, child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 16.0),
            child: Text(
              'Save',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0
              ),
            ),
          )

          )





        ],
      ),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {


      return alert;
    },
  );
}