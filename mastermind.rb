class Game

    attr_accessor :code, :hints

    def initialize
        @code = []
        @hints = []
        4.times {@code.push(rand(1..9))}
    end
end

module Functions
    def get_guess
        print 'Please guess 4 numbers: '
        guess = gets.chomp
        until guess.match?(/\b[1-9]{4}\b/) do
            print 'Please guess 4 numbers: '
            guess = gets.chomp
        end
        int_guess = guess.split('').map {|g| g.to_i} 
        int_guess
    end
end

include Functions

GAME = Game.new

def run_game
    puts GAME.code.join('')
    current = Functions.get_guess
    current.each_with_index do |num, i|
        if GAME.code.index(num) != nil
            if i == GAME.code.index(num)
                puts "#{num} in position"
                next
            end
            puts "#{num} in array, #{GAME.code.index(num)}"
        end
    end
end

run_game