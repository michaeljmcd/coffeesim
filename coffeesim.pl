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

add_customers_to_queue(_, OutLines) :- 
  OutLines = [],
  true.

simloop(Tick, WaitLines) :- (Tick < 100 -> 
                              format("~d", Tick),
                              simloop(Tick+1, WaitLines)
                            ; true).

