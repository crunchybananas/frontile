'use strict';

const EmberApp = require('ember-cli/lib/broccoli/ember-app');

module.exports = function (defaults) {
  const app = new EmberApp(defaults, {
    'ember-cli-babel': {
      enableTypeScriptTransform: true
    },
    autoImport: {
      watchDependencies: [
        '@frontile/buttons',
        '@frontile/theme',
        '@frontile/utilities',
        '@frontile/notifications',
        '@frontile/overlays',
        '@frontile/forms',
        ['@frontile/forms']
      ]
    },
    postcssOptions: {
      compile: {
        enabled: true,
        includePaths: ['app', 'node_modules/@frontile/theme/dist'],
        cacheInclude: [/.*\.(css|hbs|js|gts)$/, /tailwind\.config\.js$/],
        plugins: [
          require('tailwindcss')('./tailwind.config.js'),
          require('autoprefixer')
        ]
      }
    }
  });

  /*
  This build file specifies the options for the dummy test app of this
  addon, located in `/tests/dummy`
  This build file does *not* influence how the addon or the app using it
  behave. You most likely want to be modifying `./index.js` or app's build file
*/

  const { maybeEmbroider } = require('@embroider/test-setup');
  return maybeEmbroider(app);
};
