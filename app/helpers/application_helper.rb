module ApplicationHelper



  def ereceipts_signature(expires, key, secret)
       secret_decoded = Base64.decode64(secret)
       message = "#{key}\n#{expires}"
       hmac = OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new("sha256"), secret_decoded, message)
       signature = CGI.escape(Base64.encode64(hmac).delete("\n"))
  end



end
