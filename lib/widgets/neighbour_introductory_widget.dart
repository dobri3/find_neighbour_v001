// import 'package:find_neighbour_v001/models/neighbour_model.dart';
// import 'package:find_neighbour_v001/styles/app_colors.dart';
// import 'package:find_neighbour_v001/styles/app_text_styles.dart';
// import 'package:find_neighbour_v001/styles/app_container_styles.dart';
// import 'package:flutter/material.dart';

// class NeighbourIntroductoryWidget extends StatefulWidget {
//   final NeighbourModel neighbourModel;
//   const NeighbourIntroductoryWidget({super.key, required this.neighbourModel});

//   @override
//   State<NeighbourIntroductoryWidget> createState() => _NeighbourIntroductoryWidgetState();
// }

// class _NeighbourIntroductoryWidgetState extends State<NeighbourIntroductoryWidget> {

//   bool _isHovered = false;


//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => _isHovered = true), 
//       onExit: (_) => setState(() => _isHovered = false), 
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200), 
//         height: _isHovered ? 470 : 450,
//         width: _isHovered ? 440 : 420,
//         padding: const EdgeInsets.all(20),
//         margin: const EdgeInsets.only(right: 15),
//         decoration: AppContainerStyles.neighbourCard.copyWith(
//           color:  AppColors.baseBright,
//           border: Border.all(
//             color: _isHovered ? AppColors.textBase.withOpacity(0.5) :  AppColors.teal.withOpacity(0.5), 
//             width: 2,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                   height: 170,
//                   width: 130,

//         decoration: AppContainerStyles.photoContainer.copyWith(
//           border: Border.all(
//             color: AppColors.baseBright,
//           ),
//           image: DecorationImage(
//             image:  AssetImage(widget.neighbourModel.neighbourPhoto),
//                   fit: BoxFit.cover)
//         ),
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Align(
//                               alignment: Alignment.center,
//                               child: Text(widget.neighbourModel.neighbourFullName,
//                               textAlign: TextAlign.center, style: AppTextStyles.neighbourName(context)
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),   
                  
//                             // City
//                       _buildDetailItem(context, "Город: ${widget.neighbourModel.neighbourCity}"),
                      
//                       // Address
//                       _buildDetailItem(context, "Район/метро: ${widget.neighbourModel.neighbourAddress}"),
                      
//                       // Budget
//                       _buildDetailItem(context, "Бюджет: ${widget.neighbourModel.neighbourCost}"),
                      
//                       // Neighbour Count
//                       _buildDetailItem(context, "Кол-во соседей: ${widget.neighbourModel.neighbourCount}"),
//                     ],
//                   ),
//                 )


//               ],
//             ),
//             const SizedBox(height: 15,),
//             Align(
//             alignment: Alignment.centerLeft,
//             child: SizedBox(
//               width:400,
//               child: Text("Описание:\n${widget.neighbourModel.neighbourDescription}",
//               textAlign: TextAlign.left, style: AppTextStyles.neighbourDescription(context),
//               ),
//             ),
//           ),    


//           ],
//         )
//       )
//     );
//   }
// }

// Widget _buildDetailItem(BuildContext context, String text) {
//   return Align(
//     alignment: Alignment.centerLeft,
//     child: SizedBox(
//       width: 250,
//       child: Text(
//         text,
//         textAlign: TextAlign.left,
//         style: AppTextStyles.neighbourDetail(context),
//       ),
//     ),
//   );
// }



import 'package:find_neighbour_v001/models/neighbour_model.dart';
import 'package:find_neighbour_v001/styles/app_colors.dart';
import 'package:find_neighbour_v001/styles/app_text_styles.dart';
import 'package:find_neighbour_v001/styles/app_container_styles.dart';
import 'package:flutter/material.dart';

// class NeighbourIntroductoryWidget extends StatefulWidget {
//   final NeighbourModel neighbourModel;
//   const NeighbourIntroductoryWidget({super.key, required this.neighbourModel});

//   @override
//   State<NeighbourIntroductoryWidget> createState() => _NeighbourIntroductoryWidgetState();
// }

