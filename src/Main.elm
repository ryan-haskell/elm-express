port module Main exposing (main)

import Platform


type alias Flags =
    { port_ : Int
    }


type alias Model =
    { routes : List Route
    }


type Msg
    = Handle Request


main : Program Flags Model Msg
main =
    Platform.worker
        { init = init
        , update = update
        , subscriptions = subscriptions
        }


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        routes : List Route
        routes =
            [ Route "/" (always "<h1>Homepage</h1>")
            , Route "/people" (always "<h1>People</h1><h2>They're neat!</h2>")
            ]
    in
    ( Model routes
    , routes
        |> List.map toSimpleRoute
        |> ready
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Handle req ->
            ( model
            , outgoing
                (Response req.id
                    (Maybe.withDefault "Route path doesn't match..."
                        (getContent req model.routes)
                    )
                )
            )


getContent : Request -> List Route -> Maybe String
getContent request routes =
    routes
        |> List.filter (\route -> route.path == request.path)
        |> List.head
        |> Maybe.map (\route -> route.handler request)


subscriptions : Model -> Sub Msg
subscriptions model =
    incoming Handle


type alias Route =
    { path : String
    , handler : Request -> String
    }


type alias SimpleRoute =
    { path : String
    }


toSimpleRoute : Route -> SimpleRoute
toSimpleRoute { path } =
    SimpleRoute path


type alias Request =
    { path : String
    , id : String
    , url : String
    }


type alias Response =
    { id : String
    , content : String
    }


port ready : List SimpleRoute -> Cmd msg


port outgoing : Response -> Cmd msg


port incoming : (Request -> msg) -> Sub msg
