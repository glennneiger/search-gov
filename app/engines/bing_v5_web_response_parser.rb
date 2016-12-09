class BingV5WebResponseParser < BingV5ResponseParser
  def results
    @results ||= bing_response_body.web_pages.value.map { |v| individual_result(v) }
  end

  def total
    bing_response_body.web_pages.total_estimated_matches
  end

  private

  def individual_result(bing_result)
    Hashie::Mash.new({
      title: bing_result.name,
      url: bing_result.url,
      description: bing_result.snippet,
    })
  end

  def default_bing_response_parts
    {
      query_context: {
        altered_query: nil,
      },
      status_code: 200,
      web_pages: {
        total_estimated_matches: 0,
        value: [],
      },
    }
  end
end
