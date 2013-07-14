$( document ).ready ->
    options = _.pluck animale.animals, 'group'
    asked   = []
    current = {}

    $('.btn').click ->
        text = $( this ).text()

        if text is current.group
            handleCorrectAnswer( this )
        else 
            handleIncorrectAnswer( this )

    handleCorrectAnswer = ( btn ) ->
        $( btn ).addClass 'btn-success'
        $( btn ).removeClass 'btn-info'

        $('.name').css 'color', '#62c462'
        $('.name').text $( btn ).text()

        asked.push $('.animal').text()
        
        setTimeout ->
            resetButtons()
            resetAnswerSpace()
            showNextQuestion()
        , 1000
            
    handleIncorrectAnswer = ( btn ) ->
        $( btn ).addClass 'disabled btn-danger'
        $( btn ).removeClass 'btn-info'
        
        $('.name').css 'color', '#ee5f5b'
        $('.name').text $( btn ).text()

        clearAnswerSpace 300

    resetButtons = -> 
        $('.btn', '.buttons').removeClass 'btn-warning btn-success disabled'
        $('.btn', '.buttons').addClass 'btn-info'

    resetAnswerSpace = ->
        $('.name').css 'color', '#fff'
        $('.name').text '____'

    clearAnswerSpace = ( outDuration, callback ) ->
        $('.name').delay( 1000 ).fadeOut outDuration, ->
            resetAnswerSpace()
            $( this ).fadeIn 500, ->
                callback() if callback

    getAnimal = ->
        ix      = Math.floor( Math.random() * animale.animals.length )
        animal  = animale.animals[ ix ]

        if asked.indexOf( animal.name ) == -1
            return animal
        
        getAnimal()

    getOptions = ( animal )->
        possibleAnswers = _.select _.shuffle( options ), ( num, i) -> i <= 3
        possibleAnswers = _.reject possibleAnswers, ( group ) -> group == animal.group

        _.take possibleAnswers, 3 

    showNextQuestion = ->
        current         = getAnimal()
        possibleAnswers = getOptions current
        
        $('.animal').text current.name
        
        possibleAnswers.push current.group
        possibleAnswers = _.shuffle possibleAnswers
    
        $('.btn', '.buttons').each ( i ) ->
            $( this ).text possibleAnswers[ i ]
            
    showNextQuestion()