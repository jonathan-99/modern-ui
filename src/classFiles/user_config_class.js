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
var fs = __importStar(require("fs"));
var UserConfigReader = /** @class */ (function () {
    function UserConfigReader(filePath) {
        this.filePath = filePath;
        this.userConfig = this.readUserConfig();
    }
    UserConfigReader.prototype.readUserConfig = function () {
        try {
            var data = fs.readFileSync(this.filePath, 'utf-8');
            return JSON.parse(data);
        }
        catch (error) {
            console.error('Error reading user config file:', error);
            return { cmd: [] };
        }
    };
    UserConfigReader.prototype.getAllCmds = function () {
        return this.userConfig.cmd;
    };
    return UserConfigReader;
}());
// Usage
var userConfigReader = new UserConfigReader('../json_files/user_config.json');
var allCmds = userConfigReader.getAllCmds();
console.log('All commands:', allCmds);
