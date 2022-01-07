var WebSocketServer = require("ws").Server;

var wss = new WebSocketServer({port:7777});

var last_uid = 0; // User ID

function generateUid() {
    return last_uid++;
}

wss.on('connection', function connection(ws) {
    ws.uid = generateUid();
    ws.on('message', function(message) {
        var msg = JSON.parse(message);
            msg.uid = ws.uid;
        wss.broadcast(JSON.stringify(msg));
    });
});

wss.broadcast = function broadcast(msg) {
   console.log(msg);
   wss.clients.forEach(function each(client) {
       client.send(msg);
    });
};
