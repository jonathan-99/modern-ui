import * as fs from 'fs';

interface UserConfig {
    cmd: {
        cmd_id: number;
        name: string;
        options: string;
        priv_required: boolean;
    }[];
}

class UserConfigReader {
    private userConfig: UserConfig;

    constructor(private filePath: string) {
        this.userConfig = this.readUserConfig();
    }

    private readUserConfig(): UserConfig {
        try {
            const data = fs.readFileSync(this.filePath, 'utf-8');
            return JSON.parse(data);
        } catch (error) {
            console.error('Error reading user config file:', error);
            return { cmd: [] };
        }
    }

    getAllCmds(): { cmd_id: number; name: string; options: string; priv_required: boolean }[] {
        return this.userConfig.cmd;
    }
}

// Usage
const userConfigReader = new UserConfigReader('../json_files/user_config.json');
const allCmds = userConfigReader.getAllCmds();
console.log('All commands:', allCmds);
