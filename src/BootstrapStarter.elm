module BootstrapStarter exposing (
    BootstrapStarter, 
    PageContent(..), 
    NavBarLink(..), 
    NavBarVanilla, 
    LinkState(..), 
    NavBarDropDown, 
    NavBarDropDownItem)


-- add comment about why Html.String is used
-- add types for some things. url, maybe title.


{-|

# Creating BootstrapStarter master view type
@docs BootstrapStarter, PageContent, NavBarLink, NavBarVanilla, LinkState, NavBarDropDown, NavBarDropDownItem

-}

import Html.String

{-| A Master Page Type that represents the Bootstrap Starter Template (https://getbootstrap.com/docs/4.0/examples/starter-template/#)
-}
type alias BootstrapStarter msg = {
    navBarTitle : String
    , navBarUrl : String
    , navBarOnClick : msg 
    , navBarLinks : List (NavBarLink msg)
    , searchTitle : String
    , searchOnChange : String -> msg
    , searchOnClick : msg
    , pageTitle : String
    , pageContent : PageContent msg  }

{-| Represents the body of a page, can be a list of strings (paragraphs), or a list of custom html
-}
type PageContent msg = 
    Paragraphs (List String)
    | Custom (List (Html.String.Html msg) )


{-| Represents a NavBarLink 
-}
type NavBarLink msg = 
    Vanilla (NavBarVanilla msg)
    | DropDown (NavBarDropDown msg)

{-| Represents a vanilla NavBarLink 
-}
type alias NavBarVanilla msg = {
    title: String
    , url: String
    , onClick: msg
    , state: LinkState }

{-| Represents the state of a link 
-}
type LinkState = 
    LinkStateVanilla
    | LinkStateSelected
    | LinkStateDisabled
 

{-| Represents A NavBarLink drop down list
-}
type alias NavBarDropDown msg = {
    title: String
    , id: String
    , url: String
    , items: List (NavBarDropDownItem msg) }

{-| Represents A NavBarLink drop down list item
-}
type alias NavBarDropDownItem msg = {
    title: String
    , url: String
    , onClick: msg }

