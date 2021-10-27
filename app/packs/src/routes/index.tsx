import React, { FC } from 'react';
import { Provider } from 'react-redux';

import store from 'store';

import Home from './Home';

const Routes: FC = () => (
  <Provider store={store}>
    <Home />
  </Provider>
);

export default Routes;
