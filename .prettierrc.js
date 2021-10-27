let config;

try {
  config = require('@labforward/config/prettier');
} catch {
  // fallback for environments which does not support `exports` key in package.json yet, e.g. Atom editor
  config = require('@labforward/config/.prettierrc');
}

module.exports = config
