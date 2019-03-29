import PerfectHTTP
import PerfectHTTPServer

struct Message : Decodable {
	let hello: String
}
func handler(request: HTTPRequest, response: HTTPResponse) {
	defer { response.completed() }
	do {
		let msg: Message = try request.decode()
		response.setHeader(.contentType, value: "text/plain")
		response.appendBody(string: "\(msg.hello)\n")
	} catch {
		response.status = .internalServerError
	}
}

var routes = Routes()
routes.add(method: .post, uri: "/", handler: handler)

try HTTPServer.launch(name: "localhost", port: 8080, routes: routes)
