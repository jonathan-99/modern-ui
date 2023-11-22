import { render } from '@testing-library/react';

import ActivateButton from './ActivateButton';

test('renders Activate button', () => {
  const { container } = render(<ActivateButton />);

  expect(container).toHaveTextContent('Activate');
});