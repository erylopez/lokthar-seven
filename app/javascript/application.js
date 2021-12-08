// Entry point for the build script in your package.json
import mrujs from "mrujs";
import "@hotwired/turbo-rails"
import "./controllers"
window.Turbo = Turbo;

mrujs.start();