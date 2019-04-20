`timescale 1 ps  /  1 ps
module Icache
    #(
        parameter data_width    = 32                                            ,
        parameter address_width = 32                                            ,
        parameter block_size    = 32                                             ,
        parameter cache_depth   = 512                                           ,
        parameter addr_init_val = 32'h8000_0000                                 ,
        localparam line_width   = $clog2(cache_depth)                           ,
        localparam offset_width = $clog2(data_width*block_size  /8)               ,
        localparam tag_width    = address_width - line_width -  offset_width    ,
        localparam cache_width  = block_size*data_width

        )
    (
        input                    CLK                             ,
        input                    RST                             ,
        input                    FLUSH                           ,
        input  [address_width-1:0] ADDR                              ,
        input  [address_width-1:0] ADDR_vir                              ,
        input                    ADDR_VALID                      ,
        output reg [data_width-1:0]  DATA                            ,
        output     reg           CACHE_READY                     ,
        output                   ADDR_TO_L2_VALID                ,
        output [address_width - offset_width-1:0]   ADDR_TO_L2                      ,
        input  [cache_width-1:0] DATA_FROM_L2                    ,
        input                    DATA_FROM_L2_VALID              ,
        output [address_width-1:0] ADDR_OUT                        ,
        output [address_width-1:0] CURR_ADDR  ,
        input PAGE_FAULT,
        input ACCESS_FAULT,
        output PAGE_FAULT_OUT,
        output ACCESS_FAULT_OUT  ,
        input DCACHE_flusing                    



    );
    reg  [address_width-1:0] addr_d1             ;
    reg  [address_width-1:0] addr_d2             ;
    reg  [address_width-1:0] addr_d3             ;
    reg  [address_width-1:0] addr_d4             ;    
    
    reg page_fault_d2;
    reg page_fault_d3;
    reg page_fault_d4;

    reg access_fault_d2;
    reg access_fault_d3;
    reg access_fault_d4;

    reg  [address_width-1:0] addr_d1_vir             ;
    reg  [address_width-1:0] addr_d2_vir             ;
    reg  [address_width-1:0] addr_d3_vir             ;
    reg  [address_width-1:0] addr_d4_vir             ;
    reg                     flag                ;
    reg                     addr_to_l2_valid    ;
    reg [address_width- offset_width -1:0] addr_to_l2          ;
    reg                     cache_porta_wren    ;
    reg  [line_width-1:0]   cache_porta_waddr   ;
    wire  [line_width-1:0]   cache_porta_raddr   ;
    reg  [cache_width-1:0]  cache_porta_data_in ;
    wire  [cache_width-1:0]  cache_porta_data_out ;
    reg                     flush_d1            ;
    reg                     flush_d2           ;
    reg                     flush_d3            ;
    reg                     flush_d4            ;
    reg                     tag_porta_wren      ;
    reg  [line_width-1:0]   tag_porta_waddr     ;
    wire  [line_width-1:0]   tag_porta_raddr     ;
    reg  [tag_width-1:0]    tag_porta_data_in   ;
    wire  [tag_width-1:0]    tag_porta_data_out   ;
    wire [tag_width-1:0]    tag_addr            ;

    reg  [line_width-1:0]   state_waddr         ;
    wire  [line_width-1:0]  state_rdata         ;
    wire  [line_width-1:0]  state_raddr         ;
    reg                     state_wren          ;
    wire                    state               ;
        wire                    cache_ready;
    wire       [data_width-1:0]            data ;

    `include "i_cache_inst.vh"
    always@(*)
    begin
        CACHE_READY = cache_ready;
    end
    always @(posedge CLK) begin
        if (RST) begin
            addr_d1 <=   addr_init_val+12;
            addr_d2 <=   addr_init_val+8;
            addr_d3 <=   addr_init_val+4;      
            addr_d4 <=   addr_init_val;            
            
            addr_d1_vir <=   addr_init_val+12;
            addr_d2_vir <=   addr_init_val+8;
            addr_d3_vir <=   addr_init_val+4;      
            addr_d4_vir <=   addr_init_val; 


            flush_d1 <= 0;
            flush_d2 <= 0;
            flush_d3 <= 0;
            flush_d4 <= 0;

            access_fault_d2<=0;
            access_fault_d3<=0;
            access_fault_d4<=0;

            page_fault_d2 <=0;
            page_fault_d3 <=0;
            page_fault_d4 <=0;

            
        end
        else if (cache_ready & ADDR_VALID) begin
            addr_d1  <= ADDR;
            addr_d2  <= ADDR ;
            addr_d3  <= addr_d2 ;
            addr_d4 <= addr_d3;
            addr_d1_vir  <= ADDR_vir;
            addr_d2_vir  <= ADDR_vir  ;
            addr_d3_vir  <= addr_d2_vir ;
            addr_d4_vir <= addr_d3_vir;
            
        
            flush_d1 <= FLUSH;
            flush_d2 <= flush_d1;
            flush_d3 <= flush_d2;
            flush_d4 <= flush_d3;

            access_fault_d2 <= ACCESS_FAULT;
            access_fault_d3 <= access_fault_d2;
            access_fault_d4 <= access_fault_d3;

            page_fault_d2 <= PAGE_FAULT;
            page_fault_d3 <= page_fault_d2;
            page_fault_d4 <= page_fault_d3;
        end
    
    
    end
    always@(*)
    begin
            DATA    = page_fault_d4?0: data ;
    end

    always@(posedge CLK)
    begin
        if (RST)
        begin
            addr_to_l2_valid  <=0;
            addr_to_l2        <=0;
            flag              <=0;
        end
        else if (~cache_ready & ~state_wren )   //check whether cache ready and make sure flag goes 0 one cycle before data get written
        begin
            if(~addr_to_l2_valid & ~flag & (ADDR_VALID | ~flush_d4) & ~DCACHE_flusing) 
            begin
                addr_to_l2_valid    <= 1        ;
                addr_to_l2          <= addr_d4[address_width  -1 : offset_width] ;
                flag                <= 1        ;
            end
            else if(DATA_FROM_L2_VALID) begin
                addr_to_l2_valid    <= 0        ;
                flag<=0;
            end
            else begin
                addr_to_l2_valid    <= 0        ;
            end

        end

        if (RST) begin
            state_wren              <= 0        ;
            tag_porta_wren          <= 0        ;
            cache_porta_wren        <= 0        ;
            cache_porta_waddr       <= 0        ;   
            cache_porta_data_in     <= 0        ;
        end
        else if (DATA_FROM_L2_VALID) begin
            cache_porta_wren    <= 1                ;
            cache_porta_data_in <= DATA_FROM_L2     ;
            cache_porta_waddr   <= cache_porta_raddr;
            tag_porta_wren      <= 1                ;
            tag_porta_waddr     <= tag_porta_raddr  ;
            state_wren          <= 1                ; 
            state_waddr         <= state_raddr      ;  
            tag_porta_data_in   <= tag_addr         ;
        end
        else begin
            cache_porta_wren   <=  0            ;
            tag_porta_wren     <=  0            ;
            state_wren         <=  0            ;
        end
    end
    generate
     if (offset_width>2)
        assign data                 = cache_porta_data_out[{addr_d4[offset_width-1:2],2'b0}*8 +:32]       ;
    else begin
        assign data                 = cache_porta_data_out;
    end
    endgenerate
    
    assign cache_porta_raddr    = addr_d4[offset_width+line_width-1:offset_width]              ;
    assign tag_porta_raddr      = cache_porta_raddr                                         ;
    assign state_raddr          = cache_porta_raddr                                         ;
    assign tag_addr             = addr_d4[address_width-1:offset_width+line_width]             ;
    assign cache_ready          =  ((tag_porta_data_out == tag_addr) & state )| page_fault_d4|access_fault_d4  |flush_d3|flush_d2|flush_d1               ;
    assign ADDR_TO_L2_VALID     = addr_to_l2_valid                                          ;
    assign ADDR_TO_L2           = addr_to_l2                                                ;
    assign ADDR_OUT             = addr_d4_vir                                                   ;
    assign CURR_ADDR            = addr_d1                                                   ;
    assign ACCESS_FAULT_OUT     = access_fault_d4;
    assign PAGE_FAULT_OUT       = page_fault_d4;

endmodule



