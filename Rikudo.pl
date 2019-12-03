linkMember(_, LS, OL, [], X):- X = LS, length(LS, R), length(OL, S), R \== S.
linkMember((A,B,C,D), LS, OL, [(A,B,C,D)|T], X):- linkMember((A,B,C,D), LS, OL, T, X).
linkMember((A,B,C,D), LS, OL, [(C,D,A,B)|T], X):- linkMember((A,B,C,D), LS, OL, T, X).
linkMember((D,E,F,G), LS, OL, [H|T], X):- linkMember((D,E,F,G), [H|LS], OL, T, X).

memberInPreFilled(_, []).
memberInPreFilled((A,B,Z), [(A,B,Z)|_]).
memberInPreFilled((C,G,Z), [(E,F,D)|T]):- Z \== D, (C,G) \== (E,F), memberInPreFilled((C,G,Z), T).

position(Filled, Size, Size, point(_, _), _, _, X, _, _):- X = Filled.
position(Filled, Z, Size, point(A,B), PreFilled, Links, R, UL, LL):- Z < Size, A =< UL, B =< LL, A >= -UL, B >= -LL, (abs(A)+abs(B)) =< UL, (A, B) \== (0,0),

												memberInPreFilled((A,B,Z), PreFilled),

 												(\+ (member((A,B,_), Filled))), (linkMember((A,B,C,D), [], Links, Links, NewLinks) -> (U is Z+1, position([(A,B,Z)|Filled], U, Size, point(C,D), PreFilled, NewLinks, R, UL, LL))
												  											;
																			  	  		  (
																						   X is A-2, Y is B, U is Z+1, position([(A,B,Z)|Filled], U, Size, point(X, Y), PreFilled, Links, R, UL, LL);
																						   X is A-1, Y is B+1, U is Z+1, position([(A,B,Z)|Filled], U, Size, point(X, Y), PreFilled, Links, R, UL, LL);
																						   X is A-1, Y is B-1, U is Z+1, position([(A,B,Z)|Filled], U, Size, point(X, Y), PreFilled, Links, R, UL, LL);
																						   X is A+2, Y is B, U is Z+1, position([(A,B,Z)|Filled], U, Size, point(X, Y), PreFilled, Links, R, UL, LL);
																						   X is A+1, Y is B+1, U is Z+1, position([(A,B,Z)|Filled], U, Size, point(X, Y), PreFilled, Links, R, UL, LL);
																			   			   X is A+1, Y is B-1, U is Z+1, position([(A,B,Z)|Filled], U, Size, point(X, Y), PreFilled, Links, R, UL, LL))).



findOne(37, [], U, V):- U = 3, V = 3.
findOne(61, [], U, V):- U = 4, V = 4.
findOne(91, [], U, V):- U = 5, V = 5.
findOne(_, [(A, B, 1)|_], U, V):- U = A, V = B.
findOne(S, [_|T], U, V):- findOne(S, T, U, V).

limits(37, UL, LL):- UL = 6, LL = 3.
limits(61, UL, LL):- UL = 8, LL = 4.
limits(91, UL, LL):- UL = 10, LL = 5.

rikudo(Size, PreFilled, Links, Res):- findOne(Size, PreFilled, U, V), limits(Size, UL, LL),
									position([(0,0,-10)], 1, Size, point(U,V), PreFilled, Links, Res, UL, LL).
