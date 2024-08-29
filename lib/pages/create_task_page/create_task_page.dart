import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/pages/login_page/widgets/widgets.dart';
import 'package:task_app/repositories/sizes/custom_padding.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  DateTime time = DateTime.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  bool switchValue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать задачу'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Название', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 40, child: TextField()),
              10.ph,
              const Text('Описание', style: TextStyle(fontSize: 18)),
              10.ph,
              const SizedBox(height: 40, child: TextField()),
              10.ph,
              Row(
                children: [
                  const Text(
                    'Включить напоминание',
                    style: TextStyle(fontSize: 18),
                  ),
                  Switch(
                    activeColor: const Color.fromRGBO(38, 136, 235, 1),
                    value: switchValue,
                    onChanged: (value) {
                      setState(() {
                        switchValue = value;
                      });
                    },
                  )
                ],
              ),
              2.ph,
              const Text('День', style: TextStyle(fontSize: 18)),
              SizedBox(
                height: 40,
                child: TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    hintText: '_ _._ _._ _ _ _',
                    suffixIcon: Icon(Icons.calendar_month),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      var formatedDate =
                          "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                      setState(() {
                        dateController.text = formatedDate;
                      });
                    }
                  },
                ),
              ),
              20.ph,
              const Text('Время', style: TextStyle(fontSize: 18)),
              SizedBox(
                height: 40,
                child: TextFormField(
                  controller: timeController,
                  decoration: const InputDecoration(
                    hintText: '_ _._ _._ _ _ _',
                    suffixIcon: Icon(Icons.access_time),
                  ),
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (pickedTime != null) {
                      var formatedTime =
                          "${pickedTime.hour}-${pickedTime.minute}";
                      setState(() {
                        timeController.text = formatedTime;
                      });
                    }
                  },
                ),
              ),
              360.ph,
              GamaTextButton(
                text: 'Создать',
                color: const Color.fromRGBO(38, 136, 235, 1),
                onTap: () => context.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
