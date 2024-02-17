class ShortenedUrlsController < ApplicationController
    skip_before_action :verify_authenticity_token #for testing
    after_action :allow_iframe
    
    def create 
        url = params[:url]
        su = ShortenedUrl.where(url: url).take
        su ||= ShortenedUrl.new(url: url)
        generated_shortened_url = ""

        loop do
            query = ShortenedUrl.where(shortened_url: generated_shortened_url)
            generated_shortened_url = su.generate_shortened_url
            break if query.empty?
        end

        if su.shortened_url.nil?
            su.shortened_url = generated_shortened_url
            su.save!
        end

        flash[:notice] = generated_shortened_url
        render :create,  turbo: false
    end

    def redirect
        short_url = params[:id]
        url = ShortenedUrl.where(shortened_url: short_url).take.url

        redirect_to url, allow_other_host: true
    end

    private

    def allow_iframe
        response.headers.except! 'X-Frame-Options'
    end
end