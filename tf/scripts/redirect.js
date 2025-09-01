function handler(event) {
  var request = event.request;
  var host = request.headers["host"].value;

  if (host !== "asadalikhan.co.uk") {
    return {
      statusCode: 301,
      statusDescription: "Moved Permanently",
      headers: {
        location: { value: "https://asadalikhan.co.uk" },
      },
    };
  }

  return request;
}
