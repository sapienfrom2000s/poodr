class Gear

  def initialize(chainring, cog)
    @chainring = chainring
    @cog       = cog
  end

  def ratio
    @chainring / @cog.to_f  # <-- road to ruin
  end
end

puts Gear.new(52, 11).ratio

# single responsibility principle:
# the simplest description you can devise
# uses the word “and,” the class likely has more than one responsibility

# instead of referencing instance variables, use attribute reader and 
# reference them, so that you can change it in one place if required.
# Like, you can do 'def chainring; @chainring*some_factor; end' if req
# uired, instead of finding '@chainring' and replacing it with '@chainring*
# some_factor'. It would look shabby as well. So, wrapper is preffered.

def diameters
  data.collect {|cell|
  cell[0] + (cell[1] * 2)}
end

# Why depend on messages instead of complex data structures?
#
# So, if you need the data structure in 10 different places, you would have
# to reference it in 10 different places. If data structure changes, you 
# would have to make changes in all 10 places. 
# Why not extract the data we want and bind it to the method. And when we
# need the data we can call the method. If anything changes about the data
# when can go to that method and make the changes.
# This gives a great flexibility to our code as we aren't directly dependent
# on any code but relying on the API to provide use the needed data.

class ObscuringReferences
 attr_reader :data
 def initialize(data)
   @data = data
 end

 def diameters
  # 0 is rim, 1 is tire
  data.collect {|cell|
  cell[0] + (cell[1] * 2)}
 end
end

# As you can see the above code depends on data structure very much.It knows
# cell[0] has to be 'X' and cell[1] has to be 'Y'. You can't even reuse the code
# as it very much relies on the structure.It has to follow a strict pattern of
# @data = [[622, 20], [622, 23], [559, 30], [559, 40]]

# Now, how about we use an API to breakdown the datastructure

 class RevealingReferences
   attr_reader :wheels
   def initialize(data)
     @wheels = wheelify(data)
   end

   def diameters
     wheels.collect {|wheel|
     wheel.rim + (wheel.tire * 2)}
   end
   # ... now everyone can send rim/tire to wheel

  Wheel = Struct.new(:rim, :tire)
  def wheelify(data)
    data.collect {|cell|
    Wheel.new(cell[0], cell[1])}
  end
 end

# You can see now, wheelify sort of acts like API, not really though. But the point 
# is any changes in the structure can be adjusted in the #wheelify method instead of
# #diameters. And if you think about it,#diameters now it can be reused as well as it 
# just needs wheel.rim and wheel.tire to respond.
 
# Why enforce single responsibility everywhere?
#
# Methods, like classes, should have a single responsibility. All of the same reasons
# apply; having just one responsibility makes them easy to change and easy to reuse.

def diameters
 wheels.collect {|wheel|
  wheel.rim + (wheel.tire * 2)}
end

# So this method is doing two things, traversing through DS and calculating the
# diameter. We can split the task into two methods

 # first - iterate over the array
 def diameters
  wheels.collect {|wheel| diameter(wheel)}
 end

 # second - calculate diameter of ONE wheel
 def diameter(wheel)
  wheel.rim + (wheel.tire * 2))
 end

# Now the second method can be easily used if someone just needs diameter of one
# wheel


# Isolate responsibilities of class
#
# I didn't get much, but she says to postponed the desicion as much as 
# possible. And every class should have only one responsibility. The 
# below code is something I haven't seen before.As you can see Wheel
# is introduced inside Gear class. Maybe, the idea is since Gear and 
# Wheel is too small now. We can comprehend the idea of Wheel inside
# Gear class, thus postponing the idea of creating a seperate wheel 
# class for later. But at the same time we acknowledge that Wheel req
# uires a different class.

 class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @wheel = Wheel.new(rim, tire)
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * wheel.diameter
  end

  Wheel = Struct.new(:rim, :tire) do
  def diameter
    rim + (tire * 2)
  end
  end
 end
