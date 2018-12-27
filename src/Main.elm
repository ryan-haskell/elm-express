module Main exposing (main)

import Express exposing (Route)


main =
    Express.program
        [ Route "/"
            (always "<h1>Homepage</h1>")
        , Route "/people"
            (always "<h1>People</h1><h2>They're neat!</h2>")
        ]
