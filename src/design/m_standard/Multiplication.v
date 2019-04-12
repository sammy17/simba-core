`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Gajalakshan
// 
// Create Date: 09/09/2017 05:53:25 PM
// Design Name: 
// Module Name: Multiplication
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Multiplication #(
        parameter INPUT_WIDTH   =   32  
    ) (
        input                                       CLK                 ,
        input                                       STALL_MUL           ,
        input                                       START               ,
        input                                       SIGN1               ,
        input                                       SIGN2               ,
        input       [INPUT_WIDTH - 1        :0]     MULTIPLIER          ,
        input       [INPUT_WIDTH - 1        :0]     MULTIPLICAND        ,
        output      [2*INPUT_WIDTH - 1      :0]     PRODUCT_OUT         ,
        output                                      READY  
    );
    
        //0 
        reg     [2*INPUT_WIDTH - 1          :0]     a0,a2,a5,a8,a11,a14,a17,a20,a23,a26,a29;       //0
        reg     [2*INPUT_WIDTH - 1          :0]     a1,a3,a6,a9,a12,a15,a18,a21,a24,a27,a30;       //1
        reg     [2*INPUT_WIDTH - 1          :0]     a4,a7,a10,a13,a16,a19,a22,a25,a28,a31;         //2
        
        //1
        reg     [2*INPUT_WIDTH - 1          :0]     S111,S12,S15,S18;
        reg     [2*INPUT_WIDTH - 1          :0]     S11;
        reg     [2*INPUT_WIDTH - 1          :0]     S13,S14,S16,S17,S19,S110;
        
        reg     [2*INPUT_WIDTH - 1         :0]     C12,C13,C15,C16,C18,C19;
        reg     [2*INPUT_WIDTH - 1         :0]     C11;
        reg     [2*INPUT_WIDTH - 1         :0]     C14,C17,C110;
        
        //2
        reg     [2*INPUT_WIDTH - 1          :0]     S21;
        reg     [2*INPUT_WIDTH - 1          :0]     S22;
        reg     [2*INPUT_WIDTH - 1          :0]     S25;
        reg     [2*INPUT_WIDTH - 1          :0]     S23;
        reg     [2*INPUT_WIDTH - 1          :0]     S27;
        reg     [2*INPUT_WIDTH - 1          :0]     S24,S26;
        
        reg     [2*INPUT_WIDTH - 1          :0]     C22,C26;
        reg     [2*INPUT_WIDTH - 1          :0]     C21;
        reg     [2*INPUT_WIDTH - 1          :0]     C23,C25;
        reg     [2*INPUT_WIDTH - 1          :0]     C24,C27;
        
        //3
        reg     [2*INPUT_WIDTH - 1          :0]     S31;
        reg     [2*INPUT_WIDTH - 1          :0]     S33;
        reg     [2*INPUT_WIDTH - 1         :0]     S32;
        reg     [2*INPUT_WIDTH - 1          :0]     S35;
        reg     [2*INPUT_WIDTH - 1          :0]     S34;
        
        reg     [2*INPUT_WIDTH - 1          :0]     C34;
        reg     [2*INPUT_WIDTH - 1          :0]     C33;
        reg     [2*INPUT_WIDTH - 1          :0]     C32;
        reg     [2*INPUT_WIDTH - 1          :0]     C35;
        
        //4
        reg     [2*INPUT_WIDTH - 1          :0]     S41;
        reg     [2*INPUT_WIDTH - 1          :0]     S43;
        reg     [2*INPUT_WIDTH - 1          :0]     S42;
        
        reg     [2*INPUT_WIDTH - 1          :0]     C41;
        reg     [2*INPUT_WIDTH - 1          :0]     C42;
        reg     [2*INPUT_WIDTH - 1          :0]     C43;
        
        //5
        reg     [2*INPUT_WIDTH - 1         :0]     S51;
        reg     [2*INPUT_WIDTH - 1         :0]     S52;
        
        reg     [2*INPUT_WIDTH - 1         :0]     C51;
        reg     [2*INPUT_WIDTH - 1          :0]     C52;
        
        //6
        reg     [2*INPUT_WIDTH - 1          :0]     S61;
        reg     [2*INPUT_WIDTH - 1          :0]     C61;
        
        //7
        reg     [2*INPUT_WIDTH - 1          :0]     S71;
        reg     [2*INPUT_WIDTH - 1          :0]     C71;
        
        //General
        reg     [2*INPUT_WIDTH - 1          :0]     product             ;
        reg     [2*INPUT_WIDTH - 1          :0]     product_temp        ;
        reg     [INPUT_WIDTH - 1            :0]     multiplier_copy     ;
        reg     [2*INPUT_WIDTH - 1          :0]     multiplicand_copy   ;
        reg                                         negative_output     ;
   
        reg     [$clog2(INPUT_WIDTH)        :0]     bit_reg                 ; 
        
        assign                                      READY = !bit_reg        ;

        initial 
        begin
            product_temp    = 0;
            product         = 0;
            bit_reg             = 1;
            negative_output = 0;
        end

        always @( posedge CLK )
        begin
            if(!STALL_MUL)
            begin
                if( START )  
                begin
                    bit_reg               = 9; 
                    product           = 0;
                    product_temp      = 0;
                    multiplicand_copy = (!SIGN2 || !MULTIPLICAND[INPUT_WIDTH - 1]) ? 
                                        { {INPUT_WIDTH{1'b0}}, MULTIPLICAND } : 
                                        { {INPUT_WIDTH{1'b0}}, ~MULTIPLICAND + 1'b1};
                    multiplier_copy   = (!SIGN1 || !MULTIPLIER[INPUT_WIDTH - 1]) ?
                                        MULTIPLIER :
                                        ~MULTIPLIER + 1'b1; 
            
                    negative_output   = (SIGN1 & MULTIPLIER[INPUT_WIDTH - 1]) ^ (SIGN2 & MULTIPLICAND[INPUT_WIDTH - 1]);
                end
                else if ( bit_reg > 0 )
                begin
                    a0 = {{32{multiplier_copy[0]}} & multiplicand_copy};
                    a1 = {{{32{multiplier_copy[1]}} & multiplicand_copy},{1'b0}};
                    a2 = {{32{multiplier_copy[2]}} & multiplicand_copy};
                    a3 = {{{32{multiplier_copy[3]}} & multiplicand_copy},{1'b0}};
                    a4 = {{{32{multiplier_copy[4]}} & multiplicand_copy},{2'b0}};
                    a5 = {{32{multiplier_copy[5]}} & multiplicand_copy};
                    a6 = {{{32{multiplier_copy[6]}} & multiplicand_copy},{1'b0}};
                    a7 = {{{32{multiplier_copy[7]}} & multiplicand_copy},{2'b0}};
                    a8 = {{32{multiplier_copy[8]}} & multiplicand_copy};
                    a9 = {{{32{multiplier_copy[9]}} & multiplicand_copy},{1'b0}};
                    a10 = {{{32{multiplier_copy[10]}} & multiplicand_copy},{2'b0}};
                    a11 = {{32{multiplier_copy[11]}} & multiplicand_copy};
                    a12 = {{{32{multiplier_copy[12]}} & multiplicand_copy},{1'b0}};
                    a13 = {{{32{multiplier_copy[13]}} & multiplicand_copy},{2'b0}};
                    a14 = {{32{multiplier_copy[14]}} & multiplicand_copy};
                    a15 = {{{32{multiplier_copy[15]}} & multiplicand_copy},{1'b0}};
                    a16 = {{{32{multiplier_copy[16]}} & multiplicand_copy},{2'b0}};
                    a17 = {{32{multiplier_copy[17]}} & multiplicand_copy};
                    a18 = {{{32{multiplier_copy[18]}} & multiplicand_copy},{1'b0}};
                    a19 = {{{32{multiplier_copy[19]}} & multiplicand_copy},{2'b0}};
                    a20 = {{32{multiplier_copy[20]}} & multiplicand_copy};
                    a21 = {{{32{multiplier_copy[21]}} & multiplicand_copy},{1'b0}};
                    a22 = {{{32{multiplier_copy[22]}} & multiplicand_copy},{2'b0}};
                    a23 = {{32{multiplier_copy[23]}} & multiplicand_copy};
                    a24 = {{{32{multiplier_copy[24]}} & multiplicand_copy},{1'b0}};
                    a25 = {{{32{multiplier_copy[25]}} & multiplicand_copy},{2'b0}};
                    a26 = {{32{multiplier_copy[26]}} & multiplicand_copy};
                    a27 = {{{32{multiplier_copy[27]}} & multiplicand_copy},{1'b0}};
                    a28 = {{{32{multiplier_copy[28]}} & multiplicand_copy},{2'b0}};
                    a29 = {{32{multiplier_copy[29]}} & multiplicand_copy};
                    a30 = {{{32{multiplier_copy[30]}} & multiplicand_copy},{1'b0}};
                    a31 = {{{32{multiplier_copy[31]}} & multiplicand_copy},{2'b0}};
                    
                    //First Cycle
                    S111 <= a0+a1; 
                    S11 <= {(a2^a3^a4),2'b0};
                    C11 <= {(a2&a3)|(a3&a4)|(a4&a2),3'b0};
                    S12 <= a5^a6^a7;
                    C12 <= {(a5&a6)|(a6&a7)|(a7&a5),1'b0};
                    S13 <= {(a8^a9^a10),3'b0};
                    C13 <= {(a8&a9)|(a9&a10)|(a10&a8),1'b0};
                    S14 <= {(a11^a12^a13),3'b0};
                    C14 <= {(a11&a12)|(a12&a13)|(a13&a11),4'b0};
                    S15 <= a14^a15^a16;
                    C15 <= {(a14&a15)|(a15&a16)|(a16&a14),1'b0};
                    S16 <= {(a17^a18^a19),3'b0};
                    C16 <= {(a17&a18)|(a18&a19)|(a19&a17),1'b0};
                    S17 <= {(a20^a21^a22),3'b0};
                    C17 <= {(a20&a21)|(a21&a22)|(a22&a20),4'b0};
                    S18 <= a23^a24^a25;
                    C18 <= {(a23&a24)|(a24&a25)|(a25&a23),1'b0};
                    S19 <= {(a26^a27^a28),3'b0};
                    C19 <= {(a26&a27)|(a27&a28)|(a28&a26),1'b0};
                    S110 <= {(a29^a30^a31),3'b0};
                    C110 <= {(a29&a30)|(a30&a31)|(a31&a29),4'b0};
                    
                    //Second Cycle  
                    S21 <= S111^S11^C11;
                    C21 <= {(S111&S11)|(S11&C11)|(C11&S111),1'b0}; 
                    S22 <= S12^C12^S13;
                    C22 <= {(S12&C12)|(C12&S13)|(S13&S12),1'b0}; 
                    S23 <= {(C13^S14^C14),3'b0};
                    C23 <= {(C13&S14)|(S14&C14)|(C14&C13),1'b0}; 
                    S24 <= {(S15^C15^S16),6'b0};
                    C24 <= {(S15&C15)|(C15&S16)|(S16&S15),7'b0}; 
                    S25 <= C16^S17^C17;
                    C25 <= {(C16&S17)|(S17&C17)|(C17&C16),1'b0}; 
                    S26 <= {(S18^C18^S19),6'b0};
                    C26 <= {(S18&C18)|(C18&S19)|(S19&S18),1'b0}; 
                    S27 <= {(C19^S110^C110),3'b0};
                    C27 <= {(C19&S110)|(S110&C110)|(C110&C19),4'b0};
                    
                    //Third Cycle
                    S31 <= S21+C21;
                    S32 <= {(S22^C22^S23),5'b0};
                    C32 <= {(S22&C22)|(C22&S23)|(S23&S22),6'b0}; 
                    S33 <= C23^S24^C24;
                    C33 <= {(C23&S24)|(S24&C24)|(C24&C23),1'b0}; 
                    S34 <= {(S25^C25^S26),9'b0};
                    C34 <= {(S25&C25)|(C25&S26)|(S26&S25),1'b0}; 
                    S35 <= {(C26^S27^C27),6'b0};
                    C35 <= {(C26&S27)|(S27&C27)|(C27&C26),7'b0};
                    
                    
                    //Fourth Cycle
                    S41 <= S31^S32^C32;
                    C41 <= {(S31&S32)|(S32&C32)|(C32&S31),1'b0}; 
                    S42 <= {(S33^C33^S34),8'b0};
                    C42 <= {(S33&C33)|(C33&S34)|(S34&S33),1'b0}; 
                    S43 <= {(C34^S35^C35),9'b0};
                    C43 <= {(C34&S35)|(S35&C35)|(C35&C34),10'b0};
                    
                    //Fifth Cycle
                    S51 <= S41^C41^S42;
                    C51 <= {(S41&C41)|(C41&S42)|(S42&S41),1'b0}; 
                    S52 <= {(C42^S43^C43),8'b0};
                    C52 <= {(C42&S43)|(S43&C43)|(C43&C42),9'b0};
                    
                    //Sixth Cycle
                    S61 <= C51^S52^C52;
                    C61 <= {(C51&S52)|(S52&C52)|(C52&C51),1'b0};
                    
                    //Seventh Cycle
                    S71 <= S51^S61^C61;
                    C71 <= {(S51&S61)|(S61&C61)|(C61&S51),1'b0}; 
                        
                    product_temp <= S71+C71;
                    
                    bit_reg               <= bit_reg - 1'b1;
                end
                product           = (!negative_output) ? product_temp : ~product_temp + 1'b1;
            end
        end
        
        assign PRODUCT_OUT  = product   ;
      
endmodule