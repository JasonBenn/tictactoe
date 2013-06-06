class Cell < ActiveRecord::Base
  def self.gather_player_cells(player)
    Cell.where('player = ?', player)
  end

  def self.check_victory
    winning_player = nil
    ["X", "O"].each do |player|
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
    coords.group_by {|i| i }.values.flatten.map(&:length).include? 3
  end

  def self.check_rows(unsplit_coords)
    coords = unsplit_coords.map {|coord| coord.split('')}.map(&:first)
    coords.group_by {|i| i }.values.flatten.map(&:length).include? 3
  end


  def self.check_diagonals(unsplit_coords)
    victory = false
    victory ||= (unsplit_coords & %w[00 11 22]).length == 3
    victory ||= (unsplit_coords & %w[20 11 02]).length == 3
  end

  def to_s
    "#{coordinate[0]}, #{coordinate[1]}: Player '#{player}'"
  end
end
