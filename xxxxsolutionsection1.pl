station(al, [metropolitan]).
station(bg, [central]).
station(br, [victoria]).
station(bs, [metropolitan]).
station(cl, [central]).
station(ec, [bakerloo]).
station(em, [bakerloo, northern]).
station(eu, [northern]).
station(fp, [victoria]).
station(fr, [metropolitan]).
station(ke, [northern]).
station(kx, [metropolitan, victoria]).
station(lg, [central]).
station(ls, [central, metropolitan]).
station(nh, [central]).
station(oc, [bakerloo, central, victoria]).
station(pa, [bakerloo]).
station(tc, [central, northern]).
station(vi, [victoria]).
station(wa, [bakerloo]).
station(ws, [northern, victoria]).

%Checks to see if a predicate for station X exists
station_exists(X) :- station(X, _).