// import 'package:flutter/material.dart';

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }



class NeighbourModel{
  final String neighbourFullName;
  final String neighbourPhoto;
  final String neighbourName;
  final String neighbourSurname;
  final int neighbourAge;
  final String neighbourCity;
  final String neighbourAddress;
  final int neighbourCost;
  final String neighbourDescription;
  final int neighbourCount;

  NeighbourModel({required this.neighbourName, 
  required this.neighbourFullName, required this.neighbourPhoto, 
  required this.neighbourSurname, required this.neighbourAge, 
  required this.neighbourCity, required this.neighbourAddress, 
  required this.neighbourCost, required this.neighbourDescription, required this.neighbourCount});
}

List<NeighbourModel> neighbourModels =[
  NeighbourModel(neighbourName: "Саша", 
  neighbourFullName: "Саша Александров", 
  neighbourPhoto: "asset/images/smart_guy.jpg", 
  neighbourSurname: "Александров", 
  neighbourAge: 25, neighbourCity: "Москва", 
  neighbourAddress: "метро Длинное, Сырниковое шоссе, д.12", 
  neighbourCost: 35000, 
  neighbourDescription: """Работаю удаленно разработчиком, поэтому часто нахожусь дома. Ищу спокойное жилье без шумных вечеринок. В быту чистоплотный, убираю за собой. Уважаю личное пространство. Из увлечений: гитара (играю тихо, в наушниках), настолки, бег по утрам. Ищу соседа, с которым можно иногда пить кофе и молча работать в одной комнате, но в основном — просто мирно сосуществовать. Не курю, к алкоголю отношусь нейтрально.""", neighbourCount: 4),
  NeighbourModel(neighbourName: "Саша", 
  neighbourFullName: "Саша Александров", 
  neighbourPhoto: "asset/images/smart_guy.jpg", 
  neighbourSurname: "Александров", 
  neighbourAge: 25, neighbourCity: "Москва", 
  neighbourAddress: "метро Длинное, Сырниковое шоссе, д.12", 
  neighbourCost: 35000, 
  neighbourDescription: """Работаю удаленно разработчиком, поэтому часто нахожусь дома. Ищу спокойное жилье без шумных вечеринок. В быту чистоплотный, убираю за собой. Уважаю личное пространство. Из увлечений: гитара (играю тихо, в наушниках), настолки, бег по утрам. Ищу соседа, с которым можно иногда пить кофе и молча работать в одной комнате, но в основном — просто мирно сосуществовать. Не курю, к алкоголю отношусь нейтрально.""", neighbourCount: 4),
  NeighbourModel(neighbourName: "Саша", 
  neighbourFullName: "Саша Александров", 
  neighbourPhoto: "asset/images/smart_guy.jpg", 
  neighbourSurname: "Александров", 
  neighbourAge: 25, neighbourCity: "Москва", 
  neighbourAddress: "метро Длинное, Сырниковое шоссе, д.12", 
  neighbourCost: 35000, 
  neighbourDescription: """Работаю удаленно разработчиком, поэтому часто нахожусь дома. Ищу спокойное жилье без шумных вечеринок. В быту чистоплотный, убираю за собой. Уважаю личное пространство. Из увлечений: гитара (играю тихо, в наушниках), настолки, бег по утрам. Ищу соседа, с которым можно иногда пить кофе и молча работать в одной комнате, но в основном — просто мирно сосуществовать. Не курю, к алкоголю отношусь нейтрально.""", neighbourCount: 4),
  NeighbourModel(neighbourName: "Саша", 
  neighbourFullName: "Саша Александров", 
  neighbourPhoto: "asset/images/smart_guy.jpg", 
  neighbourSurname: "Александров", 
  neighbourAge: 25, neighbourCity: "Москва", 
  neighbourAddress: "метро Длинное, Сырниковое шоссе, д.12", 
  neighbourCost: 35000, 
  neighbourDescription: """Работаю удаленно разработчиком, поэтому часто нахожусь дома. Ищу спокойное жилье без шумных вечеринок. В быту чистоплотный, убираю за собой. Уважаю личное пространство. Из увлечений: гитара (играю тихо, в наушниках), настолки, бег по утрам. Ищу соседа, с которым можно иногда пить кофе и молча работать в одной комнате, но в основном — просто мирно сосуществовать. Не курю, к алкоголю отношусь нейтрально.""", neighbourCount: 4),
  NeighbourModel(neighbourName: "Саша", 
  neighbourFullName: "Саша Александров", 
  neighbourPhoto: "asset/images/smart_guy.jpg", 
  neighbourSurname: "Александров", 
  neighbourAge: 25, neighbourCity: "Москва", 
  neighbourAddress: "метро Длинное, Сырниковое шоссе, д.12", 
  neighbourCost: 35000, 
  neighbourDescription: """Работаю удаленно разработчиком, поэтому часто нахожусь дома. Ищу спокойное жилье без шумных вечеринок. В быту чистоплотный, убираю за собой. Уважаю личное пространство. Из увлечений: гитара (играю тихо, в наушниках), настолки, бег по утрам. Ищу соседа, с которым можно иногда пить кофе и молча работать в одной комнате, но в основном — просто мирно сосуществовать. Не курю, к алкоголю отношусь нейтрально.""", neighbourCount: 4),
  NeighbourModel(neighbourName: "Саша", 
  neighbourFullName: "Саша Александров", 
  neighbourPhoto: "asset/images/smart_guy.jpg", 
  neighbourSurname: "Александров", 
  neighbourAge: 25, neighbourCity: "Москва", 
  neighbourAddress: "метро Длинное, Сырниковое шоссе, д.12", 
  neighbourCost: 35000, 
  neighbourDescription: """Работаю удаленно разработчиком, поэтому часто нахожусь дома. Ищу спокойное жилье без шумных вечеринок. В быту чистоплотный, убираю за собой. Уважаю личное пространство. Из увлечений: гитара (играю тихо, в наушниках), настолки, бег по утрам. Ищу соседа, с которым можно иногда пить кофе и молча работать в одной комнате, но в основном — просто мирно сосуществовать. Не курю, к алкоголю отношусь нейтрально.""", neighbourCount: 4)
];