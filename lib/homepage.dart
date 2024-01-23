import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BrodcastPage extends StatefulWidget {
  const BrodcastPage({super.key});

  @override
  State<BrodcastPage> createState() => _BrodcastPageState();
}

class _BrodcastPageState extends State<BrodcastPage> {
  List<String> messages = [
    'send message',
    'send message with option',
    'Trigger a path'
  ];
  List<String> targetSegments = ['All user'];
  List<String> channels = ['website'];
  List<String> repetationsData = ['Once', 'Daile', 'Weekly', 'Monthly'];
  var selectedRepetion = 'Once';
  var selectedData = 'send message';
  var selectedChannel = 'website';
  var selectedTarget = 'All user';
  var selectedRepition = 'once';
  var date = DateTime.now();

  final _formKey = GlobalKey<FormState>();
  var brodcastName;
  var broadcastMessage;
  Color inoutColor = Color.fromARGB(114, 5, 5, 5);
  var isBold = false;
  var isItalic = false;
  var isUnderLined = false;
  var groupValue = false;
  var selectedTime = '1:00';
  var controller = TextEditingController();
  var brodcastnameController = TextEditingController();
  var brodcastmsgController = TextEditingController();
  List<String> times = [
    '1:00',
    '2:00',
    '3:00',
    '4:00',
    '5:00',
    '6:00',
    '7:00',
    '8:00',
    '9:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
    '21:00',
    '22:00',
    '23:00',
    '24:00'
  ];
  @override
  void initState() {
    // TODO: implement initState
    // generateListTimes();
    var time = DateFormat.Hm().format(date.copyWith(minute: 00));
    selectedTime = time;
    print(time);
    super.initState();
  }

  void generateListTimes() {
    DateTime temp = date;
    DateTime temp2 = date.copyWith(hour: 23, minute: 50);

    var time = DateFormat.Hm().format(date);

    selectedTime = time;
    while (temp.hour <= temp2.hour) {
      var time = DateFormat.Hm().format(date);

      print(time);
      times.add(time);
      DateTime temp3 = temp.copyWith(hour: temp.hour + 1);
      temp = temp3;
    }
  }

