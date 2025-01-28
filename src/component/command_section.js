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
Object.defineProperty(exports, "__esModule", { value: true });
var react_1 = __importStar(require("react"));
function SectionWithCommand() {
    var _a = (0, react_1.useState)(null), command = _a[0], setCommand = _a[1];
    var _b = (0, react_1.useState)(null), commandResult = _b[0], setCommandResult = _b[1];
    (0, react_1.useEffect)(function () {
        fetch('../json_files/user_config.json')
            .then(function (response) { return response.json(); })
            .then(function (data) { return setCommand(data.cmd[0]); })
            .catch(function (error) { return console.error('Error fetching command:', error); });
    }, []);
    var executeCommand = function () {
        if (command) {
            var name_1 = command.name, options = command.options;
            console.log("Executing command: ".concat(name_1, " ").concat(options));
            // Simulate command execution (replace with actual execution code)
            var result = "Command \"".concat(name_1, " ").concat(options, "\" executed successfully.");
            setCommandResult(result);
        }
    };
    return (react_1.default.createElement("section", null,
        react_1.default.createElement("h2", null, "Command Details"),
        command && (react_1.default.createElement("div", null,
            react_1.default.createElement("p", null,
                "Name: ",
                command.name),
            react_1.default.createElement("p", null,
                "Options: ",
                command.options),
            react_1.default.createElement("button", { onClick: executeCommand }, "Execute"))),
        commandResult && (react_1.default.createElement("div", null,
            react_1.default.createElement("h3", null, "Command Result:"),
            react_1.default.createElement("p", null, commandResult)))));
}
exports.default = SectionWithCommand;
