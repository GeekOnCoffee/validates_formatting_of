require 'spec_helper'

describe ValidatesFormattingOf::ModelAdditions do

  describe "email" do
    class Email < TestActiveRecord
      attr_accessor :email
      validates_formatting_of :email
    end
    it "validates that the email provided is valid" do
      Email.new(:email => "example@example.com").should be_valid
      Email.new(:email => "badexample.com").should_not be_valid
      Email.new(:email => "mbridges.91@gmail.com").should be_valid
      Email.new(:email => "some-random%%%strangely-formatted-email@lots.of.subdomains.com").should be_valid
      Email.new(:email => "this__???{}|__should@be-valid.com").should be_valid
      Email.new(:email => "visitorservices@vmfa.museum").should be_valid
      Email.new(:email => "info@samoa.travel").should be_valid
      Email.new(:email => "info@-samoa.travel").should_not be_valid
      Email.new(:email => "info@samoa-.travel").should_not be_valid
      Email.new(:email => "info@123-samoa.travel").should be_valid
    end
  end

  describe "simple email for 1.8.7 and javascript validations (such as with client_side_validations)" do
    class SimpleEmail < TestActiveRecord
      attr_accessor :email
      validates_formatting_of :email, :using => :simple_email
    end
    it "validates that the email provided is valid" do
      Email.new(:email => "example@example.com").should be_valid
      Email.new(:email => "badexample.com").should_not be_valid
      Email.new(:email => "mbridges.91@gmail.com").should be_valid
      Email.new(:email => "some-random%%%strangely-formatted-email@lots.of.subdomains.com").should be_valid
      Email.new(:email => "this__???{}|__should@be-valid.com").should be_valid
      Email.new(:email => "visitorservices@vmfa.museum").should be_valid
      Email.new(:email => "info@samoa.travel").should be_valid
      Email.new(:email => "info@-samoa.travel").should_not be_valid
      Email.new(:email => "info@samoa-.travel").should_not be_valid
      Email.new(:email => "info@123-samoa.travel").should be_valid
    end
  end
  describe "url" do
    class Webpage < TestActiveRecord
      attr_accessor :url
      validates_formatting_of :url
    end
    it "validates that the url provided is valid" do
      Webpage.new(:url => 'http://something.com').should be_valid
      Webpage.new(:url => 'http://something-else.com').should be_valid
      Webpage.new(:url => 'http://sub.domains.something-else.com').should be_valid
      Webpage.new(:url => 'http://username:password@something-else.com').should be_valid
      Webpage.new(:url => "something else").should_not be_valid
    end
  end

  describe "us_zip" do
    class USZip < TestActiveRecord
      attr_accessor :zipcode
      validates_formatting_of :zipcode, :using => :us_zip
    end
    it "validates that the zipcode provided is valid" do
      USZip.new(:zipcode => '92348').should be_valid
      USZip.new(:zipcode => '23434-2348').should be_valid
      USZip.new(:zipcode => '234').should_not be_valid
      USZip.new(:zipcode => '23408234').should_not be_valid
      USZip.new(:zipcode => 'invalid').should_not be_valid
    end
  end

  describe "alpha" do
    class Alpha < TestActiveRecord
      attr_accessor :alpha
      validates_formatting_of :alpha
    end
    it "validates that the letters provided is valid" do
      Alpha.new(:alpha => 'abscdsofjsdpfahdsofkajlsdfaspdhjfads').should be_valid
      Alpha.new(:alpha => 'asdfalskdfjhas-dlfhasdksdfaldhfadsfasdfa').should be_valid
      Alpha.new(:alpha => 'adsufasodfksadjfskjdfha98').should_not be_valid
      Alpha.new(:alpha => 'asdf ausdpf98hasdfo alsdf ja8 sd').should_not be_valid
    end
  end

  describe "alphanum" do
    class Alphanum < TestActiveRecord
      attr_accessor :letters_and_numbers
      validates_formatting_of :letters_and_numbers, :using => :alphanum
    end
    it "validates that the letters provided is valid" do
      Alphanum.new(:letters_and_numbers => 'numbersandlettersarevalid1234567890').should be_valid
      Alphanum.new(:letters_and_numbers => 'justletters').should be_valid
      Alphanum.new(:letters_and_numbers => 'letters and numbers 123 with spaces').should be_valid
      Alphanum.new(:letters_and_numbers => 'adding ; some special ** chars').should_not be_valid
    end
  end

  describe "us_phone" do
    class USPhone < TestActiveRecord
      attr_accessor :phone_number
      validates_formatting_of :phone_number, :using => :us_phone
    end
    it "validates that the phone number provided is valid" do
      USPhone.new(:phone_number => '(234) 234-3456').should be_valid
      USPhone.new(:phone_number => '123 123 3456').should be_valid
      USPhone.new(:phone_number => '1231233456').should be_valid
      USPhone.new(:phone_number => '123.123.3456').should be_valid
      USPhone.new(:phone_number => '(223)123-2347').should be_valid
      USPhone.new(:phone_number => '(223 123-2347').should_not be_valid
      USPhone.new(:phone_number => '12349870238').should_not be_valid
    end
  end

  describe "ip_address" do
    class IPAddress < TestActiveRecord
      attr_accessor :ip
      validates_formatting_of :ip, :using => :ip_address
    end
    it "validates that the IP address provided is valid" do
      IPAddress.new(:ip => '10.10.10').should_not be_valid
      IPAddress.new(:ip => '999.10.10.20').should_not be_valid
      IPAddress.new(:ip => '2222.22.22.22').should_not be_valid
      IPAddress.new(:ip => '22.2222.22.2').should_not be_valid
      IPAddress.new(:ip => '127.0.0.1').should be_valid
      IPAddress.new(:ip => '132.254.111.10').should be_valid
    end
  end

  describe "ip_address_v4" do
    class IPAddress2 < TestActiveRecord
      attr_accessor :ipv4
      validates_formatting_of :ipv4, :using => :ip_address_v4
    end
    it "validates that the IP address provided is valid" do
      IPAddress2.new(:ipv4 => '10.10.10').should_not be_valid
      IPAddress2.new(:ipv4 => '999.10.10.20').should_not be_valid
      IPAddress2.new(:ipv4 => '2222.22.22.22').should_not be_valid
      IPAddress2.new(:ipv4 => '22.2222.22.2').should_not be_valid
      IPAddress2.new(:ipv4 => '127.0.0.1').should be_valid
      IPAddress2.new(:ipv4 => '132.254.111.10').should be_valid
    end
  end

  # For clarification, NONE of the following numbers are real credit card numbers.
  # They only match the pattern. These were randomly made for testing.
  describe "credit_card" do
    class Client < TestActiveRecord
      attr_accessor :cc
      validates_formatting_of :cc, :using => :credit_card
    end
    it "validates that the credit card number provided is valid" do
      Client.new(:cc => '4264-2879-1230-0000').should be_valid # Visa style
      Client.new(:cc => '6011-1111-0000-2391').should be_valid # Discover style
      Client.new(:cc => '5422434400828888').should be_valid # Mastercard style
      Client.new(:cc => '1233444444444444').should_not be_valid # fake
    end
  end

  describe "ssn" do
    class AnotherPerson < TestActiveRecord
      attr_accessor :ssn
      validates_formatting_of :ssn
    end
    it "validates that the social security number provided is valid" do
      AnotherPerson.new(:ssn => "145.47.0191").should be_valid
      AnotherPerson.new(:ssn => "223-43-2343").should be_valid
      AnotherPerson.new(:ssn => "999.55.8888").should be_valid
      AnotherPerson.new(:ssn => "28934").should_not be_valid
      AnotherPerson.new(:ssn => "228934828934934").should_not be_valid
      AnotherPerson.new(:ssn => "23498.7234").should_not be_valid
    end
  end

  describe "hex_color" do
    class Color < TestActiveRecord
      attr_accessor :color
      validates_formatting_of :color, :using => :hex_color
    end
    it "validates that the hex color value provided is valid" do
      Color.new(:color => "efefef").should be_valid
      Color.new(:color => "98de89").should be_valid
      Color.new(:color => "000011").should be_valid
      Color.new(:color => "132").should be_valid
      Color.new(:color => "eef").should be_valid
      Color.new(:color => "efefe").should_not be_valid
      Color.new(:color => "zsdfsd").should_not be_valid
      Color.new(:color => "p98hul;").should_not be_valid
      Color.new(:color => "sdfsdfsf").should_not be_valid
    end
  end

  describe "validation options" do
    class Phony < TestActiveRecord
      attr_accessor :phone, :phone2
      validates_formatting_of :phone, :using => :us_phone, :on => :create
      validates_formatting_of :phone2, :using => :us_phone, :on => :update
    end
    it "validates the phone formatting only on creation" do
      option = Phony.new(:phone => "(123) 234-4567")
      option.should be_valid
      option.phone = "123123123"
      option.should be_valid
    end

    class Iffy < TestActiveRecord
      attr_accessor :name, :phone
      validates_presence_of :name
      validates_formatting_of :phone, :using => :us_phone, :if => lambda { |iffy| iffy.name == "Matthew" }
    end
    it "validates the phone formatting only if a name is specified" do
      Iffy.new(:phone => "(123 345-4567", :name => "Bill").should be_valid
      Iffy.new(:phone => "(123 345-4567", :name => "Matthew").should_not be_valid
    end

    class Unlessy < TestActiveRecord
      attr_accessor :name, :phone
      validates_presence_of :name
      validates_formatting_of :phone, :using => :us_phone, :unless => lambda { |unlessy| unlessy.name == "Matthew" }
    end
    it "validates the phone formatting only if a name is specified" do
      Unlessy.new(:phone => "(123 345-4567", :name => "Bill").should_not be_valid
      Unlessy.new(:phone => "(123 345-4567", :name => "Matthew").should be_valid
    end
  end
  describe "dollars" do
    class Money < TestActiveRecord
      attr_accessor :amount
      validates_formatting_of :amount, :using => :dollars
    end
    it "validates that the dollars amount provided is valid" do
      Money.new(:amount => "$100.00").should be_valid
      Money.new(:amount => "100.00").should be_valid
      Money.new(:amount => "12,234,343").should be_valid
      Money.new(:amount => "$12.34").should be_valid
      Money.new(:amount => "120,123,232.32").should be_valid
      Money.new(:amount => "$$1111111100").should_not be_valid
      Money.new(:amount => "100;00").should_not be_valid
      Money.new(:amount => "238,3423,42..99").should_not be_valid
      Money.new(:amount => "$-233").should_not be_valid
    end
  end
  describe "custom messages" do
    class Message < TestActiveRecord
      attr_accessor :first_name
      validates_formatting_of :first_name, :using => :alpha, :message => "is not a valid first name"
    end
    it "are allowed and can be used in displaying error messages" do
      message = Message.new(:first_name => "invalid-first-name-123")
      message.should_not be_valid
      message.errors.keys.class.should eq Array
      message.errors.full_messages.first.should =~ /is not a valid first name/
    end
  end

  describe "default error messages" do
    class Problems < TestActiveRecord
      attr_accessor :name
      validates_formatting_of :name, :using => :alpha
    end
    it "set a default error" do
      problems = Problems.new(:name => "sdfs12312dfsd")
      problems.should_not be_valid
      problems.errors.full_messages.first.should =~ /letters/i
      email = Email.new(:email => "not.an.email.address")
      email.should_not be_valid
      email.errors.full_messages.first.should =~ /email/i
    end
  end

=begin
  # Currently, SuperModel's validations do not detect allow_blank or allow_nil
  # This functionality has been tested separately in an empty Rails app with perfect
  # results.

  describe "nil and blank values" do
    class People < TestActiveRecord
      validates_formatting_of :last_name, :using => :alpha, :allow_blank => true
    end
    it "are allowed" do
      p = People.new(:last_name => "something")
      p.should be_valid
      p.save!
      p.reload
      p.last_name = ""
      p.should_not be_valid
    end
  end
=end

end
