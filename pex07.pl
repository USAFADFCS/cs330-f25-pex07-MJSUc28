% pex7.pl
% USAFA UFO Sightings 2024
%
% name: Michael Ulery
%
% Documentation: None
%

% The query to get the answer(s) or that there is no answer
% ?- solve.


day(tuesday).
day(wednesday).
day(thursday).
day(friday).

cadet(smith).
cadet(garcia).
cadet(jones).
cadet(chen).

ufo(weather_balloon).
ufo(kite).
ufo(fighter).
ufo(cloud).


solve :-
    cadet(TuesPerson), cadet(WedPerson), cadet(ThursPerson), cadet(FriPerson),
    all_different([TuesPerson, WedPerson, ThursPerson, FriPerson]),
    
    ufo(TuesSighting), ufo(WedSighting),
    ufo(ThursSighting), ufo(FriSighting),
    all_different([TuesSighting, WedSighting, ThursSighting, FriSighting]),
    
    Triples = [ [TuesPerson, tuesday, TuesSighting],
                [WedPerson, wednesday, WedSighting],
                [ThursPerson, thursday, ThursSighting],
                [FriPerson, friday, FriSighting] ],
    
    %Smith did not see the weather ballon
    \+ member([smith, _, weather_balloon], Triples),
    %AND Smith did not see the kite
    \+ member([smith, _, kite], Triples),
    %Garcia did not see the kite
    \+ member([garcia, _, kite], Triples),
    %Friday sighting was made by chen or one who saw fighter aircraft
    ( (member([chen, friday, _], Triples),
       \+ member([_, friday, fighter], Triples));
      (\+ member([chen, friday, _], Triples),
       member([_, friday, fighter], Triples))  ),
    %Kite not seen on Tuesday
    \+ member([_, tuesday, kite], Triples),
    %Jones did not see the weather ballon
    \+ member([jones, _, weather_balloon], Triples),
    %AND Gargia did not see the weather ballon
    \+ member([garcia, _, weather_balloon], Triples),
    %Jones did not make their sighting on Tuesday
    \+ member([jones, tuesday, _], Triples),
    %Smith did see a cloud
    member([smith, _, cloud], Triples),
    %Fighter on Friday
    member([_, friday, fighter], Triples),
    %Weather balloon not on wednesday
    \+ member([_, wednesday, weather_balloon], Triples),
    
    
    tell(TuesPerson, tuesday, TuesSighting),
    tell(WedPerson, wednesday, WedSighting),
    tell(ThursPerson, thursday, ThursSighting),
    tell(FriPerson, friday, FriSighting). %Q2: Line ends on 57

% Succeeds if all elements of the argument list are bound and different.
% Fails if any elements are unbound or equal to some other element.
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(X, Y, Z) :-
    write('On '), write(Y), write(', '), write(X),
    write(' saw a '), write(Z), write('.'), nl.