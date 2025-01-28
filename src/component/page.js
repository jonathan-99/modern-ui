"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    Object.defineProperty(o, k2, { enumerable: true, get: function() { return m[k]; } });
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var react_1 = __importStar(require("react"));
var section_1 = __importDefault(require("./section"));
var browser_class_1 = __importDefault(require("../classFiles/browser_class"));
var command_section_1 = __importDefault(require("./command_section"));
function Page() {
    var _a = (0, react_1.useState)(null), userBrowserInfo = _a[0], setUserBrowserInfo = _a[1]; // State to store browser information
    (0, react_1.useEffect)(function () {
        // Fetch browser information when component mounts
        var browserInfo = new browser_class_1.default();
        setUserBrowserInfo(browserInfo);
    }, []);
    return (react_1.default.createElement(react_1.default.Fragment, null,
        react_1.default.createElement("h1", null, "First Section"),
        react_1.default.createElement(section_1.default, null),
        react_1.default.createElement("br", null),
        react_1.default.createElement("h1", null, "Section Two"),
        react_1.default.createElement(section_1.default, null),
        userBrowserInfo && (react_1.default.createElement("div", null,
            react_1.default.createElement("h2", null, "Browser Information"),
            react_1.default.createElement("p", null,
                "User Agent: ",
                userBrowserInfo.getUserAgent()),
            react_1.default.createElement("p", null,
                "Platform: ",
                userBrowserInfo.getPlatform()))),
        react_1.default.createElement(command_section_1.default, null)));
}
exports.default = Page;
