class UserBrowserInfo {
    private userAgent: string;
    private browserAgent: string;
    private platform: string;

    constructor() {
        this.userAgent = navigator.userAgent;
        this.browserAgent = this.getBrowserAgent();
        this.platform = navigator.platform;
    }

    private getBrowserAgent(): string {
        const userAgent = navigator.userAgent;
        if (userAgent.indexOf("Firefox") !== -1) {
            return "Firefox";
        } else if (userAgent.indexOf("Chrome") !== -1) {
            return "Chrome";
        } else if (userAgent.indexOf("Safari") !== -1) {
            return "Safari";
        } else if (userAgent.indexOf("Opera") !== -1) {
            return "Opera";
        } else if (userAgent.indexOf("MSIE") !== -1 || !!document.documentMode === true) {
            return "IE"; // Internet Explorer 10 or older
        } else {
            return "Unknown";
        }
    }

    public getUserAgent(): string {
        return this.userAgent;
    }

    public getBrowserAgent(): string {
        return this.browserAgent;
    }

    public getPlatform(): string {
        return this.platform;
    }
}

export default UserBrowserInfo;
