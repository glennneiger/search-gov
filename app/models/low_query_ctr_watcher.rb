class LowQueryCtrWatcher < Watcher
  WATCHER_DEFAULTS = { search_click_total: 100, low_ctr_threshold: 15 }
  define_hash_columns_accessors column_name_method: :conditions,
                                fields: [:search_click_total, :low_ctr_threshold]

  validates_numericality_of :search_click_total, greater_than_or_equal_to: 20, only_integer: true
  validates_numericality_of :low_ctr_threshold, greater_than: 0.0, less_than: 100.0

  def humanized_alert_threshold
    "#{low_ctr_threshold}% CTR on #{search_click_total} Queries & Clicks"
  end

  def input(json)
    options = { affiliate_name: affiliate.name, time_window: time_window, min_doc_count: search_click_total.to_i,
                query_blocklist: query_blocklist }
    low_query_ctr_query_body = WatcherLowCtrQuery.new(options).body
    input_search_request(json, search_type: :count, types: %w(search click),
                         indices: watcher_indexes_from_window_size(time_window), body: JSON.parse(low_query_ctr_query_body))
  end

  def condition_script
    "ctx.payload.aggregations && ctx.payload.aggregations.agg.buckets.any({ it.ctr.value < #{low_ctr_threshold}})"
  end

  def transform_script
    "return ctx.payload.aggregations.agg.buckets.findAll({ it.ctr.value < #{low_ctr_threshold}}).collect({ it.key })"
  end

end