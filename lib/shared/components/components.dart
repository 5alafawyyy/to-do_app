import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo_updated/shared/cubit/cubit.dart';

Widget defaultButton(
    {
      double width = double.infinity,
      Color background = Colors.blue,
      required Function() function,
      required String text,

    }) => Container(
  width: width,
  color: background,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      text.toUpperCase(),
      style: const TextStyle(
        color: Colors.white,
      ),
    ) ,),
);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  onSubmit,
  onTap,
  required validate,
  required String label,
  required IconData prefix,
  bool autofocus = false,
  bool showCursor = true,
  bool readOnly = true,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  validator: validate,
  onTap: onTap,
  autofocus: autofocus,
  showCursor: showCursor,
  readOnly: readOnly,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
        prefix
    ),
    focusedBorder:OutlineInputBorder(
      borderSide: const BorderSide(
          color: Colors.blue,
          width: 2.0
      ),
      borderRadius: BorderRadius.circular(25.0),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(),
    ),

  ),


);

Widget defaultTextFormField
    ({
      required TextEditingController controller,
      required TextInputType type,
      required String label,
      required IconData prefix,
      required validate,
    }) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        border: OutlineInputBorder(),

  ),
    );


Widget buildTaskItem(
    Map model,
    context,
    ) => Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        CircleAvatar(
  
          radius: 40.0,
  
          child: Text(
  
            '${model['time']}',
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20.0,
  
        ),
  
        Expanded(
  
          child: Column(
  
            mainAxisSize: MainAxisSize.min,
  
            crossAxisAlignment: CrossAxisAlignment.start,
  
            children: [
  
              Text(
  
                '${model['title']}',
  
                style: TextStyle(
  
                  fontSize: 20.0,
  
                  fontWeight: FontWeight.bold,
  
                ),
  
              ),
  
              Text(
  
                  '${model['date']}',
  
                style: TextStyle(
  
                  color: Colors.grey,
  
                ),
  
              ),
  
            ],
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20.0,
  
        ),
  
        IconButton(
  
            onPressed: ()
  
            {
  
              AppCubit.get(context).updateData(
  
                  'done',
  
                  model['id'],
  
              );
  
            },
  
            icon: Icon(
  
              Icons.check_box,
  
              color: Colors.green[300],
  
            )),
  
        IconButton(
  
            onPressed: ()
  
            {
  
              AppCubit.get(context).updateData(
  
                'archive',
  
                model['id'],
  
              );
  
            },
  
            icon: Icon(
  
              Icons.archive,
  
              color: Colors.black45,
  
            )),
  
  
  
      ],
  
    ),
  
  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteData(model['id']);
  },
);

Widget taskBuilder(
    @required List<Map> tasks,
    ) => ConditionalBuilder(
  condition: tasks.length > 0,
  builder: (context) => ListView.separated(
    itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
    separatorBuilder: (context, index) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    ),
    itemCount: tasks.length,
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.menu,
          size: 80.0,
          color: Colors.black45,
        ),
        Text(
          'No Tasks Yet Please Add Some Tasks',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black45,
          ),
        ),
      ],
    ),
  ),
);