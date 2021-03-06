require 'spec_helper'

describe 'JTAG Driver Specification' do

  before :all do
    Origen.environment.temporary = 'j750.rb'
  end

  it 'JTAG Configuration can be declared at DUT creation' do 
    load_target('debug_RL4')

    # verify specified configuration
    dut.tclk_format.should == :rl
    dut.tclk_multiple.should == 4
    dut.tdo_strobe.should == :tclk_high
    dut.tdo_store_cycle.should == 3
    dut.init_state.should == :unknown
  end

  it 'JTAG Configuration can be changed post-DUT-creation' do
    load_target('debug_RH1')
    dut.tclk_format.should == :rh                 # check initial settings
    dut.update_jtag_config(:tclk_format, :rl)     # update configuration   
    dut.tclk_format.should == :rl                 # verify updates
  end

  it "Trying to update invalid config type results in error" do
    load_target('debug_RL1')
    lambda { dut.update_jtag_config(:invalid_config, 22) }.should raise_error
  end

  it 'JTAG TCLK format is invalid' do
    load_target('debug_RL1')
    dut.update_jtag_config(:tclk_format, :nrz)
    lambda { dut.jtag.tclk_cycle }.should raise_error
  end

  it 'JTAG State can be queried' do
    load_target('debug_RH1')
    dut.startup
    dut.jtag.idle
    dut.jtag.state_str.should == "Run-Test/Idle"

    dut.jtag.pause_dr do
      dut.jtag.state_str.should == "Pause-DR"
    end
  end


end
