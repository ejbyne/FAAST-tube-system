[![Code Climate](https://codeclimate.com/github/ejbyne/FAAST-tube-system/badges/gpa.svg)](https://codeclimate.com/github/ejbyne/FAAST-tube-system)
[![Test Coverage](https://codeclimate.com/github/ejbyne/FAAST-tube-system/badges/coverage.svg)](https://codeclimate.com/github/ejbyne/FAAST-tube-system)

# FAAST Tube System

## Summary

Week 1 Makers Academy Challenge: the mayor of London has contacted the Greater London Authority to access the Transport for London Software Development and Deployment specifications for the new FAAST Tube System ( Fast And Accessible Super Tube). Your task is to implement the FAAST system so that it can be deployed into the London underground network.

This was an important challenge for consolidating my understanding of objected oriented programming in Ruby, Ruby modules and Rspec testing (including using doubles). Through my code refactoring and one to ones with the teaching staff I learnt how good OO programming should be structured, tested and presented.

## Technologies Used

- Ruby
- Rspec

## Completed tasks

- There will be a number of trains inside the system.
- Trains will travel from station to station.
- Inside of a station, when the train stops, passengers will alight and enter the carriages of the train.
- A Passenger will touch in at the station and touch out at the destination station.
- Each coach of a train can hold up to 40 passengers.
- Each train is made of a number of coaches.

##Instructions

Clone the repo on your machine:
```
$ git clone https://github.com/ejbyne/FAAST-tube-system.git
```

Change into the directory and run the tests:
```
$ cd FAAST-tube-system
$ rspec
```

## Favourite Code Snippet

Train method for moving from station to station:

```ruby
   def move(start_station, end_station)
    raise "Destination station is full" if end_station.full_of_trains?
    start_station.release_train(self)
    end_station.receive_train(self)
    @current_station = end_station
  end
```
