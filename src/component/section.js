"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var react_1 = __importDefault(require("react"));
var action_button_1 = __importDefault(require("./action-button"));
function Section() {
    return (react_1.default.createElement(react_1.default.Fragment, null,
        react_1.default.createElement("h1", null, "Colorful Custom Button Components"),
        react_1.default.createElement(action_button_1.default, { border: "none", color: "pink", height: "200px", onClick: function () { return console.log("You clicked on the pink circle!"); }, radius: "50%", width: "200px" }, "I'm a pink circle!")));
}
exports.default = Section;
