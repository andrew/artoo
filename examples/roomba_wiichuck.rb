require 'artoo'

connection :roomba, :adaptor => :roomba, :port => '8023'
device :roomba, :driver => :roomba, :connection => :roomba

connection :arduino, :adaptor => :firmata, :port => '/dev/ttyACM0' #linux
device :wiichuck, :driver => :wiichuck, :connection => :arduino, :interval => 0.1
  
work do
  roomba.safe_mode
  on wiichuck, :z_button => proc { 
    C1 = 66
    D1 = 74
    E1 = 83
    F1 = 88
    A2 = 100
    QUARTER = 16
    HALF = 57
    la_cucaracha = []
    la_cucaracha << [C1, QUARTER] 
    la_cucaracha << [C1, QUARTER]
    la_cucaracha << [C1, QUARTER] 
    la_cucaracha << [F1, HALF] 
    la_cucaracha << [A2, QUARTER] 
    la_cucaracha << [C1, QUARTER]
    la_cucaracha << [C1, QUARTER]
    la_cucaracha << [C1, QUARTER] 
    la_cucaracha << [F1, HALF] 
    la_cucaracha << [A2, QUARTER] 
    la_cucaracha << [F1, QUARTER] 
    la_cucaracha << [F1, QUARTER] 
    la_cucaracha << [E1, QUARTER] 
    la_cucaracha << [E1, QUARTER] 
    la_cucaracha << [D1, QUARTER] 
    la_cucaracha << [D1, QUARTER] 
    la_cucaracha << [C1, QUARTER] 
    roomba.play_song(la_cucaracha)
  }
  on wiichuck, :joystick => proc { |*value|

    pair = value[1]

    if pair[:y] > 10
      roomba.forward(1)
    elsif pair[:y] < -10
      roomba.backwards(1)
    end

    if pair[:x] > 10
      roomba.turn_right
    elsif pair[:x] < -10
      roomba.turn_left
    end

  }
end
