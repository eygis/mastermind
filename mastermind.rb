class Game

    attr_accessor :code, :hints, :win, :type

    def initialize(type)
        @type = type
        @code = []
        @hints = []
        @win = false
        if @type != 1 
            4.times {@code.push(rand(1..9))}
        end
    end
end

module Functions
    def get_guess
        if GAME.type == '1'
            com_guess = []
            4.times {com_guess.push(rand(1..9))}
            com_guess
        else
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
end

include Functions

def breaker
    12.times do
        current_guess = Functions.get_guess
        current_guess.each_with_index do |num, i|
            if GAME.code.index(num) != nil
                if current_guess[i] == GAME.code[i]
                    GAME.hints.push('O')
                    next
                end
                GAME.hints.push('A')
            end
        end
        if GAME.hints == ['O', 'O', 'O', 'O']
            GAME.win = true
            break
        end
        puts GAME.hints
        GAME.hints = []
    end
    if GAME.win == false
        puts "You lose, the answer was: #{GAME.code.join('')}"
    else
        puts 'You Win!'
    end
end

def maker
    print 'Please choose a 4-digit code for the computer to guess: '
    GAME.code = gets.chomp
    until GAME.code.match?(/\b[1-9]{4}\b/) do
        print 'Please choose a 4-digit code for the computer to guess: '
        GAME.code = gets.chomp
    end
    GAME.code = GAME.code.split('').map {|c| c.to_i} 
    12.times do
        current_guess = Functions.get_guess
        puts current_guess.join('')
        current_guess.each_with_index do |num, i|
            if GAME.code.index(num) != nil
                if current_guess[i] == GAME.code[i]
                    GAME.hints.push('O')
                    next
                end
                GAME.hints.push('A')
            end
        end
        if GAME.hints == ['O', 'O', 'O', 'O']
            GAME.win = true
            break
        end
        puts GAME.hints
        GAME.hints = []
    end
    if GAME.win == false
        puts "You lose, the answer was: #{GAME.code.join('')}"
    else
        puts 'You Win!'
    end
end

print '~~If you would like to be the code maker, please enter "1", otherwise if you would like to be the code breaker, please enter any other character. '
type = gets.chomp
until type.length == 1 do
    print 'To be the maker please enter "1", else if you want to be the breaker, please type any character other than 1. '
    type = gets.chomp
end
GAME = Game.new(type)

if GAME.type == '1'
    maker
else
    breaker
end