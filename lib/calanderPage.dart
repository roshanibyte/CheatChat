import 'package:flutter/material.dart';

class CalanderPage extends StatefulWidget {
  const CalanderPage({super.key});

  @override
  State<CalanderPage> createState() => _CalanderPageState();
}

class _CalanderPageState extends State<CalanderPage> {
  bool toggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: toggle == true ? Colors.white : Colors.black,
      body: Center(
        child: IconButton(
          onPressed: () async {
            setState(() {
              toggle = !toggle;
            });
            final daterange = await showDateRangePicker(
              context: context,
              firstDate: DateTime(2021),
              lastDate: DateTime.now(),
              initialDateRange: DateTimeRange(
                start: DateTime.now(), end: DateTime.now(),
                // start: controller.fromDate.value,
                // end: controller.toDate.value,
              ),
              builder: (context, child) {
                return Theme(
                  data: toggle == true ? ThemeData.light() : ThemeData.dark(),
                  child: Center(
                    child: SizedBox(
                      height: 500,
                      width: 400,
                      child: child!,
                    ),
                  ),
                );
              },
              saveText: "Select",
            );

            //  if (daterange != null) {
            //   controller.fromDate.value = daterange.start;
            //   controller.toDate.value = daterange.end;
            //   controller.initFunction(1);
            // }
          },
          icon: Icon(
            Icons.calendar_month,
            size: 30,
            color: toggle == true ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
