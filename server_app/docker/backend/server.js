var WebSocketServer = require("ws").Server;

var wss = new WebSocketServer({port:7777});

var last_id = 0;

function generateId() {
    return last_id++;
}

wss.on('connection', function connection(ws) {
    ws.on('message', function(message) {
        var msg = JSON.parse(message);
        if (msg.command == "SOS") {
            msg.id = generateId();
        }
        wss.broadcast(JSON.stringify(msg));
    });
});

wss.broadcast = function broadcast(msg) {
   console.log(msg);
   wss.clients.forEach(function each(client) {
       client.send(msg);
    });
};
