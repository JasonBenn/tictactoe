class Cell < ActiveRecord::Base
  def self.gather_player_cells(player)
    Cell.where('player = ?', player)
  end

  def self.check_victory
    winning_player = nil
    ["X", "O"].each do |player|
      puts "**Checking Player #{player}:**"
      cells = gather_player_cells(player)
      coords = cells.map(&:coordinate)
      victory = false
      victory ||= Cell.check_columns(coords)
      victory ||= Cell.check_rows(coords)
      victory ||= Cell.check_diagonals(coords)
      winning_player = victory ? "Player #{player} wins!" : nil
    end
    winning_player
  end

  def self.check_columns(unsplit_coords)
    coords = unsplit_coords.map {|coord| coord.split('')}.map(&:last)
    victory = count_frequencies(coords).any? { |freq| freq > 3 }
    puts "...checking row values for sets of 3: #{coords}. #{victory}"
    victory
  end

  def self.check_rows(unsplit_coords)
    coords = unsplit_coords.map {|coord| coord.split('')}.map(&:first)
    victory = count_frequencies(coords).any? { |freq| freq > 3 }
    puts "...checking column values for sets of 3: #{coords}. #{victory}"
    victory
  end

  def self.count_frequencies(arr)
    hash_of_counts = Hash.new(0)
    arr.reduce(hash_of_counts) { |element| hash_of_counts[element] += 1 }
    hash_of_counts.values
  end

  def self.check_diagonals(unsplit_coords)
    victory = false
    victory ||= (unsplit_coords & %w[00 11 22]).length >= 3
    victory ||= (unsplit_coords & %w[20 11 02]).length >= 3
    puts "...checking diagonals for the 2 victory combinations: #{unsplit_coords}. #{victory}"
    victory
  end

  def to_s
    "#{coordinate[0]}, #{coordinate[1]}: Player '#{player}'"
  end
end
