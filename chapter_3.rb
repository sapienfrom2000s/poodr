# what is dependency?
#
# X depends on Y if X has to change if Y changes. 
# also say, X depends on A,B,C.... No of dependencies of X increases by
# 1 if some part of A/B/C... changes and it causes X to change.
# OOP is about making different objects interact with each other to
# complete the whole picture. It should be devs job to minimize dependencies
# .
#
# Try to find the number of dependencies in below's code.

 class Gear
   attr_reader :chainring, :cog, :rim, :tire
   def initialize(chainring, cog, rim, tire)
     @chainring = chainring
     @cog = cog
     @rim = rim
     @tire = tire
   end

   def gear_inches
     ratio * Wheel.new(rim, tire).diameter
   end

   def ratio
     chainring / cog.to_f
   end
   # ...
 end

 class Wheel
   attr_reader :rim, :tire
   def initialize(rim, tire)
     @rim = rim
     @tire = tire
   end

   def diameter
     rim + (tire * 2)
   end
   # ...
 end

#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
# If Wheel class name changes
# If number of argument changes for initialize in  Wheel class
# If order of argument changes for initialize
# Something happens to diameter method
#
# 
# Degree of coupleness(How tightly a code is coupled?)
#
# Higher the number of dependecies, tightly the code is coupled. 
# 
#
# Dependency injection 
#
# If you look into gear inches method, it depends explicitly on Wheel class
# What if lets say you want to calculate gear inches for another object that
# is not wheel. Fucked up, isn't it. How about instead passing an object that
# responds to diameter message.
#
# That would give you the flexibility to introduce objects other than Wheel
# instances.
#

def diameter
  ratio*(some_object_passed_that_responds_to_diameter.diameter)
end

# This idea is called dependency injection.
# The new code no longer depends on the Wheel class or the parameters, it
# just needs an object that resps to diameter.
# https://stackoverflow.com/questions/130794/what-is-dependency-injection
#
# What to do when you can't change dependencies?
#
#  module SomeFramework
 class Gear
 attr_reader :chainring, :cog, :wheel
 def initialize(chainring, cog, wheel)
 @chainring = chainring
 @cog = cog
 @wheel = wheel
 end
 # ...
 end
 end

 # wrap the interface to protect yourself from changes
 module GearWrapper
 def self.gear(args)
 SomeFramework::Gear.new(args[:chainring],
 args[:cog],
 args[:wheel])
 end
 end

 # Now you can create a new Gear using an arguments hash.
 GearWrapper.gear(
 :chainring => 52,
 :cog => 11,
 :wheel => Wheel.new(26, 1.5)).gear_inches

# We can't change the Gear class for some reasons but we also don't want
# to depend on the initialize order. So we wrap Gear class in the 
# GearWrapper which doesn't depends on order.
#
#
# Dependency direction
# A --> B --> C --> D
# Say, class A is the parent of B, B is the parent of C and so on.
# If you had the option to rearrange them, you would do it in the order
# of stable class --> less stable class --> least stable class
# The idea is that the less stable code is more likely to change and if 
# it lies more on the leaf side of the tree it would not result in huge 
# change to its childrens. Imagine, changing the String class for ruby.
# It would result in changing everywhere the String class is used.
