import { apiFetchSucceeded } from 'store/actions';
import { DataPoint } from 'store/reducers';
import store from 'store';

import consumer from './consumer';

consumer.subscriptions.create(
  { channel: 'DownstreamChannel' },
  {
    received(data: DataPoint) {
      store.dispatch(apiFetchSucceeded('dataPoints', [data]));
    },
  }
);
