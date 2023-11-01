import 'dart:ui';

const Fire = Color(0xffEE8130);
const Water = Color(0xff6390F0);
const Electric = Color(0xffF7D02C);
const Grass = Color(0xff7AC74C);
const Ice = Color(0xff96D9D6);
const Fighting = Color(0xffC22E28);
const Poison = Color(0xffA33EA1);
const Ground = Color(0xffE2BF65);
const Flying = Color(0xffA98FF3);
const Psychic = Color(0xffF95587);
const Bug = Color(0xffA6B91A);
const Rock = Color(0xffB6A136);
const Ghost = Color(0xff735797);
const Dragon = Color(0xff6F35FC);
const Dark = Color(0xff705746);
const Steel = Color(0xffB7B7CE);
const Fairy = Color(0xffD685AD);
const Normal = Color(0xffA8A77A);

Color checkColor(String type) {
  switch (type) {
    case 'fire':
      return Fire;

    case 'water':
      return Water;

    case 'electric':
      return Electric;

    case 'grass':
      return Grass;

    case 'ice':
      return Ice;

    case 'fighting':
      return Fighting;

    case 'poison':
      return Poison;

    case 'ground':
      return Ground;

    case 'flying':
      return Flying;

    case 'psychic':
      return Psychic;

    case 'bug':
      return Bug;

    case 'rock':
      return Rock;

    case 'ghost':
      return Ghost;

    case 'dragon':
      return Dragon;

    case 'dark':
      return Dark;

    case 'steel':
      return Steel;

    case 'fairy':
      return Fairy;

    default:
      return Normal;
  }
}
