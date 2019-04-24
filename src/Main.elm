module Main exposing (..)

import Browser
import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)
import BootstrapStarter exposing (..)
import BootstrapStarterToHtml exposing (toHtml)


---- MODEL ----


type alias Model =
    { route : Route
    , searchExpression: String
    }

type Route
    = Home
    | Link
    | DropDown
    | SearchResults


init : ( Model, Cmd Msg )
init =
    ( Model Home "", Cmd.none )



---- UPDATE ----

type Msg
    = ShowHome
    | ShowLink
    | ShowDropDown
    | UpdateSearchExpression String
    | ShowSearchResults



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShowHome ->
            ( { model | route = Home } , Cmd.none )
        ShowLink ->
            ( { model | route = Link } , Cmd.none )
        ShowDropDown ->
            ( { model | route = DropDown } , Cmd.none )
        UpdateSearchExpression searchExpression ->
            ( { model | searchExpression = searchExpression } , Cmd.none )
        ShowSearchResults ->
            ( { model | route = SearchResults } , Cmd.none )


---- VIEW ----


view : Model -> Html Msg
view model =
    masterViewType model
    |> toHtml

masterViewType : Model -> BootstrapStarter Msg
masterViewType model =
    case model.route of
        Home ->
            bootstrapStarterPage 
                "Home" 
                (Paragraphs 
                    [ "This is a demonstration website to show the use of Master View Types in Elm"
                    , "It is using a Master View Type that allows the definition and rendering of Html based on the Boostrap Starter Template" ])
        Link ->
            bootstrapStarterPage 
                "Example Link" 
                (Paragraphs 
                    [ "This is a demonstration website to show the use of Master View Types in Elm"
                    , "This is the 'Example Link' page" ])
        DropDown ->
            bootstrapStarterPage 
                "Example Drop Down Link" 
                (Paragraphs 
                    [ "This is a demonstration website to show the use of Master View Types in Elm"
                    , "This is the 'Example Drod Down Link' page" ])
        SearchResults ->
            bootstrapStarterPage 
                "Search Results" 
                (Paragraphs 
                    [ "This is a demonstration website to show the use of Master View Types in Elm"
                    , "This is the search results page"
                    , "You searched for " ++ model.searchExpression ])


bootstrapStarterPage: String -> PageContent Msg -> BootstrapStarter Msg 
bootstrapStarterPage pageTitle pageContent =
    BootstrapStarter
        (NavBar
            "Navbar" 
            ShowHome
            [
                Vanilla (NavBarVanilla "Home" ShowHome LinkStateSelected)
                , Vanilla (NavBarVanilla "Example Link" ShowLink LinkStateVanilla)
                , BootstrapStarter.DropDown (NavBarDropDown
                    "Dropdown"
                    "dropdown01"
                    [
                        NavBarDropDownItem "Drop Down Link" ShowDropDown 
                    ])
            ]
            (Search 
                "Search"
                UpdateSearchExpression
                ShowSearchResults
            )
        )
        pageTitle
        pageContent

---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
