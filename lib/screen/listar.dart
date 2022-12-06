import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reto4/controller/controladorGeneral.dart';
import 'package:reto4/process/peticiones.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class listar extends StatefulWidget {
  const listar({super.key});

  @override
  State<listar> createState() => _listarState();
}

class _listarState extends State<listar> {
 controladorGeneral Control = Get.find();

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Control.CargarTodaBD();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Container(
      child: Control.listaPosiciones?.isEmpty==false? ListView.builder(
        itemCount: Control.listaPosiciones!.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.location_searching_rounded),
              trailing: IconButton(onPressed: (){
                Alert(
                  type: AlertType.warning, 
                  context: context, title: "Atención", desc: "Seguro que quieres eliminar", 
                  buttons: [
                   DialogButton(child: Text("Si"), color: Colors.green, onPressed: (){
                   peticionesDB.EliminarPosicion(Control.listaPosiciones![index]["id"]);
                    Control.CargarTodaBD();
                    Navigator.pop(context);
                   }), 
                   DialogButton(child: Text("No"), color: Colors.red, onPressed: (){
                    Navigator.pop(context);
                   }),  

                  ]
                  ).show();  



              }, icon: Icon(Icons.delete_outline),),
              title: Text(Control.listaPosiciones![index]["coordenadas"]),
              subtitle: Text(Control.listaPosiciones![index]["fecha"]),
            ),
          );
        },
      ):Center(child: CircularProgressIndicator(),),
    ),
    );
  }
}