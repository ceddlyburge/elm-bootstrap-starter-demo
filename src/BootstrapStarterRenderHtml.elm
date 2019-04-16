module BootstrapStarterRenderHtml exposing (
    renderPage)

import Html exposing (Html)
import Html.String exposing (Html)
import BootstrapStarter exposing (..)
import BootstrapStarterRenderHtmlString as BootstrapStarterRenderHtmlString exposing (renderPage)

renderPage: BootstrapStarter msg -> Html.Html msg
renderPage bootstrap =
    BootstrapStarterRenderHtmlString.renderPage bootstrap
    |> Html.String.toHtml
