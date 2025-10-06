import 'package:find_neighbour_v001/models/neighbour_model.dart';
import 'package:flutter/material.dart';

class NeighbourIntroductoryWidget extends StatefulWidget {
  final NeighbourModel neighbourModel;
  const NeighbourIntroductoryWidget({required this.neighbourModel});

  @override
  State<NeighbourIntroductoryWidget> createState() => _NeighbourIntroductoryWidgetState();
}

class _NeighbourIntroductoryWidgetState extends State<NeighbourIntroductoryWidget> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 500,
      width: 500,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 0, 0),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF32658D)
        ),
      ),
      margin: const EdgeInsets.only(right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 170,
                  width: 130,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image:  AssetImage(widget.neighbourModel.neighbourPhoto),
        fit: BoxFit.cover, )
      ),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(20),
        //   gradient: LinearGradient(
        //       begin: Alignment.bottomRight,
        //       colors: [
        //         Colors.black.withOpacity(0.8),
        //         Colors.black.withOpacity(0.2),
        //       ]
        //     ),
            
        // ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Align(
            alignment: Alignment.center,
            child: Text(widget.neighbourModel.neighbourFullName,
            textAlign: TextAlign.center, style: const TextStyle(
              color: Colors.white, fontSize: 24, fontFamily: "Inter"
            ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 250,
              child: Text("Город: ${widget.neighbourModel.neighbourCity}",
              textAlign: TextAlign.left, style: const TextStyle(
                color: Color(0xFF6A999E), fontSize: 14, fontFamily: "Inter"
              ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width:250,
              child: Text("Район/метро: ${widget.neighbourModel.neighbourAddress}",
              textAlign: TextAlign.left, style: const TextStyle(
                color: Color(0xFF6A999E), fontSize: 14, fontFamily: "Inter"
              ),
              ),
            ),
          ),    

          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width:250,
              child: Text("Бюджет: ${widget.neighbourModel.neighbourCost}",
              textAlign: TextAlign.left, style: const TextStyle(
                color: Color(0xFF6A999E), fontSize: 14, fontFamily: "Inter"
              ),
              ),
            ),
          ),          

          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width:250,
              child: Text("Кол-во соседей: ${widget.neighbourModel.neighbourCount}",
              textAlign: TextAlign.left, style: const TextStyle(
                color: Color(0xFF6A999E), fontSize: 14, fontFamily: "Inter"
              ),
              ),
            ),
          ),       
                      ],
                    )
                       
                  ],
                )


              ],
            ),
            const SizedBox(height: 15,),
            Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width:400,
              child: Text("Описание: ${widget.neighbourModel.neighbourDescription}",
              textAlign: TextAlign.left, style: const TextStyle(
                color: Color(0xFFE7E9EC), fontSize: 14, fontFamily: "Inter"
              ),
              ),
            ),
          ),    


          ],
        )


      // height: 440,
      // width: 420,
      // margin: const EdgeInsets.only(right: 15),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(20),
      //   image: DecorationImage(image:  AssetImage(widget.neighbourModel.neighbourPhoto),
      //   fit: BoxFit.cover, )
      // ),
      // child: 
      // Container(
      //   padding: const EdgeInsets.all(20),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(20),
      //     gradient: LinearGradient(
      //         begin: Alignment.bottomRight,
      //         colors: [
      //           Colors.black.withOpacity(0.8),
      //           Colors.black.withOpacity(0.2),
      //         ]
      //       ),
            
      //   ),
      //   child: Align(
      //       alignment: Alignment.bottomLeft,
      //       child: Text(widget.neighbourModel.neighbourFullName,
      //       textAlign: TextAlign.center, style: const TextStyle(
      //         color: Colors.white, fontSize: 18
      //       ),
      //       ),
      //     ),
      // ),
    
    
    );
  }
}