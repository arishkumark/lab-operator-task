import React, { FC, Fragment, useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import _ from 'lodash';
import {
  CartesianGrid,
  Label,
  Line,
  LineChart,
  ResponsiveContainer,
  Tooltip,
  TooltipProps,
  XAxis,
  YAxis,
} from 'recharts';

import { apiFetchRequested } from 'store/actions';
import { State } from 'store/reducers';

import { Options } from '../types';

const style = {
  tooltipWrapper: {
    border: '1px solid #c7c7c7',
    background: '#c7c7c7',
    borderRadius: 4,
    padding: 10,
  },
};

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

  /*
    We are downsample the data using lodash sample size.
    This may not be accurate as we are getting the random sample.
    We may need to write an downsample algorithm to get the actual peaks
  */

  const sampleData = _.sampleSize(dataPoints, 500);

  // This function returns the formatted x-axis value and tooltip value
  const formatXAxis = (item: string, includeSeconds: boolean) => {
    const options: Options = {
      hour: 'numeric',
      minute: 'numeric',
      hour12: true,
    };

    if (includeSeconds) {
      options.second = 'numeric';
    }

    return new Date(item).toLocaleString('en-US', options);
  };

  // A custom tooltip to show the data in a desired format on hover
  const CustomTooltip = ({
    payload,
    label,
    active,
  }: TooltipProps<number, string>) => {
    if (active) {
      return (
        <div className="custom-tooltip">
          <p className="label">{`${formatXAxis(label, true)} : ${
            payload[0].value
          }`}</p>
        </div>
      );
    }

    return null;
  };

  return (
    <Fragment>
      <h1 style={{ textAlign: 'center' }}>Lab Operator data</h1>
      <div className="container">
        {_.flatMap(devices, (device) =>
          _.map(_.filter(channels, { deviceId: device.id }), (channel) => (
            <div className="channelContainer">
              <h3>
                {device.name} - {channel.name}
              </h3>
              <ResponsiveContainer width={'100%'} height={400}>
                <LineChart
                  key={`device-${device.id}-channel-${channel.id}`}
                  data={_.values(
                    _.filter(sampleData, { channelId: channel.id })
                  )}
                  height={400}
                  width={500}
                  margin={{ top: 30, right: 30, left: 30, bottom: 30 }}
                >
                  <Line dataKey="value" />
                  <CartesianGrid />
                  <Tooltip
                    wrapperStyle={style.tooltipWrapper}
                    content={<CustomTooltip />}
                  />
                  <XAxis
                    dataKey="createdAt"
                    tickFormatter={(item) => formatXAxis(item, false)}
                  >
                    <Label
                      value={new Date().toLocaleDateString('en-US', {
                        weekday: 'short',
                        year: 'numeric',
                        month: 'short',
                        day: 'numeric',
                      })}
                      offset={-10}
                      position="insideBottom"
                    />
                  </XAxis>
                  <YAxis>
                    <Label
                      value={channel.name}
                      position="insideLeft"
                      angle={-90}
                    />
                  </YAxis>
                </LineChart>
              </ResponsiveContainer>
            </div>
          ))
        )}
      </div>
    </Fragment>
  );
};

export default Home;
