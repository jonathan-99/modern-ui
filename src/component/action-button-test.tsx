/* import { render } from '@testing-library/react'; */
import * as React from "react";
import * as ReactDOM from "react-dom";
import ActivateButton from './ActivateButton';

test('renders Activate button', () => {
  const { container } = render(<ActivateButton />);

  expect(container).toHaveTextContent('Activate');
});