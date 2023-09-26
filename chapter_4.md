_set wrap to 70_

An interface should know as less as possible about the external world
to make it reusable in different contexts.

Defining interfaces:
A class should have atleast public and private interfaces, so that not
everything gets exposed to the outerworld. The private parts should 
contain implementation details for public methods.

UML diagrams:
Before starting to code/write tests, its important to visualize how
the internals in application will interact with each other. Having 
an idea of application on paper makes it makes it easier push and 
play around with the ideas. It also makes writing tests easier.

Context independence:
The current class should know as less as possible about the outside
world. It makes testing easier. There will be 3 examples in the lines
below, in increasing order of object oriented code.

Trip ----> Mechanic => Trip asks mechanic to prepare break and then 
                       change mobile, add fuel and so on.

Here it feels like Trip knows too much about the functionality of 
Mechanic. It knows about multiple points of Mechanic class.

Trip ----> Mechanic => Trip just sends bicycle to Mechanic, something
                       like `mechanic.prepare_bike` 

Improvement from last one, this time Trip just knows that mechanic
responds to prepare bike.

Trip ----> Mechanic => Trip just sends itself to Mechanic, something
                       like `mechanic.prepare_trip(self)`. Most likely
                       self contains details about trip details. It trusts
                       mechanic to understand trip details and send 
                       relevant, well maintained transports.Maybe, it's 
                       possible to return nothing at all and still do 
                       the job as side effect.

In first two examples trip has knowledge about bike.And it is sending
message to mechanic inorder to prepare bike. But, should the knowledge 
of bikes be in the domain of Trip? Like, should Trip class know about
bikes?
Last example solves the two questions presented above. Trip knows nothing
about bikes it just knows about a object who responds to `prepare_trip(some
trip_details)`. And it _trusts_ it to do its part. 
