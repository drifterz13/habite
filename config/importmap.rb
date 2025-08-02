# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", integrity: "sha384-Hea0Yk7N2rQhmxzzIGikclw/jBEhpCDFFXi+rlgF1qZtC7eAazBGapuqKzAe6yXQ", preload: true # @5.3.7
pin "@popperjs/core", to: "popper.js", integrity: "sha384-bfekMOfeUlr1dHZfNaAFiuuOeD7r+Qh45AQ2HHJY7EAAI4QGJ6qx1Qq9gsbvS+60", preload: true # @2.11.8
