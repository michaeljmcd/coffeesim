% The idea here is to build a discrete event simulator for a coffee drive
% through.

drink(coffee).
drink(frap).

time_for(coffee, 2).
time_for(frap, 20).

time_for(sugar, 1).
time_for(milk, 1).

ingredient(frap, sugar).

time_to_prepare(Base, Options, TotalTime) :- 
  time_for(Base, BaseTime),
  maplist(time_for, Options, AddOnTimes),
  sum_list(AddOnTimes, TotalAddOnTime),
  TotalTime is BaseTime + TotalAddOnTime.

add_customers_to_queue(InLine, Tick, OutLines) :- 
  random_between(0, 1, CoinFlip),
  (CoinFlip = 1 ->
    OutLines = [car(Tick)|InLine]
    ; OutLines = InLine),
  true.

add_customers_to_queues([], _, OutLines) :- OutLines = OutLines.
add_customers_to_queues([FirstQ|RestQ], Tick, OutLines) :-
  add_customers_to_queue(FirstQ, Tick, OutQ),
  add_customers_to_queues(RestQ, Tick, OutQs),
  OutLines = [OutQ|OutQs].

simloop(Tick, WaitLines) :- (Tick < 100 -> 
                              format("Tick: ~d~n", Tick),
                              add_customers_to_queues(WaitLines, Tick, WaitLines2),
                              format("Lines: ~w~n", WaitLines2),
                              simloop(Tick+1, WaitLines)
                            ; true).

