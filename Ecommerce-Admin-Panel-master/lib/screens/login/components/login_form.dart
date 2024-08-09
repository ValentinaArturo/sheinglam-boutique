import 'package:ecommerce_admin_panel/controllers/auth_controller.dart';
import 'package:ecommerce_admin_panel/controllers/menu_controller.dart';
import 'package:ecommerce_admin_panel/shared/components/default_button.dart';
import 'package:ecommerce_admin_panel/shared/components/default_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  var text_emailcontroller = TextEditingController();
  var text_passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Iniciar sesión",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 40,
          ),
          defaultTextFormField(
            controller: text_emailcontroller,
            inputtype: TextInputType.emailAddress,
            hinttext: "Correo",
            onvalidate: (value) {
              if (value!.isEmpty) return "El correo no debe estar vacio.";
            },
          ),
          SizedBox(
            height: 10,
          ),
          Consumer<AuthController>(builder: (context, authcontroller, child) {
            return defaultTextFormField(
              suffixIcon: InkWell(
                child: Icon(
                  authcontroller.showpassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onTap: () {
                  authcontroller.onchangepasswordvisibility();
                },
              ),
              obscure: authcontroller.showpassword,
              controller: text_passwordcontroller,
              inputtype: TextInputType.text,
              hinttext: "Contraseña",
              onvalidate: (value) {
                if (value!.isEmpty) return "La contraseña no debe estar vacia.";
                return null;
              },
            );
          }),
          SizedBox(
            height: 30,
          ),
          context.watch<AuthController>().isloadingSignIn
              ? CircularProgressIndicator()
              : defaultButton(
                  text: "Registro",
                  height: 50,
                  onpress: () {
                    if (_formkey.currentState!.validate()) {
                      context.read<AuthController>()
                        ..signIn(text_emailcontroller.text.trim(),
                                text_passwordcontroller.text.toString())
                            .then((value) {
                          if (value != null) {
                            text_emailcontroller.clear();
                            text_passwordcontroller.clear();
                            print("Registro completado");
                            context.read<CustomMenuController>()..buildMenu();
                          } else {}
                        });
                    }
                  }),
        ],
      ),
    );
  }
}
