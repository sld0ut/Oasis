////////////////////////////////////////////////////////
//
//  Module: OASIS_CHIP
//  Project: OASIS
//  Description: 
// 
//  Change history: 
//
////////////////////////////////////////////////////////
`timescale 1ns/10ps

module OASIS_CHIP (
`ifdef	FPGA
	(* X_INTERFACE_INFO = "XIL_INTERFACENAME ps_ahbs_hclk, ASSOCIATED_BUSIF PS_AHBS, ASSOCIATED_RESET P_GPIO_25 FREQ_HZ 20000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *)
	(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 P_OSC_H CLK" *)
	input  wire				P_OSC_H					,
	input  wire				P_OSC_L					,
	(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME PS_AHBS, FREQ_HZ 20000000" *)
	(* X_INTERFACE_INFO = "xilinx.com:interface:ahblite:2.0 PS_AHBS HPROT" *)
	input  wire [3:0]    	PS_AHBS_HPROT			,
	(* X_INTERFACE_INFO = "xilinx.com:interface:ahblite:2.0 PS_AHBS HMASTLOCK" *)
	input  wire  		   	PS_AHBS_HMSTLOCK		,
	(* X_INTERFACE_INFO = "xilinx.com:interface:ahblite:2.0 PS_AHBS HADDR" *)
	input  wire [31:0]		PS_AHBS_HADDR			,
	(* X_INTERFACE_INFO = "xilinx.com:interface:ahblite:2.0 PS_AHBS HTRANS" *)
	input  wire [ 1:0]		PS_AHBS_HTRANS			,
	(* X_INTERFACE_INFO = "xilinx.com:interface:ahblite:2.0 PS_AHBS HBURST" *)
	input  wire [2:0]    	PS_AHBS_HBURST			,
	(* X_INTERFACE_INFO = "xilinx.com:interface:ahblite:2.0 PS_AHBS HWRITE" *)
	input  wire       		PS_AHBS_HWRITE			,
	(* X_INTERFACE_INFO = "xilinx.com:interface:ahblite:2.0 PS_AHBS HSIZE" *)
	input  wire [ 2:0]		PS_AHBS_HSIZE			,
	(* X_INTERFACE_INFO = "xilinx.com:interface:ahblite:2.0 PS_AHBS HWDATA" *)
	input  wire [31:0]		PS_AHBS_HWDATA			,
	(* X_INTERFACE_INFO = "xilinx.com:interface:ahblite:2.0 PS_AHBS HRDATA" *)
	output wire [31:0]		PS_AHBS_HRDATA			,
	(* X_INTERFACE_INFO = "xilinx.com:interface:ahblite:2.0 PS_AHBS HRESP" *)
	output wire [ 1:0]		PS_AHBS_HRESP			,
	(* X_INTERFACE_INFO = "xilinx.com:interface:ahblite:2.0 PS_AHBS HREADY" *)
	output wire             PS_AHBS_HREADY			,
	output wire				O_MCLK					,
	output wire				O_MCUP_BSTA				,
	output wire				BGRIP_ROOT_CLK			,
	input  wire             FCLK_CLK1               ,

	output wire         	BBM_XO_EN       		,
	output wire         	BBM_CH_EN       		,
	output wire         	BBM_RX_EN       		,
	output wire         	BBM_TX_EN       		,
	output wire         	BBM_SPI_CS      		,
	output wire         	BBM_SPI_CK      		,
	output wire         	BBM_SPI_DW      		,
	input  wire         	BBM_SPI_DR      		,
	output wire         	BBM_SCP_CS      		,
	input  wire         	BBM_SCP_DR      		,
	output wire         	BBM_TXD_LLC     		,
	output wire         	BBM_Z2C_STB     		,
	output wire [ 3:0]		BBM_Z2C_DAT  			,
	input  wire         	BBM_C2Z_STB     		,
	input  wire [ 3:0]		BBM_C2Z_DAT  			,
`endif
`ifdef	RTL
	//eFuse
	`ifndef	TSMC55_ULP
		inout wire	VQPS		,
	`else
		inout wire	VDDQ		,
	`endif
`endif
//
	input wire	P_TEST_EN	,
	input wire	P_ROM_EN	,
	input wire	P_DBG_EN	,
	//GPIO
	inout wire	P_GPIO_00	,
	inout wire	P_GPIO_01	,
	inout wire	P_GPIO_02	,
	inout wire	P_GPIO_03	,
	inout wire	P_GPIO_04	,
	inout wire	P_GPIO_05	,
	inout wire	P_GPIO_06	,//
	inout wire	P_GPIO_07	,//
	inout wire	P_GPIO_08	,//
	inout wire	P_GPIO_09	,//
	inout wire	P_GPIO_10	,//
	inout wire	P_GPIO_11	,//
	inout wire	P_GPIO_12	,
	inout wire	P_GPIO_13	,
	inout wire	P_GPIO_14	,
	inout wire	P_GPIO_15	,
	inout wire	P_GPIO_16	,
	inout wire	P_GPIO_17	,
	inout wire	P_GPIO_18	,
	inout wire	P_GPIO_19	,
	inout wire	P_GPIO_20	,
	inout wire	P_GPIO_21	,
	inout wire	P_GPIO_22	,
	inout wire	P_GPIO_23	,
	inout wire	P_GPIO_24	,
`ifdef FPGA
	(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ps_ahbs_hresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
	(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 P_GPIO_25 RST" *)
`endif
	inout wire	P_GPIO_25	,
	inout wire	P_GPIO_26	,
	inout wire	P_GPIO_27	,
	inout wire	P_GPIO_28	,
	inout wire	P_GPIO_29	,
	inout wire	P_GPIO_30	,
	inout wire	P_GPIO_31	,
	inout wire	P_GPIO_32	,
	inout wire	P_GPIO_33	,
	inout wire	P_GPIO_34	,
	inout wire	P_GPIO_35		
);
`ifdef	PG_PIN
wire  VDD_0p90 			;
wire  VDD_SRAM_PERI_0	;
wire  VDD_SRAM_PERI_1	;
wire  VDD_SRAM_PERI_2	;
wire  VDD_SRAM_PERI_3	;
wire  VDD_SRAM_CORE_0	;
wire  VDD_SRAM_CORE_1	;
wire  VDD_SRAM_CORE_2	;
wire  VDD_SRAM_CORE_3	;
wire  VDD_0p81 			;
wire  VDDQ 				;
wire  VSS 				;
`endif
// Analog Interface
//wire				w_DIG_PORB		;
//wire				w_OSC_H			;
wire				w_OSC_H2_IN		= 1'b0;
// PAD Interface
parameter	GP_N	= 48;

wire				w_TEST_EN_C			;
wire				w_ROM_EN_C			;
wire				w_DBG_EN_C			;

wire [35:0]			w_GPIO_OE			;
wire [35:0]			w_GPIO_I			;
wire [35:0]			w_GPIO_DS 			;
wire [35:0]			w_GPIO_IE			;
wire [35:0]			w_GPIO_PE 			;
wire [35:0]			w_GPIO_PS 			;
wire [35:0]			w_GPIO_C			;

//Analog Pins                           
parameter	N = 6;                      
                                        
wire				w_AON_RSTB			;
wire				w_RTC_CLKT			;	//32KHz
wire				w_RTC_CLKB			;	//32KHz Inversion
wire				w_RFC_CLKT			;	//32MHz
wire				w_RFC_CLKB			;	//32MHz Inversion
wire				w_PLL_SDM_CLKT		;
wire				w_PLL_SDM_CLKB		;

// PLL
wire				w_PLL_PEN			;
wire				w_PLL_COARSELOCK	;
wire				w_PLL_OUT_PEN		;
wire				w_PLL_DIV2_OUT_PEN	;
//wire	[1:0]		w_PLL_CP_BCONT		;
wire 				w_PLL_CP_UGB_EN      	;	
wire [2:0]			w_PLL_CP_UGB_CONT    	;
wire [2:0]			w_PLL_CP_LEAK_EN     	;
wire 				w_PLL_CP_LEAK_COMP_EN	;
wire [2:0]			w_PLL_PFD_DELAY      	;
wire [2:0]			w_PLL_CP_CELL_EN	;
//wire	[4:0]		w_PLL_CP_LEAK_COMP	;
wire	[9:0]		w_PLL_VCO_CAP		;
wire	[7:0]		w_PLL_PM_CAP		;
wire	[4:0]		w_PLL_PC			;
wire	[1:0]		w_PLL_SC			;
wire				w_PLL_CNT_MASK		;
wire				w_PLL_CT_RST		;
wire	[2:0]		w_PLL_CT_VC_CONT	;
wire	[2:0]		w_PLL_KVCO_VB1		;
wire	[2:0]		w_PLL_KVCO_VB2		;
wire 	[12:0]		w_PLL_CT_CNT		;
// PMU
wire	[4:0]		w_PWR_SRAM_PERI_DIG	;
wire	[4:0]		w_PWR_SRAM_CORE_DIG	;
wire	[4:0]		w_PWR_SRAM_CORE_RET	;
wire	[3:0]		w_ABGR_CONT			;
wire	[3:0]		w_ABGR_TC			;
wire	[5:0]		w_ALDO_CONT			;
wire				w_ALDO_EN			;
wire				w_ALDO_EN_SEL		;
wire				w_RTC_EN			;
wire				w_RTC_EN_SEL		;
wire	[10:0]		w_RTC_SCKF			;
wire				w_FLDO_PEN			;
wire				w_FLDO_LP_EN		;
wire	[3:0]		w_FLDO_CONT			;
wire				w_FLDO_BYPASS		;
wire				w_FLDO_POK_EN		;
wire				w_FLDO_POK			;
wire				w_MLDO_PEN			;
wire				w_MLDO_LP_EN		;
wire	[5:0]		w_MLDO_CONT			;
wire				w_MLDO_POK_EN		;
wire				w_MLDO_POK			;
wire				w_DCDC_PRECHG_PEN	;
wire				w_DCDC_CORE_PEN		;
wire				w_DCDC_REF_PEN		;
//wire				w_DCDC_CLK_SRC		;
//wire				w_DCDC_CLKT			;
//wire				w_DCDC_CLKB			;
wire				w_DCDC_MODE			;
//wire	[5:0]		w_DCDC_SAW_CC		;
//wire	[2:0]		w_DCDC_EA_CFB		;
//wire	[2:0]		w_DCDC_EA_RFB		;
//wire	[2:0]		w_DCDC_EA_RIN		;
//wire	[2:0]		w_DCDC_EA_CIN		;
//wire	[1:0]		w_DCDC_EA_BIAS		;
wire	[5:0]		w_DCDC_SET_VOUT		;
//wire	[1:0]		w_DCDC_VREF_TRIM	;
wire	[2:0]		w_DCDC_CUR_TRIM		;
wire	[1:0]		w_FLDO_POK_TRIM		;
wire	[1:0]		w_MLDO_POK_TRIM		;
wire	[3:0]		w_DCDC_DT_TRIM		;
//wire				w_DCDC_TU_EN		;
//wire				w_DCDC_EXT_MODE		;
wire				w_DCDC_POK_EN		;
//wire [2:0]		w_DCDC_EA_CFB_OUT	;
//wire [1:0]		w_DCDC_EXT_OUT		;
//wire				w_EXT_REF_MODE		;
wire				w_RET_LDO_EN		;	// r2
wire [3:0]			w_RET_LDO_CONT		;	// r2
wire				w_BOD_EN			;	// r2
wire				w_DA_LDO_EN			;	// r2
wire				w_DA_LDO_BYPASS		;	// r2
wire [5:0]			w_DA_LDO_CONT		;	// r2
wire [3:0]			w_DCDC_CLIMIT_RTRIMB;	// r2
wire [3:0]			w_DCDC_ISENS_RTRIM	;
wire [2:0]			w_DCDC_ZCD_CTRIM	;
wire [2:0]			w_EXT_PFM_VREF		;
wire [3:0]			w_DCDC_PRECHG_DUR	;
wire [3:0]			w_DCDC_POK_TRIM		;
wire [3:0]			w_MBGR_TC_TRIM		;	//r2
wire [5:0]			w_MBGR_OUT_TRIM		;	//r2
wire 				w_MBGR_EN			;	//r2
//wire 				w_DA_LDO_BMUX		;	//r2
wire 				w_GPADC_BMUX		;	//r2	
wire [1:0]			w_BOD_VREFH			;	//r3
wire [1:0]			w_BOD_VREFL			;	//r3
wire [1:0]			w_DA_LDO_TAIL_CONT	;	//r3
wire 				w_BOD_RSTB			;	//r2
wire				w_DCDC_POK			;
// RFRX
wire				w_TRX_SEL			;
wire				w_RX_RF_PEN			;
wire				w_MIX_BUF_PEN		;
wire	[1:0]		w_RX_RF_GC			;
wire	[2:0]		w_LNTA_BIAS			;
wire	[2:0]		w_LNTA_BIAS2		;
wire	[2:0]		w_MIX_I_BIAS		;
wire	[2:0]		w_MIX_IB_BIAS		;
wire	[2:0]		w_MIX_Q_BIAS		;
wire	[2:0]		w_MIX_QB_BIAS		;
// RFTX
wire				w_TX_BUF_PEN		;
wire				w_TX_PRE_PEN		;
wire				w_TX_DA_PEN			;
wire	[3:0]		w_TX_DA_GC			;
// ABB
wire				w_ABB_PEN			;
wire				w_ABB_BIAS_STUP		; //r2
wire	[2:0]		w_ABB_BIAS1			;
wire	[2:0]		w_ABB_BIAS2			;
wire	[2:0]		w_ABB_VCOM			;
wire	[4:0]		w_ABB_IFC_CC		;
wire	[2:0]		w_ABB_TIA_GC		;
wire				w_ABB_TIA_RCF_EN	;
wire				w_ABB_TIA_CFB_EN	;
wire	[4:0]		w_ABB_TIA_CC		;
wire	[3:0]		w_ABB_TIA_STB		;
wire				w_ABB_TIA_MIR		;
wire	[1:0]		w_ABB_FLT_GC		;
wire	[4:0]		w_ABB_FLT_CC		;
wire	[4:0]		w_ABB_FLT_ZC		;
wire				w_ABB_FLT_SKIP		;
wire				w_ABB_FLT_WB		;
wire	[4:0]		w_ABB_FLT_IF		;
//wire				w_ABB_ACC_SWAP_EN	; //r2
//wire				w_ABB_ACC_SWAP		; //r2
wire	[2:0]		w_ABB_ACC_BW		;
wire				w_ABB_ACC_SKIP		;
wire	[4:0]		w_ABB_PGA_GC		;
wire	[1:0]		w_ABB_PGA_CFB		;
wire	[2:0]		w_ABB_DRV_OMODE		;
wire				w_ABB_DRV_STB_CC	;
wire	[3:0]		w_ABB_DRV_TPE		;
wire				w_ABB_DRV_TP_SWAP	;
wire				w_ABB_TEST_ENI		;
wire				w_ABB_TEST_ENQ		;
wire				w_GPIO01_AN_EN		;
wire				w_GPIO23_AN_EN		;
wire				w_AN_TEST_EN		;
wire				w_GPIO4_AN_EN		;
wire	[2:0]		w_AN_TEST_MUX		;
wire				w_GPIO_TEST_BUF_EN	;
wire				w_GPIO_TEST_CUR_EN	;
// FT	
wire				w_FT_PEN			;
wire				w_FT_RST			;
wire				w_FT_CLK			;
wire				w_FT_BIAS_STUP		; //r2
wire	[4:0]		w_FT_CC				;
wire				w_FT_DONE			;
// ADC
wire				w_ADC_PEN			;
wire				w_ADC_CLKT			;
wire				w_ADC_CLKB			;
wire	[2:0]		w_ADC_FS			;
wire				w_ADC_ICONV_RDY		;
wire	[7:0]		w_ADC_IDATA			;
wire				w_ADC_QCONV_RDY		;
wire	[7:0]		w_ADC_QDATA			;
wire				w_ADC_CONV_RDY_MODE	;
// GPADC
wire				w_GPADC_PEN			;
wire	[3:0]		w_GPADC_MUXSEL		;
//wire				w_GPADC_ATT_EN		; r2 del
wire				w_GPADC_BUF_EN		;
wire				w_GPADC_AMP_CHOP_EN	;
wire				w_GPADC_CLKT		;
wire				w_GPADC_CLKB		;
wire				w_GPADC_FILT_EN		;
wire				w_GPADC_CSTATE		;
wire	[2:0]		w_GPADC_INBUF_BIAS	;
wire	[2:0]		w_GPADC_AMP1_BIAS	;
wire	[2:0]		w_GPADC_AMP2_BIAS	;
wire	[2:0]		w_GPADC_BGR_BIAS	;
wire	[2:0]		w_GPADC_VCM_BIAS	;
wire	[2:0]		w_GPADC_VCM_CONT	;
wire	[1:0]		w_GPADC_VREFP_CONT	;
wire	[1:0]		w_GPADC_VREFN_CONT	;
wire				w_GPADC_RSTGEN_CLK	;
wire				w_GPADC_DSMRST		;
wire	[1:0]		w_GPADC_DOUT		;
wire				w_GPADC_DCLK		;
wire	[1:0]		w_GPADC_AMP1_VB		;
wire	[1:0]		w_GPADC_AMP2_VB		;
wire				w_GPADC_ATT_BYP_EN	;
wire				w_GPADC_ATT_VSEL	;
// TS
wire				w_TS_PEN			;
wire	[3:0]		w_TS_DEM_CLK		;
wire				w_TS_CHOP_CLK		;
wire	[1:0]		w_TS_CAL			;
wire				w_TS_SEL			;
wire				w_TS_CHOP_ON		;
wire				w_TS_DEM_ON			;
wire	[3:0]		w_TS_TRIM			;
// XO
wire				w_XO_PEN			;
wire				w_XO_MODE			;
wire	[5:0]		w_XO_CS				;
wire	[5:0]		w_XO_CL				;
wire				w_XO_PLL_CLK_EN		;
wire				w_XO_RFC_CLK_EN		;
//PHASE TRACKING RX
//wire				w_PTRX_EN			;	//R2 
// Phase
//wire				w_LO_PH_SHIFT_EN	;	//R2 del
//wire				w_LO_PH_SHIFT		;	//R2 del
//wire				w_LO_PH_I			;	//R2 del
//wire				w_LO_PH_Q			;	//R2 del
//wire				w_LO_PH_IB			;	//R2 del
//wire				w_LO_PH_QB			;	//R2 del
// ETC
wire	[23:0]		w_SPI_RSV_CORE		;
wire	[7:0]		w_SPI_RSV_AON		;
wire [15:0]			w_DEVICE_ID			;
// MASK_SPIM
wire				w_NFC_TEST_OUT		;
wire				w_NFC_WAKEUP		;
wire				w_NFC_EN			;
wire	[1:0]		w_NFC_TMUX_SEL		;
wire				w_NFC_WUR_THR_SEL	;
wire	[3:0]		w_NFC_WUR_THR		;
wire				w_NFC_VRECT_RDY_EXT	;
wire				w_NFC_VRECT_RDY_WUR ;	
wire [2:0]			w_NFC_SKP_PULSE		;
wire [6:0]			w_NFC_IF_THR		;
wire				w_NFC_CLK			;
wire				w_NFC_WRITE			;
wire [7:0]			w_NFC_WDATA			;

`ifdef	POST_SIM
OASIS_DIG u_OASIS_DIG (
`elsif	PRE_SIM
OASIS_DIG u_OASIS_DIG (
`else
OASIS_DIG  # (
	.GP_N	(GP_N	)
)u_OASIS_DIG (
`endif

`ifdef	PG_PIN
/*input		*/	.VDD_0p90 			(VDD_0p90 			),
/*input		*/	.VDD_SRAM_PERI_0	(VDD_SRAM_PERI_0	),
/*input		*/	.VDD_SRAM_PERI_1	(VDD_SRAM_PERI_1	),
/*input		*/	.VDD_SRAM_PERI_2	(VDD_SRAM_PERI_2	),
/*input		*/	.VDD_SRAM_PERI_3	(VDD_SRAM_PERI_3	),
/*input		*/	.VDD_SRAM_CORE_0	(VDD_SRAM_CORE_0	),
/*input		*/	.VDD_SRAM_CORE_1	(VDD_SRAM_CORE_1	),
/*input		*/	.VDD_SRAM_CORE_2	(VDD_SRAM_CORE_2	),
/*input		*/	.VDD_SRAM_CORE_3	(VDD_SRAM_CORE_3	),
/*input		*/	.VDD_0p81 			(VDD_0p81 			),
/*input		*/	.VDDQ 				(VDDQ 				),
/*input		*/	.VSS 				(VSS 				),
`endif

`ifdef FPGA
/*input  wire [3:0] 	*/  .PS_AHBS_HPROT			(PS_AHBS_HPROT		),
/*input  wire  			*/	.PS_AHBS_HMSTLOCK		(PS_AHBS_HMSTLOCK	),
/*input  wire [31:0]	*/	.PS_AHBS_HADDR			(PS_AHBS_HADDR		),
/*input  wire [ 1:0]	*/	.PS_AHBS_HTRANS			(PS_AHBS_HTRANS		),
/*input  wire [2:0] 	*/  .PS_AHBS_HBURST			(PS_AHBS_HBURST		),
/*input  wire       	*/	.PS_AHBS_HWRITE			(PS_AHBS_HWRITE		),
/*input  wire [ 2:0]	*/	.PS_AHBS_HSIZE			(PS_AHBS_HSIZE		),
/*input  wire [31:0]	*/	.PS_AHBS_HWDATA			(PS_AHBS_HWDATA		),
/*output wire [31:0]	*/	.PS_AHBS_HRDATA			(PS_AHBS_HRDATA		),
/*output wire [ 1:0]	*/	.PS_AHBS_HRESP			(PS_AHBS_HRESP		),
/*output wire       	*/  .PS_AHBS_HREADY			(PS_AHBS_HREADY		),
/*output wire       	*/  .O_MCLK					(O_MCLK				),
/*output wire			*/	.BGRIP_ROOT_CLK			(BGRIP_ROOT_CLK		),

/*output wire       	*/	.BBM_XO_EN   			(BBM_XO_EN   		),
/*output wire       	*/	.BBM_CH_EN   			(BBM_CH_EN   		),
/*output wire       	*/	.BBM_RX_EN   			(BBM_RX_EN   		),
/*output wire       	*/	.BBM_TX_EN   			(BBM_TX_EN   		),
/*output wire       	*/	.BBM_SPI_CS  			(BBM_SPI_CS  		),
/*output wire       	*/	.BBM_SPI_CK  			(BBM_SPI_CK  		),
/*output wire       	*/	.BBM_SPI_DW  			(BBM_SPI_DW  		),
/*input  wire       	*/	.BBM_SPI_DR  			(BBM_SPI_DR  		),
/*output wire       	*/	.BBM_SCP_CS  			(BBM_SCP_CS  		),
/*input  wire       	*/	.BBM_SCP_DR  			(BBM_SCP_DR  		),
/*output wire       	*/	.BBM_TXD_LLC 			(BBM_TXD_LLC 		),
/*output wire       	*/	.BBM_Z2C_STB 			(BBM_Z2C_STB 		),
/*output wire [ 3:0]	*/	.BBM_Z2C_DAT 			(BBM_Z2C_DAT 		),
/*input  wire       	*/	.BBM_C2Z_STB 			(BBM_C2Z_STB 		),
/*input  wire [ 3:0]	*/	.BBM_C2Z_DAT 			(BBM_C2Z_DAT 		),
`endif

//eFuse
`ifdef	RTL
	`ifndef TSMC55_ULP
	/*inout wire			*/	.VQPS				(VQPS				),
	`else
	/*inout wire			*/	.VDDQ				(VDDQ				),
	`endif
`endif 
// Analog Interface                                                     
/*input wire			*/	.I_AON_RSTB			    (w_AON_RSTB				),
/*input wire			*/	.I_RTC_CLKT			    (w_RTC_CLKT				),
/*input wire			*/	.I_RTC_CLKB			    (w_RTC_CLKB				),
/*input wire			*/	.I_RFC_CLKT			    (w_RFC_CLKT				),
/*input wire			*/	.I_RFC_CLKB			    (w_RFC_CLKB				),
/*input wire			*/	.I_PLL_SDM_CLKT			(w_PLL_SDM_CLKT			),	
/*input wire			*/	.I_PLL_SDM_CLKB			(w_PLL_SDM_CLKB			),	
// PLL                                                                  
/*output wire			*/	.O_PLL_PEN			    (w_PLL_PEN				),
/*output wire			*/	.O_PLL_COARSELOCK	    (w_PLL_COARSELOCK		),
/*output wire			*/	.O_PLL_OUT_PEN		    (w_PLL_OUT_PEN			),
/*output wire			*/	.O_PLL_DIV2_OUT_PEN	    (w_PLL_DIV2_OUT_PEN		),
///*output wire	[1:0]	*/	.O_PLL_CP_BCONT		    (w_PLL_CP_BCONT			),
/*output wire 			*/	.O_PLL_CP_UGB_EN      	(w_PLL_CP_UGB_EN      	),	
/*output wire [2:0]		*/	.O_PLL_CP_UGB_CONT    	(w_PLL_CP_UGB_CONT    	),
/*output wire [2:0]		*/	.O_PLL_CP_LEAK_EN     	(w_PLL_CP_LEAK_EN     	),
/*output wire 			*/	.O_PLL_CP_LEAK_COMP_EN	(w_PLL_CP_LEAK_COMP_EN	),
/*output wire [2:0]		*/	.O_PLL_PFD_DELAY      	(w_PLL_PFD_DELAY      	),
/*output wire [2:0]		*/	.O_PLL_CP_CELL_EN	    (w_PLL_CP_CELL_EN		),
///*output wire [4:0]		*/	.O_PLL_CP_LEAK_COMP	    (w_PLL_CP_LEAK_COMP		),
/*output wire [9:0]		*/	.O_PLL_VCO_CAP		    (w_PLL_VCO_CAP			),
/*output wire [7:0]		*/	.O_PLL_PM_CAP		    (w_PLL_PM_CAP			),
/*output wire	[4:0]	*/	.O_PLL_PC			    (w_PLL_PC				),
/*output wire	[1:0]	*/	.O_PLL_SC			    (w_PLL_SC				),
/*output wire			*/	.O_PLL_CNT_MASK		    (w_PLL_CNT_MASK			),
/*output wire			*/	.O_PLL_CT_RST		    (w_PLL_CT_RST			),
/*output wire	[2:0]	*/	.O_PLL_CT_VC_CONT	    (w_PLL_CT_VC_CONT		),
/*output wire	[2:0]	*/	.O_PLL_KVCO_VB1		    (w_PLL_KVCO_VB1			),
/*output wire	[2:0]	*/	.O_PLL_KVCO_VB2		    (w_PLL_KVCO_VB2			),
/*input wire 	[12:0]	*/	.I_PLL_CT_CNT		    (w_PLL_CT_CNT			),
// PMU
/*output wire	[4:0]	*/	.O_PWR_SRAM_PERI_DIG	(w_PWR_SRAM_PERI_DIG	),
/*output wire	[4:0]	*/	.O_PWR_SRAM_CORE_DIG	(w_PWR_SRAM_CORE_DIG	),
/*output wire	[4:0]	*/	.O_PWR_SRAM_CORE_RET	(w_PWR_SRAM_CORE_RET	),
/*output wire	[3:0]	*/	.O_ABGR_CONT			(w_ABGR_CONT			),
/*output wire	[3:0]	*/	.O_ABGR_TC			    (w_ABGR_TC				),
/*output wire	[5:0]	*/	.O_ALDO_CONT		    (w_ALDO_CONT			),
/*output wire			*/	.O_ALDO_EN			    (w_ALDO_EN				),
/*output wire			*/	.O_ALDO_EN_SEL		    (w_ALDO_EN_SEL			),
/*output wire			*/	.O_RTC_EN			    (w_RTC_EN				),
/*output wire			*/	.O_RTC_EN_SEL		    (w_RTC_EN_SEL			),
/*output wire	[10:0]	*/	.O_RTC_SCKF			    (w_RTC_SCKF				),
/*output wire			*/	.O_FLDO_PEN			    (w_FLDO_PEN				),
/*output wire			*/	.O_FLDO_LP_EN		    (w_FLDO_LP_EN			),
/*output wire	[3:0]	*/	.O_FLDO_CONT		    (w_FLDO_CONT			),
/*output wire			*/	.O_FLDO_BYPASS		    (w_FLDO_BYPASS			),
/*output wire			*/	.O_FLDO_POK_EN		    (w_FLDO_POK_EN			),
/*input wire			*/	.I_FLDO_POK			    (w_FLDO_POK				),
/*output wire			*/	.O_MLDO_PEN			    (w_MLDO_PEN				),
/*output wire			*/	.O_MLDO_LP_EN		    (w_MLDO_LP_EN			),
/*output wire	[5:0]	*/	.O_MLDO_CONT		    (w_MLDO_CONT			),
/*output wire			*/	.O_MLDO_POK_EN		    (w_MLDO_POK_EN			),
/*input wire			*/	.I_MLDO_POK			    (w_MLDO_POK				),
/*output wire			*/	.O_DCDC_PRECHG_PEN	    (w_DCDC_PRECHG_PEN		),
/*output wire			*/	.O_DCDC_CORE_PEN	    (w_DCDC_CORE_PEN		),
/*output wire			*/	.O_DCDC_REF_PEN		    (w_DCDC_REF_PEN			),
///*output wire			*/	.O_DCDC_CLK_SRC		    (w_DCDC_CLK_SRC			),
///*output wire			*/	.O_DCDC_CLKT		    (w_DCDC_CLKT			),
///*output wire			*/	.O_DCDC_CLKB		    (w_DCDC_CLKB			),
/*output wire			*/	.O_DCDC_MODE		    (w_DCDC_MODE			),
///*output wire	[5:0]	*/	.O_DCDC_SAW_CC		    (w_DCDC_SAW_CC			),
///*output wire	[2:0]	*/	.O_DCDC_EA_CFB		    (w_DCDC_EA_CFB			),
///*output wire	[1:0]	*/	.O_DCDC_EA_RFB		    (w_DCDC_EA_RFB			),
///*output wire	[1:0]	*/	.O_DCDC_EA_RIN		    (w_DCDC_EA_RIN			),
///*output wire	[2:0]	*/	.O_DCDC_EA_CIN		    (w_DCDC_EA_CIN			),
///*output wire	[1:0]	*/	.O_DCDC_EA_BIAS		    (w_DCDC_EA_BIAS			),
/*output wire	[5:0]	*/	.O_DCDC_SET_VOUT	    (w_DCDC_SET_VOUT		),
///*output wire	[1:0]	*/	.O_DCDC_VREF_TRIM	    (w_DCDC_VREF_TRIM		),
/*output wire	[2:0]	*/	.O_DCDC_CUR_TRIM	    (w_DCDC_CUR_TRIM		),
/*output wire	[1:0]	*/	.O_FLDO_POK_TRIM	    (w_FLDO_POK_TRIM		),
/*output wire	[1:0]	*/	.O_MLDO_POK_TRIM	    (w_MLDO_POK_TRIM		),
/*output wire	[3:0]	*/	.O_DCDC_DT_TRIM		    (w_DCDC_DT_TRIM			),
///*output wire			*/	.O_DCDC_TU_EN		    (w_DCDC_TU_EN			),
///*output wire			*/	.O_DCDC_EXT_MODE	    (w_DCDC_EXT_MODE		),
/*output wire			*/	.O_DCDC_POK_EN		    (w_DCDC_POK_EN			),
///*output wire [2:0]	*/	.O_DCDC_EA_CFB_OUT		(w_DCDC_EA_CFB_OUT		),
///*output wire [1:0]	*/	.O_DCDC_EXT_OUT			(w_DCDC_EXT_OUT			),
///*output wire	   		*/	.O_EXT_REF_MODE			(w_EXT_REF_MODE			),
/*output wire			*/	.O_RET_LDO_EN			(w_RET_LDO_EN		 	),	// r2
/*output wire [3:0]		*/	.O_RET_LDO_CONT			(w_RET_LDO_CONT		 	),	// r2
/*output wire			*/	.O_BOD_EN				(w_BOD_EN			 	),	// r2
/*output wire			*/	.O_DA_LDO_EN			(w_DA_LDO_EN		 	),	// r2
/*output wire			*/	.O_DA_LDO_BYPASS		(w_DA_LDO_BYPASS		),	// r2
/*output wire [5:0]		*/	.O_DA_LDO_CONT			(w_DA_LDO_CONT		 	),	// r2
/*output wire [3:0]		*/	.O_DCDC_CLIMIT_RTRIMB	(w_DCDC_CLIMIT_RTRIMB	),	// r2
/*output wire [3:0]		*/	.O_DCDC_ISENS_RTRIM		(w_DCDC_ISENS_RTRIM		),
/*output wire [2:0]		*/	.O_DCDC_ZCD_CTRIM		(w_DCDC_ZCD_CTRIM		),
/*output wire [2:0]		*/	.O_EXT_PFM_VREF			(w_EXT_PFM_VREF			),
/*output wire [3:0]		*/	.O_DCDC_PRECHG_DUR		(w_DCDC_PRECHG_DUR		),
/*output wire [3:0]		*/	.O_DCDC_POK_TRIM		(w_DCDC_POK_TRIM		),
/*output wire [3:0]		*/	.O_MBGR_TC_TRIM			(w_MBGR_TC_TRIM			),	//r2
/*output wire [5:0]		*/	.O_MBGR_OUT_TRIM		(w_MBGR_OUT_TRIM		),	//r2
/*output wire 			*/	.O_MBGR_EN				(w_MBGR_EN				),	//r2
///*output wire 			*/	.O_DA_LDO_BMUX			(w_DA_LDO_BMUX			),	//r2
/*output wire 			*/	.O_GPADC_BMUX			(w_GPADC_BMUX			),	//r2	
/*output wire [1:0]		*/	.O_BOD_VREFH			(w_BOD_VREFH			),	//r3
/*output wire [1:0]		*/	.O_BOD_VREFL			(w_BOD_VREFL			),	//r3
/*output wire [1:0]		*/	.O_DA_LDO_TAIL_CONT		(w_DA_LDO_TAIL_CONT		),
/*input  wire 			*/	.I_BOD_RSTB				(w_BOD_RSTB				),	//r2
/*input wire			*/	.I_DCDC_POK			    (w_DCDC_POK				),
// RFRX                                             
/*output wire			*/	.O_TRX_SEL			    (w_TRX_SEL				),
/*output wire			*/	.O_RX_RF_PEN		    (w_RX_RF_PEN			),
/*output wire			*/	.O_MIX_BUF_PEN		    (w_MIX_BUF_PEN			),
/*output wire	[1:0]	*/	.O_RX_RF_GC			    (w_RX_RF_GC				),
/*output wire	[2:0]	*/	.O_LNTA_BIAS		    (w_LNTA_BIAS			),
/*output wire	[2:0]	*/	.O_LNTA_BIAS2		    (w_LNTA_BIAS2			),
/*output wire	[2:0]	*/	.O_MIX_I_BIAS		    (w_MIX_I_BIAS			),
/*output wire	[2:0]	*/	.O_MIX_IB_BIAS		    (w_MIX_IB_BIAS			),
/*output wire	[2:0]	*/	.O_MIX_Q_BIAS		    (w_MIX_Q_BIAS			),
/*output wire	[2:0]	*/	.O_MIX_QB_BIAS		    (w_MIX_QB_BIAS			),
// RFTX                                             
/*output wire			*/	.O_TX_BUF_PEN		    (w_TX_BUF_PEN			),
/*output wire			*/	.O_TX_PRE_PEN		    (w_TX_PRE_PEN			),
/*output wire			*/	.O_TX_DA_PEN		    (w_TX_DA_PEN			),
/*output wire	[3:0]	*/	.O_TX_DA_GC			    (w_TX_DA_GC				),
// ABB                                              
/*output wire			*/	.O_ABB_PEN			    (w_ABB_PEN				),
/*output wire			*/	.O_ABB_BIAS_STUP	    (w_ABB_BIAS_STUP		),
/*output wire	[2:0]	*/	.O_ABB_BIAS1		    (w_ABB_BIAS1			),
/*output wire	[2:0]	*/	.O_ABB_BIAS2		    (w_ABB_BIAS2			),
/*output wire	[2:0]	*/	.O_ABB_VCOM			    (w_ABB_VCOM				),
/*output wire	[4:0]	*/	.O_ABB_IFC_CC		    (w_ABB_IFC_CC			),
/*output wire	[2:0]	*/	.O_ABB_TIA_GC		    (w_ABB_TIA_GC			),
/*output wire			*/	.O_ABB_TIA_RCF_EN	    (w_ABB_TIA_RCF_EN		),
/*output wire			*/	.O_ABB_TIA_CFB_EN	    (w_ABB_TIA_CFB_EN		),
/*output wire	[4:0]	*/	.O_ABB_TIA_CC		    (w_ABB_TIA_CC			),
/*output wire	[3:0]	*/	.O_ABB_TIA_STB		    (w_ABB_TIA_STB			),
/*output wire			*/	.O_ABB_TIA_MIR		    (w_ABB_TIA_MIR			),
/*output wire	[1:0]	*/	.O_ABB_FLT_GC		    (w_ABB_FLT_GC			),
/*output wire	[4:0]	*/	.O_ABB_FLT_CC		    (w_ABB_FLT_CC			),
/*output wire	[4:0]	*/	.O_ABB_FLT_ZC		    (w_ABB_FLT_ZC			),
/*output wire			*/	.O_ABB_FLT_SKIP		    (w_ABB_FLT_SKIP			),
/*output wire			*/	.O_ABB_FLT_WB		    (w_ABB_FLT_WB			),
/*output wire	[4:0]	*/	.O_ABB_FLT_IF		    (w_ABB_FLT_IF			),
///*output wire			*/	.O_ABB_ACC_SWAP_EN	    (w_ABB_ACC_SWAP_EN		),
///*output wire			*/	.O_ABB_ACC_SWAP		    (w_ABB_ACC_SWAP			),
/*output wire	[2:0]	*/	.O_ABB_ACC_BW		    (w_ABB_ACC_BW			),
/*output wire			*/	.O_ABB_ACC_SKIP		    (w_ABB_ACC_SKIP			),
/*output wire	[4:0]	*/	.O_ABB_PGA_GC		    (w_ABB_PGA_GC			),
/*output wire	[1:0]	*/	.O_ABB_PGA_CFB		    (w_ABB_PGA_CFB			),
/*output wire	[2:0]	*/	.O_ABB_DRV_OMODE	    (w_ABB_DRV_OMODE		),
/*output wire			*/	.O_ABB_DRV_STB_CC	    (w_ABB_DRV_STB_CC		),
/*output wire	[3:0]	*/	.O_ABB_DRV_TPE		    (w_ABB_DRV_TPE			),
/*output wire			*/	.O_ABB_DRV_TP_SWAP	    (w_ABB_DRV_TP_SWAP		),
/*output wire			*/	.O_ABB_TEST_ENI		    (w_ABB_TEST_ENI			),
/*output wire			*/	.O_ABB_TEST_ENQ		    (w_ABB_TEST_ENQ			),
/*output wire			*/	.O_GPIO01_AN_EN		    (w_GPIO01_AN_EN			),
/*output wire			*/	.O_GPIO23_AN_EN		    (w_GPIO23_AN_EN			),
/*output wire			*/	.O_AN_TEST_EN		    (w_AN_TEST_EN			),
/*output wire			*/	.O_GPIO4_AN_EN		    (w_GPIO4_AN_EN			),
/*output wire	[2:0]	*/	.O_AN_TEST_MUX		    (w_AN_TEST_MUX			),
/*output wire			*/	.O_GPIO_TEST_BUF_EN		(w_GPIO_TEST_BUF_EN		),
/*output wire			*/	.O_GPIO_TEST_CUR_EN		(w_GPIO_TEST_CUR_EN		),
// FT	                                            
/*output wire			*/	.O_FT_PEN			    (w_FT_PEN				),
/*output wire			*/	.O_FT_RST			    (w_FT_RST				),
/*output wire			*/	.O_FT_CLK			    (w_FT_CLK				),
/*output wire			*/	.O_FT_BIAS_STUP		    (w_FT_BIAS_STUP			),
/*input wire	[4:0]	*/	.I_FT_CC			    (w_FT_CC				),
/*input wire			*/	.I_FT_DONE			    (w_FT_DONE				),
// ADC                                              
/*output wire			*/	.O_ADC_PEN			    (w_ADC_PEN				),
/*output wire			*/	.O_ADC_CLKT			    (w_ADC_CLKT				),
/*output wire			*/	.O_ADC_CLKB			    (w_ADC_CLKB				),
/*output wire	[2:0]	*/	.O_ADC_FS			    (w_ADC_FS				),
/*input wire			*/	.I_ADC_ICONV_RDY	    (w_ADC_ICONV_RDY		),
/*input wire	[7:0]	*/	.I_ADC_IDATA		    (w_ADC_IDATA			),
/*input wire			*/	.I_ADC_QCONV_RDY	    (w_ADC_QCONV_RDY		),
/*input wire	[7:0]	*/	.I_ADC_QDATA		    (w_ADC_QDATA			),
/*output wire			*/	.O_ADC_CONV_RDY_MODE    (w_ADC_CONV_RDY_MODE	),
// GPADC                                            
/*output wire			*/	.O_GPADC_PEN		    (w_GPADC_PEN			),
/*output wire	[3:0]	*/	.O_GPADC_MUXSEL		    (w_GPADC_MUXSEL			),
/*output wire			*///	.O_GPADC_ATT_EN		    (w_GPADC_ATT_EN			),
/*output wire			*/	.O_GPADC_BUF_EN		    (w_GPADC_BUF_EN			),
/*output wire			*/	.O_GPADC_AMP_CHOP_EN    (w_GPADC_AMP_CHOP_EN	),
/*output wire			*/	.O_GPADC_CLKT		    (w_GPADC_CLKT			),
/*output wire			*/	.O_GPADC_CLKB		    (w_GPADC_CLKB			),
/*output wire			*/	.O_GPADC_FILT_EN	    (w_GPADC_FILT_EN		),
/*output wire			*/	.O_GPADC_CSTATE		    (w_GPADC_CSTATE			),
/*output wire	[2:0]	*/	.O_GPADC_INBUF_BIAS	    (w_GPADC_INBUF_BIAS		),
/*output wire	[2:0]	*/	.O_GPADC_AMP1_BIAS	    (w_GPADC_AMP1_BIAS		),
/*output wire	[2:0]	*/	.O_GPADC_AMP2_BIAS	    (w_GPADC_AMP2_BIAS		),
/*output wire	[2:0]	*/	.O_GPADC_BGR_BIAS	    (w_GPADC_BGR_BIAS		),
/*output wire	[2:0]	*/	.O_GPADC_VCM_BIAS		(w_GPADC_VCM_BIAS		),
/*output wire	[2:0]	*/	.O_GPADC_VCM_CONT	    (w_GPADC_VCM_CONT		),
/*output wire	[1:0]	*/	.O_GPADC_VREFP_CONT	    (w_GPADC_VREFP_CONT		),
/*output wire	[1:0]	*/	.O_GPADC_VREFN_CONT	    (w_GPADC_VREFN_CONT		),
/*input wire			*/	.I_GPADC_RSTGEN_CLK	    (w_GPADC_RSTGEN_CLK		),
/*input wire			*/	.I_GPADC_DSMRST		    (w_GPADC_DSMRST			),
/*input wire	[1:0]	*/	.I_GPADC_DOUT		    (w_GPADC_DOUT			),
/*input wire			*/	.I_GPADC_DCLK		    (w_GPADC_DCLK			),
/*output wire	[1:0]	*/	.O_GPADC_AMP1_VB	    (w_GPADC_AMP1_VB		),
/*output wire	[1:0]	*/	.O_GPADC_AMP2_VB	    (w_GPADC_AMP2_VB		),
/*output wire			*/	.O_GPADC_ATT_BYP_EN		(w_GPADC_ATT_BYP_EN		),
/*output wire			*/	.O_GPADC_ATT_VSEL		(w_GPADC_ATT_VSEL		),
// TS                                               
/*output wire			*/	.O_TS_PEN			    (w_TS_PEN				),
/*output wire	[3:0]	*/	.O_TS_DEM_CLK		    (w_TS_DEM_CLK			),
/*output wire			*/	.O_TS_CHOP_CLK		    (w_TS_CHOP_CLK			),
/*output wire	[1:0]	*/	.O_TS_CAL			    (w_TS_CAL				),
/*output wire			*/	.O_TS_SEL			    (w_TS_SEL				),
/*output wire			*/	.O_TS_CHOP_ON		    (w_TS_CHOP_ON			), //r2
/*output wire			*/	.O_TS_DEM_ON		    (w_TS_DEM_ON			), //r2
/*output wire	[3:0]	*/	.O_TS_TRIM				(w_TS_TRIM				),
// XO                                               
/*output wire			*/	.O_XO_PEN			    (w_XO_PEN				),
/*output wire			*/	.O_XO_MODE			    (w_XO_MODE				),
/*output wire	[5:0]	*/	.O_XO_CS			    (w_XO_CS				),
/*output wire	[5:0]	*/	.O_XO_CL			    (w_XO_CL				),
/*output wire			*/	.O_XO_PLL_CLK_EN	    (w_XO_PLL_CLK_EN		),
/*output wire			*/	.O_XO_RFC_CLK_EN	    (w_XO_RFC_CLK_EN		),
	//PHASE TRACKING RX
///*output wire			*/	.O_PTRX_EN				(w_PTRX_EN				),	//R2 
// Phase                                            
///*output wire			*/	.O_LO_PH_SHIFT_EN	    (w_LO_PH_SHIFT_EN		),	//R2 del
///*output wire			*/	.O_LO_PH_SHIFT		    (w_LO_PH_SHIFT			),	//R2 del
///*input wire			*/	.I_LO_PH_I			    (w_LO_PH_I				),	//R2 del
///*input wire			*/	.I_LO_PH_Q			    (w_LO_PH_Q				),	//R2 del
///*input wire			*/	.I_LO_PH_IB			    (w_LO_PH_IB				),	//R2 del
///*input wire			*/	.I_LO_PH_QB			    (w_LO_PH_QB				),	//R2 del
// MASK_SPIM                                        
/*input wire			*/	.I_NFC_TEST_OUT		    (w_NFC_TEST_OUT			),
/*input wire			*/	.I_NFC_WAKEUP		    (w_NFC_WAKEUP			),
/*output wire			*/	.O_NFC_EN			    (w_NFC_EN				),
/*output wire	[1:0]	*/	.O_NFC_TMUX_SEL		    (w_NFC_TMUX_SEL			),
/*output wire			*/	.O_NFC_WUR_THR_SEL	    (w_NFC_WUR_THR_SEL		),
/*output wire [3:0]		*/	.O_NFC_WUR_THR		    (w_NFC_WUR_THR			),
/*output wire 			*/ 	.O_NFC_VRECT_RDY_WUR	(w_NFC_VRECT_RDY_WUR	),
/*output wire			*/	.O_NFC_VRECT_RDY_EXT    (w_NFC_VRECT_RDY_EXT	),
/*output  wire [2:0]	*/	.O_NFC_SKP_PULSE		(w_NFC_SKP_PULSE		),
/*output  wire [6:0]	*/	.O_NFC_IF_THR			(w_NFC_IF_THR			),
/*input  wire			*/	.I_NFC_CLK				(w_NFC_CLK				),
/*input  wire			*/	.I_NFC_WRITE			(w_NFC_WRITE			),
/*input  wire [7:0]		*/	.I_NFC_WDATA			(w_NFC_WDATA			),
// ETC
/*output wire	[23:0]	*/	.O_SPI_RSV_CORE			(w_SPI_RSV_CORE			),
/*output wire	[7:0]	*/	.O_SPI_RSV_AON			(w_SPI_RSV_AON			),
/*input wire [15:0]		*/	.I_DEVICE_ID			(w_DEVICE_ID			),
//                                          		                    	    
// PAD Interface
/*input wire			*/	.I_TEST_EN_C			(w_TEST_EN_C			),
/*input wire			*/	.I_ROM_EN_C				(w_ROM_EN_C				),
/*input wire			*/	.I_DBG_EN_C				(w_DBG_EN_C				),
//--------------------------------------------------------------
//GPIO
//--------------------------------------------------------------
/*output wire [35:0]	*/	.O_GPIO_OE				(w_GPIO_OE				),
/*output wire [35:0]	*/	.O_GPIO_I				(w_GPIO_I 				),
/*output wire [35:0]	*/	.O_GPIO_DS 				(w_GPIO_DS				),
/*output wire [35:0]	*/	.O_GPIO_IE				(w_GPIO_IE				),
/*output wire [35:0]	*/	.O_GPIO_PE 				(w_GPIO_PE				),
/*output wire [35:0]	*/	.O_GPIO_PS 				(w_GPIO_PS				),
/*input wire [35:0]		*/	.I_GPIO_C				(w_GPIO_C 				)
);

OASIS_ANA u_OASIS_ANA (
// Analog Interface
`ifdef	PG_PIN
/*output		*/	.VDD_0p90 			(VDD_0p90 			),
/*output		*/	.VDD_SRAM_PERI_0	(VDD_SRAM_PERI_0	),
/*output		*/	.VDD_SRAM_PERI_1	(VDD_SRAM_PERI_1	),
/*output		*/	.VDD_SRAM_PERI_2	(VDD_SRAM_PERI_2	),
/*output		*/	.VDD_SRAM_PERI_3	(VDD_SRAM_PERI_3	),
/*output		*/	.VDD_SRAM_CORE_0	(VDD_SRAM_CORE_0	),
/*output		*/	.VDD_SRAM_CORE_1	(VDD_SRAM_CORE_1	),
/*output		*/	.VDD_SRAM_CORE_2	(VDD_SRAM_CORE_2	),
/*output		*/	.VDD_SRAM_CORE_3	(VDD_SRAM_CORE_3	),
/*output		*/	.VDD_0p81 			(VDD_0p81 			),
/*output		*/	.VDDQ 				(VDDQ 				),
/*output		*/	.VSS 				(VSS 				),
`endif
/*output wire			*/	.I_AON_RSTB				(w_AON_RSTB				),
/*output wire			*/	.I_RTC_CLKT				(w_RTC_CLKT				),	//32KHz
/*output wire			*/	.I_RTC_CLKB				(w_RTC_CLKB				),	//32KHz Inversion
/*output wire			*/	.I_RFC_CLKT				(w_RFC_CLKT				),	//48MHz
/*output wire			*/	.I_RFC_CLKB				(w_RFC_CLKB				),	//48MHz Inversion
/*output wire			*/	.I_PLL_SDM_CLKT			(w_PLL_SDM_CLKT			),	
/*output wire			*/	.I_PLL_SDM_CLKB			(w_PLL_SDM_CLKB			),	
// PLL
/*input wire			*/	.O_PLL_PEN				(w_PLL_PEN				),
/*input wire			*/	.O_PLL_COARSELOCK	    (w_PLL_COARSELOCK		),
/*input wire			*/	.O_PLL_OUT_PEN		    (w_PLL_OUT_PEN			),
/*input wire			*/	.O_PLL_DIV2_OUT_PEN	    (w_PLL_DIV2_OUT_PEN		),
///*input wire [1:0]	*/	.O_PLL_CP_BCONT		    (w_PLL_CP_BCONT			),
/*input wire 			*/	.O_PLL_CP_UGB_EN      	(w_PLL_CP_UGB_EN      	),	
/*input wire [2:0]		*/	.O_PLL_CP_UGB_CONT    	(w_PLL_CP_UGB_CONT    	),
/*input wire [2:0]		*/	.O_PLL_CP_LEAK_EN     	(w_PLL_CP_LEAK_EN     	),
/*input wire 			*/	.O_PLL_CP_LEAK_COMP_EN	(w_PLL_CP_LEAK_COMP_EN	),
/*input wire [2:0]		*/	.O_PLL_PFD_DELAY      	(w_PLL_PFD_DELAY      	),
/*input wire [2:0]		*/	.O_PLL_CP_CELL_EN	    (w_PLL_CP_CELL_EN		),
///*input wire [4:0]	*/	.O_PLL_CP_LEAK_COMP	    (w_PLL_CP_LEAK_COMP		),
/*input wire [9:0]		*/	.O_PLL_VCO_CAP		    (w_PLL_VCO_CAP			),
/*input wire [7:0]		*/	.O_PLL_PM_CAP		    (w_PLL_PM_CAP			),
/*input wire [4:0]		*/	.O_PLL_PC			    (w_PLL_PC				),
/*input wire [1:0]		*/	.O_PLL_SC			    (w_PLL_SC				),
/*input wire			*/	.O_PLL_CNT_MASK		    (w_PLL_CNT_MASK			),
/*input wire			*/	.O_PLL_CT_RST		    (w_PLL_CT_RST			),
/*input wire [2:0]		*/	.O_PLL_CT_VC_CONT	    (w_PLL_CT_VC_CONT		),
/*input wire [2:0]		*/	.O_PLL_KVCO_VB1		    (w_PLL_KVCO_VB1			),
/*input wire [2:0]		*/	.O_PLL_KVCO_VB2		    (w_PLL_KVCO_VB2			),
/*output wire [12:0]	*/	.I_PLL_CT_CNT		    (w_PLL_CT_CNT			),
// PMU
/*input wire	[4:0]	*/	.O_PWR_SRAM_PERI_DIG	(w_PWR_SRAM_PERI_DIG	),
/*input wire	[4:0]	*/	.O_PWR_SRAM_CORE_DIG	(w_PWR_SRAM_CORE_DIG	),
/*input wire	[4:0]	*/	.O_PWR_SRAM_CORE_RET	(w_PWR_SRAM_CORE_RET	),
/*input wire	[3:0]	*/	.O_ABGR_CONT			(w_ABGR_CONT			),
/*input wire	[3:0]	*/	.O_ABGR_TC			    (w_ABGR_TC				),
/*input wire	[5:0]	*/	.O_ALDO_CONT		    (w_ALDO_CONT			),
/*input wire			*/	.O_ALDO_EN			    (w_ALDO_EN				),
/*input wire			*/	.O_ALDO_EN_SEL		    (w_ALDO_EN_SEL			),
/*input wire			*/	.O_RTC_EN			    (w_RTC_EN				),
/*input wire			*/	.O_RTC_EN_SEL		    (w_RTC_EN_SEL			),
/*input wire	[10:0]	*/	.O_RTC_SCKF			    (w_RTC_SCKF				),
/*input wire			*/	.O_FLDO_PEN			    (w_FLDO_PEN				),
/*input wire			*/	.O_FLDO_LP_EN		    (w_FLDO_LP_EN			),
/*input wire	[3:0]	*/	.O_FLDO_CONT		    (w_FLDO_CONT			),
/*input wire			*/	.O_FLDO_BYPASS		    (w_FLDO_BYPASS			),
/*input wire			*/	.O_FLDO_POK_EN		    (w_FLDO_POK_EN			),
/*output wire			*/	.I_FLDO_POK			    (w_FLDO_POK				),
/*input wire			*/	.O_MLDO_PEN			    (w_MLDO_PEN				),
/*input wire			*/	.O_MLDO_LP_EN		    (w_MLDO_LP_EN			),
/*input wire	[5:0]	*/	.O_MLDO_CONT		    (w_MLDO_CONT			),
/*input wire			*/	.O_MLDO_POK_EN		    (w_MLDO_POK_EN			),
/*output wire			*/	.I_MLDO_POK			    (w_MLDO_POK				),
/*input wire			*/	.O_DCDC_PRECHG_PEN	    (w_DCDC_PRECHG_PEN		),
/*input wire			*/	.O_DCDC_CORE_PEN	    (w_DCDC_CORE_PEN		),
/*input wire			*/	.O_DCDC_REF_PEN		    (w_DCDC_REF_PEN			),
///*input wire			*/	.O_DCDC_CLK_SRC		    (w_DCDC_CLK_SRC			),
///*input wire			*/	.O_DCDC_CLKT		    (w_DCDC_CLKT			),
///*input wire			*/	.O_DCDC_CLKB		    (w_DCDC_CLKB			),
/*input wire			*/	.O_DCDC_MODE		    (w_DCDC_MODE			),
///*input wire	[5:0]	*/	.O_DCDC_SAW_CC		    (w_DCDC_SAW_CC			),
///*input wire	[2:0]	*/	.O_DCDC_EA_CFB		    (w_DCDC_EA_CFB			),
///*input wire	[1:0]	*/	.O_DCDC_EA_RFB		    (w_DCDC_EA_RFB			),
///*input wire	[1:0]	*/	.O_DCDC_EA_RIN		    (w_DCDC_EA_RIN			),
///*input wire	[2:0]	*/	.O_DCDC_EA_CIN		    (w_DCDC_EA_CIN			),
///*input wire	[1:0]	*/	.O_DCDC_EA_BIAS		    (w_DCDC_EA_BIAS			),
/*input wire	[5:0]	*/	.O_DCDC_SET_VOUT	    (w_DCDC_SET_VOUT		),
///*input wire	[1:0]	*/	.O_DCDC_VREF_TRIM	    (w_DCDC_VREF_TRIM		),
/*input wire	[2:0]	*/	.O_DCDC_CUR_TRIM	    (w_DCDC_CUR_TRIM		),
/*input wire	[1:0]	*/	.O_FLDO_POK_TRIM	    (w_FLDO_POK_TRIM		),
/*input wire	[1:0]	*/	.O_MLDO_POK_TRIM	    (w_MLDO_POK_TRIM		),
/*input wire	[3:0]	*/	.O_DCDC_DT_TRIM		    (w_DCDC_DT_TRIM			),
///*input wire			*/	.O_DCDC_TU_EN		    (w_DCDC_TU_EN			),
///*input wire			*/	.O_DCDC_EXT_MODE	    (w_DCDC_EXT_MODE		),
/*input wire			*/	.O_DCDC_POK_EN		    (w_DCDC_POK_EN			),
///*input wire [2:0]	*/	.O_DCDC_EA_CFB_OUT		(w_DCDC_EA_CFB_OUT		),
///*input wire [1:0]	*/	.O_DCDC_EXT_OUT			(w_DCDC_EXT_OUT			),
///*input wire	   		*/	.O_EXT_REF_MODE			(w_EXT_REF_MODE			),
/*input wire			*/	.O_RET_LDO_EN			(w_RET_LDO_EN		 	),//r2
/*input wire [3:0]		*/	.O_RET_LDO_CONT			(w_RET_LDO_CONT		 	),//r2
/*input wire			*/	.O_BOD_EN				(w_BOD_EN			 	),//r2
/*input wire			*/	.O_DA_LDO_EN			(w_DA_LDO_EN		 	),//r2
/*input wire			*/	.O_DA_LDO_BYPASS		(w_DA_LDO_BYPASS		),//r2
/*input wire [5:0]		*/	.O_DA_LDO_CONT			(w_DA_LDO_CONT		 	),//r2
/*input wire [3:0]		*/	.O_DCDC_CLIMIT_RTRIMB	(w_DCDC_CLIMIT_RTRIMB	),//r3
/*input wire [3:0]		*/	.O_DCDC_ISENS_RTRIM		(w_DCDC_ISENS_RTRIM     ),//r3
/*input wire [2:0]		*/	.O_DCDC_ZCD_CTRIM		(w_DCDC_ZCD_CTRIM		),
/*input wire [2:0]		*/	.O_EXT_PFM_VREF			(w_EXT_PFM_VREF			),
/*input wire [3:0]		*/	.O_DCDC_PRECHG_DUR		(w_DCDC_PRECHG_DUR		),
/*input wire [3:0]		*/	.O_DCDC_POK_TRIM		(w_DCDC_POK_TRIM		),
/*input wire [3:0]		*/	.O_MBGR_TC_TRIM			(w_MBGR_TC_TRIM			),//r2
/*input wire [5:0]		*/	.O_MBGR_OUT_TRIM		(w_MBGR_OUT_TRIM		),//r2
/*input wire 			*/	.O_MBGR_EN				(w_MBGR_EN				),//r2
///*input wire 			*/	.O_DA_LDO_BMUX			(w_DA_LDO_BMUX			),//r2
/*input wire 			*/	.O_GPADC_BMUX			(w_GPADC_BMUX			),//r2	
/*input wire [1:0]		*/	.O_BOD_VREFH			(w_BOD_VREFH			),//r3
/*input wire [1:0]		*/	.O_BOD_VREFL			(w_BOD_VREFL			),//r3
/*input wire [1:0]		*/	.O_DA_LDO_TAIL_CONT		(w_DA_LDO_TAIL_CONT		),//r3
/*output wire 			*/	.I_BOD_RSTB				(w_BOD_RSTB				),//r2
/*output wire			*/	.I_DCDC_POK			    (w_DCDC_POK				),
// RFRX         
/*input wire			*/	.O_TRX_SEL			    (w_TRX_SEL				),
/*input wire			*/	.O_RX_RF_PEN			(w_RX_RF_PEN			),
/*input wire			*/	.O_MIX_BUF_PEN		    (w_MIX_BUF_PEN			),
/*input wire	[1:0]	*/	.O_RX_RF_GC			    (w_RX_RF_GC				),
/*input wire	[2:0]	*/	.O_LNTA_BIAS			(w_LNTA_BIAS			),
/*input wire	[2:0]	*/	.O_LNTA_BIAS2			(w_LNTA_BIAS2			),
/*input wire	[2:0]	*/	.O_MIX_I_BIAS		    (w_MIX_I_BIAS			),
/*input wire	[2:0]	*/	.O_MIX_IB_BIAS		    (w_MIX_IB_BIAS			),
/*input wire	[2:0]	*/	.O_MIX_Q_BIAS		    (w_MIX_Q_BIAS			),
/*input wire	[2:0]	*/	.O_MIX_QB_BIAS		    (w_MIX_QB_BIAS			),
// RFTX               
/*input wire			*/	.O_TX_BUF_PEN		    (w_TX_BUF_PEN			),
/*input wire			*/	.O_TX_PRE_PEN		    (w_TX_PRE_PEN			),
/*input wire			*/	.O_TX_DA_PEN			(w_TX_DA_PEN			),
/*input wire	[3:0]	*/	.O_TX_DA_GC			    (w_TX_DA_GC				),
// ABB                
/*input wire			*/	.O_ABB_PEN			    (w_ABB_PEN				),
/*input wire			*/	.O_ABB_BIAS_STUP	    (w_ABB_BIAS_STUP		),
/*input wire	[2:0]	*/	.O_ABB_BIAS1			(w_ABB_BIAS1			),
/*input wire	[2:0]	*/	.O_ABB_BIAS2			(w_ABB_BIAS2			),
/*input wire	[2:0]	*/	.O_ABB_VCOM			    (w_ABB_VCOM				),
/*input wire	[4:0]	*/	.O_ABB_IFC_CC		    (w_ABB_IFC_CC			),
/*input wire	[2:0]	*/	.O_ABB_TIA_GC		    (w_ABB_TIA_GC			),
/*input wire			*/	.O_ABB_TIA_RCF_EN	    (w_ABB_TIA_RCF_EN		),
/*input wire			*/	.O_ABB_TIA_CFB_EN	    (w_ABB_TIA_CFB_EN		),
/*input wire	[4:0]	*/	.O_ABB_TIA_CC		    (w_ABB_TIA_CC			),
/*input wire	[3:0]	*/	.O_ABB_TIA_STB		    (w_ABB_TIA_STB			),
/*input wire			*/	.O_ABB_TIA_MIR		    (w_ABB_TIA_MIR			),
/*input wire	[1:0]	*/	.O_ABB_FLT_GC		    (w_ABB_FLT_GC			),
/*input wire	[4:0]	*/	.O_ABB_FLT_CC		    (w_ABB_FLT_CC			),
/*input wire	[4:0]	*/	.O_ABB_FLT_ZC		    (w_ABB_FLT_ZC			),
/*input wire			*/	.O_ABB_FLT_SKIP		    (w_ABB_FLT_SKIP			),
/*input wire			*/	.O_ABB_FLT_WB		    (w_ABB_FLT_WB			),
/*input wire	[4:0]	*/	.O_ABB_FLT_IF		    (w_ABB_FLT_IF			),
///*input wire			*/	.O_ABB_ACC_SWAP_EN	    (w_ABB_ACC_SWAP_EN		),
///*input wire			*/	.O_ABB_ACC_SWAP		    (w_ABB_ACC_SWAP			),
/*input wire	[2:0]	*/	.O_ABB_ACC_BW		    (w_ABB_ACC_BW			),
/*input wire			*/	.O_ABB_ACC_SKIP		    (w_ABB_ACC_SKIP			),
/*input wire	[4:0]	*/	.O_ABB_PGA_GC		    (w_ABB_PGA_GC			),
/*input wire	[1:0]	*/	.O_ABB_PGA_CFB		    (w_ABB_PGA_CFB			),
/*input wire	[2:0]	*/	.O_ABB_DRV_OMODE		(w_ABB_DRV_OMODE		),
/*input wire			*/	.O_ABB_DRV_STB_CC	    (w_ABB_DRV_STB_CC		),
/*input wire	[3:0]	*/	.O_ABB_DRV_TPE		    (w_ABB_DRV_TPE			),
/*input wire			*/	.O_ABB_DRV_TP_SWAP	    (w_ABB_DRV_TP_SWAP		),
/*input wire			*/	.O_ABB_TEST_ENI		    (w_ABB_TEST_ENI			),
/*input wire			*/	.O_ABB_TEST_ENQ		    (w_ABB_TEST_ENQ			),
/*input wire			*/	.O_GPIO01_AN_EN		    (w_GPIO01_AN_EN			),
/*input wire			*/	.O_GPIO23_AN_EN		    (w_GPIO23_AN_EN			),
/*input wire			*/	.O_AN_TEST_EN		    (w_AN_TEST_EN			),
/*input wire			*/	.O_GPIO4_AN_EN		    (w_GPIO4_AN_EN			),
/*input wire	[2:0]	*/	.O_AN_TEST_MUX		    (w_AN_TEST_MUX			),
/*input wire			*/	.O_GPIO_TEST_BUF_EN		(w_GPIO_TEST_BUF_EN		),
/*input wire			*/	.O_GPIO_TEST_CUR_EN		(w_GPIO_TEST_CUR_EN		),
// FT	                
/*input wire			*/	.O_FT_PEN			    (w_FT_PEN				),
/*input wire			*/	.O_FT_RST			    (w_FT_RST				),
/*input wire			*/	.O_FT_CLK			    (w_FT_CLK				),
/*input wire			*/	.O_FT_BIAS_STUP			(w_FT_BIAS_STUP			),
/*output wire	[4:0]	*/	.I_FT_CC				(w_FT_CC				),
/*output wire			*/	.I_FT_DONE			    (w_FT_DONE				),
// ADC  
/*input wire			*/	.O_ADC_PEN			    (w_ADC_PEN				),
/*input wire			*/	.O_ADC_CLKT			    (w_ADC_CLKT				),
/*input wire			*/	.O_ADC_CLKB			    (w_ADC_CLKB				),
/*input wire	[2:0]	*/	.O_ADC_FS			    (w_ADC_FS				),
/*output wire			*/	.I_ADC_ICONV_RDY		(w_ADC_ICONV_RDY		),
/*output wire	[7:0]	*/	.I_ADC_IDATA			(w_ADC_IDATA			),
/*output wire			*/	.I_ADC_QCONV_RDY		(w_ADC_QCONV_RDY		),
/*output wire	[7:0]	*/	.I_ADC_QDATA			(w_ADC_QDATA			),
/*input wire			*/	.O_ADC_CONV_RDY_MODE	(w_ADC_CONV_RDY_MODE	),
// GPADC  
/*input wire			*/	.O_GPADC_PEN			(w_GPADC_PEN			),
/*input wire	[3:0]	*/	.O_GPADC_MUXSEL		    (w_GPADC_MUXSEL			),
/*input wire			*///	.O_GPADC_ATT_EN		    (w_GPADC_ATT_EN			),
/*input wire			*/	.O_GPADC_BUF_EN		    (w_GPADC_BUF_EN			),
/*input wire			*/	.O_GPADC_AMP_CHOP_EN	(w_GPADC_AMP_CHOP_EN	),
/*input wire			*/	.O_GPADC_CLKT		    (w_GPADC_CLKT			),
/*input wire			*/	.O_GPADC_CLKB		    (w_GPADC_CLKB			),
/*input wire			*/	.O_GPADC_FILT_EN		(w_GPADC_FILT_EN		),
/*input wire			*/	.O_GPADC_CSTATE		    (w_GPADC_CSTATE			),
/*input wire	[2:0]	*/	.O_GPADC_INBUF_BIAS	    (w_GPADC_INBUF_BIAS		),
/*input wire	[2:0]	*/	.O_GPADC_AMP1_BIAS	    (w_GPADC_AMP1_BIAS		),
/*input wire	[2:0]	*/	.O_GPADC_AMP2_BIAS	    (w_GPADC_AMP2_BIAS		),
/*input wire	[2:0]	*/	.O_GPADC_BGR_BIAS		(w_GPADC_BGR_BIAS		),
/*input wire	[2:0]	*/	.O_GPADC_VCM_BIAS	  	(w_GPADC_VCM_BIAS		),
/*input wire	[2:0]	*/	.O_GPADC_VCM_CONT	    (w_GPADC_VCM_CONT		),
/*input wire	[1:0]	*/	.O_GPADC_VREFP_CONT	    (w_GPADC_VREFP_CONT		),
/*input wire	[1:0]	*/	.O_GPADC_VREFN_CONT	    (w_GPADC_VREFN_CONT		),
/*output wire			*/	.I_GPADC_RSTGEN_CLK	    (w_GPADC_RSTGEN_CLK		),
/*output wire			*/	.I_GPADC_DSMRST		    (w_GPADC_DSMRST			),
/*output wire	[1:0]	*/	.I_GPADC_DOUT		    (w_GPADC_DOUT			),
/*output wire			*/	.I_GPADC_DCLK		    (w_GPADC_DCLK			),
/*input wire	[1:0]	*/	.O_GPADC_AMP1_VB		(w_GPADC_AMP1_VB		),
/*input wire	[1:0]	*/	.O_GPADC_AMP2_VB		(w_GPADC_AMP2_VB		),
/*input wire			*/	.O_GPADC_ATT_BYP_EN		(w_GPADC_ATT_BYP_EN		),
/*input wire			*/	.O_GPADC_ATT_VSEL		(w_GPADC_ATT_VSEL		),
// TS                 
/*input wire			*/	.O_TS_PEN			    (w_TS_PEN				),
/*input wire	[3:0]	*/	.O_TS_DEM_CLK		    (w_TS_DEM_CLK			),
/*input wire			*/	.O_TS_CHOP_CLK		    (w_TS_CHOP_CLK			),
/*input wire	[1:0]	*/	.O_TS_CAL			    (w_TS_CAL				),
/*input wire			*/	.O_TS_SEL			    (w_TS_SEL				),
/*input wire			*/	.O_TS_CHOP_ON			(w_TS_CHOP_ON			),	//r2
/*input wire			*/	.O_TS_DEM_ON			(w_TS_DEM_ON			),	//r2
/*input wire	[3:0]	*/	.O_TS_TRIM				(w_TS_TRIM				),
// XO  
/*input wire			*/	.O_XO_PEN			    (w_XO_PEN				),
/*input wire			*/	.O_XO_MODE			    (w_XO_MODE				),
/*input wire	[5:0]	*/	.O_XO_CS				(w_XO_CS				),
/*input wire	[5:0]	*/	.O_XO_CL				(w_XO_CL				),
/*input wire			*/	.O_XO_PLL_CLK_EN		(w_XO_PLL_CLK_EN		),
/*input wire			*/	.O_XO_RFC_CLK_EN		(w_XO_RFC_CLK_EN		),
	//PHASE TRACKING RX
///*input wire			*/	.O_PTRX_EN				(w_PTRX_EN				),	//R2 
// Phase  
///*input wire			*/	.O_LO_PH_SHIFT_EN	    (w_LO_PH_SHIFT_EN		),	//R2 del
///*input wire			*/	.O_LO_PH_SHIFT		    (w_LO_PH_SHIFT			),	//R2 del
///*output wire			*/	.I_LO_PH_I			    (w_LO_PH_I				),	//R2 del
///*output wire			*/	.I_LO_PH_Q			    (w_LO_PH_Q				),	//R2 del
///*output wire			*/	.I_LO_PH_IB			    (w_LO_PH_IB				),	//R2 del
///*output wire			*/	.I_LO_PH_QB			    (w_LO_PH_QB				),	//R2 del
// MASK_SPIM                         
/*output wire			*/	.I_NFC_TEST_OUT		    (w_NFC_TEST_OUT			),
/*output wire			*/	.I_NFC_WAKEUP		    (w_NFC_WAKEUP			),
/*input wire			*/	.O_NFC_EN			    (w_NFC_EN				),
/*input wire	[1:0]	*/	.O_NFC_TMUX_SEL		    (w_NFC_TMUX_SEL			),
/*input wire			*/	.O_NFC_WUR_THR_SEL	    (w_NFC_WUR_THR_SEL		),
/*input wire [3:0]		*/	.O_NFC_WUR_THR		    (w_NFC_WUR_THR			),
/*input wire 			*/ 	.O_NFC_VRECT_RDY_WUR	(w_NFC_VRECT_RDY_WUR	),
/*input wire			*/	.O_NFC_VRECT_RDY_EXT	(w_NFC_VRECT_RDY_EXT	),
/*input  wire [2:0]		*/	.O_NFC_SKP_PULSE		(w_NFC_SKP_PULSE		),
/*input  wire [6:0]		*/	.O_NFC_IF_THR			(w_NFC_IF_THR			),
/*output wire			*/	.I_NFC_CLK				(w_NFC_CLK				),
/*output wire			*/	.I_NFC_WRITE			(w_NFC_WRITE			),
/*output wire [7:0]		*/	.I_NFC_WDATA			(w_NFC_WDATA			),
// ETC
/*input wire	[23:0]	*/	.O_SPI_RSV_CORE			(w_SPI_RSV_CORE			),	
/*input wire	[7:0]	*/	.O_SPI_RSV_AON			(w_SPI_RSV_AON			),	
/*output wire [15:0]	*/	.I_DEVICE_ID		    (w_DEVICE_ID			),
// PAD
/*inout wire			*/	.P_TEST_EN				(P_TEST_EN				),
/*inout wire			*/	.P_ROM_EN				(P_ROM_EN				),
/*inout wire			*/	.P_DBG_EN				(P_DBG_EN				),
`ifdef	FPGA
/*inout wire			*/	.P_OSC_H				(P_OSC_H				),
/*inout wire			*/	.P_OSC_L				(P_OSC_L				),
/*inout wire			*/	.O_MCUP_BSTA			(O_MCUP_BSTA			),
/*input wire            */  .FCLK_CLK1              (FCLK_CLK1              ),
`endif
//GPIO                                          	                    	
/*inout wire			*/	.P_GPIO_00				(P_GPIO_00				),
/*inout wire			*/	.P_GPIO_01				(P_GPIO_01				),
/*inout wire			*/	.P_GPIO_02				(P_GPIO_02				),
/*inout wire			*/	.P_GPIO_03				(P_GPIO_03				),
/*inout wire			*/	.P_GPIO_04				(P_GPIO_04				),
/*inout wire			*/	.P_GPIO_05				(P_GPIO_05				),
/*inout wire			*/	.P_GPIO_06				(P_GPIO_06				),
/*inout wire			*/	.P_GPIO_07				(P_GPIO_07				),
/*inout wire			*/	.P_GPIO_08				(P_GPIO_08				),
/*inout wire			*/	.P_GPIO_09				(P_GPIO_09				),
/*inout wire			*/	.P_GPIO_10				(P_GPIO_10				),
/*inout wire			*/	.P_GPIO_11				(P_GPIO_11				),
/*inout wire			*/	.P_GPIO_12				(P_GPIO_12				),
/*inout wire			*/	.P_GPIO_13				(P_GPIO_13				),
/*inout wire			*/	.P_GPIO_14				(P_GPIO_14				),
/*inout wire			*/	.P_GPIO_15				(P_GPIO_15				),
/*inout wire			*/	.P_GPIO_16				(P_GPIO_16				),
/*inout wire			*/	.P_GPIO_17				(P_GPIO_17				),
/*inout wire			*/	.P_GPIO_18				(P_GPIO_18				),
/*inout wire			*/	.P_GPIO_19				(P_GPIO_19				),
/*inout wire			*/	.P_GPIO_20				(P_GPIO_20				),
/*inout wire			*/	.P_GPIO_21				(P_GPIO_21				),
/*inout wire			*/	.P_GPIO_22				(P_GPIO_22				),
/*inout wire			*/	.P_GPIO_23				(P_GPIO_23				),
/*inout wire			*/	.P_GPIO_24				(P_GPIO_24				),
/*inout wire			*/	.P_GPIO_25				(P_GPIO_25				),
/*inout wire			*/	.P_GPIO_26				(P_GPIO_26				),
/*inout wire			*/	.P_GPIO_27				(P_GPIO_27				),
/*inout wire			*/	.P_GPIO_28				(P_GPIO_28				),
/*inout wire			*/	.P_GPIO_29				(P_GPIO_29				),
/*inout wire			*/	.P_GPIO_30				(P_GPIO_30				),
/*inout wire			*/	.P_GPIO_31				(P_GPIO_31				),
/*inout wire			*/	.P_GPIO_32				(P_GPIO_32				),
/*inout wire			*/	.P_GPIO_33				(P_GPIO_33				),
/*inout wire			*/	.P_GPIO_34				(P_GPIO_34				),
/*inout wire			*/	.P_GPIO_35				(P_GPIO_35				),
//                                              	                    	
// PAD Interface
/*input wire			*/	.I_TEST_EN_C			(w_TEST_EN_C			),
/*input wire			*/	.I_ROM_EN_C				(w_ROM_EN_C				),
/*input wire			*/	.I_DBG_EN_C				(w_DBG_EN_C				),
//GPIO
/*input wire [35:0]		*/	.O_GPIO_OE				(w_GPIO_OE				),
/*input wire [35:0]		*/	.O_GPIO_I				(w_GPIO_I				),
/*input wire [35:0]		*/	.O_GPIO_DS 				(w_GPIO_DS 				),
/*input wire [35:0]		*/	.O_GPIO_IE				(w_GPIO_IE				),
/*input wire [35:0]		*/	.O_GPIO_PE 				(w_GPIO_PE 				),
/*input wire [35:0]		*/	.O_GPIO_PS 				(w_GPIO_PS 				),
/*output wire [35:0]	*/	.I_GPIO_C				(w_GPIO_C				)
);

endmodule
