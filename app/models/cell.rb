class Cell < ActiveRecord::Base

  def self.gather_coordinates(player)
    Cell.where('player = ?', player).map(&:coordinate)
  end

  def self.count_frequencies(arr)
    counts = Hash.new(0)
    arr.each { |element| counts[element] += 1 }
    counts.values
  end

  def self.check_victory
    victory_message = nil
    ["X", "O"].each do |player|
      puts "**Checking Player #{player}:**"
      coords = gather_coordinates(player)
      victory = false
      victory ||= Cell.check_rows(coords)
      victory ||= Cell.check_columns(coords)
      victory ||= Cell.check_diagonals(coords)
      victory_message ||= victory ? "#{player} WINS" : nil
    end
    p victory_message
  end

  def self.check_rows(unsplit_coords)
    coords = unsplit_coords.map { |coord| coord[0] }
    victory = count_frequencies(coords).any? { |freq| freq >= 3 }
    puts "...checking row values for sets of 3: #{coords}. #{victory}"
    victory
  end

  def self.check_columns(unsplit_coords)
    coords = unsplit_coords.map { |coord| coord[1] }
    victory = count_frequencies(coords).any? { |freq| freq >= 3 }
    puts "...checking column values for sets of 3: #{coords}. #{victory}"
    victory
  end

  def self.check_diagonals(unsplit_coords)
    victory ||= (unsplit_coords & %w[00 11 22]).length >= 3
    victory ||= (unsplit_coords & %w[20 11 02]).length >= 3
    puts "...checking diagonals for the 2 victory combinations: #{unsplit_coords}. #{victory}"
    victory
  end

  def to_s
    "#{coordinate[0]}, #{coordinate[1]}: Player '#{player}'"
  end
end
