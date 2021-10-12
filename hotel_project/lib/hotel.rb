require_relative "room"

class Hotel
  def initialize(hotel_name, rooms_hash)
    @name = hotel_name
    @rooms = {}
    rooms_hash.each { |room, capacity| @rooms[room] = Room.new(capacity) }
  end

  def name
    @name
        .split
        .map(&:capitalize)
        .join(" ")
  end

  attr_reader :rooms

  def room_exists?(query)
    rooms.keys.include?(query)
  end

  def check_in(person, room_name)
    this_room = rooms[room_name]
    if !room_exists?(room_name)
        puts "sorry, room does not exist"
    else
        if this_room.add_occupant(person)
            puts "check in successful"
        else 
            puts "sorry, room is full"
        end
    end
  end 

  def has_vacancy?
    rooms.values.any? { |room_obj| !room_obj.full? }
  end

  def list_rooms
    rooms.each do |name, this_room|
        if !this_room.full?
            puts "#{name} - #{this_room.available_space}"
        else
            puts "#{name} - 0"
        end
    end
  end






end
