interface Action<T = unknown> {
  type: string;
  payload: T;
}

export const apiFetchRequested = (model: string, params = {}): Action => ({
  type: 'API_FETCH_REQUESTED',
  payload: {
    model,
    params,
  },
});

export const apiFetchSucceeded = (
  model: string,
  resources: unknown
): Action => ({
  type: 'API_FETCH_SUCCEEDED',
  payload: {
    model,
    resources,
  },
});
