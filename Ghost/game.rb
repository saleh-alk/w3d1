require_relative 'player'

class Game

    #attr_reader :dictionary
    lines_with_newlines = File.readlines("dictionary.txt").map{|line| line.gsub(/\n$/,"")}
    @@dictionary = {}
    lines_with_newlines.each{|word| @@dictionary[word] = word}

    def initialize(*names)

        @players = names.map!{|ele| Player.new(ele)}
        @fragment = ''
        # lines_with_newlines = File.readlines("dictionary.txt").map{|line| line.gsub(/\n$/,"")}
        # @dictionary = {}
        # lines_with_newlines.each{|word| @dictionary[word] = word}

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
                puts "#{current_player.name} lose"
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
        puts "Congrats #{players[0]} you win!!!!"
    end

    def remove_player
        @players = @players.reject {|ele| ele.letter == 'GHOST'}
    end

    def run
        until @players.length == 1
            play_round
            record
            remove_player
        end
    end
end


#b = Game.new('saleh', 'nash', 'ike')
