% The idea here is to build a discrete event simulator for a coffee drive
% through.

drink(coffee).
drink(frap).

time_to_prepare(coffee, 2).
time_to_prepare(frap, 20).

ingredient(frap, sugar).

add_customers_to_queue(_, OutLines) :- OutLines = [].

simloop(Tick, WaitLines) :- (Tick < 100 -> 
                              format("~d", Tick),
                              simloop(Tick+1, WaitLines)
                            ; true).

