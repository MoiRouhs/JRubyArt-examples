# frozen_string_literal: true
# Tile factory
class TileFactory
  attr_reader :acute

  def initialize(acute = false)
    @acute = acute
  end

  # setup the initial tiling with all red tiles
  def tile(a, b, c)
    return ATile.new(0, a, b, c) if acute
    Tile.new(0, a, b, c)
  end
end

# Regular Tile class
class Tile
  include Processing::Proxy
  PHI = (1.0 + Math.sqrt(5)) / 2.0 # golden ratio
  COLORS = %w[#ff0000 #0000ff].freeze # red blue
  attr_reader :a, :b, :c, :col

  def initialize(col, a,  b,  c)
    @col, @a, @b, @c = col, a, b, c
  end

  def display
    no_stroke
    fill(color(COLORS[col]))
    triangle(a.x, a.y, b.x, b.y, c.x, c.y)
    # fill(0, 0, 255)
    # ellipse(a.x, a.y, 4,4)
    # ellipse(b.x, b.y, 4,4)
    # ellipse(c.x, c.y, 4,4)
  end

  def subdivide
    result = []
    if col.zero?
      # Subdivide red triangle
      p = b - a
      p /= PHI
      p += a
      result << Tile.new(0, c, p, b)
      result << Tile.new(1, p, c, a)
    else
      # Subdivide blue triangle
      q = a - b
      q /= PHI
      q += b
      r = c - b
      r /= PHI
      r += b
      result << Tile.new(1, r, c, a)
      result << Tile.new(1, q, r, b)
      result << Tile.new(0, r, q, a)
    end
    result
  end
end

# Acute Tile class
class ATile < Tile
  def subdivide
    result = []
    if col.zero?
      # Subdivide red (half kite) triangle
      q = b - a
      q /= PHI
      q += a
      r = c - b
      r /= PHI
      r += b
      result << ATile.new(1, r, q, b)
      result << ATile.new(0, q, a, r)
      result << ATile.new(0, c, a, r)
    else
      # Subdivide blue (half dart) triangle
      p = a - c
      p /= PHI
      p += c
      result << ATile.new(1, b, p, a)
      result << ATile.new(0, p, c, b)
    end
    result
  end
end
