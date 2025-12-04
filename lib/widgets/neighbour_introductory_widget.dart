import 'package:find_neighbour_v001/models/neighbour_model.dart';
import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';
import 'package:find_neighbour_v001/styles/app_container_styles.dart';
import 'package:flutter/material.dart';

class NeighbourIntroductoryWidget extends StatefulWidget {
  final NeighbourModel neighbourModel;
  const NeighbourIntroductoryWidget({super.key, required this.neighbourModel});

  @override
  State<NeighbourIntroductoryWidget> createState() => _NeighbourIntroductoryWidgetState();
}

class _NeighbourIntroductoryWidgetState extends State<NeighbourIntroductoryWidget> {

  bool _isHovered = false;


  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true), 
      onExit: (_) => setState(() => _isHovered = false), 
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), 
        height: _isHovered ? 470 : 450,
        width: _isHovered ? 440 : 420,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(right: 15),
        decoration: AppContainerStyles.neighbourCard.copyWith(
          color:  AppColors.baseBright,
          border: Border.all(
            color: _isHovered ? AppColors.textBase.withOpacity(0.5) :  AppColors.teal.withOpacity(0.5), 
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 170,
                  width: 130,

        decoration: AppContainerStyles.photoContainer.copyWith(
          border: Border.all(
            color: AppColors.baseBright,
          ),
          image: DecorationImage(
            image:  AssetImage(widget.neighbourModel.neighbourPhoto),
                  fit: BoxFit.cover)
        ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Align(
                              alignment: Alignment.center,
                              child: Text(widget.neighbourModel.neighbourFullName,
                              textAlign: TextAlign.center, style: AppTextStyles.neighbourName
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),   
                  
                            // City
                      _buildDetailItem("Город: ${widget.neighbourModel.neighbourCity}"),
                      
                      // Address
                      _buildDetailItem("Район/метро: ${widget.neighbourModel.neighbourAddress}"),
                      
                      // Budget
                      _buildDetailItem("Бюджет: ${widget.neighbourModel.neighbourCost}"),
                      
                      // Neighbour Count
                      _buildDetailItem("Кол-во соседей: ${widget.neighbourModel.neighbourCount}"),
                    ],
                  ),
                )


              ],
            ),
            const SizedBox(height: 15,),
            Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width:400,
              child: Text("Описание:\n${widget.neighbourModel.neighbourDescription}",
              textAlign: TextAlign.left, style: AppTextStyles.neighbourDescription,
              ),
            ),
          ),    


          ],
        )
      )
    );
  }
}

Widget _buildDetailItem(String text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: SizedBox(
      width: 250,
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: AppTextStyles.neighbourDetail,
      ),
    ),
  );
}