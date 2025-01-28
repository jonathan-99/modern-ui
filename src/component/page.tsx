import React, { useState, useEffect } from "react";
import Section from "./section";
import UserBrowserInfo from "../classFiles/browser_class";
import SectionWithCommand from "./command_section";

function Page() {
    const [userBrowserInfo, setUserBrowserInfo] = useState<UserBrowserInfo | null>(null); // State to store browser information

    useEffect(() => {
        // Fetch browser information when component mounts
        const browserInfo = new UserBrowserInfo();
        setUserBrowserInfo(browserInfo);
    }, []);

    return (
        <>
            <h1>First Section</h1>
            <Section />
            <br />
            <h1>Section Two</h1>
            <Section />
            {/* Display browser information */}
            {userBrowserInfo && (
                <div>
                    <h2>Browser Information</h2>
                    <p>User Agent: {userBrowserInfo.getUserAgent()}</p>
                    {/* <p>Browser Agent: {userBrowserInfo.getBrowserAgent()}</p> */}
                    <p>Platform: {userBrowserInfo.getPlatform()}</p>
                </div>
            )}
            {/* Include the new section */}
            <SectionWithCommand />
        </>
    );
}

export default Page;
