FAAST Tube System
=======================

## Synopsis

Week 1 Makers Academy Challenge: the mayor of London has contacted the Greater London Authority to access the Transport for London Software Development and Deployment specifications for the new FAAST Tube System ( Fast And Accessible Super Tube). Your task is to implement the FAAST system so that it can be deployed into the London underground network.

## Technologies Used

- Ruby
- Rspec

## Job List

- There will be a number of trains inside the system.
- Trains will travel from station to station.
- Inside of a station, when the train stops, passengers will alight and enter the carriages of the train.
- A Passenger will touch in at the station and touch out at the destination station.
- Each coach of a train can hold up to 40 passengers.
- Each train is made of a number of coaches.

## Favourite Code Snippet

Train method for moving from station to station:

~~~
   def move(start_station, end_station)
    raise "Destination station is full" if end_station.full_of_trains?
    start_station.release_train(self)
    end_station.receive_train(self)
    @current_station = end_station
  end
~~~

## Collaborators

- None

## Still to complete/refactor

- None

## Takeaway

This was an important challenge for consolidating my understanding of objected oriented programming in ruby, ruby modules and Rspec testing (including using doubles). Through my code refactoring and one to ones with the teaching staff I learnt how good OO programming should be structured, tested and presented.