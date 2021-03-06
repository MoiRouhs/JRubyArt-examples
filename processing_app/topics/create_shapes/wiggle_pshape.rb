#
# WigglePShape.
# wiggler library uses PVector, see vecmath library
# examples to see alternative using Vec2D
# How to move the individual vertices of a PShape
#

load_library :wiggler

attr_reader :wiggler

def setup
  sketch_title 'Wiggle PShape'
  @wiggler = Wiggler.new width, height
end

def draw
  background(255)
  wiggler.display
  wiggler.wiggle
end

def settings
  size(640, 360, P2D)
end
