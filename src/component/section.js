"use strict";
/*
# https://www.twilio.com/blog/intro-custom-button-component-typescript-react
# button within a section */
exports.__esModule = true;
var React = require("react");
function Section() {
    return (React.createElement(React.Fragment, null,
        React.createElement("h1", null, "Colorful Custom Button Components"),
        React.createElement("button", { "border-size": "none", color: "pink", "height-size": "200px", onClick: function () { return console.log("You clicked on the pink circle!"); }, "radius-size": "50%", "width-size": "200px", children: "I'm a pink circle!" })));
}
exports["default"] = Section;
