# https://www.twilio.com/blog/intro-custom-button-component-typescript-react
# button within a section

import action-button from "./src/components/action-button";

function Section() {
  return (
    <>
      <h1>Colorful Custom Button Components</h1>
      <Button
        border="none"
        color="pink"
        height = "200px"
        onClick={() => console.log("You clicked on the pink circle!")}
        radius = "50%"
        width = "200px"
        children = "I'm a pink circle!"
      />
    </>
  );
}

export default Section;