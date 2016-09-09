Mime::Type.unregister :json
api_mime_types = [
  "application/vnd.api+json",
  "text/x-json",
  "application/json",
]
Mime::Type.register "application/vnd.api+json", :json, api_mime_types
