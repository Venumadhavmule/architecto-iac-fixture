import http from "node:http";

const server = http.createServer((req, res) => {
  res.writeHead(200, { "content-type": "application/json" });
  res.end(JSON.stringify({ ok: true, service: "architecto-fixture" }));
});

server.listen(3000);
