require 'spec_helper'

RSpec.describe Game do
  before :each do
    @game = Game.new
    @computer_player = ComputerPlayer.new
    @player = Player.new
  end

  it 'initializes the game state correctly' do
    @game.start_new_game
    expect(@game.player.player_board).to be_a(Board)
    expect(@game.computer_player.computer_board).to be_a(Board)
    expect(game.player).to be_an_instance_of(Player)
    expect(game.computer_player).to be_an_instance_of(ComputerPlayer)
    expect(game.quit).to be(false)
    expect(game.game_over).to be(false)
    expect(game.used_coordinates).to be_empty
  end

  it 'checks play_again? method for yes' do
    allow($stdin).to receive(:gets).and_return("yes\n")
    expect(game.play_again?).to be(true)
  end

  it 'checks play_again? method for no' do
    allow($stdin).to receive(:gets). and_return("no\n")
    expect(game.play_again?).to be(false)
  end

  it 'handles player shots correctly' do
    @game.start_new_game
    allow(@game).to receive(:gets).and_return("A1\n")
    @game.player_shot
    expect{@game.display_player_shot("A1")}.to output("Player shot at A1 was a miss!\n").to_stdout
  end

  it 'handles computer shots correctly' do
    allow(game).to receive(:available_coordinates).and_return(["A1", "A2", "A3", "A4"])
    expect(game.used_coordinates).to be_empty
    allow(game.player_board.cells["A1"]).to receive(:fire_upon)
    game.computer_shot
    expect(game.player.player_board.cells["A1"]).to have_received(:fire_upon)
    expect(game.used_coordinates).to include("A1")
  end

  it 'returns false when the coordinate is invalid' do
    allow(game.computer_player.computer_board).to receive(:valid_coordinate?). and_return(false)
    expect(game.valid_shot?("Z9")).to be(false)
  end
  it 'returns false when the coordinate is invalid' do
    allow(game.computer_player.computer_board).to receive(:valid_coordinate). and_return(true)

    cell = double('cell',fired_upon?: true)

    allow(game.computer_player.computer_board.cells["A1"]).to receive(:fired_upon?).and_return(true)

    expect(game.valid_shot?("A1")).to be(false)
  end
  it 'game_over? returns true when all player ships sunk' do
    game.player.player_ships.each { |ship| allow(ship).to receive(:sunk?).and_return(true)}

    epect(game.game_over?).to be(true)
  end

  it 'game_over? returns true when all computer ships sunk' do
    game.computer_player.computer_ships.each { |ship| allow(ship).to receive(sunk?).and_return(true)}
    expect(game.game_over?).to be(true)
  end

end