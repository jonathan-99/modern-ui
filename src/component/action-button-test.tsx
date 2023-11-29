/* import { render } from '@testing-library/react'; */
import * as React from "react";
import * as ReactDOM from "react-dom";
import ActionB from './action-button';

test('renders Activate button', () => {
  const { container } = render(<ActionB />);

  expect(container).toHaveTextContent('Activate');
});