    MEMORY  
    #(
        .data_width(cache_width ),
        .address_width(line_width),
        .depth(cache_depth)
        )
    cache_memory
    (
        .CLK(CLK),
        .PORTA_WREN(cache_porta_wren)           ,
        .PORTA_RADDR(cache_porta_raddr)         ,
        .PORTA_WADDR(cache_porta_raddr)         ,
        .PORTA_DATA_IN(cache_porta_data_in)     ,
        .PORTA_DATA_OUT(cache_porta_data_out)

        );
    MEMORY  
    #(
        .data_width(tag_width   )               ,
        .address_width(line_width)              ,
        .depth(cache_depth)
        )
    tag_memory
    (
        .CLK(CLK)                               ,
        .PORTA_WREN(tag_porta_wren)             ,
        .PORTA_RADDR(tag_porta_raddr)           ,
        .PORTA_WADDR(cache_porta_raddr)           ,
        .PORTA_DATA_IN(tag_porta_data_in)       ,
        .PORTA_DATA_OUT(tag_porta_data_out)

        );
    STATE_MEMORY
    #(
        .depth(cache_depth),
        .address_width(line_width)

    )
    state_memory_inst
    (
        .CLK(CLK)               ,
        .RST(RST)               ,
        .FLUSH(flush_d2 & ADDR_VALID)        ,
        .WREN(state_wren)       ,
        .WADDR (cache_porta_raddr)    ,
        .RADDR(state_raddr)     ,
        .STATE(state) ,
        .DATA(1'b1)  
     );
