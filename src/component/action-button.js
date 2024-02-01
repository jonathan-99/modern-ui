"use strict";
exports.__esModule = true;
var material_1 = require("@mui/material");
var React = require("react");
var aButton = function (_a) {
    var border = _a.border, color = _a.color, children = _a.children, height = _a.height, onClick = _a.onClick, radius = _a.radius, width = _a.width;
    return (React.createElement(material_1.Button, { onClick: onClick, style: {
            backgroundColor: color,
            border: border,
            borderRadius: radius,
            height: height,
            width: width
        } }, children));
};
exports["default"] = aButton;
