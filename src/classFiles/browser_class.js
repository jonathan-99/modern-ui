"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var UserBrowserInfo = /** @class */ (function () {
    function UserBrowserInfo() {
        this.userAgent = navigator.userAgent;
        this.browserAgent = this.getBrowserAgent(); // Calls the private method
        this.platform = navigator.platform;
    }
    UserBrowserInfo.prototype.getBrowserAgent = function () {
        var userAgent = navigator.userAgent;
        if (userAgent.indexOf("Firefox") !== -1) {
            return "Firefox";
        }
        else if (userAgent.indexOf("Chrome") !== -1) {
            return "Chrome";
        }
        else if (userAgent.indexOf("Safari") !== -1) {
            return "Safari";
        }
        else if (userAgent.indexOf("Opera") !== -1) {
            return "Opera";
        }
        else if (userAgent.indexOf("MSIE") !== -1 || !!document.DOCUMENT_NODE === true) {
            return "IE"; // Internet Explorer 10 or older
        }
        else {
            return "Unknown";
        }
    };
    UserBrowserInfo.prototype.getUserAgent = function () {
        return this.userAgent;
    };
    UserBrowserInfo.prototype.getPlatform = function () {
        return this.platform;
    };
    return UserBrowserInfo;
}());
exports.default = UserBrowserInfo;
