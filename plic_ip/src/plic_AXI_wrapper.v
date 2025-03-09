`timescale 1 ns / 1 ps
module PLIC_AXI_wrapper
	#(

		parameter integer C_S_AXI_DATA_WIDTH	= 64,
		parameter integer C_S_AXI_ADDR_WIDTH	= 28
	)(
  input         auto_int_in_0,
  input         auto_int_in_1,
  input         auto_int_in_2,
  input         auto_int_in_3,
  input         auto_int_in_4,
  input         auto_int_in_5,
  input         auto_int_in_6,
  input         auto_int_in_7,
  input         auto_int_in_8,
  input         auto_int_in_9,
  input         auto_int_in_10,
  input         auto_int_in_11,
  input         auto_int_in_12,
  input         auto_int_in_13,
  input         auto_int_in_14,
  input         auto_int_in_15,
  input         auto_int_in_16,
  input         auto_int_in_17,
  input         auto_int_in_18,
  input         auto_int_in_19,
  input         auto_int_in_20,
  input         auto_int_in_21,
  input         auto_int_in_22,
  input         auto_int_in_23,
  input         auto_int_in_24,
  input         auto_int_in_25,
  input         auto_int_in_26,
  input         auto_int_in_27,
  input         auto_int_in_28,
  input         auto_int_in_29,
  input         auto_int_in_30,
  input         auto_int_in_31,
  output        auto_int_out_1_0,
  output        auto_int_out_0_0,
  
  input wire  S_AXI_ACLK,
  input wire  S_AXI_ARESETN,
  input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
  input wire [2 : 0] S_AXI_AWPROT,
  input wire  S_AXI_AWVALID,
  output reg  S_AXI_AWREADY,
  input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
  input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
  input wire  S_AXI_WVALID,
  output reg  S_AXI_WREADY,
  output reg [1 : 0] S_AXI_BRESP,
  output reg  S_AXI_BVALID,
  input wire  S_AXI_BREADY,
  input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
  input wire [2 : 0] S_AXI_ARPROT,
  input wire  S_AXI_ARVALID,
  output reg  S_AXI_ARREADY,
  output reg [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
  output reg [1 : 0] S_AXI_RRESP,
  output reg  S_AXI_RVALID,
  input wire  S_AXI_RREADY
);
localparam idle = 0;
localparam w = 1;
localparam wpl = 2;
localparam wplr = 3;
localparam bres = 4;
localparam r = 5;
localparam rd = 6;
localparam idl = 7;

reg [2:0] current_state;


reg [C_S_AXI_ADDR_WIDTH-1:0] write_address;
reg [C_S_AXI_ADDR_WIDTH-1:0] read_data;
reg [C_S_AXI_ADDR_WIDTH-1:0] write_data;
 
  wire        auto_in_a_ready;
  reg         auto_in_a_valid;
  reg  [2:0]  auto_in_a_bits_opcode;
  reg  [2:0]  auto_in_a_bits_param;
  reg  [1:0]  auto_in_a_bits_size;
  reg  [8:0]  auto_in_a_bits_source;
  reg  [27:0] auto_in_a_bits_address;
  reg  [7:0]  auto_in_a_bits_mask;
  reg  [63:0] auto_in_a_bits_data;
  reg         auto_in_a_bits_corrupt;
  reg         auto_in_d_ready;
  wire        auto_in_d_valid;
  wire [2:0]  auto_in_d_bits_opcode;
  wire [1:0]  auto_in_d_bits_size;
  wire [8:0]  auto_in_d_bits_source;
  wire [63:0] auto_in_d_bits_data;

always@(posedge S_AXI_ACLK) begin
    if(~S_AXI_ARESETN) begin
        current_state <= idle;
        S_AXI_AWREADY<=0;
        S_AXI_ARREADY <=0;
        S_AXI_WREADY<= 0;
        S_AXI_BVALID <=0;
        S_AXI_RVALID <=0;
        S_AXI_RDATA <=0;
        S_AXI_BRESP  <=0;
        S_AXI_RRESP  <=0;
        auto_in_a_bits_size<=3; 
        auto_in_a_valid <=0;
        auto_in_a_bits_opcode <=0;
        auto_in_a_bits_param <=0;
        auto_in_a_bits_source <=0;
        auto_in_a_bits_data <= 0;
        auto_in_a_bits_mask <=0;
        auto_in_a_bits_address <=0;
        auto_in_a_bits_corrupt <=0;
        auto_in_d_ready <=0;      
    end
    else begin
    case(current_state)
        idle: begin
               if(S_AXI_AWVALID) begin
                    S_AXI_AWREADY<= 1;
                    auto_in_a_bits_address <= S_AXI_AWADDR;             
                    current_state<= w;
                end
                if(S_AXI_ARVALID) begin
                   S_AXI_ARREADY <=1;
                    current_state <= r;
                    auto_in_a_bits_address <= S_AXI_ARADDR;
                    auto_in_a_valid <= 1;
                    auto_in_a_bits_opcode <= 4;
                end

        end
        r: begin
               if(S_AXI_ARVALID & S_AXI_ARREADY) begin
                    S_AXI_ARREADY <=0;
               end
               if(auto_in_a_valid & auto_in_a_ready) begin
                    auto_in_a_valid <=0;
               end
               if(auto_in_d_valid) begin
                  auto_in_d_ready<=1;
                  S_AXI_RDATA <= auto_in_d_bits_data;
                  S_AXI_RVALID <=1;
                  current_state <= rd;
               end
        end
        rd: begin
            if(auto_in_d_valid & auto_in_d_ready) begin
                auto_in_d_ready <=0;
            end
            if(S_AXI_RVALID & S_AXI_RREADY) begin
                S_AXI_RVALID<=0;
                current_state<= idle;
            end
        end
        w: begin
              if(S_AXI_AWVALID &  S_AXI_AWREADY) begin
                  S_AXI_AWREADY <=0;
              end
               if(S_AXI_WVALID) begin
                  auto_in_a_bits_data <= S_AXI_WDATA;
                  current_state <= wpl;
                  auto_in_a_valid<= 1;
                  S_AXI_WREADY <=1;
                  auto_in_a_bits_opcode <= 0;
                  auto_in_a_bits_mask <= S_AXI_WSTRB;
               end
        end
        wpl: begin
            if(S_AXI_WVALID & S_AXI_WREADY) begin
                S_AXI_WREADY<=0;
            end
            if(auto_in_a_valid & auto_in_a_ready) begin
                auto_in_a_valid <= 0;
            end
            if(auto_in_d_valid)begin
               auto_in_d_ready <=1;
               S_AXI_BVALID<=1;
               current_state <= wplr;
           end
        end
        wplr: begin
             if(auto_in_d_valid & auto_in_d_ready) begin
                    auto_in_d_ready <= 0;
             end
             if(S_AXI_BVALID & S_AXI_BREADY) begin
                S_AXI_BVALID <=0;
                current_state <= idle;
            end 
        end
       
        
    endcase
    end
  end


     TLPLIC plic_inst(
       S_AXI_ACLK,
       ~S_AXI_ARESETN,
       auto_int_in_0,
       auto_int_in_1,
       auto_int_in_2,
       auto_int_in_3,
       auto_int_in_4,
       auto_int_in_5,
       auto_int_in_6,
       auto_int_in_7,
       auto_int_in_8,
       auto_int_in_9,
       auto_int_in_10,
       auto_int_in_11,
       auto_int_in_12,
       auto_int_in_13,
       auto_int_in_14,
       auto_int_in_15,
       auto_int_in_16,
       auto_int_in_17,
       auto_int_in_18,
       auto_int_in_19,
       auto_int_in_20,
       auto_int_in_21,
       auto_int_in_22,
       auto_int_in_23,
       auto_int_in_24,
       auto_int_in_25,
       auto_int_in_26,
       auto_int_in_27,
       auto_int_in_28,
       auto_int_in_29,
       auto_int_in_30,
       auto_int_in_31,
       auto_int_out_1_0,
       auto_int_out_0_0,
       auto_in_a_ready,
       auto_in_a_valid,
       auto_in_a_bits_opcode,
       auto_in_a_bits_param,
       auto_in_a_bits_size,
       auto_in_a_bits_source,
       auto_in_a_bits_address,
       auto_in_a_bits_mask,
       auto_in_a_bits_data,
       auto_in_a_bits_corrupt,
       auto_in_d_ready,
       auto_in_d_valid,
       auto_in_d_bits_opcode,
       auto_in_d_bits_size,
       auto_in_d_bits_source,
       auto_in_d_bits_data
    );
endmodule
