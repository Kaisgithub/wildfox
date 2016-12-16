class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # before_filter :allow_cross_domain_access
  # #allow cross domain access
  # def allow_cross_domain_access
  #   response.headers['Access-Control-Allow-Origin'] = '*'
  #   response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, OPTIONS, DELETE, PATCH'
  #   response.headers['Access-Control-Allow-Headers'] = 'origin, content-type, X-Requested-With'
  #   response.headers['Access-Control-Max-Age'] = '1800'
  # end

  protect_from_forgery with: :null_session

  skip_before_filter  :verify_authenticity_token       # Can't verify CSRF token authenticity

  def xtoy(s)
    objs = "['" + s + "']"
    while (objs["_"])
      objs["_"] = "']['"
    end
    return objs
  end

  def dtoy(s)
    objs = "['" + s + "']"
    while (objs["."])
      objs["."] = "']['"
    end
    return objs
  end

  def jtom(s)
    while (s["\"=>"])
      s["\"=>"] = "\":"
    end
    return s
  end

end
