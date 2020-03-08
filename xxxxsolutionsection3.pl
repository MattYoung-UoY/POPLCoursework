%Defining the sum predicate which calls the recursiveSum predicate
sum(Lst, Sum) :- recursiveSum(Lst, Sum).
%Base case for the recursiveSum predicate. If the list is empty then the sum is 0
recursiveSum([],0).
%Recursive case for the recursiveSum predicate. Sum is equal to the first element, plus the sum of the remaining elements
recursiveSum([First|Tail], Sum) :- recursiveSum(Tail, PartSum), Sum is PartSum + First.

%Test Cases

%sum([1, 2, 3], X).
%X=6.

%sum([1, 2, 3], 6).
%true.

%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

%Defining the desc predicate
desc(Lst) :- descending(Lst).
%Base cases for the desc predicate. If the list is empty, or has only one element, then the list is descending. ! stops any further backtracking, so that multiple answers are not given, just the correct one.
descending([]) :- !.
descending([_]) :- !.
%Recursive case for the descending predicate. If the first element is more than the second element, and the list without the first element is descending, then the whole list is descending
descending([X,Y|Z]) :- X > Y, descending([Y|Z]).

%Test Cases

%desc([5,3,2,0]).
%true.

%desc([5,3,2,0,1]).
%false.

%desc([1]).
%true.

%desc([]).
%true.