"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var material_1 = require("@mui/material");
var react_1 = __importDefault(require("react"));
var ActionButton = function (_a) {
    var border = _a.border, color = _a.color, children = _a.children, height = _a.height, onClick = _a.onClick, radius = _a.radius, width = _a.width;
    return (react_1.default.createElement(material_1.Button, { onClick: onClick, style: {
            backgroundColor: color,
            border: border,
            borderRadius: radius,
            height: height,
            width: width
        } }, children));
};
exports.default = ActionButton;
