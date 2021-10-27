import React, { FC, Fragment, useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import _ from 'lodash';
import { CartesianGrid, Line, LineChart, XAxis, YAxis } from 'recharts';

import { apiFetchRequested } from 'store/actions';
import { State } from 'store/reducers';

const Home: FC = () => {
  const dispatch = useDispatch();
  const channels = useSelector((state: State) => state.channels);
  const dataPoints = useSelector((state: State) => state.dataPoints);
  const devices = useSelector((state: State) => state.devices);

  useEffect(() => {
    dispatch(apiFetchRequested('devices'));
    dispatch(apiFetchRequested('channels'));
    dispatch(apiFetchRequested('data_points'));
  }, []);

  return (
    <Fragment>
      {_.flatMap(devices, (device) =>
        _.map(_.filter(channels, { deviceId: device.id }), (channel) => (
          <LineChart
            key={`device-${device.id}-channel-${channel.id}`}
            data={_.values(_.filter(dataPoints, { channelId: channel.id }))}
            height={400}
            width={500}
          >
            <Line dataKey="value" />
            <CartesianGrid />
            <XAxis dataKey="createdAt" />
            <YAxis />
          </LineChart>
        ))
      )}
    </Fragment>
  );
};

export default Home;