// class _NeighbourIntroductoryWidgetState extends State<NeighbourIntroductoryWidget> {

//   bool _isHovered = false;


//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => _isHovered = true), 
//       onExit: (_) => setState(() => _isHovered = false), 
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200), 
//         height: _isHovered ? 470 : 450,
//         width: _isHovered ? 440 : 420,
//         padding: const EdgeInsets.all(20),
//         margin: const EdgeInsets.only(right: 15),
//         decoration: AppContainerStyles.neighbourCard.copyWith(
//           color:  AppColors.baseBright,
//           border: Border.all(
//             color: _isHovered ? AppColors.textBase.withOpacity(0.5) :  AppColors.teal.withOpacity(0.5), 
//             width: 2,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                   height: 170,
//                   width: 130,

//         decoration: AppContainerStyles.photoContainer.copyWith(
//           border: Border.all(
//             color: AppColors.baseBright,
//           ),
//           image: DecorationImage(
//             image:  AssetImage(widget.neighbourModel.neighbourPhoto),
//                   fit: BoxFit.cover)
//         ),
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Align(
//                               alignment: Alignment.center,
//                               child: Text(widget.neighbourModel.neighbourFullName,
//                               textAlign: TextAlign.center, style: AppTextStyles.neighbourName(context)
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),   
                  
//                             // City
//                       _buildDetailItem(context, "Город: ${widget.neighbourModel.neighbourCity}"),
                      
//                       // Address
//                       _buildDetailItem(context, "Район/метро: ${widget.neighbourModel.neighbourAddress}"),
                      
//                       // Budget
//                       _buildDetailItem(context, "Бюджет: ${widget.neighbourModel.neighbourCost}"),
                      
//                       // Neighbour Count
//                       _buildDetailItem(context, "Кол-во соседей: ${widget.neighbourModel.neighbourCount}"),
//                     ],
//                   ),
//                 )


//               ],
//             ),
//             const SizedBox(height: 15,),
//             Align(
//             alignment: Alignment.centerLeft,
//             child: SizedBox(
//               width:400,
//               child: Text("Описание:\n${widget.neighbourModel.neighbourDescription}",
//               textAlign: TextAlign.left, style: AppTextStyles.neighbourDescription(context),
//               ),
//             ),
//           ),    


//           ],
//         )
//       )
//     );
//   }
// }

// Widget _buildDetailItem(BuildContext context, String text) {
//   return Align(
//     alignment: Alignment.centerLeft,
//     child: SizedBox(
//       width: 250,
//       child: Text(
//         text,
//         textAlign: TextAlign.left,
//         style: AppTextStyles.neighbourDetail(context),
//       ),
//     ),
//   );
// }











class NeighbourIntroductoryWidget extends StatefulWidget {
  final NeighbourModel neighbourModel;
  const NeighbourIntroductoryWidget({super.key, required this.neighbourModel});

  @override
  State<NeighbourIntroductoryWidget> createState() =>
      _NeighbourIntroductoryWidgetState();
}

