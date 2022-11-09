class App
  def call(env)
    headers = { 'Content-Type' => 'text/html' }

    return [200, headers, ['favicon']] if env['PATH_INFO'] == '/favicon.ico'

    path = env['QUERY_STRING'].split('=').last
    [200, headers, [file_with_same_content(path)]]
  end

  private

  def file_with_same_content(dir)
    files = []
    Dir[File.join(dir, '*')].each do |file|
      files << File.read(file)
    end
  
    hash = Hash.new(0)
    files.each do |v|
      hash[v] += 1
    end
  
    max = hash.max_by{|k, v| v}
    if max.nil?
      'There is no file or path is wrong.'
    else
      max.join(' ')
    end
  end
end
