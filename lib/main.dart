import 'package:flutter/material.dart';
import 'package:flutter_text_box/flutter_text_box.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'formulario.dart';
import 'api.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 26, 188, 191)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final key = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ButtonStyle style = FilledButton.styleFrom(textStyle: const TextStyle(fontSize: 16));
  String email = "", password = "";
  bool? recordar_pw = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const NetworkImage("https://images.unsplash.com/photo-1702203614057-eb91ae07fb96?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.dstATop,
            ),
          ),
        ),

        padding: const EdgeInsets.symmetric(horizontal: 34),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _login(),
            _botones(context),
          ]
        )
      ),
    );
  }


Widget _login() {
  return Center(
    child: Form(
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          const Text(
            'LOGIN',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),
          TextBoxIcon(
            icon: Icons.email_outlined,
            inputType: TextInputType.emailAddress,
            label: 'Correo',
            hint: 'Ingrese su correo electronico',
            errorText: 'Este campo es requerido !',
            onSaved: (String value) {
              email = value;
            },
          ),

          const SizedBox(height: 16),
          TextBoxIcon(
            icon: Icons.password_outlined,
            label: 'Contraseña',
            hint: 'Ingrese su contraseña',
            errorText: 'Este campo es requerido !',
            obscure: true,
            onSaved: (String value) {
              password = value;
            },
          ),

          const SizedBox(height: 14),
          CheckboxListTileFormField(
            title: Text('Recordar contraseña'),
            onSaved: (bool? value) {
              recordar_pw = value;
              },
          ),
        const SizedBox(height: 35),

        ],
      ),
    ),
  );
}



Widget _botones(BuildContext context) {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 16),
        FilledButton.tonal(
          style: style,
          //onPressed: () => ingresar(),
          //Aqui va el boton ingresar
          onPressed: () {
            final state = key.currentState;
            if (state!.validate()) {
              state.save();
              print("Ha ingresado del sistema");
              print("Verificando");
              print(email);
              print(password);
              print(recordar_pw);

              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => const MyApiPage(title: 'Lectura API - Poeta',))); //const WindowsForm()));
              // Obtiene los valores del formulario
              //String email = emailController.text;
            // String password = passwordController.text;

              // Verifica las credenciales (datos quemados en el codigo)
              if (_validarCredenciales(email, password)) {
                print("Acceso concedido");
                //Fluttertoast.showToast(msg: "Acceso concedido");
              } else {
                print("Error en las credenciales de acceso");
              }
            }
          },
          child: const Text('Ingresar', textAlign: TextAlign.center),
        ),

        const SizedBox(height: 16),
        FilledButton.tonal(
          style: style,
          onPressed: () => salir(),
          child: const Text('Salir', textAlign: TextAlign.center),
        ),
      ],
    ),
  );
}

void salir() {
  print("Ha salido del sistema");
}

void ingresar(BuildContext context) {
  final state = key.currentState;
  if (state!.validate()) {
    state.save();
    print("Ha ingresado del sistema");
    print("Verificando");
    print(email);
    print(password);
    print(recordar_pw);

    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => const MyApiPage(title: 'Lectura API - Poeta',))); //const WindowsForm()));
    // Obtiene los valores del formulario
    //String email = emailController.text;
   // String password = passwordController.text;

    // Verifica las credenciales (datos quemados en el codigo)
    if (_validarCredenciales(email, password)) {
      print("Acceso concedido");
      //Fluttertoast.showToast(msg: "Acceso concedido");
    } else {
      print("Error en las credenciales de acceso");
    }
  }
}

  bool _validarCredenciales(String email, String password) {
    // Datos quemados para la validación
    String userEmail = "grupo6";
    String userPassword = "123";

    // Compara los valores con las credenciales quemadas
    return email == userEmail && password == userPassword;
  }

}
