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

adj(wa, pa).
adj(pa, oc).
adj(nh, lg).
adj(lg, oc).
adj(br, vi).
adj(vi, oc).
adj(oc, em).
adj(oc, tc).
adj(oc, ws).
adj(em, ke).
adj(em, ec).
adj(em, tc).
adj(ws, tc).
adj(ws, eu).
adj(ws, kx).
adj(tc, cl).
adj(cl, ls).
adj(ls, al).
adj(ls, bg).
adj(ls, kx).
adj(kx, fp).
adj(kx, bs).
adj(bs, fr).

adjacent(X, Y) :- adj(X, Y) ; adj(Y, X).