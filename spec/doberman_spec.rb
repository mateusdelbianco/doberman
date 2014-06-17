require 'spec_helper'

describe Doberman::WatchDog do
  describe "#initialize" do
    it "should set a custom error_message" do
      w = Doberman::WatchDog.new(:error_message => "custom_error_message")
      expect(w.error_message).to eq("custom_error_message")
    end

    it "should set a custom timeout" do
      w = Doberman::WatchDog.new(:timeout => 1234)
      expect(w.timeout).to eq(1234)
    end
  end

  describe "using the watchdog" do
    context "protection against bad users" do
      before :each do
        @watchdog = Doberman::WatchDog.new
      end

      after :each do
        @watchdog.stop
      end

      it "should not raise error if stop is used without start" do
        expect { @watchdog.stop }.not_to raise_error
      end

      it "should not raise error if stop is used after start" do
        @watchdog.start
        expect { @watchdog.stop }.not_to raise_error
      end

      it "should not raise error if start is used twice" do
        @watchdog.start
        expect { @watchdog.start }.not_to raise_error
      end

      it "should not raise error if start is used after stop" do
        @watchdog.start
        @watchdog.stop
        expect { @watchdog.start }.not_to raise_error
      end

      it "should not raise error if ping is used without start" do
        expect { @watchdog.ping }.not_to raise_error
      end

      it "should start watchdog if ping is used without start" do
        expect(@watchdog).to receive(:start)
        @watchdog.ping
      end

      it "should not raise error if ping is used after start" do
        @watchdog.start
        expect { @watchdog.ping }.not_to raise_error
      end
    end

    context "using the watchdog" do
      it "should raise error if timeout is reached" do
        w = Doberman::WatchDog.new(:timeout => 0.1)
        w.start
        w.ping
        expect { sleep 0.4 }.to raise_error
        w.stop
      end

      it "should not raise error if timeout is not reached" do
        w = Doberman::WatchDog.new(:timeout => 1)
        w.start
        w.ping
        expect { sleep 0.4 }.not_to raise_error
        w.stop
      end

      it "should not raise error if timeout is reached but ping is used" do
        w = Doberman::WatchDog.new(:timeout => 0.5)
        w.start
        w.ping
        expect do
          3.times do
            sleep 0.3
            w.ping
          end
        end.not_to raise_error
        w.stop
      end

      it "should not raise error if timeout is reached after stop" do
        w = Doberman::WatchDog.new(:timeout => 0.1)
        w.start
        w.ping
        w.stop
        expect { sleep 0.4 }.not_to raise_error
      end
    end
  end
end
