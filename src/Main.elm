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
                    html [ attribute "lang" "en" ]
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
                            , link
                                [ rel "icon"
                                , href "https://seeklogo.com/images/E/elm-logo-9DEF2A830B-seeklogo.com.png"
                                ]
                            ]
                        , body []
                            [ div [ class "hero is-fullheight has-text-centered is-info" ]
                                [ div [ class "hero-body" ]
                                    [ div [ class "container" ]
                                        [ h1 [ class "title is-1" ] [ text "Elm ExpressJS" ]
                                        , h2 [ class "subtitle is-4" ] [ text "A web server built with elm!" ]
                                        , a [ href "/people", class "button is-info is-inverted is-outlined" ] [ text "To the people page!" ]
                                        ]
                                    ]
                                ]
                            , script [] [ text "console.log('Hello world!')" ]
                            ]
                        ]
            )
        , Route "/people"
            (\req ->
                Html <|
                    html [ attribute "lang" "en" ]
                        [ head []
                            [ title "People"
                            , meta
                                [ name "description"
                                , content "This is the people page."
                                ]
                            , link
                                [ href "https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.2/css/bulma.min.css"
                                , rel "stylesheet"
                                ]
                            , link
                                [ rel "icon"
                                , href "https://seeklogo.com/images/E/elm-logo-9DEF2A830B-seeklogo.com.png"
                                ]
                            ]
                        , body []
                            [ div [ class "hero is-fullheight has-text-centered is-success" ]
                                [ div [ class "hero-body" ]
                                    [ div [ class "container" ]
                                        [ h1 [ class "title is-1" ] [ text "People Page" ]
                                        , h2 [ class "subtitle is-4" ] [ text "Look at all those humans!" ]
                                        , a [ href "/", class "button is-success is-inverted is-outlined" ] [ text "Back to homepage" ]
                                        ]
                                    ]
                                ]
                            ]
                        ]
            )
        ]
