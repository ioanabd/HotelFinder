import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/hotel.dart';
import '../../models/question.dart';
import '../../providers/question_provider.dart';
import '../../widgets/custom_appbar.dart';

class HotelPage extends StatefulWidget {
  final List<Question> answers;
  final Question lastQuestion;
  final String lastAnswer;
  const HotelPage({Key? key, required this.answers, required this.lastQuestion, required this.lastAnswer}) : super(key: key);

  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {

  @override
  Widget build(BuildContext context) {
    var questionsProvider = context.watch<QuestionProvider>();

    widget.answers.add(Question(name: widget.lastQuestion.name, questionText: widget.lastQuestion.questionText, answers: [widget.lastAnswer]));

    return FutureBuilder(
        future: questionsProvider.getHotelsFuture(widget.answers),
        builder: (BuildContext ctx, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.done) {
            if (asyncSnapshot.hasError) {
              return const Center(child: Text('Could not retrieve hotels!'));
            }
            return SafeArea(
                child: Scaffold(
                  appBar: const CustomAppBar(title: 'Gaseste-ti cazare', back: false),
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: questionsProvider.hotels.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return Container(
                            alignment: Alignment.center,
                            child: Column(
                              children:[
                                hotelDescription(questionsProvider.hotels[index]),
                              ],
                            ),
                          );
                        }
                    ),
                  ),
                )
            );
          }else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }

  Widget hotelDescription(Hotel hotel) {

    String capacity = hotel.Capacity.toString();
    bool breakfast = false;
    String roomFacilities = 'Facilitati camera: ';
    String hotelFacilities = 'Facilitati hotel: ';
    if(hotel.Breakfast == 'da'){
      breakfast = true;
    }
    for ( int i = 0; i < hotel.RoomFacilities.length - 1; i++ ){
      roomFacilities = '$roomFacilities${hotel.RoomFacilities[i]}, ';
    }
    roomFacilities = roomFacilities + hotel.Facilities[hotel.Facilities.length - 1];
    for ( int i = 0; i < hotel.Facilities.length - 1; i++ ){
      hotelFacilities = '$hotelFacilities${hotel.Facilities[i]}, ';
    }
    hotelFacilities = hotelFacilities + hotel.Facilities[hotel.Facilities.length - 1];
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: 370,
          height: 440,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,10,20,0),
                  child: Text(
                    hotel.Name,
                    style: TextStyle(
                      color: Colors.amber[800],
                      fontSize: 30,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,8,0,0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hotel.Stars,
                        style: const TextStyle(color: Colors.black,
                          fontSize: 25,decoration: TextDecoration.none,
                        ),
                      ),
                      const Icon(Icons.star, size: 27.0),
                      const SizedBox(width: 10.0),
                      Text(hotel.Rating,
                        style: const TextStyle(color: Colors.black,
                          fontSize: 25,decoration: TextDecoration.none,
                        ),)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,8,0,0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_city,size: 27.0),
                      Text(
                        hotel.DistanceToCenter,
                        style: const TextStyle(color: Colors.black,
                          fontSize: 25,decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,8,0,0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Capacitate:',
                        style: TextStyle(color: Colors.black,
                          fontSize: 25,decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        capacity,
                        style: const TextStyle(color: Colors.black,
                          fontSize: 25,decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,8,0,0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mic dejun inclus:',
                        style: TextStyle(color: Colors.black,
                          fontSize: 25,decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      breakfast ?
                      const Icon(Icons.check_circle, size: 27, color: Colors.green,)
                          : const Icon(Icons.close_outlined, size: 27, color: Colors.pink)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,8,0,0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(roomFacilities, style: const TextStyle(color: Colors.black,
                          fontSize: 25,decoration: TextDecoration.none,
                        ),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,8,0,0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(hotelFacilities, style: const TextStyle(color: Colors.black,
                          fontSize: 25,decoration: TextDecoration.none,
                        ),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }
}
