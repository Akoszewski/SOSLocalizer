var WebSocketServer = require("ws").Server;

var wss = new WebSocketServer({port:7777});

wss.on('connection', function connection(ws) {
    ws.on('message', function(message) {
        wss.broadcast(message.toString());
    })
});

wss.broadcast = function broadcast(msg) {
   console.log(msg);
   wss.clients.forEach(function each(client) {
       client.send(msg);
    });
};
