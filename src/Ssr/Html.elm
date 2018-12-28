module Ssr.Html exposing
    ( Html
    , a
    , blockquote
    , body
    , button
    , div
    , h1
    , h2
    , h3
    , h4
    , h5
    , h6
    , head
    , html
    , link
    , meta
    , p
    , script
    , text
    , title
    , toString
    )

import Ssr.VirtualDom as VirtualDom exposing (Node, childlessNode, node, text)


type alias Html =
    Node



-- Top level boyos


title text_ =
    node "title" [] [ text text_ ]


html =
    node "html"


head =
    node "head"


link =
    childlessNode "link"


meta =
    childlessNode "meta"


script =
    childlessNode "script"


body =
    node "body"


div =
    node "div"


h1 =
    node "h1"


h2 =
    node "h2"


h3 =
    node "h3"


h4 =
    node "h4"


h5 =
    node "h5"


h6 =
    node "h6"


p =
    node "p"


a =
    node "a"


button =
    node "button"


blockquote =
    node "blockquote"


text =
    VirtualDom.text


toString : Html -> String
toString =
    VirtualDom.toString
