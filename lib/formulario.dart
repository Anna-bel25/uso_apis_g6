import 'package:flutter/material.dart';
import 'package:flutter_text_box/flutter_text_box.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:uso_apis_g6/main.dart';
import 'main.dart';
import 'package:intl/intl.dart';


class WindowsForm extends StatelessWidget {
  const WindowsForm({super.key});
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Formulario',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 26, 188, 191)),
          useMaterial3: true,
        ),
        home: WindowsFormPage(title: 'Ingreso de datos'),
      );
    }
  }

  class WindowsFormPage extends StatefulWidget {
  const WindowsFormPage({super.key, required this.title});
  final String title;

  @override
  State<WindowsFormPage> createState() => _WindowsFormPageState();
}

class _WindowsFormPageState extends State<WindowsFormPage> {
  final key = GlobalKey<FormState>();
  final ButtonStyle style = FilledButton.styleFrom(textStyle: const TextStyle(fontSize: 16));
  String nombres = "", email = "", password = "";
  int cedula = 0, edad = 0;
  bool? recordar_pw = false;
  DateTime? fechaNacimiento;

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _formulario(),
                _botones(),
              ], // Cierre de la lista de widgets
            ),
          ),
        ),
      ),
    );
  }
  

  Widget _formulario() {
    return Column(
      children: [
        const SizedBox(height: 25),
        const Text(
          'FORMULARIO',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),
        TextBoxIcon(
          icon: Icons.numbers_outlined,
          inputType: TextInputType.number,
          label: 'Cedula',
          hint: 'Ingrese su cedula',
          errorText: 'Este campo es requerido !',
          onSaved: (String value) {
            cedula = int.parse(value);
          },
        ),

        const SizedBox(height: 16),
        TextBoxIcon(
          icon: Icons.supervised_user_circle_outlined,
          inputType: TextInputType.text,
          label: 'Nombres',
          hint: 'Ingrese sus nombres',
          errorText: 'Este campo es requerido !',
          onSaved: (String value) {
            nombres = value;
          },
        ),

        const SizedBox(height: 16),
        TextBoxIcon(
          icon: Icons.numbers_outlined,
          inputType: TextInputType.number,
          label: 'Edad',
          hint: 'Ingrese su edad',
          errorText: 'Este campo es requerido !',
          onSaved: (String value) {
            edad = int.parse(value);
          },
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
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Color.fromARGB(67, 26, 188, 191),
              width: 0.8,
            ),
          ),
          child: ListTile(
            title: const Text(
              "Fecha de Nacimiento",
              style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 74, 75, 75)),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null && pickedDate != fechaNacimiento) {
                setState(() {
                  fechaNacimiento = pickedDate;
                });
              }
            },
            subtitle: fechaNacimiento != null
                ? Text(
                    "${DateFormat('dd/MM/yyyy').format(fechaNacimiento!)}",
                    style: const TextStyle(fontSize: 16),
                  )
                : null,
            trailing: Container(
              margin: EdgeInsets.only(left: 24),
              child: const Icon(
                Icons.calendar_today,
                size: 16.0,
                color: Color.fromARGB(187, 8, 123, 217)
              ),
            ),
          ),
        ),

        /*SizedBox(height: 16),
        ListTile(
          title: Text("Fecha de Nacimiento"),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null && pickedDate != fechaNacimiento) {
              setState(() {
                fechaNacimiento = pickedDate;
              });
            }
          },
          subtitle: fechaNacimiento != null
              ? Text("${DateFormat('dd/MM/yyyy').format(fechaNacimiento!)}")
              : null,
          trailing: Icon(Icons.calendar_today),
        ),*/

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

      ],
    );
  }



  Widget _botones() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 120),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilledButton.tonal(
                style: style,
                onPressed: () {
                  _showModal(context);
                },
                child: const Text('Aceptar', textAlign: TextAlign.center),
              ),

              ElevatedButton(
                //style: style,
                onPressed: () {
                  _resetForm();
                },
                child: const Text('Borrar', textAlign: TextAlign.center),
              ),

              const SizedBox(height: 16),
              FilledButton.tonal(
                style: style,
                //onPressed: () => regresar(),
                onPressed: (){
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => const MyHomePage(title: '',)));
                    print("Se va a regresar al login");
                    },
                child: const Text('Regresar', textAlign: TextAlign.center),  
              ),

              /*ElevatedButton(
                onPressed: () {
                  print("Botón de prueba presionado");
                  _showModal(context);
                },
                child: Text("Prueba"),
              ),*/
            ],
          ),
        ],
      ),
    );
  }

  void _showModal(BuildContext context) {
    if (key.currentState != null && key.currentState!.validate()) {
      key.currentState?.save();
      print("Nombres: $nombres");
      print("Email: $email");
      print("Cédula: $cedula");
      print("Edad: $edad");
      print("Fecha de Nacimiento: $fechaNacimiento");

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Datos Ingresados:"),
                  const SizedBox(height: 10),
                  Text("Nombres: $nombres"),
                  Text("Email: $email"),
                  Text("Cédula: $cedula"),
                  Text("Edad: $edad"),
                  Text("Fecha de Nacimiento: ${DateFormat('dd/MM/yyyy').format(fechaNacimiento!)}"),
                ],
              ),
            ),
          );
        },
      );
    }
  }



  void _resetForm() {
    key.currentState?.reset();
    setState(() {
      nombres = "";
      email = "";
      cedula = 0;
      edad = 0;
      fechaNacimiento = null;
    });
  }


}