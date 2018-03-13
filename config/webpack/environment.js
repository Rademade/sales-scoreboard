const { environment } = require('@rails/webpacker')
const vue =  require('./loaders/vue')
const path = require('path')

environment.loaders.append('vue', vue)

// https://github.com/rails/webpacker/issues/1063#issuecomment-349374978
environment.config.resolve.alias = {
    Services: path.resolve(__dirname, '..', '..', 'app/javascript/packs/services'),
    Components: path.resolve(__dirname, '..', '..', 'app/javascript/packs/components')
};

module.exports = environment
