module Ssr.VirtualDom exposing
    ( Attribute
    , Node
    , attribute
    , childlessNode
    , node
    , text
    , toString
    )

import VirtualDom


type Node
    = Node String (List Attribute) (List Node)
    | ChildlessNode String (List Attribute)
    | Text String


type Attribute
    = Attribute String String


text : String -> Node
text =
    Text


node : String -> List Attribute -> List Node -> Node
node =
    Node


childlessNode : String -> List Attribute -> Node
childlessNode =
    ChildlessNode


attribute : String -> String -> Attribute
attribute =
    Attribute


toString : Node -> String
toString node_ =
    case node_ of
        Node name attributes children ->
            String.join ""
                [ "<"
                , name
                , attributes
                    |> List.map
                        (\(Attribute name_ value) ->
                            " " ++ safe name_ ++ "=" ++ "\"" ++ safe value ++ "\""
                        )
                    |> String.join ""
                , ">"
                , String.join "" (List.map toString children)
                , "</"
                , name
                , ">"
                ]

        ChildlessNode name attributes ->
            String.join ""
                [ "<"
                , name
                , attributes
                    |> List.map
                        (\(Attribute name_ value) ->
                            " " ++ safe name_ ++ "=" ++ "\"" ++ safe value ++ "\""
                        )
                    |> String.join ""
                , "/>"
                ]

        Text text_ ->
            text_


safe : String -> String
safe =
    String.replace "\"" "&quot;"
        >> String.replace "<" "&lt;"
        >> String.replace ">" "&gt;"


toVirtualDom : Node -> VirtualDom.Node msg
toVirtualDom node_ =
    case node_ of
        Node name attributes children ->
            VirtualDom.node name
                (List.map (\(Attribute key value) -> VirtualDom.attribute key value) attributes)
                (List.map toVirtualDom children)

        ChildlessNode name attributes ->
            VirtualDom.node name
                (List.map (\(Attribute key value) -> VirtualDom.attribute key value) attributes)
                []

        Text text_ ->
            VirtualDom.text text_
