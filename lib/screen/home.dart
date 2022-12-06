import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:reto4/controller/controladorGeneral.dart';
import 'package:reto4/process/peticiones.dart';
import 'package:reto4/screen/listar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
 
controladorGeneral Control = Get.find();

void ObtenerPosicion() async{
  Position posicion = await peticionesDB.determinePosition();
  print(posicion.toString());
  Control.cargaUnaPosicion(posicion.toString());
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
          
          Alert(type:AlertType.warning,context: context, title: "Atención", desc:  "Seguro que quieres eliminar todas las ubicaciones?", buttons: [
            DialogButton(child: Text("Si"), color: Colors.green, onPressed: (){
             peticionesDB.EliminarTodas();
             Control.CargarTodaBD();
              Navigator.pop(context);
            }),
            DialogButton(child: Text("No"), color: Colors.red, onPressed: (){
              
              Navigator.pop(context);
            }),
            

          ]).show();
          

        }, icon: Icon(Icons.delete_forever))],
        title: Text(widget.title),
      ),
    body: listar(),





    floatingActionButton: FloatingActionButton(onPressed: (){
      ObtenerPosicion();
      Alert(title: "Atención", desc: "Quiere almacenar la ubicación actual? "+Control.unaPosicion+"",type: AlertType.info,
      buttons: [DialogButton(color: Colors.green,child: Text("Si"), onPressed: (){

              peticionesDB.GuardarPosicion(Control.unaPosicion,DateTime.now().toString());
              Control.CargarTodaBD();
              Navigator.pop(context);
        
        
        
        }),
              DialogButton(color: Colors.red,child: Text("No"), onPressed: (){Navigator.pop(context);})
      ],
       context: context).show();
    
    }, child:Icon(Icons.location_on_outlined),
    ),
    );
  }
}
