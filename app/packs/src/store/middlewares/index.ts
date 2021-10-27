import { Middleware } from 'redux';
import _ from 'lodash';

import { apiFetchSucceeded } from '../actions';
import { State } from '../reducers';
import toParams from './toParams';

const middleware: Middleware<unknown, State> =
  (state) => (next) => (action) => {
    if (action.type !== 'API_FETCH_REQUESTED') return next(action);
    return fetch(
      `/api/${action.payload.model}.json?${toParams(action.payload.params)}`,
      {
        headers: { 'Content-Type': 'application/json' },
      }
    ).then(async (response) => {
      const json = await response.json();

      state.dispatch(apiFetchSucceeded(action.payload.model, json));
    });
  };

export default middleware;
