import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/Core_Logic/models/task_models/requests/create_request/create_request.dart';
import 'package:task_manager/Core_Logic/models/task_models/requests/update_request/update_request.dart';
import 'package:task_manager/Core_Logic/models/task_models/responses/todo_model.dart';
import 'package:task_manager/Frontend/Functions/Login/Login_blocs/profile_bloc/profile_bloc.dart';
import 'package:task_manager/Frontend/Functions/Tasks/Tasks_blocs/add_update_bloc/addupdatetodo_bloc.dart';
import 'package:task_manager/Frontend/Functions/Tasks/Tasks_blocs/task_bloc/todo_bloc.dart';
import '../../../../Essentials_App/depndency_injection.dart';

class AddUpdateTodoWidget extends StatefulWidget {
  final TodoModel? model;
  const AddUpdateTodoWidget({super.key, this.model});

  @override
  State<AddUpdateTodoWidget> createState() => _AddUpdateTodoWidgetState();
}

class _AddUpdateTodoWidgetState extends State<AddUpdateTodoWidget> {
  final contentController = TextEditingController();

  late AddupdatetodoBloc addupdatetodoBloc;
  bool? completed = false;
  @override
  void initState() {
    addupdatetodoBloc = instance<AddupdatetodoBloc>();
    if (widget.model != null) {
      contentController.text = widget.model?.todo ?? "";
      completed = widget.model?.completed ?? false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 15),
        Text(widget.model != null ? "Update Task " : "Add Task ",
            style: const TextStyle(
              fontSize: 20, // Adjust font size as desired
              fontWeight: FontWeight.bold, // Make the title bold
              color: Colors.black, // Set the title text color
            )),
        const SizedBox(height: 30),
        TextField(
          controller: contentController,
          maxLines: 4,
          minLines: 4,
          decoration: const InputDecoration(
            labelText: "Task Description",
            border: OutlineInputBorder(),
            alignLabelWithHint: true,
            labelStyle: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 30),
        BlocConsumer(
          bloc: addupdatetodoBloc,
          listener: (context, AddupdatetodoState state) {
            state.mapOrNull(
              successAdded: (value) {
                context
                    .read<TodoBloc>()
                    .add(TodoEvent.addTodo(model: value.model));
                Fluttertoast.showToast(
                    msg: "Added successfully",
                    backgroundColor: const Color.fromARGB(255, 181, 214, 227));
                context.pop();
              },
              successUpdated: (value) {
                context.read<TodoBloc>().add(TodoEvent.updateTodo(
                    todoId: widget.model?.id ?? 0, model: value.model));
                Fluttertoast.showToast(
                    msg: "Updated successfully",
                    backgroundColor: const Color.fromARGB(255, 186, 223, 224));
                context.pop();
              },
            );
          },
          builder: (context, AddupdatetodoState state) {
            return state.maybeMap(
              loading: (value) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: CircularProgressIndicator(),
                );
              },
              orElse: () {
                return ElevatedButton(
                  onPressed: widget.model != null
                      ? () {
                          addupdatetodoBloc.add(AddupdatetodoEvent.updateTodo(
                              todoId: widget.model?.id ?? 0,
                              updateRequest: UpdateRequest(
                                  todo: contentController.text,
                                  completed: completed ?? false)));
                        }
                      : () {
                          addupdatetodoBloc.add(AddupdatetodoEvent.addTodo(
                              createRequest: CreateRequest(
                                  todo: contentController.text,
                                  completed: completed ?? false,
                                  userId: context
                                          .read<ProfileBloc>()
                                          .profileData
                                          ?.id ??
                                      1)));
                        },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        Theme.of(context).colorScheme.primary, // Set text color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                  ),
                  child:
                      Text(widget.model != null ? "Update Task" : "Add Task"),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
