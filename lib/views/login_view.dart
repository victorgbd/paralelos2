import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:paralelos2/product_repository.dart';
import 'package:paralelos2/views/home_view.dart';

class Loginview extends ConsumerStatefulWidget {
  const Loginview({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginviewState();
}

class _LoginviewState extends ConsumerState<Loginview> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    void signIn(BuildContext context) async {
      FocusManager.instance.primaryFocus?.unfocus();
      final result = _formKey.currentState?.saveAndValidate() ?? false;

      if (!result) return;

      final user = _formKey.currentState?.value['user'] as String;
      final password = _formKey.currentState?.value['password'] as String;
      final flag =
          await ref.read(productRepositoryProvider).signIn(user, password);
      if (flag) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const ProductView(),
            ),
            (Route<dynamic> route) => false);
      } else {
        return;
      }
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
                    "User",
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
                        keyboardType: TextInputType.emailAddress,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
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
                    "Password",
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
                        decoration: InputDecoration(
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(hidePassword
                                ? Icons.visibility_off
                                : Icons.remove_red_eye),
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                          ),
                        ),
                        name: 'password',
                        keyboardType: TextInputType.text,
                        obscureText: hidePassword,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(4),
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
                      signIn(context);
                    },
                    child: const Text(
                      "Iniciar sesión",
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
