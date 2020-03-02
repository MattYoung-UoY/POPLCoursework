station('AL', [metropolitan]).
station('BG', [central]).
station('BR', [victoria]).
station('BS', [metropolitan]).
station('CL', [central]).
station('EC', [bakerloo]).
station('EM', [bakerloo, northern]).
station('EU', [northern]).
station('FP', [victoria]).
station('FR', [metropolitan]).
station('KE', [northern]).
station('KX', [metropolitan, victoria]).
station('LG', [central]).
station('LS', [central, metropolitan]).
station('NH', [central]).
station('OC', [bakerloo, central, victoria]).
station('PA', [bakerloo]).
station('TC', [central, northern]).
station('VI', [victoria]).
station('WA', [bakerloo]).
station('WS', [northern, victoria]).

%-------------------------------------------------------------------------------

%Checks to see if a predicate for station X exists
station_exists(X) :- station(X, _).

%-------------------------------------------------------------------------------

adj('WA', 'PA').
adj('PA', 'OC').
adj('NH', 'LG').
adj('LG', 'OC').
adj('BR', 'VI').
adj('VI', 'OC').
adj('OC', 'EM').
adj('OC', 'TC').
adj('OC', 'WS').
adj('EM', 'KE').
adj('EM', 'EC').
adj('EM', 'TC').
adj('WS', 'TC').
adj('WS', 'EU').
adj('WS', 'KX').
adj('TC', 'CL').
adj('CL', 'LS').
adj('LS', 'AL').
adj('LS', 'BG').
adj('LS', 'KX').
adj('KX', 'FP').
adj('KX', 'BS').
adj('BS', 'FR').

adjacent(X, Y) :- adj(X, Y) ; adj(Y, X).

%-------------------------------------------------------------------------------
%Test Cases
%sameLine('WA', 'EC', Line).
%Line = bakerloo.

%sameLine('FP', 'KE', Line).
%false.

%sameLine('OC', 'KX', Line).
%Line = victoria.

%sameLine('PA', 'KX', Line).
%false.

%sameLine checks if the stations exist, and then check that the specified line is a member of the lists of lines for both stations.
sameLine(Station1, Station2, Line) :- station(Station1, X), station(Station2, Y), member(Line, X), member(Line, Y).

%-------------------------------------------------------------------------------
%Test Cases
%line(metropolitan,ListOfStations).
%ListOfStations = ['AL', 'BS', 'FR', 'KX', 'LS'].

%line(victoria, ListOfStations).
%ListOfStations = ['BR', 'FP', 'KX', 'OC', 'VI', 'WS'].

%line(northern, ListOfStations).
%ListOfStations = ['EM', 'EU', 'KE', 'TC', 'WS'].

%line finds all Stations where Line belongs to the list of lines of the station.
line(Line, ListOfStations) :- findall(Station, (station(Station, Lines), member(Line, Lines)), ListOfStations).

%-------------------------------------------------------------------------------
%Test Cases
%station_numlines('AL', NumberOfLines).
%NumberOfLines = 1.

%station_numlines('EM', NumberOfLines).
%NumberOfLines = 2.

%station_numlines('OC', NumberOfLines).
%NumberOfLines = 3.

%station_numlines('TC', NumberOfLines).
%NumberOfLines = 2.

%station_numlines finds the list of lines for the given station and then returns the length of that list.
station_numlines(Station, NumberOfLines) :- station(Station, Lines), length(Lines, NumberOfLines).

%-------------------------------------------------------------------------------
%Test Cases
%adjacent2interchange('OC', InterchangeStation).
%false.

%adjacent2interchange('CL', InterchangeStation).
%InterchangeStation = 'TC' ;
%InterchangeStation = 'LS'.

%adjacent2interchange('PA', InterchangeStation).
%InterchangeStation = 'OC'.

%adjacent2interchange checks to see if the station is not an interchange station. If it is then it returns false. Otherwise it looks for all of the adjacent interchange stations and returns them one at a time.
adjacent2interchange(NonInterStation, InterchangeStation) :- station_numlines(NonInterStation, NumberOfLines), (NumberOfLines =:= 1), adjacent(InterchangeStation, NonInterStation), station_numlines(InterchangeStation, NumInterchangeLines), (NumInterchangeLines > 1).

%-------------------------------------------------------------------------------





















