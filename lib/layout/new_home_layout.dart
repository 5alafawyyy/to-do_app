import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_updated/shared/components/components.dart';
import 'package:todo_updated/shared/cubit/cubit.dart';
import 'package:todo_updated/shared/cubit/states.dart';

class new_home_layout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

/*
Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            titles[currentIndex],
          ),
        ),
        body: ConditionalBuilder(
          condition: tasksList.length > 0,
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
                    /*
                    setState(()
                    {
                      isShowBottomSheet = false;
                      fabIcon = Icons.edit;

                      tasksList = value;
                      print(tasksList);
                    });
                    */

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

                /*
                setState(() {
                  fabIcon = Icons.edit;
                });
                */
              });
              isShowBottomSheet = true;
              /*
              setState(() {
                fabIcon = Icons.add;
              });
              */
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

            /*
            setState(() {
              currentIndex = index;
            });
            */
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
      ),
* */

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..createDatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {
            if (state is AppInsertDatabaseState) {
              Navigator.pop(context);
            }
          },
          builder: (BuildContext context, AppStates state) {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Text(
                  cubit.titles[cubit.currentIndex],
                ),
              ),
              body: ConditionalBuilder(
                condition: state is! AppGetDatabaseLoadingState,
                builder: (context) => cubit.screens[cubit.currentIndex],
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.isShowBottomSheet) {
                    if (formKey.currentState!.validate()) {
                      cubit.insertToDatabase(titleController.text,
                          timeController.text, dateController.text);
                    }
                  } else {
                    scaffoldKey.currentState!
                        .showBottomSheet(
                          (context) => Container(
                            color: Colors.blue[50],
                            padding: const EdgeInsets.all(20.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultFormField(
                                    controller: titleController,
                                    type: TextInputType.text,
                                    autofocus: true,
                                    showCursor: true,
                                    readOnly: false,
                                    validate: (value) {
                                      if (value.isEmpty) {
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
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timeController.text =
                                            value!.format(context).toString();
                                        print(value.format(context));
                                      });
                                    },
                                    validate: (value) {
                                      if (value.isEmpty) {
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
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2022-08-10'),
                                      ).then((value) {
                                        dateController.text = DateFormat.yMMMd()
                                            .format(value!)
                                            .toString();
                                        print(DateFormat.yMMMd().format(value));
                                      });
                                    },
                                    validate: (value) {
                                      if (value.isEmpty) {
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
                        )
                        .closed
                        .then((value) {
                      cubit.changeBottomSheetState(
                        false,
                        Icons.edit,
                      );
                    });
                    cubit.changeBottomSheetState(
                      true,
                      Icons.add,
                    );
                  }
                },
                child: Icon(
                  cubit.fabIcon,
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
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
          },
        ));
  }
}
