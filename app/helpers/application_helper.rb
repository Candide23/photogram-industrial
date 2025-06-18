module ApplicationHelper
    # Given a full URL string, return just the host + path
  def only_host_and_path(raw_url)
    return "" if raw_url.blank?

    uri = URI.parse(raw_url)
    host_and_path = "#{uri.host}#{uri.path}"
    return host_and_path
  rescue URI::InvalidURIError
    # if it wasn’t a valid URL, just return whatever they entered
    return raw_url
  end
end
