animale.messages = {
    getMessageFor: ( score ) ->
        switch score 
            when 0 then 'Wow. That\'s almost impressively bad!'
            when 1 then 'Well you got that one right and that\'s better than missing them all!'
            when 2, 3 then 'Hey, you got some of them. Have another go!'
            when 4, 5, 6 then 'Not bad at all. Getting there!'
            when 7, 8, 9 then 'You obviously know your way around a group of animals!'
            when 10 then 'Flawless victory!' 
}