import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final String name;
  final String species;
  final String image;

  const Character(
      {required this.name, required this.species, required this.image});

  @override
  List<Object?> get props => [name, species, image];
}