  void printjson() {
    brodcastName = brodcastnameController.text;
    broadcastMessage = brodcastnameController.text;
    Map<String, dynamic> m = groupValue
        ? {
            "Brodacst Name": brodcastName,
            "Target Channel": selectedChannel,
            "Brodcat type": selectedData,
            "Brodcast messages": broadcastMessage,
            "Target Segment": targetSegments,
            "Schedules": groupValue,
            "Brpdcast Repetition": selectedRepition,
            "Date": DateFormat.yMMMd().format(date),
            "Time": selectedTime
          }
        : {
            "Brodacst Name": brodcastName,
            "Target Channel": selectedChannel,
            "Brodcat type": selectedData,
            "Brodcast messages": broadcastMessage,
            "Target Segment": targetSegments,
            "Schedules": groupValue,
            "Brpdcast Repetition": null,
            "Date": null,
            "Time": null
          };

    final json = jsonEncode(m);
    print(json);
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              backgroundColor: Colors.black54,
              colorScheme: ColorScheme.light(
                background: Colors.black54,
                onBackground: Colors.black54,
                surface: Colors.black,
                primary: Color.fromARGB(255, 130, 18, 10), // <-- SEE HERE
                onPrimary: Colors.white, // <-- SEE HERE
                onSurface: Colors.white, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.red, // button text color
                ),
              ),
            ),
            child: child!);
      },
      context: context,
      initialDate: date, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != date)
      setState(() {
        date = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    final double hight = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(222, 23, 23, 23),
      appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.fromLTRB(width * 0.25, 5, 0, 5),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: EdgeInsets.fromLTRB(width * 0.3, 5, 0, 5),
            child: Text(
              'Create New Brodcast',
              style: GoogleFonts.openSans().copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          )),
      body: Container(
        margin: EdgeInsets.fromLTRB(width * 0.1, 10, width * 0.1, 0),
        height: hight * 0.9,
        width: width * 0.6,
        child: Column(
          children: [
            Container(
              height: hight * 0.77,
              width: width * 0.6,
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Brodcast Name',
                        style: GoogleFonts.openSans()
                            .copyWith(fontSize: 15, color: Colors.white),
                      ),
                    ),
                    InputDecorator(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: inoutColor,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius: BorderRadius.circular(5.0)),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 1, 10, 1),
                        ),
                        child: TextFormField(
                          controller: brodcastnameController,
                          style: TextStyle(color: Colors.white),
                          onSaved: (newValue) {
                            brodcastName = newValue;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Enter Name',
                            focusColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter some text';
                            }
                            return null;
                          },
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Target Channel',
                        style: GoogleFonts.openSans()
                            .copyWith(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      child: InputDecorator(
                        decoration: InputDecoration(
                          fillColor: inoutColor,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius: BorderRadius.circular(5.0)),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 1, 10, 1),
                        ),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                          hint: Text(
                            'Select',
                            style: GoogleFonts.openSans()
                                .copyWith(fontSize: 12, color: Colors.white),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please fill in the field';
                            }
                            return null;
                          },
                          dropdownColor: Color.fromARGB(222, 23, 23, 23),
                          // isDense: true,

                          onChanged: (value) {
                            setState(() {
                              selectedChannel = value ?? "website";
                            });
                          },
                          items: channels.map((currentData) {
                            return DropdownMenuItem(
                                value: currentData,
                                child: Container(
                                  width: width * 0.54,
                                  height: 40,
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.tv,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        currentData,
                                        style: GoogleFonts.openSans().copyWith(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ));
                          }).toList(),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Brodcast Type',
                        style: GoogleFonts.openSans()
                            .copyWith(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      child: InputDecorator(
                        decoration: InputDecoration(
                          fillColor: inoutColor,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius: BorderRadius.circular(5.0)),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 1, 10, 1),
                        ),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                          dropdownColor: Color.fromARGB(222, 23, 23, 23),
                          // isDense: true,
                          value: selectedData,
                          onChanged: (value) {
                            setState(() {
                              selectedData = value ?? "send message";
                            });
                          },
                          items: messages.map((currentData) {
                            return DropdownMenuItem(
                                value: currentData,
                                child: Container(
                                  width: width * 0.54,
                                  height: 40,
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    currentData,
                                    style: GoogleFonts.openSans().copyWith(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ));
                          }).toList(),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Brodcast Message',
                        style: GoogleFonts.openSans()
                            .copyWith(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10)),
                      height: 240,
                      width: width * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 160,
                            child: InputDecorator(
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'please enter some text';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  setState(() {
                                    broadcastMessage = newValue!;
                                  });
                                },
                                controller: brodcastmsgController,
                                decoration: InputDecoration(
                                  label: Text(
                                    'Type your message here',
                                    style: GoogleFonts.openSans().copyWith(
                                        fontSize: 10,
                                        color: const Color.fromARGB(
                                            255, 183, 182, 182)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: width * 0.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.bolt,
                                      color: Colors.white,
                                      size: 22,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.format_align_justify,
                                      color: Colors.white,
                                      size: 22,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.format_underline,
                                      color: Colors.white,
                                      size: 22,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.link,
                                      color: Colors.white,
                                      size: 22,
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Target Segments',
                        style: GoogleFonts.openSans()
                            .copyWith(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      child: InputDecorator(
                        decoration: InputDecoration(
                          fillColor: inoutColor,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius: BorderRadius.circular(5.0)),
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 1, 10, 1),
                        ),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                          dropdownColor: Color.fromARGB(222, 23, 23, 23),
                          // isDense: true,
                          value: selectedTarget,
                          onChanged: (value) {
                            setState(() {
                              selectedTarget = value ?? "All user";
                            });
                          },
                          items: targetSegments.map((currentData) {
                            return DropdownMenuItem(
                                value: currentData,
                                child: Container(
                                  width: width * 0.54,
                                  height: 40,
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    currentData,
                                    style: GoogleFonts.openSans().copyWith(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ));
                          }).toList(),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Schedules',
                        style: GoogleFonts.openSans()
                            .copyWith(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: width * 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                            width: width * 0.2,
                            child: ListTile(
                              title: Text(
                                'Send Now',
                                style: GoogleFonts.openSans().copyWith(
                                    fontSize: 12, color: Colors.white),
                              ),
                              leading: Radio(
                                activeColor: Color.fromARGB(255, 130, 18, 10),
                                value: false,
                                groupValue: groupValue,
                                onChanged: (value) {
                                  setState(() {
                                    groupValue = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: width * 0.2,
                            child: ListTile(
                              title: Text(
                                'Schedule',
                                style: GoogleFonts.openSans().copyWith(
                                    fontSize: 12, color: Colors.white),
                              ),
                              leading: Radio(
                                activeColor: Color.fromARGB(255, 130, 18, 10),
                                value: true,
                                groupValue: groupValue,
                                onChanged: (value) {
                                  setState(() {
                                    groupValue = value!;
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    groupValue
                        ? Container(
                            height: 280,
                            width: width * 0.6,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Target Segments',
                                      style: GoogleFonts.openSans().copyWith(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                        fillColor: inoutColor,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 2),
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 1, 10, 1),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                        dropdownColor:
                                            Color.fromARGB(222, 23, 23, 23),
                                        // isDense: true,
                                        value: selectedRepetion,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedRepetion = value ?? "Once";
                                          });
                                        },
                                        items:
                                            repetationsData.map((currentData) {
                                          return DropdownMenuItem(
                                              value: currentData,
                                              child: Container(
                                                width: width * 0.54,
                                                height: 40,
                                                padding: EdgeInsets.all(10),
                                                child: Text(
                                                  currentData,
                                                  style: GoogleFonts.openSans()
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                ),
                                              ));
                                        }).toList(),
                                      )),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Date',
                                      style: GoogleFonts.openSans().copyWith(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: inoutColor,
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      height: 50,
                                      width: width * 0.6,
                                      child: ListTile(
                                        trailing: Icon(
                                          Icons.edit_calendar_outlined,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        title: Text(
                                          DateFormat.yMMMd().format(date),
                                          style: GoogleFonts.openSans()
                                              .copyWith(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Time',
                                      style: GoogleFonts.openSans().copyWith(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                        fillColor: inoutColor,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 2),
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 1, 10, 1),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                        dropdownColor:
                                            Color.fromARGB(222, 23, 23, 23),
                                        // isDense: true,
                                        value: selectedTime,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedTime = value ?? "24:00";
                                          });
                                        },
                                        items: times.map((currentData) {
                                          return DropdownMenuItem(
                                              value: currentData,
                                              child: Container(
                                                width: width * 0.54,
                                                height: 40,
                                                padding: EdgeInsets.all(10),
                                                child: Text(
                                                  currentData,
                                                  style: GoogleFonts.openSans()
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                ),
                                              ));
                                        }).toList(),
                                      )),
                                    ),
                                  ),
                                ]),
                          )
                        : Container(
                            height: 0,
                          ),
                  ],
                ),
              ),
            ),
            Divider(),
            SizedBox(
              height: 50,
              width: width * 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: Color.fromARGB(255, 130, 18, 10)),
                    onPressed: () {
                      _formKey.currentState!.validate();
                      printjson();
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 12, 2, 12),
                      child: Text(
                        groupValue ? 'Schedule Brodcast' : 'Publish Broadcast',
                        style: GoogleFonts.openSans()
                            .copyWith(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: Colors.white),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 12, 2, 12),
                      child: Text(
                        'Save Draft',
                        style: GoogleFonts.openSans().copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
