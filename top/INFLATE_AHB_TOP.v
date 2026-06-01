////////////////////////////////////////////////////////
//
//  Module: INFLATE_AHB_TOP
//  Project: OASIS
//  Description: 
// 
//  Change history: 
//  24.04.04 : initial description
//  24.05.20 : Closing first version
//
////////////////////////////////////////////////////////
`include "inflate.inc"
`timescale 1ns/10ps

module INFLATE_AHB_TOP 
(
    input  wire                         SE                  ,
    input  wire                         TE                  ,
    input  wire                         CKE_IP              ,
    input  wire                         RESET_IP            ,
    input  wire                         HCLK_CG_EN          ,
    //
	input wire [4*4-1:0]				I_MEM_RM			,
	input wire [4-1:0]					I_MEM_RME			,
	input wire [4-1:0]					I_MEM_TEST1			,
    input  wire                         I_BIST_MD           ,
    output wire                         O_BIST_DONE         ,
    output wire                         O_BIST_FAIL         ,
    // AHB Common
    input  wire                         HCLK                ,
    input  wire                         FCLK                ,
    input  wire                         HRESETN             ,
    // AHB Slave
    input wire                          SLV_HSEL            ,
    input wire  [31:0]                  SLV_HADDR           ,
    input wire  [ 1:0]                  SLV_HTRANS          ,
    input wire  [ 2:0]                  SLV_HSIZE           ,
    input wire  [ 3:0]                  SLV_HPROT           ,
    input wire                          SLV_HWRITE          ,
    input wire  [ 2:0]                  SLV_HBURST          ,
    input wire                          SLV_HMLOCK          ,
    input wire  [31:0]                  SLV_HWDATA          ,
    input wire                          SLV_HREADYIN        ,
    output wire [1:0]                   SLV_HRESP           ,
    output wire [31:0]                  SLV_HRDATA          ,
    output wire                         SLV_HREADYOUT       ,
    // for Flow CON
    output wire                         O_FLCON_REQ         ,
    output wire [8:0]				    O_FLCON_DCNT        ,
    output wire                         O_FLCON_BYTE_MODE   ,
	output wire [1:0]                   O_FLCON_TMODE		,
    input  wire                         I_FLCON_ACK         , 
    output wire [31:0]                  O_FLCON_SADDR       ,
    output wire [31:0]                  O_FLCON_DADDR       ,
	output wire							O_INFL_INTR			,
	input  wire							I_SPIF_PGM_MON
);

//----------------------------------------------------------------------------
// Declaration
//----------------------------------------------------------------------------
wire                                w_infl_en           ;
wire                                w_infl_ben          ;
wire                                w_ibuf_flash		;
wire                                w_obuf_flash		;
wire                                w_exsw_flash		;
wire                                w_infl_mem_csb      ;
wire    [3:0]                       w_infl_mem_web      ;
wire    [`MEM_ADDR_BIT-1:0]         w_infl_mem_addr     ;
wire    [31:0]                      w_infl_mem_odata    ;
wire                                w_mem_access_valid  ;
wire    [`MEM_ADDR_BIT-1:0]         w_ll_base           ;
wire    [`MEM_ADDR_BIT-1:0]         w_dist_base         ;
wire    [3:0]                       w_ll_max_bit        ; 
wire    [3:0]                       w_ll_sc_bit         ;  
wire    [3:0]                       w_dist_max_bit      ; 
wire    [3:0]                       w_dist_sc_bit       ; 
wire    [3:0]                       w_hdt_fmt	        ; 
wire    [31:0]                      w_infl_mbase        ; 
wire    [31:0]                      w_infl_ibase        ; 
wire    [31:0]                      w_infl_obase        ; 
wire    [3:0]                       w_init_rshift       ;  
wire    [`MVBLK_SIZE_BIT-1:0]       w_ibuf_mvblk_size   ;
wire    [`MEM_ADDR_BIT-1:0]         w_ibuf_min_size     ;
wire    [`MEM_ADDR_BIT-1:0]         w_ibuf_saddr        ;
wire    [`MEM_ADDR_BIT-1:0]         w_ibuf_eaddr        ;
wire    [`MEM_ADDR_BIT-1:0]         w_ibuf_caddrl       ;
wire    [`MEM_ADDR_BIT-1:0]         w_ibuf_caddrh       ;
wire    [`MEM_ADDR_BIT-1:0]         w_ibuf_cptr         ;
wire    [`MEM_ADDR_BIT-1:0]         w_ibuf_eptr         ;
wire    [`MVBLK_SIZE_BIT-1:0]       w_obuf_mvblk_size   ;
wire    [`MEM_ADDR_BIT-1:0]         w_obuf_max_size     ;
wire    [`MEM_ADDR_BIT-1:0]         w_obuf_caddr        ;
wire    [`MEM_ADDR_BIT-1:0]         w_obuf_cptr         ;
wire    [`MEM_ADDR_BIT-1:0]         w_obuf_eptr         ;
wire    [`MEM_ADDR_BIT-1:0]         w_sw_saddr          ;
wire    [`MEM_ADDR_BIT-1:0]         w_sw_eaddr          ;
wire    [`MEM_ADDR_BIT-1:0]         w_sw_caddr          ;
wire    [`MEM_ADDR_BIT-1:0]         w_sw_cptr           ;
wire    [`MEM_ADDR_BIT-1:0]         w_sw_eptr           ;
wire    [`MEM_ADDR_BIT-1:0]         w_exsw_saddr        ;
wire    [`MEM_ADDR_BIT-1:0]         w_exsw_eaddr        ;
wire    [3:0]                       w_infl_stop_req     ;
wire    [`STATUS_BIT-1:0]           w_infl_stat         ; 
wire                                w_infl_intr_req     ;
wire    [`MEM_ADDR_BIT-1:0]			w_ibuf_num			;
wire    [`MEM_ADDR_BIT-1:0]   		w_obuf_num   		;
wire	[`MEM_ADDR_BIT-1:0]			w_exsw_num			;
wire	[`MEM_ADDR_BIT-1:0]			w_sw_num	 		;
wire	[`MAX_OUT_SIZE_BIT-1:0]		w_ocnt				;
wire	[`MAX_IN_SIZE_BIT-1:0]		w_icnt		 		;
wire	[`MAX_OUT_SIZE_BIT-1:0]		w_dcnt				;
wire    [`MAX_OUT_SIZE_BIT-1:0]		w_dbg_ocnt			;
wire    [`MAX_IN_SIZE_BIT-1:0]		w_dbg_icnt		 	;
wire    [`MAX_OUT_SIZE_BIT-1:0]		w_dbg_dcnt			;
wire    [`MEM_ADDR_BIT-1:0]			w_dbg_ibcnt			;
wire                              	w_dbg_ocnt_updt		;
wire                              	w_dbg_icnt_updt		;
wire                              	w_dbg_dcnt_updt		;
wire                              	w_dbg_ibcnt_updt	;
wire                              	w_dbg_obuf_ack		;
wire                              	w_dbg_exsw_ack		;
wire    [31:0]						w_hd_byte_buf		;
wire    [4:0]						w_hd_byte_offset	;	
wire    [`MAX_IN_SIZE_BIT-1:0]		w_icnt_max			;	
wire    [`MAX_OUT_SIZE_BIT-1:0]		w_dcnt_max			;
wire                                w_fill_ibuf         ;
wire                                w_flush_obuf        ;
wire                                w_updt_exsw         ;
wire						   		w_wait_pgm			;
wire 	[3:0]				   		w_infl_stat_aux		;	
wire								w_lastsb_flush		;
wire								w_mwait_ahbs		;
wire								w_chk_pgm			;
wire								w_ibuf_inc_fz		;
wire								w_obuf_inc_fz		;
wire	[8:0]						w_exsw_mvblk_size	;
wire	[`MAX_OUT_SIZE_BIT-1:0]		w_exsw_ret_addr		;

