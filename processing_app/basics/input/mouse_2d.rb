# Moving the mouse changes the position and size of each box.
def setup
  sketch_title 'Mouse 2d'
  no_stroke
  color_mode RGB, 255, 255, 255, 100
  rect_mode CENTER
end

def draw
  background 51
  fill 255, 80
  rect mouse_x, height / 2, mouse_y / 2 + 10, mouse_y / 2 + 10
  fill 255, 80
  inverse_x = width - mouse_x
  inverse_y = height - mouse_y
  rect inverse_x, height / 2, inverse_y / 2 + 10, inverse_y/ 2 + 10
end

def settings
  size 640, 360
end
