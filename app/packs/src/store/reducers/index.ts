import { AnyAction } from 'redux';
import _ from 'lodash';

interface Resource {
  id: number;
  createdAt: Date;
  updatedAt: Date;
}

export interface Channel extends Resource {
  deviceId: number;
  name: string;
}

export interface DataPoint extends Resource {
  channelId: number;
  value: number;
}

export interface Device extends Resource {
  name: string;
}

export interface State {
  channels: Record<number, Channel>;
  dataPoints: Record<number, DataPoint>;
  devices: Record<number, Device>;
}

const initialState: State = {
  channels: {},
  dataPoints: {},
  devices: {},
};

const normalize = (resources: Array<Resource>) =>
  _.keyBy(
    _.map(resources, (resource: Resource) =>
      _.mapKeys(resource, (_value: unknown, key: string) => _.camelCase(key))
    ),
    'id'
  );

const reducers = (
  state: State = initialState,
  action: AnyAction = { type: 'DUMMY' }
): State => {
  switch (action.type) {
    case 'API_FETCH_SUCCEEDED':
      return {
        ...state,
        [_.camelCase(action.payload.model)]: {
          ...state[_.camelCase(action.payload.model) as keyof State],
          ...normalize(action.payload.resources),
        },
      };
    default:
      return state;
  }
};

export default reducers;
