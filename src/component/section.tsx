/*
# https://www.twilio.com/blog/intro-custom-button-component-typescript-react
# button within a section */

import * as React from "react";
import * as ReactDOM from "react-dom";
import aButton from "./action-button";

function Section() {
  return (
    <>
      <h1>Colorful Custom Button Components</h1>
      <button
        border-size="none"
        color="pink"
        height-size = "200px"
        onClick={() => console.log("You clicked on the pink circle!")}
        radius-size = "50%"
        width-size = "200px"
        children = "I'm a pink circle!"
      />
    </>
  );
}

export default Section;