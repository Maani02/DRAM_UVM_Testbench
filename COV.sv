class dram_cov  extends uvm_subscriber #(dram_seq_item);
`uvm_component_utils(dram_cov)

dram_seq_item pkt;
real cov;

covergroup CovPort;
  option.per_instance = 1;
  option.auto_bin_max = 4;
  address : coverpoint pkt.add {
    bins low    = {[0:20]};
    bins med    = {[21:42]};
    bins high   = {[43:63]};
  }
  data : coverpoint  pkt.data_in {
    bins low    = {[0:50]};
    bins med    = {[51:150]};
    bins high   = {[151:255]};
  }
  wr: coverpoint pkt.wr{
    bins b1[]={0,1};}
  en: coverpoint pkt.en{
    bins b2[]={0,1};}
endgroup

function new (string name = "dram_cov", uvm_component parent);
  super.new (name, parent);
  CovPort = new();
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction
	  
  function void write (dram_seq_item t);
	`uvm_info("SEQ","SEQUENCE TRANSACTIONS",UVM_NONE);
	pkt = t;
	CovPort.sample();
    $display("data=%d add=%d en=%d wr=%d coverage %%=%0.2f", t.data_in, t.add, t.en, t.wr, CovPort.get_inst_coverage());
endfunction
  
function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    cov = CovPort.get_coverage();
endfunction

function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), $sformatf("Coverage is %f", cov), UVM_MEDIUM)
 endfunction

endclass