//----------------------------------------------------------------------------
// Rest & Clock Control
//----------------------------------------------------------------------------
wire                 sig_rstb;
wire                 hclkg, FCLKG;
assign sig_rstb = HRESETN & (TE|RESET_IP);

CLK_GATE I_CG_HCLK (.EN(CKE_IP), .TE(SE), .ICLK(HCLK), .OCLK(hclkg));
CLK_GATE I_CG_FCLK (.EN(CKE_IP), .TE(SE), .ICLK(FCLK), .OCLK(FCLKG));

//----------------------------------------------------------------------------
// AHB2AHB Bridge
//----------------------------------------------------------------------------
wire [4-1:0]	w_HMASTERM	= 'h0;
wire			w_HRESPS;
assign SLV_HRESP	= {1'b0,w_HRESPS};

wire [32-1:0]	S_HADDR		;
wire   [1:0] 	S_HTRANS	;
wire   [2:0] 	S_HSIZE		;
wire         	S_HWRITE	;
wire [4-1:0]	S_HMASTER	;
wire   [3:0] 	S_HPROT		;
wire         	S_HMASTLOCK	;
wire   [2:0] 	S_HBURST	;
wire [32-1:0]	S_HWDATA	;
wire			S_HSEL		= S_HTRANS[1];

wire         	S_HREADYOUT	;
wire [1:0]		S_HRESP		;
wire [32-1:0]	S_HRDATA	;

wire			S_HREADYIN	= S_HREADYOUT;

cmsdk_ahb_to_ahb_sync u_cmsdk_ahb_to_ahb_sync (
/*input  wire		  */	.HCLK		(hclkg			),
/*input  wire		  */	.HRESETn	(sig_rstb		),

// AHB connection to master
/*input  wire         */	.HSELS		(SLV_HSEL		),
/*input  wire [AW-1:0]*/	.HADDRS		(SLV_HADDR		),
/*input  wire    [1:0]*/	.HTRANSS	(SLV_HTRANS		),
/*input  wire    [2:0]*/	.HSIZES		(SLV_HSIZE		),
/*input  wire         */	.HWRITES	(SLV_HWRITE		),
/*input  wire         */	.HREADYS	(SLV_HREADYIN	),
/*input  wire    [3:0]*/	.HPROTS		(SLV_HPROT		),
/*input  wire [MW-1:0]*/	.HMASTERS	(w_HMASTERM		),
/*input  wire         */	.HMASTLOCKS	(SLV_HMLOCK		),
/*input  wire [DW-1:0]*/	.HWDATAS	(SLV_HWDATA		),
/*input  wire    [2:0]*/	.HBURSTS	(SLV_HBURST		),

/*output wire         */	.HREADYOUTS	(SLV_HREADYOUT	),
/*output wire         */	.HRESPS		(w_HRESPS		),
/*output wire [DW-1:0]*/	.HRDATAS	(SLV_HRDATA		),

// AHB connection to slave
/*output wire [AW-1:0]*/	.HADDRM		(S_HADDR		),
/*output wire   [1:0] */	.HTRANSM	(S_HTRANS		),
/*output wire   [2:0] */	.HSIZEM		(S_HSIZE		),
/*output wire         */	.HWRITEM	(S_HWRITE		),
/*output wire   [3:0] */	.HPROTM		(S_HPROT		),
/*output wire [MW-1:0]*/	.HMASTERM	(S_HMASTER		),
/*output wire         */	.HMASTLOCKM	(S_HMASTLOCK	),
/*output wire [DW-1:0]*/	.HWDATAM	(S_HWDATA		),
/*output wire   [2:0] */	.HBURSTM	(S_HBURST		),

/*input  wire         */	.HREADYM	(S_HREADYOUT	),
/*input  wire         */	.HRESPM		(S_HRESP[0]		),
/*input  wire [DW-1:0]*/	.HRDATAM	(S_HRDATA		)
);

//----------------------------------------------------------------------------
// AHB Slave
//----------------------------------------------------------------------------
wire    w_hclk_cg;
hclk_cg u_HCLK_CG (
/*input wire    */  .SE             (SE         ),
/*input wire    */  .HCLK           (hclkg      ),
/*input wire    */  .HRESET_N       (sig_rstb   ),
/*input wire    */  .HSEL           (S_HSEL     ),
/*input wire    */  .HCLK_CG_EN     (HCLK_CG_EN ),
/*output wire   */  .HCLK_CG        (w_hclk_cg  )
);

//----------------------------------------------------------------------------
// Memory Map
//----------------------------------------------------------------------------
`define CFG_SIZE    16'h1000    //4KB
`define MEM_SIZE    16'h7000    //28KB
wire    w_hsel_cfg  = (S_HSEL && (S_HADDR[14:12]<=2'd0));   //4KB (0x0000~0x0FFF)
wire    w_hsel_mem  = (S_HSEL && (S_HADDR[14:12]> 2'd0));   //28KB(0x1000~0x57FF)

//----------------------------------------------------------------------------
// Slave
//----------------------------------------------------------------------------
reg   [31:0] haddr_reg;
reg    [1:0] hsize_reg;

wire [31:0]  w_hrdata_cfg ;
wire         w_hready_cfg ;
wire [1:0]   w_hresp_cfg  ;

wire         hvalid_mem;
wire         hvalid_mem_rd;
reg          hvalid_mem_rd_d;
reg          hvalid_mem_rd_d2;
reg          hvalid_mem_wr;
reg          hvalid_mem_reg;

wire  [31:0] w_hrdata_mem   ;
wire         w_hready_mem   ;
wire [1:0]   w_hresp_mem    ;

wire         byte_00_we;
wire         byte_01_we;
wire         byte_10_we;
wire         byte_11_we;

assign byte_00_we = (haddr_reg[1:0]==2'b00);
assign byte_01_we = (((hsize_reg[1:0]==2'b00)&&(haddr_reg[1:0]==2'b01)) ||
                    ((hsize_reg[1:0]==2'b01)&&(haddr_reg[1:0]==2'b00)) ||
                    ((hsize_reg[1]==1'b1)&&(haddr_reg[1:0]==2'b00)));
assign byte_10_we = (((hsize_reg[1:0]==2'b00)&&(haddr_reg[1:0]==2'b10)) ||
                    ((hsize_reg[1:0]==2'b01)&&(haddr_reg[1:0]==2'b10)) ||
                    ((hsize_reg[1]==1'b1)&&(haddr_reg[1:0]==2'b00)));
assign byte_11_we = (((hsize_reg[1:0]==2'b00)&&(haddr_reg[1:0]==2'b11)) ||
                    ((hsize_reg[1:0]==2'b01)&&(haddr_reg[1:0]==2'b10)) ||
                    ((hsize_reg[1]==1'b1)&&(haddr_reg[1:0]==2'b00)));

always @(posedge w_hclk_cg or negedge sig_rstb)
begin
    if (~sig_rstb) begin
        haddr_reg <= #1 20'b0;
        hsize_reg <= #1 2'b10; //word

        hvalid_mem_wr    <= #1 1'b0;
        hvalid_mem_rd_d  <= #1 1'b0;
        hvalid_mem_rd_d2 <= #1 1'b0;
    end
    else begin
        if (S_HREADYIN & S_HTRANS[1] & (w_hsel_cfg|w_hsel_mem)) begin
            haddr_reg <= #1 S_HADDR[19:0];
        end
        hsize_reg <= #1 S_HSIZE[1:0];

        hvalid_mem_wr    <= #1 hvalid_mem & S_HWRITE;
        hvalid_mem_rd_d  <= #1 hvalid_mem_rd;
        hvalid_mem_rd_d2 <= #1 hvalid_mem_rd_d;
    end
end
assign hvalid_mem       = S_HREADYIN & S_HTRANS[1] & w_hsel_mem;
assign hvalid_mem_rd    = hvalid_mem     & !S_HWRITE;
wire   w_hvalid_mem_rd_d= (w_mwait_ahbs) ? hvalid_mem_rd_d2 : hvalid_mem_rd_d; 

/*
integer i;
reg [31:0]  c_reg   [0:REG_DEPTH-1];

always @(posedge w_hclk_cg or negedge sig_rstb) 
    if (~sig_rstb) begin
        for(i=0;i<REG_DEPTH;i=i+1) begin
            c_reg[i] <= 'd0;
        end
    end else begin
        if (hvalid_reg & hwrite_reg) begin
            if(byte_00_we) begin c_reg[haddr_reg[9:2]][07:00] <= S_HWDATA[07:00]; end
            if(byte_01_we) begin c_reg[haddr_reg[9:2]][15:08] <= S_HWDATA[15:08]; end
            if(byte_10_we) begin c_reg[haddr_reg[9:2]][23:16] <= S_HWDATA[23:16]; end
            if(byte_11_we) begin c_reg[haddr_reg[9:2]][31:24] <= S_HWDATA[31:24]; end
        end //hwrite_valid
    end //clock edge

always @(*) begin
    w_hrdata_cfg <= 32'b0;
    if (hvalid_reg & ~hwrite_reg) begin
        if(haddr_reg[9:2]>=REG_DEPTH) begin
            if(haddr_reg[9:2]==(REG_DEPTH+0)) begin
                //w_hrdata_cfg <= ;
            end
        end else begin
                //REG_DEPTH>1
                //w_hrdata_cfg <= c_reg[haddr_reg[9:2]];
                w_hrdata_cfg <= c_reg[haddr_reg[$clog2(REG_DEPTH)-1+2:2]];
        end
    end
end
*/

//----------------------------------------------------------------------------
// Buffer
//----------------------------------------------------------------------------
wire            			buf_clk                 ;
wire            			buf_rstb                ;
wire            			buf_cen                 ;
wire    [3:0]   			buf_wen                 ;
wire    [`MEM_ADDR_BIT-3:0] buf_a                   ;
wire    [`MEM_ADDR_BIT-1:0] buf_a_full  = buf_a << 2; //view only
wire    [31:0]  			buf_din                 ;
wire    [31:0]  			buf_dout                ;
reg     [31:0]  			buf_dout_d              ;
wire            			w_ahbs_mem_cen          ;
wire    [`MEM_ADDR_BIT-3:0] w_ahbs_mem_a            ;
wire    [3:0]  				w_ahbs_mem_wen          ;

assign    w_ahbs_mem_cen = (hvalid_mem_rd||hvalid_mem_wr) ? 1'b0 : 1'b1;
assign    w_ahbs_mem_a   = (hvalid_mem_rd) ? (S_HADDR[`MEM_ADDR_BIT-1:2]-(`CFG_SIZE>>2)) : (haddr_reg[`MEM_ADDR_BIT-1:2]-(`CFG_SIZE>>2));
assign    w_ahbs_mem_wen = (hvalid_mem_wr) ? ~{byte_11_we,byte_10_we,byte_01_we,byte_00_we} : {4{1'b1}};

assign    buf_cen   = (~w_ahbs_mem_cen) ? 1'b0           : w_infl_mem_csb       ;
assign    buf_a     = (~w_ahbs_mem_cen) ? w_ahbs_mem_a   : w_infl_mem_addr[`MEM_ADDR_BIT-1:2];
assign    buf_wen   = (~w_ahbs_mem_cen) ? w_ahbs_mem_wen : w_infl_mem_web       ;
assign #2 buf_din   = (~w_ahbs_mem_cen) ? S_HWDATA[31:0] : w_infl_mem_odata     ;

CLK_MUX u_buf_clk   (.A(hclkg),     .B(HCLK),   .S(I_BIST_MD), .Y(buf_clk));
CLK_MUX u_buf_rstb  (.A(sig_rstb),  .B(HRESETN),.S(I_BIST_MD), .Y(buf_rstb));

always @(posedge hclkg or negedge sig_rstb) begin
	if (sig_rstb == 1'b0)
		buf_dout_d <= 32'd0;
	else
		buf_dout_d <= buf_dout;
end


`ifndef SIM_INFL_MEM
    `ifdef  BIST_HW_ON
    sp_1024x32_wrap_bist u_INFL_MEM (
    /*input wire            */  .SCAN_MD    (TE             ),
    /*input wire            */  .BIST_MD    (I_BIST_MD      ),
    /*output wire           */  .BIST_DONE  (O_BIST_DONE    ),
    /*output wire           */  .BIST_FAIL  (O_BIST_FAIL    ),
    `else
    sp_1024x32_wrap u_INFL_MEM (
    `endif
	`ifdef	HLMC55_ULP
	/*input  wire   		*/	.RME		(I_MEM_RME[0]	),
	/*input  wire [3:0]		*/	.RM			(I_MEM_RM[03:00]),
	`endif
	/*input  wire   		*/	.TEST1		(I_MEM_TEST1[0]	),
    /*input  wire           */  .RSTB   	(buf_rstb   	),
    /*input  wire           */  .CLK    	(buf_clk    	),
    /*input  wire           */  .CEN    	(buf_cen    	),
    /*input  wire   [3:0]   */  .WEN    	(buf_wen    	),
    /*input  wire [9:0]		*/  .A      	(buf_a[9:0]		),
    /*input  wire [31:0]    */  .D      	(buf_din    	),
    /*output wire [31:0]    */  .Q      	(buf_dout   	)
    );
`else
    //---------------------------------------------  
    reg [31:0]      memory_word[0:(2**(`MEM_ADDR_BIT-2)-1)];
    reg [31:0]      r_buf_dout;
    assign          buf_dout = r_buf_dout;
    
    initial $readmemh(`MM_HEX_FILE, memory_word);
    
    wire w_mem_read = &buf_wen;
    always @(posedge buf_clk) begin
        if (~buf_cen && w_mem_read)
            r_buf_dout <= memory_word[buf_a];
    end
    always @(posedge buf_clk) begin
        if(~buf_cen) begin
            if(~buf_wen[0])
                memory_word[buf_a][7:0]   <= buf_din[7:0];
            if(~buf_wen[1])
                memory_word[buf_a][15:8]  <= buf_din[15:8];
            if(~buf_wen[2])
                memory_word[buf_a][23:16] <= buf_din[23:16];
            if(~buf_wen[3])
                memory_word[buf_a][31:24] <= buf_din[31:24];
        end
    end
`endif
//---------------------------------------------  
//----------------------------------------------------------------------------
// Slave Mux
//----------------------------------------------------------------------------
wire [31:0] w_buf_dout  = (w_mwait_ahbs) ? buf_dout_d : buf_dout;
assign S_HRESP      = 2'd0;
assign S_HRDATA     = (w_hvalid_mem_rd_d) ? w_buf_dout : w_hrdata_cfg;
assign S_HREADYOUT  = (w_mwait_ahbs) ? ~hvalid_mem_rd_d : 1'b1;

//----------------------------------------------------------------------------
// Port Map : Inflate core
//----------------------------------------------------------------------------
assign w_mem_access_valid = w_ahbs_mem_cen;
`ifdef SIM_SKIP_FLCON_ACK
wire   w_flcon_ack        = 1'b1; 
`else
wire   w_flcon_ack        = I_FLCON_ACK;
`endif

wire [`MVBLK_SIZE_BIT-1:0] w_flcon_dcnt;
assign O_FLCON_DCNT = w_flcon_dcnt[8:0];

inflate_core u_inflate_core(
/*input                             */  .I_INFL_CLK         (   hclkg               ),
/*input                             */  .I_INFL_RSTN        (   sig_rstb            ),
/*input                             */  .I_INFL_EN          (   w_infl_en           ),
/*input                             */  .I_INFL_BEN         (   w_infl_ben          ),
/*input                             */  .I_IBUF_FLASH       (   w_ibuf_flash        ),
/*input                             */  .I_OBUF_FLASH       (   w_obuf_flash	    ),
/*input                             */  .I_EXSW_FLASH       (   w_exsw_flash	    ),
/*output                            */  .O_MEM_CSB          (   w_infl_mem_csb      ),
/*output    [3:0]                   */  .O_MEM_WEB          (   w_infl_mem_web      ),
/*output    [`MEM_ADDR_BIT-1:0]     */  .O_MEM_ADDR         (   w_infl_mem_addr     ),
/*output    [31:0]                  */  .O_MEM_DATA         (   w_infl_mem_odata    ),
/*input     [31:0]                  */  .I_MEM_DATA         (   buf_dout_d          ),
/*input                             */  .I_MEM_ACCESS_VALID (   w_mem_access_valid  ), 
/*output                            */  .O_FLCON_REQ        (   O_FLCON_REQ         ),
/*output    [`MVBLK_SIZE_BIT-1:0]   */  .O_FLCON_DCNT       (   w_flcon_dcnt		),
/*output                            */  .O_FLCON_BYTE_MODE  (   O_FLCON_BYTE_MODE   ),
/*output    [1:0]                   */  .O_FLCON_TMODE		(	O_FLCON_TMODE		),
/*input                             */  .I_FLCON_ACK        (   w_flcon_ack         ), 
/*output    [31:0]                  */  .O_FLCON_SADDR      (   O_FLCON_SADDR       ),
/*output    [31:0]                  */  .O_FLCON_DADDR      (   O_FLCON_DADDR       ),
/*input     [`MEM_ADDR_BIT-1:0]     */  .I_LL_BASE          (   w_ll_base           ), 
/*input     [`MEM_ADDR_BIT-1:0]     */  .I_DIST_BASE        (   w_dist_base         ),  
/*input     [3:0]                   */  .I_LL_MAX_BIT       (   w_ll_max_bit        ), 
/*input     [3:0]                   */  .I_LL_SC_BIT        (   w_ll_sc_bit         ),  
/*input     [3:0]                   */  .I_DIST_MAX_BIT     (   w_dist_max_bit      ), 
/*input     [3:0]                   */  .I_DIST_SC_BIT      (   w_dist_sc_bit       ), 
/*input     [3:0]                   */  .I_HDT_FMT		    (   w_hdt_fmt	        ), 
/*input     [31:0]                  */  .I_INFL_MBASE       (   w_infl_mbase        ), 
/*input     [31:0]                  */  .I_INFL_IBASE       (   w_infl_ibase        ), 
/*input     [31:0]                  */  .I_INFL_OBASE       (   w_infl_obase        ), 
/*input     [3:0]                   */  .I_INIT_RSHIFT      (   w_init_rshift       ), 
/*input     [`MVBLK_SIZE_BIT-1:0]   */  .I_IBUF_MVBLK_SIZE  (   w_ibuf_mvblk_size   ),
/*input     [`MEM_ADDR_BIT-1:0]     */  .I_IBUF_MIN_SIZE    (   w_ibuf_min_size     ),
/*input     [`MEM_ADDR_BIT-1:0]     */  .I_IBUF_SADDR       (   w_ibuf_saddr        ),
/*input     [`MEM_ADDR_BIT-1:0]     */  .I_IBUF_EADDR       (   w_ibuf_eaddr        ),
/*input     [`MEM_ADDR_BIT-1:0]     */  .I_IBUF_CADDRL      (   w_ibuf_caddrl       ),
/*input     [`MEM_ADDR_BIT-1:0]     */  .I_IBUF_CADDRH      (   w_ibuf_caddrh       ),
/*output    [`MEM_ADDR_BIT-1:0]     */  .O_IBUF_CPTR        (   w_ibuf_cptr         ),
/*output    [`MEM_ADDR_BIT-1:0]     */  .O_IBUF_EPTR        (   w_ibuf_eptr         ),
/*input     [`MVBLK_SIZE_BIT-1:0]   */  .I_OBUF_MVBLK_SIZE  (   w_obuf_mvblk_size   ),
/*input     [`MEM_ADDR_BIT-1:0]     */  .I_OBUF_MAX_SIZE    (   w_obuf_max_size     ),
/*input     [`MEM_ADDR_BIT-1:0]     */  .I_OBUF_CADDR	    (   w_obuf_caddr        ),
/*output    [`MEM_ADDR_BIT-1:0]     */  .O_OBUF_CPTR        (   w_obuf_cptr         ),
/*output    [`MEM_ADDR_BIT-1:0]     */  .O_OBUF_EPTR        (   w_obuf_eptr         ),
/*input     [`MEM_ADDR_BIT-1:0]     */  .I_SW_SADDR         (   w_sw_saddr          ),
/*input     [`MEM_ADDR_BIT-1:0]     */  .I_SW_EADDR         (   w_sw_eaddr          ),
/*input     [`MEM_ADDR_BIT-1:0]     */  .I_SW_CADDR         (   w_sw_caddr          ),
/*output    [`MEM_ADDR_BIT-1:0]     */  .O_SW_CPTR          (   w_sw_cptr           ),
/*output    [`MEM_ADDR_BIT-1:0]     */  .O_SW_EPTR          (   w_sw_eptr           ),
/*input     [`MEM_ADDR_BIT-1:0]     */  .I_EXSW_SADDR       (   w_exsw_saddr        ),
/*input     [`MEM_ADDR_BIT-1:0]     */  .I_EXSW_EADDR       (   w_exsw_eaddr        ),
/*input     [3:0]                   */  .I_INFL_STOP_REQ    (   w_infl_stop_req     ),
/*output                            */  .O_INFL_INTR_REQ    (   w_infl_intr_req     ),
/*output    [`STATUS_BIT-1:0]       */  .O_INFL_STAT        (   w_infl_stat         ),
/*output	[`MEM_ADDR_BIT-1:0]		*/	.O_IBUF_NUM			(	w_ibuf_num			),
/*output    [`MEM_ADDR_BIT-1:0] 	*/	.O_OBUF_NUM   		(	w_obuf_num 			),
/*output	[`MEM_ADDR_BIT-1:0]		*/	.O_EXSW_NUM			(	w_exsw_num			),
/*output	[`MEM_ADDR_BIT-1:0]		*/	.O_SW_NUM	 		(	w_sw_num			),
/*output	[`MAX_OUT_SIZE_BIT-1:0] */	.O_OCNT				(	w_ocnt				),
/*output	[`MAX_IN_SIZE_BIT-1:0]	*/	.O_ICNT		 		(	w_icnt				),
/*output	[`MAX_OUT_SIZE_BIT-1:0]	*/	.O_DCNT				(	w_dcnt				), 
/*input     [`MAX_OUT_SIZE_BIT-1:0] */  .I_DBG_OCNT		    (   w_dbg_ocnt			),
/*input     [`MAX_IN_SIZE_BIT-1:0]  */  .I_DBG_ICNT		    (   w_dbg_icnt			),
/*input     [`MAX_OUT_SIZE_BIT-1:0] */  .I_DBG_DCNT		    (   w_dbg_dcnt			),
/*input     [`MEM_ADDR_BIT-1:0]     */  .I_DBG_IBCNT	    (   w_dbg_ibcnt			),
/*input                             */  .I_DBG_OCNT_UPDT    (   w_dbg_ocnt_updt		),
/*input                             */  .I_DBG_ICNT_UPDT    (   w_dbg_icnt_updt		),
/*input                             */  .I_DBG_DCNT_UPDT    (   w_dbg_dcnt_updt		),
/*input                             */  .I_DBG_IBCNT_UPDT   (   w_dbg_ibcnt_updt	),
/*input                             */	.I_DBG_OBUF_ACK     (   w_dbg_obuf_ack		),
/*input                             */	.I_DBG_EXSW_ACK     (   w_dbg_exsw_ack		),
/*output    [31:0]					*/	.O_HD_BYTE_BUF		(	w_hd_byte_buf   	),
/*output    [4:0]					*/	.O_HD_BYTE_OFFSET	(   w_hd_byte_offset    ),
/*input     [`MAX_IN_SIZE_BIT-1:0]  */  .I_ICNT_MAX		    (   w_icnt_max          ),
/*input     [`MAX_OUT_SIZE_BIT-1:0] */  .I_DCNT_MAX	        (   w_dcnt_max          ),
/*output                            */  .O_FILL_IBUF        (   w_fill_ibuf         ),
/*output                            */  .O_FLUSH_OBUF       (   w_flush_obuf        ),
/*output                            */  .O_UPDT_EXSW        (   w_updt_exsw         ),
/*input  						    */	.I_SPIF_PGM_MON		(	I_SPIF_PGM_MON      ),
/*input							    */	.I_WAIT_PGM			(	w_wait_pgm			),
/*output wire [3:0]				    */	.O_INFL_STAT_AUX	(	w_infl_stat_aux		),
/*input                             */	.I_LASTSB_FLUSH     (   w_lastsb_flush      ),
/*input                             */	.I_CHK_PGM		    (   w_chk_pgm			),
/*input                             */	.I_IBUF_INC_FZ		(   w_ibuf_inc_fz		),
/*input                             */	.I_OBUF_INC_FZ		(   w_obuf_inc_fz		),
/*output [8:0]						*/	.O_EXSW_MVBLK_SIZE	(   w_exsw_mvblk_size   ),
/*output [`MAX_OUT_SIZE_BIT-1:0]	*/	.O_EXSW_RET_ADDR	(   w_exsw_ret_addr	    )
);

//----------------------------------------------------------------------------
// Port Map : Register file
//----------------------------------------------------------------------------
ahb_inflate_slave u_ahb_inflate_slave (
/*input  wire                       */  .I_FCLK            (  FCLKG                   ),
/*input  wire                       */  .I_HCLK            (  w_hclk_cg               ),
/*input  wire                       */  .I_HRESETN         (  sig_rstb                ),
/*input  wire                       */  .I_HSELS           (  w_hsel_cfg              ),
/*input  wire  [ADDRWIDTH-1:0]      */  .I_HADDRS          (  S_HADDR[`ADDRWIDTH-1:0] ),
/*input  wire  [1:0]                */  .I_HTRANSS         (  S_HTRANS                ),
/*input  wire  [2:0]                */  .I_HSIZES          (  S_HSIZE                 ),
/*input  wire                       */  .I_HWRITES         (  S_HWRITE                ),
/*input  wire                       */  .I_HREADYS         (  S_HREADYIN              ),
/*input  wire  [31:0]               */  .I_HWDATAS         (  S_HWDATA                ),
/*output wire                       */  .O_HREADYOUTS      (                          ),
/*output wire                       */  .O_HRESPS          (                          ),
/*output wire  [31:0]               */  .O_HRDATAS         (  w_hrdata_cfg            ),
/*output wire                       */  .O_INFL_EN         (  w_infl_en               ),
/*output wire                       */  .O_INFL_BEN        (  w_infl_ben              ),
/*output wire                       */  .O_IBUF_FLASH      (  w_ibuf_flash            ),
/*output wire                       */  .O_OBUF_FLASH      (  w_obuf_flash	          ),
/*output wire                       */  .O_EXSW_FLASH      (  w_exsw_flash	          ),
/*output wire  [`MEM_ADDR_BIT-1:0]  */  .O_LL_BASE         (  w_ll_base               ),
/*output wire  [`MEM_ADDR_BIT-1:0]  */  .O_DIST_BASE       (  w_dist_base             ),
/*output wire  [3:0]                */  .O_LL_MAX_BIT      (  w_ll_max_bit            ), 
/*output wire  [3:0]                */  .O_LL_SC_BIT       (  w_ll_sc_bit             ),  
/*output wire  [3:0]                */  .O_DIST_MAX_BIT    (  w_dist_max_bit          ), 
/*output wire  [3:0]                */  .O_DIST_SC_BIT     (  w_dist_sc_bit           ), 
/*output wire  [3:0]                */  .O_HDT_FMT 		   (  w_hdt_fmt		          ), 
/*output wire  [31:0]               */  .O_INFL_MBASE      (  w_infl_mbase            ), 
/*output wire  [31:0]               */  .O_INFL_IBASE      (  w_infl_ibase            ), 
/*output wire  [31:0]               */  .O_INFL_OBASE      (  w_infl_obase            ), 
/*output wire  [3:0]                */  .O_INIT_RSHIFT     (  w_init_rshift           ),  
/*output wire  [`MVBLK_SIZE_BIT-1:0]*/  .O_IBUF_MVBLK_SIZE (  w_ibuf_mvblk_size       ),
/*output wire  [`MEM_ADDR_BIT-1:0]  */  .O_IBUF_MIN_SIZE   (  w_ibuf_min_size         ),
/*output wire  [`MEM_ADDR_BIT-1:0]  */  .O_IBUF_SADDR      (  w_ibuf_saddr            ),
/*output wire  [`MEM_ADDR_BIT-1:0]  */  .O_IBUF_EADDR      (  w_ibuf_eaddr            ),
/*output wire  [`MEM_ADDR_BIT-1:0]  */  .O_IBUF_CADDRL     (  w_ibuf_caddrl           ),
/*output wire  [`MEM_ADDR_BIT-1:0]  */  .O_IBUF_CADDRH     (  w_ibuf_caddrh           ),
/*input  wire  [`MEM_ADDR_BIT-1:0]  */  .I_IBUF_CPTR       (  w_ibuf_cptr             ),
/*input  wire  [`MEM_ADDR_BIT-1:0]  */  .I_IBUF_EPTR       (  w_ibuf_eptr             ),
/*output wire  [`MVBLK_SIZE_BIT-1:0]*/  .O_OBUF_MVBLK_SIZE (  w_obuf_mvblk_size       ),
/*output wire  [`MEM_ADDR_BIT-1:0]  */  .O_OBUF_MAX_SIZE   (  w_obuf_max_size         ),
/*output wire  [`MEM_ADDR_BIT-1:0]  */  .O_OBUF_CADDR	   (  w_obuf_caddr            ),
/*input  wire  [`MEM_ADDR_BIT-1:0]  */  .I_OBUF_CPTR       (  w_obuf_cptr             ),
/*input  wire  [`MEM_ADDR_BIT-1:0]  */  .I_OBUF_EPTR       (  w_obuf_eptr             ),
/*output wire  [`MEM_ADDR_BIT-1:0]  */  .O_SW_SADDR        (  w_sw_saddr              ),
/*output wire  [`MEM_ADDR_BIT-1:0]  */  .O_SW_EADDR        (  w_sw_eaddr              ),
/*output wire  [`MEM_ADDR_BIT-1:0]  */  .O_SW_CADDR        (  w_sw_caddr              ),
/*input  wire  [`MEM_ADDR_BIT-1:0]  */  .I_SW_CPTR         (  w_sw_cptr               ),
/*input  wire  [`MEM_ADDR_BIT-1:0]  */  .I_SW_EPTR         (  w_sw_eptr               ),
/*output wire  [`MEM_ADDR_BIT-1:0]  */  .O_EXSW_SADDR      (  w_exsw_saddr            ),
/*output wire  [`MEM_ADDR_BIT-1:0]  */  .O_EXSW_EADDR      (  w_exsw_eaddr            ),
/*output wire  [3:0]                */  .O_INFL_STOP_REQ   (  w_infl_stop_req         ),
/*input  wire                       */  .I_INFL_INTR_REQ   (  w_infl_intr_req         ),
/*output wire                       */  .O_INFL_INTR       (  O_INFL_INTR             ),
/*input  wire  [`STATUS_BIT-1:0]    */  .I_INFL_STAT       (  w_infl_stat             ),
/*input		   [`MEM_ADDR_BIT-1:0]	*/	.I_IBUF_NUM		   (  w_ibuf_num			  ),
/*input        [`MEM_ADDR_BIT-1:0]  */ 	.I_OBUF_NUM   	   (  w_obuf_num 		      ),
/*input		   [`MEM_ADDR_BIT-1:0]	*/	.I_EXSW_NUM		   (  w_exsw_num			  ),
/*input		   [`MEM_ADDR_BIT-1:0]	*/	.I_SW_NUM	 	   (  w_sw_num			      ),
/*input		   [`MEM_ADDR_BIT-1:0]	*/	.I_OCNT			   (  w_ocnt				  ),
/*input		   [`MEM_ADDR_BIT-1:0]	*/	.I_ICNT		 	   (  w_icnt				  ),
/*input		   [`MAX_OUT_SIZE_BIT-1:0]*/.I_DCNT			   (  w_dcnt				  ),
/*output       [`MAX_OUT_SIZE_BIT-1:0]*/.O_DBG_OCNT		   (  w_dbg_ocnt			  ),
/*output       [`MAX_IN_SIZE_BIT-1:0] */.O_DBG_ICNT		   (  w_dbg_icnt			  ),
/*output       [`MAX_OUT_SIZE_BIT-1:0]*/.O_DBG_DCNT		   (  w_dbg_dcnt			  ),
/*output       [`MEM_ADDR_BIT-1:0]    */.O_DBG_IBCNT	   (  w_dbg_ibcnt			  ),
/*output                              */.O_DBG_OCNT_UPDT   (  w_dbg_ocnt_updt		  ),
/*output                              */.O_DBG_ICNT_UPDT   (  w_dbg_icnt_updt		  ),
/*output                              */.O_DBG_DCNT_UPDT   (  w_dbg_dcnt_updt		  ),
/*output                              */.O_DBG_IBCNT_UPDT  (  w_dbg_ibcnt_updt		  ),
/*output                              */.O_DBG_OBUF_ACK    (  w_dbg_obuf_ack		  ),
/*output                              */.O_DBG_EXSW_ACK    (  w_dbg_exsw_ack		  ),
/*input        [31:0]				  */.I_HD_BYTE_BUF	   (  w_hd_byte_buf           ),
/*input        [4:0]				  */.I_HD_BYTE_OFFSET  (  w_hd_byte_offset	      ),
/*output       [`MAX_IN_SIZE_BIT-1:0]*/ .O_ICNT_MAX		   (  w_icnt_max              ),
/*output       [`MAX_OUT_SIZE_BIT-1:0]*/.O_DCNT_MAX	       (  w_dcnt_max              ),
/*input                               */.I_FILL_IBUF       (  w_fill_ibuf             ),
/*input                               */.I_FLUSH_OBUF      (  w_flush_obuf            ),
/*input                               */.I_UPDT_EXSW       (  w_updt_exsw             ),
/*output						   	  */.O_WAIT_PGM		   (  w_wait_pgm			  ),
/*input        [3:0]			   	  */.I_INFL_STAT_AUX   (  w_infl_stat_aux		  ),
/*output			                  */.O_LASTSB_FLUSH    (  w_lastsb_flush          ),
/*output			                  */.O_MWAIT_AHBS	   (  w_mwait_ahbs	          ),
/*output			                  */.O_CHK_PGM		   (  w_chk_pgm		          ),
/*output			                  */.O_IBUF_INC_FZ     (  w_ibuf_inc_fz	          ),
/*output			                  */.O_OBUF_INC_FZ     (  w_obuf_inc_fz	          ),
/*input		  [8:0]					  */.I_EXSW_MVBLK_SIZE (  w_exsw_mvblk_size	      ),
/*input		  [`MAX_OUT_SIZE_BIT-1:0] */.I_EXSW_RET_ADDR   (  w_exsw_ret_addr	      )	
);
endmodule
