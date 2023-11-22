/*# https://www.twilio.com/blog/intro-custom-button-component-typescript-react
# section within a page
*/ 
import section from "./section";
import * as React from "react";
import * as ReactDOM from "react-dom";

function Page() {
  return (
    <>
      <h1>First Section</h1>
      <section/>
      <br></br>
      <h1>Section Two</h1>
      <section/>
    </>
  );
}

export default Page;