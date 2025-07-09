const path = require('path');
const autolinkHeadings = require('remark-autolink-headings');
const highlight = require('rehype-highlight');
const codeImport = require('remark-code-import');
const withProse = require('@docfy/plugin-with-prose');

/**
 * @type {import('@docfy/core/lib/types').DocfyConfig}
 */
module.exports = {
  repository: {
    url: 'https://github.com/josemarluedke/frontile',
    editBranch: 'main'
  },
  tocMaxDepth: 3,
  plugins: [withProse({ className: 'prose max-w-none dark:prose-invert' })],
  remarkPlugins: [autolinkHeadings, codeImport],
  rehypePlugins: [
    [
      highlight,
      {
        aliases: { javascript: 'gjs', typescript: 'gts' }
      }
    ]
  ],
  sources: [
    {
      root: path.resolve(__dirname, '../docs'),
      pattern: '**/*.md',
      urlPrefix: 'docs'
    },

    ...[
      'buttons',
      'utilities',
      'status',
      'collections',
      'forms',
      'forms-legacy',
      'notifications',
      'overlays'
    ].map((pkgName) => {
      return {
        root: path.resolve(__dirname, `../packages/${pkgName}`),
        pattern: '(docs|src)/**/**/*.md',
        urlPrefix: `docs/${pkgName}`,
        urlSchema: 'manual'
      };
    })
  ],
  labels: {
    accessibility: 'Accessibility',
    customization: 'Customization',
    components: 'Components',
    docs: 'Documentation',
    utilities: 'Utilities',
    collections: 'Collections',
    status: 'Status',
    buttons: 'Buttons',
    overlays: 'Overlays',
    notifications: 'Notifications',
    forms: 'Forms',
    'forms-legacy': 'Forms (Legacy)',
  }
};
