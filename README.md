# modern-ui
UI with *API calls in TypeScript. This takes a json list of commands (such as ls, ps, ping) then offers them to a user 
(depending on browser) to execute them and show the return.

*still in conceptual stage

## architecture.

page -contains-> section -contains-> action button and output pane.

# Execution

 - In Visual Studio

 ```
 tsc index.tsx --jsx react
 ```

# Installation Steps.
 -  Install NodeJS on the computer's OS. https://nodejs.org/en
 -  sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# Installation check / errors.
 - Check
  - nvm --version
  - node --version
  - docker --version
  - docker compose version

 - Installation specific for Windows and Visual Studio
  - sudo update-alternatives --config iptables
 
## Install the following:
Installing docker
```
sudo curl -fsSL https://get.docker.com -o get-docker.sh | bash
sudo usermod -aG docker $USER
```
## Installing all the node, nvm etc
```
sudo apt install node npm nvm -y
sudo curl -qL https://www.npmjs.com/install.sh | sh
npm install node @types/react @types/react-dom @emotion/styled @mui/material @mui/icons-material 
npm install 
            typescript@latest --save-dev 
            @types/node --save-dev
```
## Remove
Ensure node_modules -> prop-types (all) are deleted. (I don't remember what installed them in the first place.)
```npm uninstall @types/prop-types```

# Testing.
Written with a jenkins file, to a build server and the app run locally.
## commands used:
```commandline
Set-ItemProperty -Path .\startup-and-install.sh -Name IsReadOnly -Value $false
icacls .\startup-and-install.sh /grant Everyone:RX

```

# References / Link / Top learning sites.
 - https://react.dev/learn
 - https://code.visualstudio.com/Docs/languages/typescript
 - https://www.digitalocean.com/community/tutorials/react-typescript-with-react