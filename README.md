conekta-subscription-example
============================

Ejemplo de como crear pagos recurrentes, un ejemplo "Sass".

Necesitas una cuenta de <a href="http://conekta.io/"> Conekta </a>. Puedes crear una cuenta de prueba <a href="https://admin.conekta.io/users/sign_up"> aqui</a> y cambiar las llaves ( pública y privada ) en el archivo de /config/application.yml

Vas a ver las llaves en tu cuenta en la seccion de "API Keys"

<img src="https://s3.amazonaws.com/conekta/ejemplos/api_keys.png" />

Para usar pagos recurrentes, hay que incluir la gema en el archivo Gemfile:

gem 'conekta', :git => 'git://github.com/conekta/conekta-ruby.git',  :branch => 'subscriptions'



