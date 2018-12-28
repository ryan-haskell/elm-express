module Ssr exposing (render)

import Ssr.VirtualDom as VirtualDom


type alias Options =
    { title : String
    , meta : List ( String, String )
    , body : List VirtualDom.Node
    }


render : Options -> String
render { title, meta, body } =
    String.join "\n" <|
        [ "<html lang=\"en\">"
        , "<head>"
        , "<meta charset=\"UTF-8\">"
        , "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"
        , "<meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\">"
        , "<title>" ++ title ++ "</title>"
        , metaTags meta
        , "</head>"
        , "<body>"
        ]
            ++ List.map VirtualDom.toString body
            ++ [ "</body>"
               , "</html>"
               ]


metaTags : List ( String, String ) -> String
metaTags metaList =
    String.join "\n" <|
        List.map metaTag metaList


metaTag : ( String, String ) -> String
metaTag ( name, content ) =
    "<meta name=\"" ++ name ++ "\" content=\"" ++ content ++ "\">"
