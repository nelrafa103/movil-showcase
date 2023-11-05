import 'dart:ui';

const Fire = Color(0xffEE8130);
const FireLighter = Color(0xffFFA550);
const FireDarker = Color(0xffC56600);

const Water = Color(0xff6390F0);
const WaterLighter = Color(0xff90B4FF);
const WaterDarker = Color(0xff3E68C2);

const Electric = Color(0xffF7D02C);
const ElectricLighter = Color(0xffFFEA79);
const ElectricDarker = Color(0xffC9AA00);

const Grass = Color(0xff7AC74C);
const GrassLighter = Color(0xff9ED379);
const GrassDarker = Color(0xff5B8B29);

const Ice = Color(0xff96D9D6);
const IceLighter = Color(0xffB3ECE9);
const IceDarker = Color(0xff6BA5A3);

const Fighting = Color(0xffC22E28);
const FightingLighter = Color(0xffD84B46);
const FightingDarker = Color(0xff901C18);

const Poison = Color(0xffA33EA1);
const PoisonLighter = Color(0xffC05AB7);
const PoisonDarker = Color(0xff7A2973);

const Ground = Color(0xffE2BF65);
const GroundLighter = Color(0xffF0D580);
const GroundDarker = Color(0xffB79B50);

const Flying = Color(0xffA98FF3);
const FlyingLighter = Color(0xffBCABFF);
const FlyingDarker = Color(0xff8965C9);

const Psychic = Color(0xffF95587);
const PsychicLighter = Color(0xffFF7AA3);
const PsychicDarker = Color(0xffC9315D);

const Bug = Color(0xffA6B91A);
const BugLighter = Color(0xffC1D43D);
const BugDarker = Color(0xff869314);

const Rock = Color(0xffB6A136);
const RockLighter = Color(0xffD0C956);
const RockDarker = Color(0xff8C7C15);

const Ghost = Color(0xff735797);
const GhostLighter = Color(0xff8F74B2);
const GhostDarker = Color(0xff5B4F75);

const Dragon = Color(0xff6F35FC);
const DragonLighter = Color(0xff8B5BFF);
const DragonDarker = Color(0xff4921C2);

const Dark = Color(0xff705746);
const DarkLighter = Color(0xff8B6C61);
const DarkDarker = Color(0xff513E37);

const Steel = Color(0xffB7B7CE);
const SteelLighter = Color(0xffD0D0E4);
const SteelDarker = Color(0xff8A8AA6);

const Fairy = Color(0xffD685AD);
const FairyLighter = Color(0xffEF9FC6);
const FairyDarker = Color(0xffB65E86);

const Normal = Color(0xffA8A77A);
const NormalLighter = Color(0xffC3C2A2);
const NormalDarker = Color(0xff8B8A60);


const Custom_Colors = {
  "fire": {
    "color": Fire,
    "lighter": FireLighter,
    "darker": FireDarker,
  },

  "water": {
    "color": Water,
    "lighter": WaterLighter,
    "darker": WaterDarker,
  },

  "electric": {
    "color": Electric,
    "lighter": ElectricLighter,
    "darker": ElectricDarker,
  },

  "grass": {
    "color": Grass,
    "lighter": GrassLighter,
    "darker": GrassDarker,
  },

  "ice": {
    "color": Ice,
    "lighter": IceLighter,
    "darker": IceDarker,
  },

  "fighting": {
    "color": Fighting,
    "lighter": FightingLighter,
    "darker": FightingDarker,
  },

  "poison": {
    "color": Poison,
    "lighter": PoisonLighter,
    "darker": PoisonDarker,
  },

  "ground": {
    "color": Ground,
    "lighter": GroundLighter,
    "darker": GroundDarker,
  },

  "flying": {
    "color": Flying,
    "lighter": FlyingLighter,
    "darker": FlyingDarker,
  },

  "psychic": {
    "color": Psychic,
    "lighter": PsychicLighter,
    "darker": PsychicDarker,
  },

  "bug": {
    "color": Bug,
    "lighter": BugLighter,
    "darker": BugDarker,
  },

  "rock": {
    "color": Rock,
    "lighter": RockLighter,
    "darker": RockDarker,
  },

  "ghost": {
    "color": Ghost,
    "lighter": GhostLighter,
    "darker": GhostDarker,
  },

  "dragon": {
    "color": Dragon,
    "lighter": DragonLighter,
    "darker": DragonDarker,
  },

  "dark": {
    "color": Dark,
    "lighter": DarkLighter,
    "darker": DarkDarker,
  },

  "steel": {
    "color": Steel,
    "lighter": SteelLighter,
    "darker": SteelDarker,
  },

  "fairy": {
    "color": Fairy,
    "lighter": FairyLighter,
    "darker": FairyDarker,
  },

  "normal": {
    "color": Normal,
    "lighter": NormalLighter,
    "darker": NormalDarker,
  },


};

 
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