class _NeighbourIntroductoryWidgetState
    extends State<NeighbourIntroductoryWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Адаптивные размеры карточки
    double cardWidth = screenWidth < 750 ? screenWidth * 0.8 : _isHovered ? 440 : 420;
    double cardHeight = screenWidth < 750 ? 450 : _isHovered ? 470 : 450;
    double imageHeight = screenWidth < 750 ? 150 : 170;
    double imageWidth = screenWidth < 750 ? 100 : 130;
    bool isMobile = screenWidth < 750;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: cardWidth,
        height: cardHeight,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(right: 15, bottom: 15),
        decoration: AppContainerStyles.neighbourCard.copyWith(
          color: AppColors.baseBright,
          border: Border.all(
            color: _isHovered
                ? AppColors.textBase.withOpacity(0.5)
                : AppColors.teal.withOpacity(0.5),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Верхняя часть: фото + инфо
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: imageHeight,
                  width: imageWidth,
                  decoration: AppContainerStyles.photoContainer.copyWith(
                    border: Border.all(color: AppColors.baseBright),
                    image: DecorationImage(
                      image: AssetImage(widget.neighbourModel.neighbourPhoto),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Информация о соседе
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.neighbourModel.neighbourFullName,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.neighbourName(context),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildDetailItem(
                          context, "Город: ${widget.neighbourModel.neighbourCity}"),
                      _buildDetailItem(context,
                          "Район/метро: ${widget.neighbourModel.neighbourAddress}"),
                      _buildDetailItem(
                          context, "Бюджет: ${widget.neighbourModel.neighbourCost}"),
                      _buildDetailItem(context,
                          "Кол-во соседей: ${widget.neighbourModel.neighbourCount}"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Описание
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Описание:\n${widget.neighbourModel.neighbourDescription}",
                textAlign: TextAlign.left,
                style: AppTextStyles.neighbourDescription(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildDetailItem(BuildContext context, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Text(
      text,
      style: AppTextStyles.neighbourDetail(context),
    ),
  );
}








// class NeighbourIntroductoryWidget extends StatefulWidget {
//   final NeighbourModel neighbourModel;
//   const NeighbourIntroductoryWidget({super.key, required this.neighbourModel});

//   @override
//   State<NeighbourIntroductoryWidget> createState() =>
//       _NeighbourIntroductoryWidgetState();
// }

// class _NeighbourIntroductoryWidgetState
//     extends State<NeighbourIntroductoryWidget> {
//   bool _isHovered = false;

//   bool _isMobile(BuildContext context) {
//     return MediaQuery.of(context).size.width < 750;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isMobile = _isMobile(context);

//     final cardWidth = isMobile ? screenWidth * 0.8 : 420.0;
//     final cardHeight = isMobile ? 450.0 : 450.0;
//     final imageHeight = isMobile ? 150.0 : 170.0;
//     final imageWidth = isMobile ? 100.0 : 130.0;

//     final card = AnimatedScale(
//       scale: _isHovered ? 1.03 : 1.0,
//       duration: const Duration(milliseconds: 200),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         width: cardWidth,
//         height: cardHeight,
//         padding: const EdgeInsets.all(20),
//         margin: const EdgeInsets.only(right: 15, bottom: 15),
//         decoration: AppContainerStyles.neighbourCard.copyWith(
//           color: AppColors.baseBright,
//           border: Border.all(
//             color: _isHovered
//                 ? AppColors.textBase.withOpacity(0.5)
//                 : AppColors.teal.withOpacity(0.5),
//             width: 2,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// Фото + инфо
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: imageHeight,
//                   width: imageWidth,
//                   decoration: AppContainerStyles.photoContainer.copyWith(
//                     border: Border.all(color: AppColors.baseBright),
//                     image: DecorationImage(
//                       image: AssetImage(
//                           widget.neighbourModel.neighbourPhoto),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           widget.neighbourModel.neighbourFullName,
//                           textAlign: TextAlign.center,
//                           style: AppTextStyles.neighbourName(context),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       _buildDetailItem(
//                         context,
//                         "Город: ${widget.neighbourModel.neighbourCity}",
//                       ),
//                       _buildDetailItem(
//                         context,
//                         "Район/метро: ${widget.neighbourModel.neighbourAddress}",
//                       ),
//                       _buildDetailItem(
//                         context,
//                         "Бюджет: ${widget.neighbourModel.neighbourCost}",
//                       ),
//                       _buildDetailItem(
//                         context,
//                         "Кол-во соседей: ${widget.neighbourModel.neighbourCount}",
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             Text(
//               "Описание:\n${widget.neighbourModel.neighbourDescription}",
//               style: AppTextStyles.neighbourDescription(context),
//             ),
//           ],
//         ),
//       ),
//     );

//     /// ✅ MouseRegion только для desktop
//     if (isMobile) return card;

//     return MouseRegion(
//       onEnter: (_) => setState(() => _isHovered = true),
//       onExit: (_) => setState(() => _isHovered = false),
//       child: card,
//     );
//   }
// }

// Widget _buildDetailItem(BuildContext context, String text) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 2),
//     child: Text(
//       text,
//       style: AppTextStyles.neighbourDetail(context),
//     ),
//   );
// }
