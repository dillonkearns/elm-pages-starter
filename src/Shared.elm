module Shared exposing (Model, Msg(..), PageView, RenderedBody, SharedMsg(..), StaticData, template)

import Element exposing (Element)
import Html exposing (Html)
import Layout
import Pages
import Pages.PagePath exposing (PagePath)
import Pages.StaticHttp as StaticHttp
import TemplateType exposing (TemplateType)


type alias SharedTemplate templateDemuxMsg msg1 msg2 =
    { init :
        Maybe
            { path :
                { path : PagePath Pages.PathKey
                , query : Maybe String
                , fragment : Maybe String
                }
            , metadata : TemplateType
            }
        -> ( Model, Cmd Msg )
    , update : Msg -> Model -> ( Model, Cmd Msg )
    , view :
        StaticData
        ->
            { path : PagePath Pages.PathKey
            , frontmatter : TemplateType
            }
        -> Model
        -> (Msg -> templateDemuxMsg)
        -> PageView templateDemuxMsg
        -> { body : Html templateDemuxMsg, title : String }
    , map : (msg1 -> msg2) -> PageView msg1 -> PageView msg2
    , staticData : List ( PagePath Pages.PathKey, TemplateType ) -> StaticHttp.Request StaticData
    , subscriptions : TemplateType -> PagePath Pages.PathKey -> Model -> Sub Msg
    , onPageChange :
        Maybe
            ({ path : PagePath Pages.PathKey
             , query : Maybe String
             , fragment : Maybe String
             }
             -> Msg
            )
    }


template : SharedTemplate msg msg1 msg2
template =
    { init = init
    , update = update
    , view = view
    , map = map
    , staticData = staticData
    , subscriptions = subscriptions
    , onPageChange = Just OnPageChange
    }


type alias RenderedBody =
    Element Never


type alias PageView msg =
    { title : String, body : List (Element msg) }


type Msg
    = OnPageChange
        { path : PagePath Pages.PathKey
        , query : Maybe String
        , fragment : Maybe String
        }
    | SharedMsg SharedMsg


type alias StaticData =
    ()


type SharedMsg
    = IncrementFromChild


type alias Model =
    { showMobileMenu : Bool
    , counter : Int
    }


map : (msg1 -> msg2) -> PageView msg1 -> PageView msg2
map fn doc =
    { title = doc.title
    , body = List.map (Element.map fn) doc.body
    }


init :
    Maybe
        { path :
            { path : PagePath Pages.PathKey
            , query : Maybe String
            , fragment : Maybe String
            }
        , metadata : TemplateType
        }
    -> ( Model, Cmd Msg )
init maybePagePath =
    ( { showMobileMenu = False
      , counter = 0
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnPageChange page ->
            ( { model | showMobileMenu = False }, Cmd.none )

        SharedMsg globalMsg ->
            case globalMsg of
                IncrementFromChild ->
                    ( { model | counter = model.counter + 1 }, Cmd.none )


subscriptions : TemplateType -> PagePath Pages.PathKey -> Model -> Sub Msg
subscriptions _ _ _ =
    Sub.none


staticData : a -> StaticHttp.Request StaticData
staticData siteMetadata =
    StaticHttp.succeed ()


view :
    StaticData
    ->
        { path : PagePath Pages.PathKey
        , frontmatter : TemplateType
        }
    -> Model
    -> (Msg -> msg)
    -> PageView msg
    -> { body : Html msg, title : String }
view globalStaticData page model toMsg pageView =
    Layout.view pageView page
