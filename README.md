## nk.pl OAuth2 Strategy for OmniAuth 1.0

Supports the OAuth 2.0 server-side authentication, and OAuth user data endpoint. To get application key/secret please go to http://developers.nk.pl

## Installing
Add to your `Gemfile`:

```ruby
gem 'omniauth-nk'
```
Then `bundle install`.

## Usage

Put into your config/initializers/omniauth.rb

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :nk, ENV['NK_KEY'], ENV['NK_SECRET']
end

OmniAuth.config.on_failure do |env|
  [302, {'Location' => "#{env['SCRIPT_NAME']}#{OmniAuth.config.path_prefix}/failure?message=#{env['omniauth.error.type']}", 'Content-Type'=> 'text/html'}, []]
end
```

Get own application key/secret from http://developers.nk.pl

## Auth Hash

Here's an example *Auth Hash* available in request

```ruby
{
  :provider => 'nk',
  :uid => 'person.acbdefgh',
  :info => {
    :name => 'Jan Kowalski',
    :email => 'jan@kowalski.pl',
    :age  => 33,
    :gender => 'male'
    :location => 'Wrocław',
    :image => 'http://photos.nasza-klasa.pl/125/10/thumb/6646b702e7.jpeg',
  },
  :credentials => {
    :token => 'ABCDEF...',
    :expires_at => 1321747205,
    :expires => true
  },
  :extra => {
    :raw_info => {
      :entry => {
          [see http://developers.nk.pl/wiki/Rest_Service_Profile_Information]
      }
    }
  }
}
```
