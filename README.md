conekta-subscription-example
============================

Ejemplo de cómo crear pagos recurrentes, un ejemplo "Sass".


Para seguir este ejemplo necesitas una cuenta de <a href="http://conekta.io/"> Conekta </a>. 

Puedes crear una cuenta de prueba <a href="https://admin.conekta.io/users/sign_up">  aquí </a>  y cambiar las llaves ( pública y privada ) en el archivo de /config/application.yml.

Después de esto vas a ver las llaves en tu cuenta en la seccion de "API Keys".

<img src="https://s3.amazonaws.com/conekta/ejemplos/api_keys.png" />

La llave privada la usamos para las llamadas del lado del servidor y la llave pública es lo que usamos para frontend (para tokenizar los datos de la tarjeta).

Para usar pagos recurrentes, hay que incluir la gema en el archivo Gemfile asi:

<code>

	gem 'conekta', :git => 'git://github.com/conekta/conekta-ruby.git',  :branch => 'subscriptions'

</code>

Para empezar a hacer pagos recurrentes es necesario tokenizar los datos de la tarjeta usando <a href="https://conektaapi.s3.amazonaws.com/v0.3.0/js/conekta.js"> Conekta.js </a>. La forma que se muestra abajo es un ejemplo de los datos que se necesitas para crear un token.

<img src="https://s3.amazonaws.com/conekta/images/form.png" />

Hay un tutorial sobre los detalles de este flujo <a href="https://admin.conekta.io/es/docs/suscripciones"> aqui.</a>

Una vez que tengas el token de la tarjeta, hay que mandar el token al servidor. Con este token puedes crear un cliente (y cobrar el cliente después), implementar un cargo único o crear una suscripción (asignando al cliente un plan).

En este ejemplo, creamos un cliente con el token y en el mismo paso asignamos un plan para este cliente (este plan ya está definido previamente).
<code>

        customer = Conekta::Customer.create(
          :email => email,
          :description => name,
          :name => name,
          :cards => card_array,
          :plan => 'silver-plan', #silver plan already created
        )

</code>

Una vez que tengas el webhook configurado en el panel de administración, 

<img src="https://s3.amazonaws.com/conekta/ecommerce/images/webhook.png" style="width:500px;"/> 

puedes implementar el flujo de cada <a href="https://admin.conekta.io/en/docs/api_v030#events"> evento</a> importante para una suscripción.

Puedes ver el ejemplo funcionando <a href="http://pagos-recurrentes.herokuapp.com/"> aqui </a>





