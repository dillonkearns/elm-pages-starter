module DocumentSvg exposing (view)

import Color exposing (Color)
import Element exposing (Element)
import Svg exposing (Svg)
import Svg.Attributes as Attr


strokeColor : String
strokeColor =
    "black"


pageTextColor : String
pageTextColor =
    "black"


fillColor : String
fillColor =
    "url(#grad1)"


fillGradient : Svg msg
fillGradient =
    gradient
        (Color.rgb255 5 117 230)
        (Color.rgb255 0 242 96)


gradient : Color -> Color -> Svg msg
gradient color1 color2 =
    Svg.linearGradient
        [ Attr.id "grad1"
        , Attr.x1 "0%"
        , Attr.y1 "0%"
        , Attr.x2 "100%"
        , Attr.y2 "0%"
        ]
        [ Svg.stop
            [ Attr.offset "10%"
            , Attr.style ("stop-color:" ++ Color.toCssString color1 ++ ";stop-opacity:1")
            ]
            []
        , Svg.stop
            [ Attr.offset "100%"
            , Attr.style ("stop-color:" ++ Color.toCssString color2 ++ ";stop-opacity:1")
            ]
            []
        ]


view : Element msg
view =
    Svg.svg
        [ Attr.version "1.1"
        , Attr.viewBox "251.0485 144.52063 56.114286 74.5"
        , Attr.width "56.114286"
        , Attr.height "74.5"
        , Attr.width "30px"
        ]
        [ Svg.defs []
            [ fillGradient ]
        , Svg.metadata [] []
        , Svg.g
            [ Attr.id "Canvas_11"
            , Attr.stroke "none"
            , Attr.fill fillColor
            , Attr.strokeOpacity "1"
            , Attr.fillOpacity "1"
            , Attr.strokeDasharray "none"
            ]
            [ Svg.g [ Attr.id "Canvas_11: Layer 1" ]
                [ Svg.g [ Attr.id "Group_38" ]
                    [ Svg.g [ Attr.id "Graphic_32" ]
                        [ Svg.path
                            [ Attr.d "M 252.5485 146.02063 L 252.5485 217.52063 L 305.66277 217.52063 L 305.66277 161.68254 L 290.00087 146.02063 Z"
                            , Attr.stroke strokeColor
                            , Attr.strokeLinecap "round"
                            , Attr.strokeLinejoin "round"
                            , Attr.strokeWidth "3"
                            ]
                            []
                        ]
                    , Svg.g
                        [ Attr.id "Line_34"
                        ]
                        [ Svg.line
                            [ Attr.x1 "266.07286"
                            , Attr.y1 "182.8279"
                            , Attr.x2 "290.75465"
                            , Attr.y2 "183.00997"
                            , Attr.stroke pageTextColor
                            , Attr.strokeLinecap "round"
                            , Attr.strokeLinejoin "round"
                            , Attr.strokeWidth "2"
                            ]
                            []
                        ]
                    , Svg.g
                        [ Attr.id "Line_35"
                        ]
                        [ Svg.line
                            [ Attr.x1 "266.07286"
                            , Attr.y1 "191.84156"
                            , Attr.x2 "290.75465"
                            , Attr.y2 "192.02363"
                            , Attr.stroke pageTextColor
                            , Attr.strokeLinecap "round"
                            , Attr.strokeLinejoin "round"
                            , Attr.strokeWidth "2"
                            ]
                            []
                        ]
                    , Svg.g
                        [ Attr.id "Line_36"
                        ]
                        [ Svg.line
                            [ Attr.x1 "266.07286"
                            , Attr.y1 "200.85522"
                            , Attr.x2 "290.75465"
                            , Attr.y2 "201.0373"
                            , Attr.stroke pageTextColor
                            , Attr.strokeLinecap "round"
                            , Attr.strokeLinejoin "round"
                            , Attr.strokeWidth "2"
                            ]
                            []
                        ]
                    , Svg.g
                        [ Attr.id "Line_37"
                        ]
                        [ Svg.line
                            [ Attr.x1 "266.07286"
                            , Attr.y1 "164.80058"
                            , Attr.x2 "278.3874"
                            , Attr.y2 "164.94049"
                            , Attr.stroke pageTextColor
                            , Attr.strokeLinecap "round"
                            , Attr.strokeLinejoin "round"
                            , Attr.strokeWidth "2"
                            ]
                            []
                        ]
                    ]
                ]
            ]
        ]
        |> Element.html
        |> Element.el []
