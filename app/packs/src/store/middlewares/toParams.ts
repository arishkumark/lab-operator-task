import _ from 'lodash';

const toParams = (source: Record<string, unknown>): string => {
  const params = new URLSearchParams();
  const appendParam = (value: unknown, key: string) => {
    if (_.isArray(value)) {
      _.forEach(value, (value2: unknown) => appendParam(value2, `${key}[]`));
    } else if (_.isPlainObject(value)) {
      // eslint-disable-next-line @typescript-eslint/ban-types
      _.forEach(value as object, (value2: unknown, key2: string) =>
        appendParam(value2, `${key}[${_.snakeCase(key2)}]`)
      );
    } else {
      params.append(key, `${value}`);
    }
  };

  _.forEach(source, (value, key) => appendParam(value, _.snakeCase(key)));

  return params.toString();
};

export default toParams;
