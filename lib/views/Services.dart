import 'package:aaishani_store_user_app/bloc/ServicesBloc.dart';
import 'package:aaishani_store_user_app/models/ServicesModel.dart';
import 'package:flutter/material.dart';
class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {

  ServicesModel servicesModel,servicesModel2;  
  @override
  void initState() {    
    super.initState();    
    getServices();
  }
  getServices()async 
  {
    servicesModel2 = await servicesBloc.getServices();
    setState((){
         servicesModel = servicesModel2;
    });           
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: servicesModel == null ?Center(child: 
      CircularProgressIndicator(backgroundColor: Colors.green)): Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*0.90,
        child: ListView.builder(
          itemCount: servicesModel.data.length,
          itemBuilder: (context,index){
            return Card( 
              child: Column(
                children: [
                  Text(servicesModel.data[index].name),
                  Text(servicesModel.data[index].address),
                  Text(servicesModel.data[index].contact),
                  Text(servicesModel.data[index].contactPersonName),
                  Text(servicesModel.data[index].serviceType),                  
                ],
              ),
            );
          },
      ),
      ),
    );
  }
}
