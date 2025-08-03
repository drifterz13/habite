# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", integrity: "sha384-uoqG/CmZpD/9qXOeB/Uvgdz4+WArrrNNuGlXfcBlxw38/GqiC5goN4WYEMl814Uc", preload: true # @5.3.7
pin "@popperjs/core", to: "popper.js", integrity: "sha384-VG3bOqbFug7TD6AyHLLA94Lry0HntTObaohUp1OeSdqzEOG8aDvd22SE8DTppZrm", preload: true # @2.11.8
