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
