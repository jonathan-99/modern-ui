import React from "react";
import ActionButton from "./ActionButton";

function Section() {
    return (
        <>
            <h1>Colorful Custom Button Components</h1>
            <ActionButton
                border="none"
                color="pink"
                height="200px"
                onClick={() => console.log("You clicked on the pink circle!")}
                radius="50%"
                width="200px"
            >
                I'm a pink circle!
            </ActionButton>
        </>
    );
}

export default Section;
