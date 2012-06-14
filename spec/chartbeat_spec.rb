require 'spec_helper'

describe Chartbeat::API do
  subject { Chartbeat::API.new apikey: 'fakehost.com', host: 'fake_key' }

  def fake_url(m)
    FakeWeb.register_uri(:get, %r|http://api\.chartbeat\.com/#{m}/|, body: File.read("./spec/fixtures/#{m}.json"))
  end

  describe 'histogram' do
    before(:all) { fake_url('live/histogram') }

    it { expect { histogram }.should_not raise_error(NoMethodError) }

    let(:response) { subject.histogram keys: 'R,W,I', breaks: '1,5,10' }
    it { response["I"]["type"].should == "numeric" }
  end

  describe 'pathsummary' do
    before(:all) { fake_url('live/pathsummary') }

    it { expect { pathsummary }.should_not raise_error(NoMethodError) }

    let(:response) { subject.pathsummary keys: 'I,n,r', types: 'n,n,s' }
    it { response["/signup"]["I"]["type"].should == "numeric" }
  end

  describe 'quickstats' do
    before(:all) { fake_url('live/quickstats') }

    it { expect { quickstats }.should_not raise_error(NoMethodError) }

    let(:response) { subject.quickstats }
    it { response["direct"].should == 129 }
  end

 describe 'recent' do
   before(:all) { fake_url('live/recent') }

    it { expect { recent }.should_not raise_error(NoMethodError) }

    let(:response) { subject.recent }
    it { response.first["w"].should == "undefined" }
  end

  describe 'referrers' do
    before(:all) { fake_url('live/referrers') }

    it { expect { referrers }.should_not raise_error(NoMethodError) }

    let(:response) { subject.referrers }
    it { response["referrers"][""].should == 34 }
  end

  describe 'summary' do
    before(:all) { fake_url('live/summary') }

    it { expect { summary }.should_not raise_error(NoMethodError) }

    let(:response) { subject.summary keys: 'I,n,r' }
    it { response["I"]["type"].should == "numeric" }
  end

  describe 'toppages' do
    before(:all) { fake_url('live/toppages') }

    it { expect { toppages }.should_not raise_error(NoMethodError) }

    let(:response) { subject.toppages }
    it { response.first["visitors"].should == 14 }
  end

  describe 'geo' do
    before(:all) { fake_url('live/geo') }

    it { expect { geo }.should_not raise_error(NoMethodError) }

    let(:response) { subject.geo }
    it { response["regions"]["27"].should == 1 }
  end

  describe 'alerts' do
    before(:all) { fake_url('historical/dashapi/alerts') }

    it { expect { alerts }.should_not raise_error(NoMethodError) }

    let(:response) { subject.alerts since: 1233739200 }
    it { response.first["url"].should == "chartbeat.com" }
  end

  describe 'snapshots' do
    before(:all) { fake_url('historical/dashapi/snapshots') }

    it { expect { snapshots }.should_not raise_error(NoMethodError) }

    let(:response) { subject.snapshots api: 'pages', timestamp: 1233739200 }
    it { response["historical"].should == true }
  end

  describe 'stats' do
    before(:all) { fake_url('historical/dashapi/stats') }

    it { expect { stats }.should_not raise_error(NoMethodError) }

    let(:response) { subject.stats }
    it { response["idle_avg"].should == 4.33 }
  end

  describe 'data_series' do
    before(:all) { fake_url('historical/dashapi/data_series') }

    it { expect { data_series }.should_not raise_error(NoMethodError) }

    let(:response) { subject.data_series type: 'summary', days: 1, minutes: 20 }
    it { response["people"].first.should == 43 }
  end

  describe 'day_data_series' do
    before(:all) { fake_url('historical/dashapi/day_data_series') }

    it { expect { day_data_series }.should_not raise_error(NoMethodError) }

    let(:response) { subject.day_data_series type: 'paths', timestamp: 1233739200 }
    it { response["dates"].first.should == 1275932700 }
  end
end
