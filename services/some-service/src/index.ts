import * as http from 'http'

import { messageResponse } from 'message/response'

const listener: http.RequestListener = function(_req, res) {
  res.writeHead(200)
  res.end(messageResponse())
}

const server = http.createServer(listener)
server.listen(4576)
