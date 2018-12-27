module Main exposing (main)

import Express exposing (Route)


main : Express.Application
main =
    Express.application
        [ Route "/"
            (\req -> "<h1>Homepage</h1>")
        , Route "/people"
            (\req -> "<h1>People</h1><h2>They're neat!</h2>")
        ]
