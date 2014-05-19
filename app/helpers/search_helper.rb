module SearchHelper
  def results_of_type(array, type)
    results = array.select { |o| o.is_a?(type) }
  end

  def each_result_of_type(array, type, message = "No search results")
    each_result(results_of_type(array, type), message)
  end
  
  def each_result(results, message = "No search results")
    if results.size == 0
      content_tag(:p, message)
    else
      if block_given?
        results.each do |r|
          yield r
        end
      end
    end
  end  
end