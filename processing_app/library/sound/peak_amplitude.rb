# This sketch shows how to use the Amplitude class to analyze the changing
# "loudness" of a stream of sound. In this case an audio sample is analyzed.
load_library :sound
java_import 'processing.sound.Amplitude'
java_import 'processing.sound.SoundFile'

# Declare the processing sound variables
attr_reader :sample, :rms, :sum
# Declare a smooth factor to smooth out sudden changes in amplitude.
# With a smooth factor of 1, only the last measured amplitude is used for the
# visualisation, which can lead to very abrupt changes. As you decrease the
# smooth factor towards 0, the measured amplitudes are averaged across frames,
# leading to more pleasant gradual changes
SMOOTH_FACTOR = 0.25

def settings
  size(640, 360)
end

def setup
  sketch_title 'Peak Amplitude'
  @sum = 0.0
  #Load and play a soundfile and loop it
  @sample = SoundFile.new(self, data_path('beat.aiff'))
  sample.loop
  # Create and patch the rms tracker
  @rms = Amplitude.new(self)
  rms.input(sample)
end

def draw
  # Set background color, noStroke and fill color
  background(125, 255, 125)
  noStroke()
  fill(255, 0, 150)
  # smooth the rms data by smoothing factor
  @sum += (rms.analyze - sum) * SMOOTH_FACTOR
  # rms.analyze() return a value between 0 and 1. It's
  # scaled to height/2 and then multiplied by a fixed scale factor
  rms_scaled = sum * (height / 2) * 5
  # We draw a circle whose size is coupled to the audio analysis
  ellipse(width / 2, height / 2, rms_scaled, rms_scaled)
end
