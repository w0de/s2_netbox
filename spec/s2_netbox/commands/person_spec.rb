require 'spec_helper'

describe S2Netbox::Commands::Person do
  describe 'add' do
    context 'when multiple access_levels are specified' do
      context 'when a session_id is not specified' do
        before :each do
          configure

          stub_request(:post, "https://test-s2.some.net/goforms/nbapi").
              with(:body => "APIcommand=<NETBOX-API><COMMAND name='AddPerson' num='1'><PARAMS><PERSONID>8a806ed6-0246-49d0-b7a7-ab6402da01e3</PERSONID><FIRSTNAME>Michael</FIRSTNAME><LASTNAME>Shimmins</LASTNAME><EXPDATE></EXPDATE><ACTDATE>10/10/2016</ACTDATE><UDF1>Teamsquare</UDF1><ACCESSLEVELS><ACCESSLEVEL>MEL2_Staff</ACCESSLEVEL><ACCESSLEVEL>MEL2_IT</ACCESSLEVEL></ACCESSLEVELS></PARAMS></COMMAND></NETBOX-API>").
              to_return(:status => 200, :body => "<NETBOX><RESPONSE command='AddPerson' num=\"1\"><CODE>SUCCESS</CODE><DETAILS><PERSONID>8a806ed6-0246-49d0-b7a7-ab6402da01e3</PERSONID></DETAILS></RESPONSE></NETBOX>", :headers => {})

          @result = S2Netbox::Commands::Person.add({
                                                       :person_id => '8a806ed6-0246-49d0-b7a7-ab6402da01e3',
                                                       :first_name => 'Michael',
                                                       :last_name => 'Shimmins',
                                                       :exp_date => nil,
                                                       :act_date => '10/10/2016'
                                                   }, %w(MEL2_Staff MEL2_IT), 'Teamsquare')
        end

        it 'should be a S2Netbox::ApiResponse' do
          expect(@result).to be_a(S2Netbox::ApiResponse)
        end

        it 'should return the correct details' do
          expect(@result.details['PERSONID']).to eq('8a806ed6-0246-49d0-b7a7-ab6402da01e3')
        end
      end

      context 'when a session_id is specified' do
        before :each do
          configure

          stub_request(:post, "https://test-s2.some.net/goforms/nbapi").
              with(:body => "APIcommand=<NETBOX-API sessionid='session_id'><COMMAND name='AddPerson' num='1'><PARAMS><PERSONID>8a806ed6-0246-49d0-b7a7-ab6402da01e3</PERSONID><FIRSTNAME>Michael</FIRSTNAME><LASTNAME>Shimmins</LASTNAME><EXPDATE></EXPDATE><ACTDATE>10/10/2016</ACTDATE><UDF1>Teamsquare</UDF1><ACCESSLEVELS><ACCESSLEVEL>MEL2_Staff</ACCESSLEVEL><ACCESSLEVEL>MEL2_IT</ACCESSLEVEL></ACCESSLEVELS></PARAMS></COMMAND></NETBOX-API>").
              to_return(:status => 200, :body => "<NETBOX><RESPONSE command='AddPerson' num=\"1\"><CODE>SUCCESS</CODE><DETAILS><PERSONID>8a806ed6-0246-49d0-b7a7-ab6402da01e3</PERSONID></DETAILS></RESPONSE></NETBOX>", :headers => {})

          @result = S2Netbox::Commands::Person.add({
                                                       :person_id => '8a806ed6-0246-49d0-b7a7-ab6402da01e3',
                                                       :first_name => 'Michael',
                                                       :last_name => 'Shimmins',
                                                       :exp_date => nil,
                                                       :act_date => '10/10/2016'
                                                   }, %w(MEL2_Staff MEL2_IT), 'Teamsquare', 'session_id')
        end

        it 'should be a S2Netbox::ApiResponse' do
          expect(@result).to be_a(S2Netbox::ApiResponse)
        end

        it 'should return the correct details' do
          expect(@result.details['PERSONID']).to eq('8a806ed6-0246-49d0-b7a7-ab6402da01e3')
        end
      end
    end

    context 'when a single access level is specified' do
      context 'when a session_id is specified' do
        before :each do
          configure

          stub_request(:post, "https://test-s2.some.net/goforms/nbapi").
              with(:body => "APIcommand=<NETBOX-API sessionid='session_id'><COMMAND name='AddPerson' num='1'><PARAMS><PERSONID>8a806ed6-0246-49d0-b7a7-ab6402da01e3</PERSONID><FIRSTNAME>Michael</FIRSTNAME><LASTNAME>Shimmins</LASTNAME><EXPDATE></EXPDATE><ACTDATE>10/10/2016</ACTDATE><UDF1>Teamsquare</UDF1><ACCESSLEVELS><ACCESSLEVEL>MEL2_Staff</ACCESSLEVEL></ACCESSLEVELS></PARAMS></COMMAND></NETBOX-API>").
              to_return(:status => 200, :body => "<NETBOX><RESPONSE command='AddPerson' num=\"1\"><CODE>SUCCESS</CODE><DETAILS><PERSONID>8a806ed6-0246-49d0-b7a7-ab6402da01e3</PERSONID></DETAILS></RESPONSE></NETBOX>", :headers => {})

          @result = S2Netbox::Commands::Person.add({
                                                       :person_id => '8a806ed6-0246-49d0-b7a7-ab6402da01e3',
                                                       :first_name => 'Michael',
                                                       :last_name => 'Shimmins',
                                                       :exp_date => nil,
                                                       :act_date => '10/10/2016'
                                                   }, 'MEL2_Staff', 'Teamsquare', 'session_id')
        end

        it 'should be a S2Netbox::ApiResponse' do
          expect(@result).to be_a(S2Netbox::ApiResponse)
        end

        it 'should return the correct details' do
          expect(@result.details['PERSONID']).to eq('8a806ed6-0246-49d0-b7a7-ab6402da01e3')
        end
      end

      context 'when a session_id is not specified' do
        before :each do
          configure

          stub_request(:post, "https://test-s2.some.net/goforms/nbapi").
              with(:body => "APIcommand=<NETBOX-API><COMMAND name='AddPerson' num='1'><PARAMS><PERSONID>8a806ed6-0246-49d0-b7a7-ab6402da01e3</PERSONID><FIRSTNAME>Michael</FIRSTNAME><LASTNAME>Shimmins</LASTNAME><EXPDATE></EXPDATE><ACTDATE>10/10/2016</ACTDATE><UDF1>Teamsquare</UDF1><ACCESSLEVELS><ACCESSLEVEL>MEL2_Staff</ACCESSLEVEL></ACCESSLEVELS></PARAMS></COMMAND></NETBOX-API>").
              to_return(:status => 200, :body => "<NETBOX><RESPONSE command='AddPerson' num=\"1\"><CODE>SUCCESS</CODE><DETAILS><PERSONID>8a806ed6-0246-49d0-b7a7-ab6402da01e3</PERSONID></DETAILS></RESPONSE></NETBOX>", :headers => {})

          @result = S2Netbox::Commands::Person.add({
                                                       :person_id => '8a806ed6-0246-49d0-b7a7-ab6402da01e3',
                                                       :first_name => 'Michael',
                                                       :last_name => 'Shimmins',
                                                       :exp_date => nil,
                                                       :act_date => '10/10/2016'
                                                   }, 'MEL2_Staff', 'Teamsquare')
        end

        it 'should be a S2Netbox::ApiResponse' do
          expect(@result).to be_a(S2Netbox::ApiResponse)
        end

        it 'should return the correct details' do
          expect(@result.details['PERSONID']).to eq('8a806ed6-0246-49d0-b7a7-ab6402da01e3')
        end
      end
    end
  end

  describe 'modify' do
    before :each do
      configure

      stub_request(:post, "https://test-s2.some.net/goforms/nbapi").
          with(:body => "APIcommand=<NETBOX-API><COMMAND name='ModifyPerson' num='1'><PARAMS><FIRSTNAME>Michael</FIRSTNAME><LASTNAME>Shimmins</LASTNAME><EXPDATE></EXPDATE><ACTDATE>10/10/2016</ACTDATE><UDF1>Teamsquare</UDF1><ACCESSLEVELS><ACCESSLEVEL>MEL2_Staff</ACCESSLEVEL><ACCESSLEVEL>MEL2_IT</ACCESSLEVEL></ACCESSLEVELS><PERSONID>8a806ed6-0246-49d0-b7a7-ab6402da01e3</PERSONID></PARAMS></COMMAND></NETBOX-API>").
          to_return(:status => 200, :body => "<NETBOX><RESPONSE command='ModifyPerson' num=\"1\"><CODE>SUCCESS</CODE><DETAILS><PERSONID>8a806ed6-0246-49d0-b7a7-ab6402da01e3</PERSONID></DETAILS></RESPONSE></NETBOX>", :headers => {})

      @result = S2Netbox::Commands::Person.modify('8a806ed6-0246-49d0-b7a7-ab6402da01e3', {
          :first_name => 'Michael',
          :last_name => 'Shimmins',
          :exp_date => nil,
          :act_date => '10/10/2016'
      }, %w(MEL2_Staff MEL2_IT), 'Teamsquare')
    end

    it 'should be a S2Netbox::ApiResponse' do
      expect(@result).to be_a(S2Netbox::ApiResponse)
    end

    it 'should return the correct details' do
      expect(@result.details['PERSONID']).to eq('8a806ed6-0246-49d0-b7a7-ab6402da01e3')
    end
  end
end