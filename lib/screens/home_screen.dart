import 'package:flutter/material.dart';
import 'package:network_request/services/person_network_service.dart';

import '../model/person.dart';
class Home extends StatelessWidget {
final PersonNetworkService personService=PersonNetworkService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EMPLOYEES'S INFORMATION"),
      ),
      body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://images.pexels.com/photos/7130537/pexels-photo-7130537.jpeg"),
          fit: BoxFit.cover,
        )
      ),
        child:SafeArea(
          child: FutureBuilder(
            future: personService.fetchPersons(10),
            builder: (BuildContext context,AsyncSnapshot<List<Person>>snapshot){
              if(snapshot.hasData) {
                return Row(
                  children: <Widget>[
                    Expanded(child: Container(
                      child: Card(
                        color: Colors.black.withOpacity(0),
                        child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (BuildContext context, int index) {
                              var currentPerson = snapshot.data![index];
                              return ListTile(
                                title: Text(currentPerson.name,
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                                leading: CircleAvatar(
                                  backgroundImage:
                                  NetworkImage(currentPerson.imageUrl),
                                ),
                                subtitle: Text(
                                    "Phone:${currentPerson.phoneNumber}"
                                    ,
                                    style: TextStyle(
                                        color: Colors.white,
                                    )),
                              );
                            }),
                      ),
                    )

                    )
                  ],
                );
              }
                if(snapshot.hasError){
    return Center(
    child: Icon(
    Icons.error,
    color: Colors.red,
    size: 82.0,
    ));




                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(("PLEASE WAIT......."))
                    ],
                  ),
                );

            },
          ),
        ),
      ),

    );
  }
}

