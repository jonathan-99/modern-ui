import * as React from 'react';
import { render } from 'react-dom';

import Page from './component/page';

function App(){
    return (
        render(<Page />, document.getElementById('main'))
    );
}



export default App;