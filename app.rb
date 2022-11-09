require 'json'

class App
  def call(env)
    headers = { 'Content-Type' => 'text/html' }

    return [200, headers, ['favicon']] if env['PATH_INFO'] == '/favicon.ico'

    array = env['QUERY_STRING'].split('&')
    params = {}
    array.each do |arr|
      a = arr.split('=')
      params[a.first] = a.last
    end
    [200, headers, [file_with_same_content(params['path'])]]
  end

  private

  def file_with_same_content(dir)
    return 'Need <b>path</b> parameter' if dir.nil?
    files = []
    Dir[File.join(dir, '*')].each do |file|
      files << File.read(file)
    end
  
    hash = Hash.new(0)
    files.each { |v| hash[v] += 1 }
  
    max = hash.max_by{ |k, v| v }
    if max.nil?
      'There is no file or path is wrong.'
    else
      max.join(' ')
    end
  end
end
