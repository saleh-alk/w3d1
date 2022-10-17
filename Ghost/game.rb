require_relative 'player'

class Game

    #attr_reader :dictionary
    lines_with_newlines = File.readlines("dictionary.txt").map{|line| line.gsub(/\n$/,"")}
    @@dictionary = {}
    lines_with_newlines.each{|word| @@dictionary[word] = word}

    def self.add_names
        names = []

        puts 'How many players are playing'
        number_of_players = gets.chomp

        (0...number_of_players.to_i).each do |i|
            puts 'Enter Players name: '
            name = gets.chomp
            names << Player.new(name)
        end
        names
    end

    def initialize
        @players = Game.add_names #.map!{|ele| Player.new(ele)}
        @fragment = ''
    end

    def next_player
        @players = @players.rotate
    end

    def previous_player
        @players[-1]
    end

    def current_player
        @players[0]
    end



    def play_round
        @players.length.times do
            k = current_player.guess
            @fragment += k
            if @@dictionary.has_key?(@fragment)
                puts "#{current_player.name} lost"
                current_player.add_letter
                puts @fragment
                @fragment = ""
                next_player
                break
            else
                next_player
                if @fragment.length == 8
                    @fragment = ''
                else
                    puts @fragment
                end
            end
        end
    end

    def record
        @players.each do |ele|
            print "#{ele.name}: #{ele.letter}"
            puts
        end
        puts "Congrats #{@players[0].name} you win!!!!" if @players.length == 1
    end

    def remove_player
        @players = @players.reject {|ele| ele.letter == 'GHOST'}
    end

    def run
        until @players.length == 1
            play_round
            remove_player
            record
        end
    end
end


b = Game.new()
b.run
