const express = require('express')

const config = {
  port_: 3000
}

const { Elm } = require('./elm.js')
const elm = Elm.Main.init({
  flags: config
})

const handler = (route) => (req, res, next) => {
  const id = route.path + Date.now()
  elm.ports.outgoing.subscribe(respond(id, res))
  elm.ports.incoming.send({
    id,
    path: route.path,
    url: req.originalUrl
  })
}

const respond = (id, res) => (response) =>
  (id === response.id)
    ? [ elm.ports.outgoing.unsubscribe(respond(id, res)), res.send(response.content) ]
    : []

elm.ports.ready.subscribe(function (routes) {
  const app = express()
  routes.forEach(route =>
    app.get(route.path, handler(route))
  )
  app.listen(config.port_, _ =>
    console.info(`Ready at http://localhost:${config.port_}`)
  )
})
