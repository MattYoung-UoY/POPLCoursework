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
adjacent2interchange(NonInterStation, InterchangeStation) :- station_numlines(NonInterStation, NumberOfLines), (NumberOfLines == 1), adjacent(InterchangeStation, NonInterStation), station_numlines(InterchangeStation, NumInterchangeLines), (NumInterchangeLines > 1).

%-------------------------------------------------------------------------------
%Test Cases
%route('TC', 'CL', Route).
%Route = ['TC', 'CL'] ;
%Route = ['TC', 'OC', 'WS', 'KX', 'LS', 'CL'] ;
%Route = ['TC', 'EM', 'OC', 'WS', 'KX', 'LS', 'CL'] ;
%Route = ['TC', 'WS', 'KX', 'LS', 'CL'] ;
%false.

%route('OC', 'CL', Route).
%Route = ['OC', 'EM', 'TC', 'CL'] ;
%Route = ['OC', 'EM', 'TC', 'WS', 'KX', 'LS', 'CL'] ;
%Route = ['OC', 'TC', 'CL'] ;
%Route = ['OC', 'TC', 'WS', 'KX', 'LS', 'CL'] ;
%Route = ['OC', 'WS', 'TC', 'CL'] ;
%Route = ['OC', 'WS', 'KX', 'LS', 'CL'] ;
%false.

%route calls the recursive function rt, appends the last station to the list, and then reverses the result, so that it is the correct order.
route(From, To, Route) :- rt(From, To, [], PartRoute), not(member(To, PartRoute)), reverse([To|PartRoute], Route).

%Base case (To and From are adjacent stations). Appends station From to the temporary route and then sets Route to this list.
rt(From, To, TempRt, Route) :- adjacent(To, From), not(member(From, TempRt)), Route = [From|TempRt].
%Recursive case. Gets all of the possible nodes that could be next in the list. Checks to see if this next node is not already in the list. Adds it to the list and then recursively calls the rt function with Next as the value for the From parameter.
rt(From, To, TempRt, Route) :- adjacent(From, Next), not(member(Next, TempRt)), rt(Next, To, [From|TempRt], Route).

%-------------------------------------------------------------------------------
%Test Cases
%route_time('FR', 'OC', Route, Minutes).
%Route = ['FR', 'BS', 'KX', 'WS', 'OC'],
%Minutes = 16 ;
%Route = ['FR', 'BS', 'KX', 'WS', 'TC', 'OC'],
%Minutes = 20 ;
%Route = ['FR', 'BS', 'KX', 'WS', 'TC', 'EM', 'OC'],
%Minutes = 24 ;
%Route = ['FR', 'BS', 'KX', 'LS', 'CL', 'TC', 'OC'],
%Minutes = 24 ;
%Route = ['FR', 'BS', 'KX', 'LS', 'CL', 'TC', 'EM', 'OC'],
%Minutes = 28 ;
%Route = ['FR', 'BS', 'KX', 'LS', 'CL', 'TC', 'WS', 'OC'],
%Minutes = 28 ;
%false.

%route_time('BR', 'VI', Route, Minutes).
%Route = ['BR', 'VI'],
%Minutes = 4 ;
%false.

%route_time uses the route function from the previous question to find the route.
%It then finds the length of the route, subtracts one to find the number of trains, and then multiplies the number of trains by 4 to find the journey time.
route_time(From, To, Route, Minutes) :- route(From, To, Route), length(Route, RtLen), Trains is RtLen - 1, Minutes is 4 * Trains.
















