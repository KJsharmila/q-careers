require 'rails_helper'

RSpec.describe Candidate, :type => :model do

  let(:candidate) {FactoryGirl.create(:candidate)}
  let(:fresher1) {FactoryGirl.create(:fresher, email: "email1@domain.com")}

  context "Factory" do
    it "should validate all the candidate factories" do
      expect(FactoryGirl.build(:candidate).valid?).to be true
    end
  end

  context "Associations" do
    it { should have_many(:career_interests) }
    it { should have_many(:events) }
  end

  context "Validations" do
    it { should validate_presence_of :name }
    it { should allow_value('Krishnaprasad Varma').for(:name )}
    it { should_not allow_value('KP').for(:name )}
    it { should_not allow_value("x"*257).for(:name )}

    it { should validate_presence_of :email }
    it { should allow_value('something@domain.com').for(:email )}
    it { should_not allow_value('something domain.com').for(:email )}
    it { should_not allow_value('something.domain.com').for(:email )}
    it { should_not allow_value('ED').for(:email )}
    it { should_not allow_value("x"*257+"@domain.com").for(:email )}

    # FIXME - The phone validation should be in place
    # Put a regular expression to allow the following formats
    # A Combination of any numbers, spaces, hyphes(-) and min length of 6 and max length of 12 excluding spaces
    it { should validate_presence_of :phone }
    it { should allow_value('9880123123').for(:phone )}
    it { should_not allow_value('9880 123 123').for(:phone )}
    it { should_not allow_value('9880-123-123').for(:phone )}
    it { should_not allow_value('12343').for(:phone )}
    it { should_not allow_value('1234 1234 1234 1234').for(:phone )}

    # FIXME - Check minimum length (poodle validation sets it as 3)
    # And Maximum as 128
    it { should validate_presence_of :current_city }
    it { should allow_value('Mysore').for(:current_city )}
    it { should allow_value('New-Delhi').for(:current_city )}
    it { should allow_value('New Delhi').for(:current_city )}
    it { should_not allow_value('CC').for(:current_city )}
    it { should_not allow_value("x"*129).for(:current_city )}

    # FIXME - Check minimum length (poodle validation sets it as 3)
    # And Maximum as 128
    it { should validate_presence_of :native_city }
    it { should allow_value('Mysore').for(:native_city )}
    it { should allow_value('New-Delhi').for(:native_city )}
    it { should allow_value('New Delhi').for(:native_city )}
    it { should_not allow_value('CC').for(:native_city )}
    it { should_not allow_value("x"*129).for(:native_city )}

    # FIXME - Check min length and max length
  end

  context "Class Methods" do
    it "fetch" do
      fresher1
      expect(Fresher.fetch({email: "email1@domain.com"}).persisted?).to eq(true)
      expect(Fresher.fetch({email: "email1@domain.com"}).id).to eq(fresher1.id)
      expect(Fresher.fetch({email: "email2@domain.com", name: "Some Name"}).persisted?).to be_falsy
      expect(Fresher.fetch({email: "email2@domain.com", name: "Some Name"}).email).to eq("email2@domain.com")
      expect(Fresher.fetch({email: "email2@domain.com", name: "Some Name"}).name).to eq("Some Name")
    end
  end

  context "Instance Methods" do
    it "namify" do
      fresher = FactoryGirl.build(:fresher, name: "Ravi Shankar")
      expect(fresher.namify).to eq("RS")

      fresher = FactoryGirl.build(:fresher, name: "Krishnaprasad")
      expect(fresher.namify).to eq("K")

      fresher = FactoryGirl.build(:fresher, name: "Mohandas Karam Chand Gandhi")
      expect(fresher.namify).to eq("MK")
    end

    it "display_current_address" do
      expect(FactoryGirl.build(:fresher, current_city: "Mysore", current_state: "Karnataka", current_country: "India").display_current_address).to eq("Mysore, Karnataka, India")
      expect(FactoryGirl.build(:fresher, current_city: "Mysore", current_state: nil, current_country: "India").display_current_address).to eq("Mysore, India")
      expect(FactoryGirl.build(:fresher, current_city: nil, current_state: "Karnataka", current_country: "India").display_current_address).to eq("Karnataka, India")
      expect(FactoryGirl.build(:fresher, current_city: nil, current_state: nil, current_country: "India").display_current_address).to eq("India")
    end

    it "display_native_address" do
      expect(FactoryGirl.build(:fresher, native_city: "Mysore", native_state: "Karnataka", native_country: "India").display_native_address).to eq("Mysore, Karnataka, India")
      expect(FactoryGirl.build(:fresher, native_city: "Mysore", native_state: nil, native_country: "India").display_native_address).to eq("Mysore, India")
      expect(FactoryGirl.build(:fresher, native_city: nil, native_state: "Karnataka", native_country: "India").display_native_address).to eq("Karnataka, India")
      expect(FactoryGirl.build(:fresher, native_city: nil, native_state: nil, native_country: "India").display_native_address).to eq("India")
    end
  end

end