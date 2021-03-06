#
# Storing Input.
#
# Move the mouse across the screen to change the position
# of the circles. The positions of the mouse are recorded
# into an array and played back every frame. Between each
# frame, the newest value are added to the end of each array
# and the oldest value is deleted.
#

NUM = 60
attr_reader :pos
Vec = Struct.new(:x, :y)

def setup
  sketch_title 'Storing Input'
  @pos = Array.new(NUM, Vec.new(0, 0))  # initialize a array of Vec Struct
  noStroke()
  fill(255, 153)
end

def draw
  background(51)
  # Cycle through the array, using a different entry on each frame.
  # Using modulo (%) like this is faster than moving all the values over.
  which = frame_count % NUM
  pos[which] = Vec.new(mouse_x, mouse_y)
  (1..NUM).each do |i|
    # which + 1 is the smallest (the oldest in the array)
    idx = (which + i) % NUM
    ellipse(pos[idx].x, pos[idx].y, i, i)
  end
end

def settings
  size(640, 360)
  smooth(4)
end

