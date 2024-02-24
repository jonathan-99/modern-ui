import React, { useState, useEffect } from 'react';

interface Command {
    name: string;
    options: string;
}

function SectionWithCommand() {
    const [command, setCommand] = useState<Command | null>(null);
    const [commandResult, setCommandResult] = useState<string | null>(null);

    useEffect(() => {
        fetch('../json_files/user_config.json')
            .then(response => response.json())
            .then(data => setCommand(data.cmd[0]))
            .catch(error => console.error('Error fetching command:', error));
    }, []);

    const executeCommand = () => {
        if (command) {
            const { name, options } = command;
            console.log(`Executing command: ${name} ${options}`);
            // Simulate command execution (replace with actual execution code)
            const result = `Command "${name} ${options}" executed successfully.`;
            setCommandResult(result);
        }
    };

    return (
        <section>
            <h2>Command Details</h2>
            {command && (
                <div>
                    <p>Name: {command.name}</p>
                    <p>Options: {command.options}</p>
                    <button onClick={executeCommand}>Execute</button>
                </div>
            )}
            {commandResult && (
                <div>
                    <h3>Command Result:</h3>
                    <p>{commandResult}</p>
                </div>
            )}
        </section>
    );
}

export default SectionWithCommand;
