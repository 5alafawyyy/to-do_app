/*
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:todo_updated/modules/archived_tasks/archived_tasks.dart';
import 'package:todo_updated/modules/done_tasks/done.dart';
import 'package:todo_updated/modules/tasks/tasks.dart';
import 'package:todo_updated/shared/components/components.dart';
import 'package:todo_updated/shared/components/constants.dart';
*/

/*
class home_layout extends StatefulWidget {

  @override
  State<home_layout> createState() => _tasksState();
}
*/
/*
class _tasksState extends State<home_layout> {
  int currentIndex = 0;

  List<Widget> screens =
  [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),

  ];

  List<String> titles =
  [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',

  ];

   late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
   bool isShowBottomSheet = false;
   IconData fabIcon = Icons.edit;

   var titleController = TextEditingController();
   var timeController = TextEditingController();
   var dateController = TextEditingController();






  @override
  void initState() {
    super.initState();

    createDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          titles[currentIndex],
        ),
      ),
     body: ConditionalBuilder(
       condition: tasks.length > 0,
       builder: (context) => screens[currentIndex],
       fallback: (context) => Center(child: CircularProgressIndicator()),
     ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          if(isShowBottomSheet) {
            if(formKey.currentState!.validate())
            {
              insertToDatabase(
                titleController.text,
                dateController.text,
                timeController.text,
              ).then((value) =>
              {
                GetDataFromDatabase(database).then((value)
              {
              Navigator.pop(context);
              setState(()
              {
                isShowBottomSheet = false;
                fabIcon = Icons.edit;

                tasks = value;
                print(tasks);
                });
              })
              });
            }
          }else{
            scaffoldKey.currentState!.showBottomSheet(
                  (context) => Container(
                  color: Colors.blue[50],
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        defaultFormField(controller: titleController,
                            type: TextInputType.text,
                            autofocus: true,
                            showCursor: true,
                            readOnly: false,
                            validate: (value)
                            {
                              if(value.isEmpty){
                                return 'Title must not be empty';
                              }
                              return null;
                            },
                            label: 'Task Title',
                            prefix: Icons.title,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: timeController,
                          type: TextInputType.datetime,
                          onTap: (){
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value)
                            {
                              timeController.text = value!.format(context).toString();
                              print(value.format(context));
                            }
                            );
                          },
                          validate: (value)
                          {
                            if(value.isEmpty){
                              return 'Time must not be empty';
                            }
                            return null;
                          },
                          label: 'Task Time',
                          prefix: Icons.watch_later_outlined,

                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: dateController,
                          type: TextInputType.datetime,
                          onTap: (){
                            showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2022-03-15'),
                            ).then((value) {
                              dateController.text = DateFormat.yMMMd().format(value!).toString();
                              print(DateFormat.yMMMd().format(value));
                            });
                          },
                          validate: (value)
                          {
                            if(value.isEmpty){
                              return 'Date must not be empty';
                            }
                            return null;
                          },
                          label: 'Task Date',
                          prefix: Icons.calendar_today,

                        ),

                      ],
                    ),
                  ),
                ),
              elevation: 20.0,
            ).closed.then((value)
            {
              isShowBottomSheet = false;
              setState(() {
            fabIcon = Icons.edit;
            });
            });
            isShowBottomSheet = true;
            setState(() {
              fabIcon = Icons.add;
            });
          }



          /*
           try{
            var name = await getName();
            print(name);

            throw('Some error');
          }catch(error)
          {
            print('error ${error.toString()}');
          }
          */ //TRY ... Catch
          // then  .... catchError
          /*getName().then((value){

            print(value);

            //throw('Some error');
          }).catchError((error){
            print('error ${error.toString()}');
          });*/


        },
        child: Icon(
          fabIcon,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt,
            ),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_box_outlined,
            ),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.archive_outlined,
            ),
            label: 'Archived',
          ),

        ],
      ),
    );
  }

  //Future<String> getName() async
  //{
  //  return 'Ahmed Khallaf';
  //}


  void createDatabase() async
  {
    database = await openDatabase(
        'todo.db',
      version: 1,
      onCreate: (database, version){
          print('database created');
          database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT,time TEXT, status TEXT)').then((value) {
            print('table created');
          }).catchError((error){
            print('error ${error.toString()}');
          });
      },
      onOpen: (database)
      {

      }
    );
  }

  Future insertToDatabase(
      String title,
      String time,
      String date,
      ) async
  {
    return await database.transaction((txn) async
    {
      await txn.rawInsert(
        'INSERT INTO tasks( title, date, time, status) VALUES("$title", "$date", "$time", "new")'
    ).then((value){
      print('$value inserted successfully');
    }).catchError((error){
      print('Error when inserting ${error.toString()}');
    });
  });
  }


  Future<List<Map>> GetDataFromDatabase(database) async
  {
     return await database.rawQuery('SELECT * FROM tasks');
  }
}
 */
