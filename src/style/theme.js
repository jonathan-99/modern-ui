"use strict";
/*import { createTheme as createThemeInstance } from '@material-ui/core/styles'; */
var __assign = (this && this.__assign) || function () {
    __assign = Object.assign || function(t) {
        for (var s, i = 1, n = arguments.length; i < n; i++) {
            s = arguments[i];
            for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p))
                t[p] = s[p];
        }
        return t;
    };
    return __assign.apply(this, arguments);
};
Object.defineProperty(exports, "__esModule", { value: true });
var material_1 = require("@mui/material");
var commonTheme = {
    typography: {
        h1: {
            fontSize: '2rem',
        },
        h2: {
            fontSize: '1.5rem',
        },
        h3: {
            fontSize: '1.3rem',
        },
        h4: {
            fontSize: '1.1rem',
        },
    },
    palette: {
        primary: {
            main: '#523174',
            light: '#cfa1fd',
            dark: '#42275d',
        },
        secondary: {
            main: '#4a21ad',
            light: '#d8cfdf',
        },
    },
};
var theme = (0, material_1.createTheme)(__assign(__assign({}, commonTheme), { components: {
        MuiTableRow: {
            styleOverrides: {
                root: {
                    '&:nth-of-type(even)': {
                        backgroundColor: 'rgba(0, 0, 0, 0.04)',
                    },
                },
            },
        },
        MuiTableCell: {
            styleOverrides: {
                root: {
                    paddingTop: '.2rem',
                    paddingBottom: '.2rem',
                },
            },
        },
    } }));
exports.default = theme;
