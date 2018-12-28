port module Express exposing (Application, Request, Route, WebResponse(..), application)

import Platform
import Ssr.Html


type alias Application =
    Program Flags Model Msg


type alias Flags =
    { port_ : Int
    }


type alias Model =
    { routes : List Route
    }


type Msg
    = Handle Request


application : List Route -> Application
application routes =
    Platform.worker
        { init = init routes
        , update = update
        , subscriptions = subscriptions
        }


init : List Route -> Flags -> ( Model, Cmd Msg )
init routes flags =
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
        |> Maybe.map
            (\route ->
                case route.handler request of
                    Html html ->
                        Ssr.Html.toString html

                    PlainText text ->
                        text
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    incoming Handle


type alias Route =
    { path : String
    , handler : Request -> WebResponse
    }


type WebResponse
    = Html Ssr.Html.Html
    | PlainText String


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
