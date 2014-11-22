# Data Model
## Set
A set is the lowest record of a workout.

* Activity   [String, required]  
*(e.g. Bench Press)*
* Weight [optional]
* Duration [optional]  
*(time in seconds)*
* Reps [Integer, optional]
* Units [String, optional]  
*(lbs/kg)*
* Comments [String, optional]

Add later?
* Distance [optional]  
*(meters/feet/miles?)*

## SetGroup
A set group is any grouping of sets

* Sets [List of set, required]
* Name [String]  
*(e.g. 3 rounds for time, warmup, accessory sets)*
* Duration [optional]

## Workout
* Date
* SetGroup
* Comments
* Name  
* Duration
*(e.g. Cindy)
