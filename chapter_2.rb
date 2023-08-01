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
