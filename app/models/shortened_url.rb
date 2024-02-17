class ShortenedUrl < ApplicationRecord

    def generate_shortened_url
        return (Base64.encode64 SecureRandom.hex(3) + (Digest::MD5.hexdigest(Time.now.to_i.to_s + self.url)[0..3]))[0..6] if self.shortened_url.nil?
        self.shortened_url
    end
end
