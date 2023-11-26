import 'dart:ui';

const Fire = Color(0xffFB9B51);
const FireLighter = Color(0xffFFA550);
const FireDarker = Color(0xffC56600);

const Water = Color(0xff4A90DD);
const WaterLighter = Color(0xff90B4FF);
const WaterDarker = Color(0xff3E68C2);

const Electric = Color(0xffEDD53E);
const ElectricLighter = Color(0xffFFEA79);
const ElectricDarker = Color(0xffd28700);

const Grass = Color(0xff5FBC51);
const GrassLighter = Color(0xff9ED379);
const GrassDarker = Color(0xff5fa900);

const Ice = Color(0xff70CCBD);
const IceLighter = Color(0xffB3ECE9);
const IceDarker = Color(0xff00b6b4);

const Fighting = Color(0xffCE4265);
const FightingLighter = Color(0xffD84B46);
const FightingDarker = Color(0xff901C18);

const Poison = Color(0xffA864C7);
const PoisonLighter = Color(0xffC05AB7);
const PoisonDarker = Color(0xff7A2973);

const Ground = Color(0xffDC7545);
const GroundLighter = Color(0xffff9f73);
const GroundDarker = Color(0xff86441f);

const Flying = Color(0xff90A7DA);
const FlyingLighter = Color(0xffb2ccff);
const FlyingDarker = Color(0xff546794);

const Psychic = Color(0xffF66F71);
const PsychicLighter = Color(0xffFF7AA3);
const PsychicDarker = Color(0xffC9315D);

const Bug = Color(0xff92BC2C);
const BugLighter = Color(0xffC1D43D);
const BugDarker = Color(0xff869314);

const Rock = Color(0xffC5B489);
const RockLighter = Color(0xffffedc3);
const RockDarker = Color(0xff796336);

const Ghost = Color(0xff516AAC);
const GhostLighter = Color(0xff91aeff);
const GhostDarker = Color(0xff34469f);

const Dragon = Color(0xff0C69C8);
const DragonLighter = Color(0xff2e94ff);
const DragonDarker = Color(0xff153d70);

const Dark = Color(0xff6E7587);
const DarkLighter = Color(0xff4e69b7);
const DarkDarker = Color(0xff3a3d4d);

const Steel = Color(0xff52869D);
const SteelLighter = Color(0xff8ec7e3);
const SteelDarker = Color(0xff385364);

const Fairy = Color(0xffEC8CE5);
const FairyLighter = Color(0xffEF9FC6);
const FairyDarker = Color(0xffB65E86);

const Normal = Color(0xff9298A4);
const NormalLighter = Color(0xffc7d1de);
const NormalDarker = Color(0xff4c535e);


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
