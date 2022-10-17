class Player
    attr_reader :name, :letter
    
    def initialize(name)
        @name = name
        @letter = ''
    end

    def alert_invalid_guess(letter)
        ('a'..'z').to_a.include?(letter)
    end

    def guess
        print 'pick a letter a-z: '
        input = gets.chomp()
        until alert_invalid_guess(input)
            puts 'invalid pick one letter from a to z:  '
            input = gets.chomp()
        end
        return input
    end

    def add_letter
        if @letter == ''
            @letter += 'G'
        else
            ghost = ['G', 'H', 'O', 'S', 'T']
            @letter += ghost[ghost.index(@letter[-1])+1]
        end
    end
end
