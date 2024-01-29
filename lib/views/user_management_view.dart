import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:paralelos2/user_repository.dart';

class UserManagementView extends ConsumerStatefulWidget {
  const UserManagementView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserManagementViewState();
}

class _UserManagementViewState extends ConsumerState<UserManagementView> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    void save(BuildContext context) async {
      FocusManager.instance.primaryFocus?.unfocus();
      final result = _formKey.currentState?.saveAndValidate() ?? false;

      if (!result) return;

      final user = _formKey.currentState?.value['user'] as String;
      final nombre = _formKey.currentState?.value['nombre'] as String;
      final password = _formKey.currentState?.value['password'] as String;
      final rol = _formKey.currentState?.value['rol'] as String;

      await ref
          .read(userRepositoryProvider)
          .create(nombre, user, password, rol);
      _formKey.currentState?.reset();
    }

    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0),
                  child: Text(
                    "user",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[200]
                            : const Color(0xff1c272b),
                        border:
                            Border.all(color: Colors.grey.shade400, width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: FormBuilderTextField(
                        decoration: const InputDecoration(
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        name: 'user',
                        keyboardType: TextInputType.text,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 22.0),
                  child: Text(
                    "nombre",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[200]
                            : const Color(0xff1c272b),
                        border:
                            Border.all(color: Colors.grey.shade400, width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: FormBuilderTextField(
                        decoration: const InputDecoration(
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        name: 'nombre',
                        keyboardType: TextInputType.text,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Padding(
                  padding: EdgeInsets.only(left: 22.0),
                  child: Text(
                    "password",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[200]
                            : const Color(0xff1c272b),
                        border:
                            Border.all(color: Colors.grey.shade400, width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: FormBuilderTextField(
                        decoration: const InputDecoration(
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        name: 'password',
                        keyboardType: TextInputType.number,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Padding(
                  padding: EdgeInsets.only(left: 22.0),
                  child: Text(
                    "rol",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[200]
                            : const Color(0xff1c272b),
                        border:
                            Border.all(color: Colors.grey.shade400, width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: FormBuilderTextField(
                        decoration: const InputDecoration(
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        name: 'rol',
                        keyboardType: TextInputType.number,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(2),
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ))),
                    onPressed: () {
                      save(context);
                    },
                    child: const Text(
                      "Guardar",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
