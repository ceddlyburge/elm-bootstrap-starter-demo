module BootstrapStarterRenderHtmlString exposing (
    renderPage, 
    renderNavBarDropDownItem, 
    renderNavBarDropDown, 
    renderNavBarVanilla, 
    renderSearch,
    renderNavBar,
    renderNavBarLinks,
    renderPageTitleAndContent)

import Html.String as Html exposing (Html)
import Html.String.Attributes as Attributes
import Html.String.Events as Events
import BootstrapStarter exposing (..)

-- add comment about scope / visisibility and having to make so for the tests

renderPage: BootstrapStarter msg -> Html msg
renderPage bootstrap =
    Html.node
        "div"
        []
        (
            [ renderNavBar bootstrap.navBar
            , renderPageTitleAndContent bootstrap.pageTitle bootstrap.pageContent
            ]  
        )

renderNavBar: NavBar msg -> Html msg
renderNavBar navBar =
    Html.nav
        [ Attributes.class "navbar navbar-expand-md navbar-dark bg-dark fixed-top" ]
        [ Html.a 
            [ Attributes.class "navbar-brand"
            , Attributes.tabindex 1   ]
            [ Html.text "Navbar" ]
        , Html.button 
            [ Attributes.class "navbar-toggler"
            , Attributes.attribute "type" "button"
            , Attributes.attribute "data-toggle" "collapse"
            , Attributes.attribute "data-target" "#navbarsExampleDefault"
            , Attributes.attribute "aria-controls" "navbarsExampleDefault"
            , Attributes.attribute "aria-expanded" "false"
            , Attributes.attribute "aria-label" "Toggle navigation"
            ]
            [ Html.span 
                [ Attributes.class "navbar-toggler-icon" ]
                []
            ]
        , Html.div
            [ Attributes.class "collapse navbar-collapse"
            , Attributes.id "navbarsExampleDefault" ]
            [ renderNavBarLinks navBar.navBarLinks
            , renderSearch navBar.search ]
        ]

renderNavBarLinks: List (NavBarLink msg) -> Html msg
renderNavBarLinks navBarLinks =
    Html.ul
        [ Attributes.class "navbar-nav mr-auto" ]
        ( List.map renderNavBarLink navBarLinks)

renderNavBarLink: NavBarLink msg -> Html msg
renderNavBarLink navBarlink =
    case navBarlink of 
        Vanilla navBarLinkVanilla ->
            renderNavBarVanilla navBarLinkVanilla
        DropDown navBarDropDown ->
            renderNavBarDropDown navBarDropDown 

renderNavBarDropDown: NavBarDropDown msg -> Html msg
renderNavBarDropDown navBarDropDown =
    Html.li 
        [ Attributes.class "nav-item dropdown" ]
        [   Html.a 
                [   
                    Attributes.class "nav-link dropdown-toggle", 
                    Attributes.id navBarDropDown.id,
                    Attributes.attribute "data-toggle" "dropdown",
                    Attributes.attribute "aria-haspopup" "true",
                    Attributes.attribute "aria-expanded" "false"
                ]
                [ Html.text navBarDropDown.title ],
            Html.div
                [ 
                    Attributes.class "dropdown-menu",
                    Attributes.attribute "aria-labelledby" navBarDropDown.id
                 ]
                (List.map renderNavBarDropDownItem navBarDropDown.items)
        ] 

renderNavBarDropDownItem: NavBarDropDownItem msg -> Html msg
renderNavBarDropDownItem navBarDropDownItem =
    Html.a 
        [ Attributes.class "dropdown-item"
        , Events.onClick navBarDropDownItem.onClick ]
        [ Html.text navBarDropDownItem.title ] 

renderNavBarVanilla: NavBarVanilla msg -> Html msg
renderNavBarVanilla navBarVanilla =
    Html.li 
        [ Attributes.class ("nav-item" ++ selectedClass navBarVanilla.state) ]
        [   Html.a 
                [   
                    Attributes.class ("nav-link" ++ disabledClass navBarVanilla.state)
                    , Events.onClick navBarVanilla.onClick
                ]
                (
                    [ Html.text navBarVanilla.title ] 
                    ++ selectedSpan navBarVanilla.state
                ) 
        ] 

renderSearch: Search msg -> Html msg
renderSearch search =
    Html.form 
        [ Attributes.class "form-inline my-2 my-lg-0" ]
        [ Html.input 
            [ Attributes.class "form-control mr-sm-2"
            , Attributes.attribute "type" "text" 
            , Attributes.attribute "placeholder" search.title 
            , Attributes.attribute "aria-label" search.title 
            , Events.onInput search.onInput
            ] 
            []
        , Html.button 
            [ Attributes.class "btn btn-outline-success my-2 my-sm-0"
            , Attributes.attribute "type" "button" 
            , Events.onClick search.onClick 
            ] 
            [ Html.text search.title ]   
        ] 

renderPageTitleAndContent: String -> PageContent msg -> Html msg
renderPageTitleAndContent pageTitle pageContent =
    Html.main_
        [ Attributes.attribute "role" "main"
        , Attributes.class "container" 
        ] 
        [ Html.div
            [ Attributes.class "starter-template" ] 
            (
                [ Html.h1 
                    []
                    [ Html.text pageTitle ]
                ]
                ++ renderPageContent pageContent
            )
        ]

renderPageContent: PageContent msg -> List (Html msg)
renderPageContent pageContent =
    case pageContent of
        Paragraphs paragraphs ->
            List.map (\(paragraph) -> Html.p [] [ Html.text paragraph ]) paragraphs
        Custom customHtml ->
            customHtml

-- repeating the case statement in selectedClass and selectedSpan is a bit of a code smell but I'm not going to worry about it for now
selectedClass: LinkState -> String
selectedClass linkState =
    case linkState of 
        LinkStateSelected ->
            " active"
        _ ->
            ""

selectedSpan: LinkState -> List (Html msg)
selectedSpan linkState =
    case linkState of 
        LinkStateSelected ->
            [ Html.span 
                [ Attributes.class "sr-only" ]
                [ Html.text "(current)" ]
            ]
        _ ->
            []

disabledClass: LinkState -> String
disabledClass linkState =
    case linkState of 
        LinkStateDisabled ->
            " disabled"
        _ ->
            ""

-- These render as p tags so are not useful.
-- renderBootstrapScripts: List (Html msg)
-- renderBootstrapScripts =
--         [ Html.node 
--             "script"
--             [ Attributes.attribute "src" "https://code.jquery.com/jquery-3.2.1.slim.min.js"
--             , Attributes.attribute "integrity" "sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
--             , Attributes.attribute "crossorigin" "anonymous"
--             ]
--             []
--         , Html.node 
--             "script"
--             [ Attributes.attribute "src" "https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
--             , Attributes.attribute "integrity" "sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
--             , Attributes.attribute "crossorigin" "anonymous"
--             ]
--             []    
--         , Html.node 
--             "script"
--             [ Attributes.attribute "src" "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
--             , Attributes.attribute "integrity" "sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
--             , Attributes.attribute "crossorigin" "anonymous"
--             ]
--             []    
--         ]

