import uvm_pkg::*;
`include "uvm_macros.svh"
`include "intif.sv"
//`include "DESIGN.sv"
`include "design.sv"
`include "sequence_item.sv"
`include "sequence.sv"
`include  "sequencer.sv"
`include "driver.sv"
`include "COV.sv"
`include "mon1.sv"
`include "mon2.sv"
`include "agent1.sv"
`include "agent2.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "test.sv"

module testbench();
bit clk;

initial
begin
clk=1'b0;
forever #5 clk=~clk;
end
intif inf(clk);
DUT dut(inf);
initial
begin
uvm_config_db#(virtual intif)::set(uvm_root::get(),"*","inf",inf);
run_test("dram_test");
end
endmodule
