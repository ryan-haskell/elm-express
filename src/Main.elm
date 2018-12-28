module Main exposing (main)

import Express exposing (Route, WebResponse(..))
import Ssr.Attributes exposing (..)
import Ssr.Html exposing (..)


main : Express.Application
main =
    Express.application
        [ Route "/"
            (\req ->
                Html <|
                    html []
                        [ head []
                            [ title "Homepage"
                            , meta
                                [ name "description"
                                , content "This is the homepage."
                                ]
                            , link
                                [ href "https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.2/css/bulma.min.css"
                                , rel "stylesheet"
                                ]
                            ]
                        , body []
                            [ div []
                                [ h1 [ class "title" ] [ text "Hello" ]
                                , h2 [] [ text "I love elm" ]
                                , p [] [ text "Lorem ipsum, my dood!" ]
                                , p [] [ text ("Your path is:" ++ req.url) ]
                                ]
                            ]
                        ]
            )
        , Route "/people"
            (\req -> PlainText "<h1>Persons</h1><h2>They're neat!</h2>")
        , Route "/rene"
            (\req -> PlainText req.url)
        ]
