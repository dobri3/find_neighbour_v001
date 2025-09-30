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
    return AspectRatio(aspectRatio: 2/3,
    child: Container(
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        image: DecorationImage(image:  AssetImage(widget.neighbourModel.neighbourPhoto),
        fit: BoxFit.cover,)
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.black.withOpacity(0.2),
              ]
            ),
            
        ),
        child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(widget.neighbourModel.neighbourFullName, style: const TextStyle(
              color: Colors.white, fontSize: 20
            ),
            ),
          ),
      ),
    ),
    
    );
  }
}