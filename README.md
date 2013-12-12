conekta-subscription-example
============================

Ejemplo de como crear pagos recurrentes, un ejemplo "Sass".

Necesitas una cuenta de <a href="http://conekta.io/"> Conekta </a>. Puedes crear una cuenta de prueba <a href="https://admin.conekta.io/users/sign_up"> aqui</a> y cambiar las llaves ( pública y privada ) en el archivo de /config/application.yml

Vas a ver las llaves en tu cuenta en la seccion de "API Keys"

<img src="https://s3.amazonaws.com/conekta/ejemplos/api_keys.png" />

Para usar pagos recurrentes, hay que incluir la gema en el archivo Gemfile:

gem 'conekta', :git => 'git://github.com/conekta/conekta-ruby.git',  :branch => 'subscriptions'

La primera parte es tokenizar la tarjeta usando <a href="https://conektaapi.s3.amazonaws.com/v0.3.0/js/conekta.js"> Conekta.js </a>. Hay un tutorial del flujo <a href="https://admin.conekta.io/es/docs/suscripciones"> aqui.</a>

Una vez que tengas el token de la tarjeta, hay que mandar el token al servidor. Con este token puedes crear un cliente (y cobrar el cliente despues), implementar un cargo unico o crear una suscripción (asignando al cliente un plan). En este ejemplo, creamos un cliente con el token y en el mismo paso asignamos un plan para este cliente (este plan ya está definido).

Puedes ver el ejemplo funcionando <a href="http://pagos-recurrentes.herokuapp.com/"> aqui </a>


