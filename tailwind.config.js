module.exports = {
  mode: 'jit',
  purge: [
    './app/views/**/*.html.erb',
    './app/views/**/*.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js'
  ],
  darkMode: 'media'
}
