import toParams from './toParams';

describe('toParams', () => {
  it('support simple value', async () => {
    expect(toParams({ foo: 'bar' })).toEqual('foo=bar');
  });

  it('support array value', async () => {
    expect(toParams({ foo: [1, 2, 3] })).toEqual(
      'foo%5B%5D=1&foo%5B%5D=2&foo%5B%5D=3'
    );
  });

  it('support object value', async () => {
    expect(toParams({ foo: { bar: 'baz' } })).toEqual('foo%5Bbar%5D=baz');
  });

  it('support complex nested params', async () => {
    expect(toParams({ filter: { id: [1, 2] } })).toEqual(
      'filter%5Bid%5D%5B%5D=1&filter%5Bid%5D%5B%5D=2'
    );

    expect(
      toParams({
        filter: { createdAt: { gt: '2020-12-31', lt: '2021-01-01' } },
      })
    ).toEqual(
      'filter%5Bcreated_at%5D%5Bgt%5D=2020-12-31&filter%5Bcreated_at%5D%5Blt%5D=2021-01-01'
    );
  });
});
