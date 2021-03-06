$( document ).ready ->
    options = _.pluck animale.animals, 'group'
    asked   = []
    current = {}
    round   = 0
    locked  = false

    $('.btn', '.buttons').click ->
        if locked then return

        text = $( this ).text()

        if text is current.group
            handleCorrectAnswer( this )
        else 
            handleIncorrectAnswer( this )

    $('.play').click ->
        $('.menu, .final-score').hide()
        $('.game').show()

        showNextQuestion()

    handleCorrectAnswer = ( btn ) ->
        locked = true
        markSuccess btn

        asked.push $('.animal').text()
        round += 1

        if round == 10
            return showResults()
        
        $('.name').clearQueue()

        setTimeout ->
            resetButtons()
            resetAnswerSpace()
            showNextQuestion()
        , 1000

    handleIncorrectAnswer = ( btn ) ->
        locked = true

        $( btn ).addClass 'disabled btn-danger'
        $( btn ).removeClass 'btn-info'
        
        $('.name').css 'color', '#ee5f5b'
        $('.name').text $( btn ).text()

        if !$(".disc:eq(#{round})").hasClass 'correct'
            $(".disc:eq(#{round})").addClass 'incorrect'

        clearAnswerSpace 300, ->
            locked = false

    markSuccess = ( btn ) ->
        $( btn ).addClass 'btn-success'
        $( btn ).removeClass 'btn-info'

        $('.name').css 'color', '#62c462'
        $('.name').text $( btn ).text()

        if !$(".disc:eq(#{round})").hasClass 'incorrect'
            $(".disc:eq(#{round})").addClass 'correct'

    resetButtons = ->
        $('.btn', '.buttons').removeClass 'btn-warning btn-success disabled'
        $('.btn', '.buttons').addClass 'btn-info'

    resetAnswerSpace = ->
        $('.name').css 'color', '#fff'
        $('.name').text '____'

    resetDiscs = ->
        $('.disc').removeClass 'correct incorrect'

    clearAnswerSpace = ( outDuration, callback ) ->
        $('.name').clearQueue().delay( 1000 ).fadeOut outDuration, ->
            resetAnswerSpace()
            $( this ).fadeIn 500, ->
                callback() if callback

    getAnimal = ->
        ix      = Math.floor( Math.random() * animale.animals.length )
        animal  = animale.animals[ ix ]

        asked = [] if asked.length == animale.animals.length

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

        locked = false

    showResults = ->
        correctAnswers = $('.disc.correct').length
        message        = animale.messages.getMessageFor correctAnswers
        
        $('.game').fadeOut 3000, ->
            reset()

            $('.total').text "#{correctAnswers}/10"
            $('.message').text message
            
            $('.final-score').show()

    reset = ->
        asked   = []
        current = {}
        round   = 0
        locked  = false

        resetButtons()
        resetAnswerSpace()
        resetDiscs()

    $('.menu').show()