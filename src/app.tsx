import * as React from 'react';
import { render } from 'react-dom';

import Page from './src/component/page';

function App(){
    return (
        render(<page />, document.getElementById('main'));
    );
}



export default App;