## Just Another Zombie RPG: An online turn-based tile-based RPG developed while learning web development.

Made with my mentor at [Bloc](http://bloc.io)

Basic functionality:

* Registering for an account.
* Ability to host and join games.
* Two factions - humans and zombies.
* One regular class for each faction.
* Two melee and two ranged weapons.
* One regular map to play on.

Ambitious functionality:

* Chat system.
* One advanced class for each faction.
* One extra map to play on.
* Third faction (The cult)

__

## Game design document:

Two classes for the humans:

- Survivor (basic class)
- Soldier (advanced class)

Two classes for the zombie faction:

- Regulars (basic class)
- Grunt (advanced class)

Map:

- Urban area (shopping district)

__

**Human Faction**

Basic combat stats:

Strength 
- increases threshold weight of weapons handling 
- increases threshold weight of carried items  
- melee weapon damage
- reduces stamina cost for swinging a melee weapon

Agility 
- determines running speed 
- evasion checks
- initiative checks

Perception
- determines firing accuracy and range 
- sight range
- observation checks
- reduces stamina cost for firing a ranged weapon

Endurance 
- determines stamina (action points)
- increases health points

__

Weapons:

Fire Axe
- Basic melee weapon

Sledgehammer
- Heavy melee weapon

Shotgun
- Short ranged weapon

Bolt-action rifle
- Long ranged weapon

__

Extra notes:

- Weapons have weight that require a certain amount of strength to carry. If your character has less than the strength required
to wield that weapon. He/She will suffer a penalties to accuracy and damage for melee weapons and accuracy for ranged weapons.

- Observation checks are automatic checks that a character make when noticing something strange in the battlefield - such as stealth
units or traps. Observation checks on the frontal vision of the character are 100%; while his side vision suffers a 50% penalty
and a 90% penalty for his/her back.

- Running speed is the distance a character can cover per action point spent.

__

** Zombie Faction**

Basic combat stats:

Strength
- increases melee damage
- minor increase to damage threshold

Agility
- determines attack accuracy
- determines running speed
- initiative checks

Endurance
- determines stamina (action points)
- increases health points and damage threshold

__

Type of attacks:

Attack
- A regular swinging punch
- Can cause knockdown / concussion

Bite
- Massive damage
- High chance of infection (causing death to the victim within 3 turns)