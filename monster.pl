/*-----Part 1-----*/
/* type basicType(t) */
basicType(water).
basicType(grass).
basicType(fire).
basicType(ghost).
basicType(normal).

/* monster and type monster(mo, t)*/
monster(chewtle, water).
monster(pansage, grass).
monster(rapidash, fire).
monster(shuppet, ghost).
monster(wooloo, normal).

/* move and type move(mv, t)*/
move(waterGun, water).
move(headbutt, normal).
move(hydroPump, water).
move(tackle, normal).

move(lick, ghost).
move(sunnyDay, fire).
move(seedBomb, grass).

move(flameCharge, fire).
move(quickAttack, normal).
move(overheat, fire).

move(hex, ghost).
move(shadowBall, ghost).
move(screech, normal).

move(grassySlide, grass).
move(stomp, normal).

/* monster and move monsterMove(mo ,mv)*/
monsterMove(chewtle, waterGun).
monsterMove(chewtle, headbutt).
monsterMove(chewtle, hydroPump).
monsterMove(chewtle, tackle).

monsterMove(pansage, lick).
monsterMove(pansage, sunnyDay).
monsterMove(pansage, seedBomb).
monsterMove(pansage, tackle).

monsterMove(rapidash, flameCharge).
monsterMove(rapidash, sunnyDay).
monsterMove(rapidash,quickAttack).
monsterMove(rapidash, overheat).

monsterMove(shuppet, hex).
monsterMove(shuppet, sunnyDay).
monsterMove(shuppet, shadowBall).
monsterMove(shuppet, screech).

monsterMove(wooloo, grassySlide).
monsterMove(wooloo, tackle).
monsterMove(wooloo, headbutt).
monsterMove(wooloo, stomp).

/*-----Part 2-----*/
/* effectiveness on type typeEffectiveness(t1, t2, e)*/

/*-----fire-----*/
typeEffectiveness(fire, fire, weak).
typeEffectiveness(fire, ghost, ordinary).
typeEffectiveness(fire, grass, strong).
typeEffectiveness(fire, water, weak).
typeEffectiveness(fire, normal, ordinary).

/*-----ghost-----*/
typeEffectiveness(ghost, fire, ordinary).
typeEffectiveness(ghost, ghost, strong).
typeEffectiveness(ghost, grass, ordinary).
typeEffectiveness(ghost, water, ordinary).
typeEffectiveness(ghost, normal, superweak).

/*-----grass-----*/
typeEffectiveness(grass, fire, weak).
typeEffectiveness(grass, ghost, ordinary).
typeEffectiveness(grass, grass, weak).
typeEffectiveness(grass, water, strong).
typeEffectiveness(grass, normal, ordinary).

/*-----water-----*/
typeEffectiveness(water, fire, strong).
typeEffectiveness(water, ghost, ordinary).
typeEffectiveness(water, grass, weak).
typeEffectiveness(water, water, weak).
typeEffectiveness(water, normal, ordinary).

/*-----normal-----*/
typeEffectiveness(normal, fire, ordinary).
typeEffectiveness(normal, ghost, superweak).
typeEffectiveness(normal, grass, ordinary).
typeEffectiveness(normal, water, ordinary).
typeEffectiveness(normal, normal, ordinary).

/*-----Part 3-----*/
/*-----defining the order of effectiveness -> strong > ordinary > weak > superweak moreEffective(e1, e2)*/
moreEffective(strong, ordinary).
moreEffective(ordinary, weak).
moreEffective(weak, superweak).

/*-----Part 4-----*/
/*-----defining transitive order of effectiveness using Prolog Rules (eg: strong > weak)
We use recursion as given in lecture slides 4B */

moreEffectiveThan(E1, E2) :- moreEffective(E1, E2).
moreEffectiveThan(E1, E2) :- moreEffective(E1, X), moreEffectiveThan(X, E2).

/*-----Part 5-----*/
/*-----Monster(MO) has a move(MV) which are both of the same type(X)*/
monsterMoveTypeMatch(MV, MO) :- monsterMove(MO, MV), monster(MO, X), move(MV, Y), (X = Y).

/*-----Part 6-----*/
/*MV1 is more effective than MV2 for monster type T.
First we find the move types of M1 (X) and M2 (Y), 
then we find how effective that move type is against the monster type T (A and B)
and finally define A more effective than B */
moreEffectiveTypeMove(T, MV1, MV2) :- move(MV1, X), move(MV2, Y),
                                      typeEffectiveness(X, T, A), typeEffectiveness(Y, T, B),
                                      moreEffectiveThan(A, B).

/* -----Part 7-----*/
/*For Monster MO1 performing MV1, and Monster 2 performing MV2,
We first find the types of the monsters (X and Y) and the types of the moves (A and B). 
We then find out how effective MV1 is against MO2 and how effective MV2 is against MO1 (E and F).
finally we define E more effective than F */

moreEffectiveMonsterMove(MO1, MO2, MV1,MV2) :- monsterMove(MO1, MV1), monsterMove(MO2, MV2),
                                               monster(MO1, X), monster(MO2, Y),
                                               move(MV1, A), move(MV2, B),
                                               typeEffectiveness(A, Y, E), typeEffectiveness(B, X, F),
                                               moreEffectiveThan(E, F).