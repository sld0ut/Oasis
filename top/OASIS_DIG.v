//
//  Module: OASIS_DIG
//  Project: OASIS
//  Description: 
// 
//  Change history: 
//
////////////////////////////////////////////////////////
`timescale 1ns/10ps

module OASIS_DIG # (
	parameter GP_N	= (48)
) (
`ifdef FPGA
	input  wire [3:0]   	PS_AHBS_HPROT			,
	input  wire  			PS_AHBS_HMSTLOCK		,
	input  wire [31:0]		PS_AHBS_HADDR			,
	input  wire [ 1:0]		PS_AHBS_HTRANS			,
	input  wire [2:0]   	PS_AHBS_HBURST			,
	input  wire       		PS_AHBS_HWRITE			,
	input  wire [ 2:0]		PS_AHBS_HSIZE			,
	input  wire [31:0]		PS_AHBS_HWDATA			,
	output wire [31:0]		PS_AHBS_HRDATA			,
	output wire [ 1:0]		PS_AHBS_HRESP			,
	output wire         	PS_AHBS_HREADY			,
	output wire         	O_MCLK					,
	output wire				BGRIP_ROOT_CLK			,

	output wire         	BBM_XO_EN      			,
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
	// Analog Interface
	input wire				I_AON_RSTB				,	//
	input wire				I_RTC_CLKT				,	//32KHz
	input wire				I_RTC_CLKB				,	//32KHz Inversion
	input wire				I_RFC_CLKT				,	//32MHz
	input wire				I_RFC_CLKB				,	//32MHz Inversion
	// PLL
	output wire				O_PLL_PEN				,
	output wire				O_PLL_COARSELOCK		,
	output wire				O_PLL_OUT_PEN			,
	output wire				O_PLL_DIV2_OUT_PEN		,
//	output wire	[1:0]		O_PLL_CP_BCONT			,
	output wire 			O_PLL_CP_UGB_EN      	,	
	output wire [2:0]		O_PLL_CP_UGB_CONT    	,
	output wire [2:0]		O_PLL_CP_LEAK_EN     	,
	output wire 			O_PLL_CP_LEAK_COMP_EN	,
	output wire [2:0]		O_PLL_PFD_DELAY      	,
	output wire [2:0]		O_PLL_CP_CELL_EN		,
//	output wire [4:0]		O_PLL_CP_LEAK_COMP		,
	output wire [9:0]		O_PLL_VCO_CAP			,
	output wire [7:0]		O_PLL_PM_CAP			,
	output wire	[4:0]		O_PLL_PC				,
	output wire	[1:0]		O_PLL_SC				,
	output wire				O_PLL_CNT_MASK			,
	output wire				O_PLL_CT_RST			,
	output wire	[2:0]		O_PLL_CT_VC_CONT		,
	output wire	[2:0]		O_PLL_KVCO_VB1			,
	output wire	[2:0]		O_PLL_KVCO_VB2			,
	input wire				I_PLL_SDM_CLKT			,	//	I_PLL_VCO_DIV		,
	input wire				I_PLL_SDM_CLKB			,	//	I_PLL_VCO_DIVB		,
	input wire 	[12:0]		I_PLL_CT_CNT			,
	// PMU
	output wire	[4:0]		O_PWR_SRAM_CORE_DIG		,			
	output wire	[4:0]		O_PWR_SRAM_CORE_RET		,			
	output wire	[4:0]		O_PWR_SRAM_PERI_DIG		,			
	output wire	[3:0]		O_ABGR_CONT				,			
	output wire	[3:0]		O_ABGR_TC				,
	output wire	[5:0]		O_ALDO_CONT				,
	output wire				O_ALDO_EN				,
	output wire				O_ALDO_EN_SEL			,
	output wire				O_RTC_EN				,
	output wire				O_RTC_EN_SEL			,
	output wire	[10:0]		O_RTC_SCKF				,
	output wire				O_FLDO_PEN				,
	output wire				O_FLDO_LP_EN			,
	output wire [3:0]		O_FLDO_CONT				,
	output wire				O_FLDO_BYPASS			,
	output wire				O_FLDO_POK_EN			,
	input wire				I_FLDO_POK				,	//
	output wire				O_MLDO_PEN				,
	output wire				O_MLDO_LP_EN			,
	output wire	[5:0]		O_MLDO_CONT				,
	output wire				O_MLDO_POK_EN			,
	input wire				I_MLDO_POK				, //
	output wire				O_DCDC_PRECHG_PEN		,
	output wire				O_DCDC_CORE_PEN			,
	output wire				O_DCDC_REF_PEN			,
//	output wire				O_DCDC_CLK_SRC			,	//r2 del
//	output wire				O_DCDC_CLKT				,	//r2 del //
//	output wire				O_DCDC_CLKB				,	//r2 del //
	output wire				O_DCDC_MODE				,
//	output wire	[5:0]		O_DCDC_SAW_CC			,	//r2 del
//	output wire	[2:0]		O_DCDC_EA_CFB			,	//r2 del
//	output wire	[2:0]		O_DCDC_EA_RFB			,	//r2 del
//	output wire	[2:0]		O_DCDC_EA_RIN			,	//r2 del
//	output wire	[2:0]		O_DCDC_EA_CIN			,	//r2 del
//	output wire	[1:0]		O_DCDC_EA_BIAS			,	//r2 del
	output wire	[5:0]		O_DCDC_SET_VOUT			,	//r2
//	output wire	[1:0]		O_DCDC_VREF_TRIM		,	//r2 del
	output wire	[2:0]		O_DCDC_CUR_TRIM			,
	output wire [1:0]		O_FLDO_POK_TRIM			,
	output wire [1:0]		O_MLDO_POK_TRIM			,
	output wire	[3:0]		O_DCDC_DT_TRIM			,
//	output wire				O_DCDC_TU_EN			,	//r2 del
//	output wire				O_DCDC_EXT_MODE			,	//r2 del
	output wire				O_DCDC_POK_EN			,
//	output wire [2:0]		O_DCDC_EA_CFB_OUT		,	//r2 del
//	output wire [1:0]		O_DCDC_EXT_OUT			,	//r2 del
//	output wire				O_EXT_REF_MODE			,	//r2 del
	output wire				O_RET_LDO_EN			,	// r2
	output wire [3:0]		O_RET_LDO_CONT			,	// r2
	output wire				O_BOD_EN				,	// r2
	output wire				O_DA_LDO_EN				,	// r2
	output wire				O_DA_LDO_BYPASS			,	// r2
	output wire [5:0]		O_DA_LDO_CONT			,	// r2
	output wire [3:0]		O_DCDC_CLIMIT_RTRIMB	,	// r2
	output wire [3:0]		O_DCDC_ISENS_RTRIM		,
	output wire [2:0]		O_DCDC_ZCD_CTRIM		,
	output wire [2:0]		O_EXT_PFM_VREF			,
	output wire [3:0]		O_DCDC_PRECHG_DUR		,
	output wire [3:0]		O_DCDC_POK_TRIM			,
	output wire [3:0]		O_MBGR_TC_TRIM			,	//r2
	output wire [5:0]		O_MBGR_OUT_TRIM			,	//r2
	output wire 			O_MBGR_EN				,	//r2
//	output wire 			O_DA_LDO_BMUX			,	//r2
	output wire 			O_GPADC_BMUX			,	//r2AON --> r3DIG	
	output wire [1:0]		O_BOD_VREFH				,	//r3
	output wire [1:0]		O_BOD_VREFL				,	//r3
	output wire [1:0]		O_DA_LDO_TAIL_CONT		,	
	input  wire 			I_BOD_RSTB				,	//r2
	input wire				I_DCDC_POK				, 	//
	// RFRX
	output wire				O_TRX_SEL				,
	output wire				O_RX_RF_PEN				,
	output wire				O_MIX_BUF_PEN			,
	output wire	[1:0]		O_RX_RF_GC				,
	output wire	[2:0]		O_LNTA_BIAS				,
	output wire	[2:0]		O_LNTA_BIAS2			,
	output wire	[2:0]		O_MIX_I_BIAS			,
	output wire	[2:0]		O_MIX_IB_BIAS			,
	output wire	[2:0]		O_MIX_Q_BIAS			,
	output wire	[2:0]		O_MIX_QB_BIAS			,
	// RFTX
	output wire				O_TX_BUF_PEN			,
	output wire				O_TX_PRE_PEN			,
	output wire				O_TX_DA_PEN				,
	output wire	[3:0]		O_TX_DA_GC				,
	// ABB
	output wire				O_ABB_PEN				,
	output wire				O_ABB_BIAS_STUP			, //r2
	output wire	[2:0]		O_ABB_BIAS1				,
	output wire	[2:0]		O_ABB_BIAS2				,
	output wire	[2:0]		O_ABB_VCOM				,
	output wire	[4:0]		O_ABB_IFC_CC			,
	output wire	[2:0]		O_ABB_TIA_GC			,
	output wire				O_ABB_TIA_RCF_EN		,
	output wire				O_ABB_TIA_CFB_EN		,
	output wire	[4:0]		O_ABB_TIA_CC			,
	output wire	[3:0]		O_ABB_TIA_STB			,
	output wire				O_ABB_TIA_MIR			,
	output wire	[1:0]		O_ABB_FLT_GC			,
	output wire	[4:0]		O_ABB_FLT_CC			,
	output wire	[4:0]		O_ABB_FLT_ZC			,
	output wire				O_ABB_FLT_SKIP			,
	output wire				O_ABB_FLT_WB			,
	output wire	[4:0]		O_ABB_FLT_IF			,
//output wire				O_ABB_ACC_SWAP_EN		, //r3
//output wire				O_ABB_ACC_SWAP			, //r3
	output wire	[2:0]		O_ABB_ACC_BW			,
	output wire				O_ABB_ACC_SKIP			,
	output wire	[4:0]		O_ABB_PGA_GC			,
	output wire	[1:0]		O_ABB_PGA_CFB			,
	output wire	[2:0]		O_ABB_DRV_OMODE			,
	output wire				O_ABB_DRV_STB_CC		,
	output wire	[3:0]		O_ABB_DRV_TPE			,
	output wire				O_ABB_DRV_TP_SWAP		,
	output wire				O_ABB_TEST_ENI			,
	output wire				O_ABB_TEST_ENQ			,
	output wire				O_GPIO01_AN_EN			,
	output wire				O_GPIO23_AN_EN			,
	output wire				O_AN_TEST_EN			,
	output wire				O_GPIO4_AN_EN			,
	output wire	[2:0]		O_AN_TEST_MUX			,
	output wire				O_GPIO_TEST_BUF_EN			,
	output wire				O_GPIO_TEST_CUR_EN			,
	// FT	
	output wire				O_FT_PEN				,
	output wire				O_FT_RST				,
	output wire				O_FT_CLK				,
	output wire				O_FT_BIAS_STUP			, //r2
	input wire	[4:0]		I_FT_CC					,
	input wire				I_FT_DONE				,
	// ADC
	output wire				O_ADC_PEN				,
	output wire				O_ADC_CLKT				,
	output wire				O_ADC_CLKB				,
	output wire	[2:0]		O_ADC_FS				,
	input wire				I_ADC_ICONV_RDY			,
	input wire	[7:0]		I_ADC_IDATA				,
	input wire				I_ADC_QCONV_RDY			,
	input wire	[7:0]		I_ADC_QDATA				,
	output wire				O_ADC_CONV_RDY_MODE		,
	// GPADC
	output wire				O_GPADC_PEN				,
	output wire	[3:0]		O_GPADC_MUXSEL			,
//	output wire				O_GPADC_ATT_EN			, //r2del
	output wire				O_GPADC_BUF_EN			,
	output wire				O_GPADC_AMP_CHOP_EN		,
	output wire				O_GPADC_CLKT			,
	output wire				O_GPADC_CLKB			,
	output wire				O_GPADC_FILT_EN			,		// O_FILT_EN
	output wire				O_GPADC_CSTATE			,		// O_CSTATE	
	output wire	[2:0]		O_GPADC_INBUF_BIAS		,
	output wire	[2:0]		O_GPADC_AMP1_BIAS		,
	output wire	[2:0]		O_GPADC_AMP2_BIAS		,
	output wire	[2:0]		O_GPADC_BGR_BIAS		,
	output wire	[2:0]		O_GPADC_VCM_BIAS		,
	output wire	[2:0]		O_GPADC_VCM_CONT		,
	output wire	[1:0]		O_GPADC_VREFP_CONT		,
	output wire	[1:0]		O_GPADC_VREFN_CONT		,
	input wire				I_GPADC_RSTGEN_CLK		,		// I_CLK_RSTGEN
	input wire				I_GPADC_DSMRST			,		// I_DSMRST
	input wire	[1:0]		I_GPADC_DOUT			,		// I_DIN
	input wire				I_GPADC_DCLK			,		// I_CLK_FILTER
	output wire	[1:0]		O_GPADC_AMP1_VB			,
	output wire	[1:0]		O_GPADC_AMP2_VB			,
	output wire				O_GPADC_ATT_BYP_EN		,
	output wire				O_GPADC_ATT_VSEL		,
	// TS
	output wire				O_TS_PEN				,
	output wire	[3:0]		O_TS_DEM_CLK			,
	output wire				O_TS_CHOP_CLK			,
	output wire	[1:0]		O_TS_CAL				,
	output wire				O_TS_SEL				,
	output wire				O_TS_CHOP_ON			,
	output wire				O_TS_DEM_ON				,
	output wire [3:0]		O_TS_TRIM				,
	// XO
	output wire				O_XO_PEN				,
	output wire				O_XO_MODE				,
	output wire	[5:0]		O_XO_CS					,
	output wire	[5:0]		O_XO_CL					,
	output wire				O_XO_PLL_CLK_EN			,
	output wire				O_XO_RFC_CLK_EN			,
	//PHASE TRACKING RX
//	output wire				O_PTRX_EN				,	//R2 
	// Phase
//	output wire				O_LO_PH_SHIFT_EN		,	//R2 del
//	output wire				O_LO_PH_SHIFT			,	//R2 del
//	input wire				I_LO_PH_I				,	//R2 del
//	input wire				I_LO_PH_Q				,	//R2 del
//	input wire				I_LO_PH_IB				,	//R2 del
//	input wire				I_LO_PH_QB				,	//R2 del
	// ETC
	output wire	[23:0]		O_SPI_RSV_CORE			,
	output wire	[7:0]		O_SPI_RSV_AON			,
	input wire 	[15:0]		I_DEVICE_ID				,
	// MASK_SPIM
	input wire				I_NFC_TEST_OUT			,
	input wire				I_NFC_WAKEUP			,
	output wire				O_NFC_EN				,
	output wire	[1:0]		O_NFC_TMUX_SEL			,
	output wire				O_NFC_WUR_THR_SEL		,
	output wire [3:0]		O_NFC_WUR_THR			,
    output wire 			O_NFC_VRECT_RDY_WUR		,
	output wire				O_NFC_VRECT_RDY_EXT		,
	output wire [2:0]		O_NFC_SKP_PULSE			,
	output wire [6:0]		O_NFC_IF_THR			,
	input  wire				I_NFC_CLK				,
	input  wire				I_NFC_WRITE				,
	input  wire [7:0]		I_NFC_WDATA				,
	// PAD Interface
	input wire				I_TEST_EN_C				,
	input wire				I_ROM_EN_C				,
	input wire				I_DBG_EN_C				,

	output wire	[35:0]		O_GPIO_OE				,
	output wire	[35:0]		O_GPIO_I				,
	output wire	[35:0]		O_GPIO_DS				,
	output wire	[35:0]		O_GPIO_IE				,
	output wire	[35:0]		O_GPIO_PE				,
	output wire	[35:0]		O_GPIO_PS				,
	input wire	[35:0]		I_GPIO_C			
);

wire				w_SCAN_MD			;
wire				w_SCAN_EN			;
wire				w_SCAN_RSTN			;
wire				w_SCAN_HCLK			;
wire				w_SCAN_HCLK_1		;
wire				w_SCAN_LCLK			;

wire				w_BIST_MD			;
wire				w_BIST_RSTN			;
wire				w_BIST_CLK			;
wire	[7:0]		w_BIST_DONE			;
wire	[7:0]		w_BIST_FAIL			;
wire	[7:0]		w_BIST_MISR			;

wire				w_TEST_EN_ANA		;
wire				w_TEST_EN_SYS		;
wire				w_TEST_EN_MASK		;

//wire				w_EFUSE_TEST_VEN 	;	
wire				w_EFUSE_TEST_MD  	;	
wire				w_EFUSE_TEST_CSB	;
`ifndef TEF55ULP256	
	wire				w_EFUSE_TEST_PGENB	;
	wire				w_EFUSE_TEST_STROBE	;
	wire				w_EFUSE_TEST_LOAD	;
	wire	[7:0]		w_EFUSE_TEST_Q		;
	`ifdef	TSMC55_ULP
	wire	[9:0]		w_EFUSE_TEST_A		;
	`else
	wire	[7:0]		w_EFUSE_TEST_A		;
//	wire				w_EFUSE_TEST_SEL	;
	wire				w_EFUSE_TEST_PS		;
	`endif
`else
wire				w_EFUSE_TEST_SEL 	;	
wire				w_EFUSE_TEST_SCLK	; 	
wire				w_EFUSE_TEST_PGM 	;	
wire				w_EFUSE_TEST_DIN 	;	
wire 				w_EFUSE_TEST_DOUT	;
`endif

wire				w_ANAT_MD			;
wire				w_ANAT_RSTN			;
wire				w_ANAT_HCLK			;
wire				w_ANAT_LCLK			;

wire				w_RTC_CLK_SEL		= 1'b0;	//CHK
wire				w_RFC_CLK_SEL		= 1'b0;	//CHK
	
wire [2:0]			w_RTC_CLK			;	//32KHz
wire				w_RFC_CLKT			;
wire				w_RFC_CLKB			;

wire [2:0]	w_POR_TM		;
CLK_MUX u_POR_TM_0 (.A(I_AON_RSTB ),.B(w_BIST_RSTN), .S(w_BIST_MD), .Y(w_POR_TM[0]));
CLK_MUX u_POR_TM_1 (.A(w_POR_TM[0]),.B(w_ANAT_RSTN), .S(w_ANAT_MD), .Y(w_POR_TM[1]));
CLK_MUX u_POR_TM_2 (.A(w_POR_TM[1]),.B(w_SCAN_RSTN), .S(w_SCAN_MD), .Y(w_POR_TM[2]));

wire	w_RTC_CLKT_TM;
wire	w_RTC_CLKB_TM;
CLK_MUX u_RTC_CLKT_TM (.A(I_RTC_CLKT), .B(w_SCAN_LCLK), .S(w_SCAN_MD), .Y(w_RTC_CLKT_TM));
CLK_MUX u_RTC_CLKB_TM (.A(I_RTC_CLKB), .B(w_SCAN_LCLK), .S(w_SCAN_MD), .Y(w_RTC_CLKB_TM));

// Insert scan mux
wire		w_FLDO_POK			;
wire		w_MLDO_POK			;
wire		w_DCDC_POK			;
wire 		w_BOD_RSTB			;	//r2
wire		w_NFC_WAKEUP		;
wire		w_NFC_WRITE 		;    
wire [7:0]	w_NFC_WDATA			;
wire [7:0]	w_SCAN_PAT			;
wire 		w_NFC_CLK			;

wire		w_FLDO_POK_0			= w_SCAN_PAT[0];
wire		w_MLDO_POK_0			= w_SCAN_PAT[0];
wire		w_DCDC_POK_0			= w_SCAN_PAT[0];
wire		w_BOD_RSTB_0			= w_SCAN_PAT[0];
wire		w_NFC_WAKEUP_0			= w_SCAN_PAT[0];
wire 		w_NFC_CLK_0				= w_SCAN_PAT[0];		
wire 		w_NFC_WRITE_0			= w_SCAN_PAT[0];		
wire [7:0]	w_NFC_WDATA_0			= w_SCAN_PAT[7:0];	
wire		w_NFC_TEST_OUT_0		= w_SCAN_PAT[0];

wire		w_ALDO_EN			;
wire		w_ALDO_EN_SEL		;
wire		w_RTC_EN			;
wire		w_FLDO_PEN			;
wire		w_FLDO_LP_EN		;
wire		w_FLDO_POK_EN		;
wire [4:0]	w_PWR_SRAM_PERI_DIG	;			
wire [4:0]	w_PWR_SRAM_CORE_DIG	;			
wire [4:0]	w_PWR_SRAM_CORE_RET	;			
wire		w_MLDO_PEN			;
wire		w_MLDO_LP_EN		;
wire		w_MLDO_POK_EN		;
wire		w_DCDC_PRECHG_PEN	;
wire		w_DCDC_CORE_PEN		;
wire		w_DCDC_REF_PEN		;
wire		w_DCDC_POK_EN		;
wire		w_NFC_EN			;
wire		w_NFC_EN_TM			;
wire		w_RET_LDO_EN		;
wire		w_BOD_EN			;
wire 		w_MBGR_EN			;	//r2
wire [1:0]	w_BOD_VREFH			;	//r3
wire [1:0]	w_BOD_VREFL			;	//r3
wire [1:0]	w_DA_LDO_TAIL_CONT	;
// input
CLK_MUX u_FLDO_POK				(.A(I_FLDO_POK		),	.B(w_FLDO_POK_0		),	.S(w_SCAN_MD),	.Y(w_FLDO_POK		));//ANA2AON
CLK_MUX u_MLDO_POK				(.A(I_MLDO_POK		),	.B(w_MLDO_POK_0		),	.S(w_SCAN_MD),	.Y(w_MLDO_POK		));//ANA2AON
CLK_MUX u_DCDC_POK				(.A(I_DCDC_POK		),	.B(w_DCDC_POK_0		),	.S(w_SCAN_MD),	.Y(w_DCDC_POK		));//ANA2AON
CLK_MUX u_BOD_RSTB				(.A(I_BOD_RSTB		),	.B(w_BOD_RSTB_0		),	.S(w_SCAN_MD),	.Y(w_BOD_RSTB		));//ANA2AON
CLK_MUX u_NFC_WAKEUP			(.A(I_NFC_WAKEUP	),	.B(w_NFC_WAKEUP_0	),	.S(w_SCAN_MD),	.Y(w_NFC_WAKEUP		));//ANA2AON
CLK_MUX u_NFC_CLK				(.A(I_NFC_CLK		),	.B(w_NFC_CLK_0		),	.S(w_SCAN_MD),	.Y(w_NFC_CLK		));//ANA2AON
CLK_MUX u_NFC_WRITE				(.A(I_NFC_WRITE		),	.B(w_NFC_WRITE_0	),	.S(w_SCAN_MD),	.Y(w_NFC_WRITE		));//ANA2AON
CLK_MUX u_NFC_WDATA[7:0]		(.A(I_NFC_WDATA		),	.B(w_NFC_WDATA_0	),	.S(w_SCAN_MD),	.Y(w_NFC_WDATA		));//ANA2AON
CLK_MUX u_NFC_TEST_OUT			(.A(I_NFC_TEST_OUT	),	.B(w_NFC_TEST_OUT_0	),	.S(w_SCAN_MD),	.Y(w_NFC_TEST_OUT	));	//ANA2CORE

// output
CLK_MUX u_ALDO_EN				(.A(w_ALDO_EN			),	.B(1'b0),	.S(w_SCAN_MD),	.Y(O_ALDO_EN			));//AON2ANA
CLK_MUX u_ALDO_EN_SEL			(.A(w_ALDO_EN_SEL		),	.B(1'b1),	.S(w_SCAN_MD),	.Y(O_ALDO_EN_SEL		));//AON2ANA
CLK_MUX u_RTC_EN				(.A(w_RTC_EN			),	.B(1'b0),	.S(w_SCAN_MD),	.Y(O_RTC_EN				));//AON2ANA
CLK_MUX u_FLDO_PEN				(.A(w_FLDO_PEN			),	.B(1'b0),	.S(w_SCAN_MD),	.Y(O_FLDO_PEN			));//AON2ANA
CLK_MUX u_FLDO_LP_EN			(.A(w_FLDO_LP_EN		),	.B(1'b0),	.S(w_SCAN_MD),	.Y(O_FLDO_LP_EN			));//AON2ANA
CLK_MUX u_FLDO_POK_EN			(.A(w_FLDO_POK_EN		),	.B(1'b0),	.S(w_SCAN_MD),	.Y(O_FLDO_POK_EN		));//AON2ANA
CLK_MUX u_PWR_SRAM_PERI_DIG[4:0](.A(w_PWR_SRAM_PERI_DIG	),	.B(1'b1),	.S(w_SCAN_MD),	.Y(O_PWR_SRAM_PERI_DIG	));//AON2ANA
CLK_MUX u_PWR_SRAM_CORE_DIG[4:0](.A(w_PWR_SRAM_CORE_DIG	),	.B(1'b1),	.S(w_SCAN_MD),	.Y(O_PWR_SRAM_CORE_DIG	));//AON2ANA
CLK_MUX u_PWR_SRAM_CORE_RET[4:0](.A(w_PWR_SRAM_CORE_RET	),	.B(1'b0),	.S(w_SCAN_MD),	.Y(O_PWR_SRAM_CORE_RET	));//AON2ANA
CLK_MUX u_MLDO_PEN				(.A(w_MLDO_PEN			),	.B(1'b0),	.S(w_SCAN_MD),	.Y(O_MLDO_PEN			));//AON2ANA
CLK_MUX u_MLDO_LP_EN			(.A(w_MLDO_LP_EN		),	.B(1'b0),	.S(w_SCAN_MD),	.Y(O_MLDO_LP_EN			));//AON2ANA
CLK_MUX u_MLDO_POK_EN			(.A(w_MLDO_POK_EN		),	.B(1'b0),	.S(w_SCAN_MD),	.Y(O_MLDO_POK_EN		));//AON2ANA
CLK_MUX u_DCDC_PRECHG_PEN		(.A(w_DCDC_PRECHG_PEN	),	.B(1'b0),	.S(w_SCAN_MD),	.Y(O_DCDC_PRECHG_PEN	));//AON2ANA
CLK_MUX u_DCDC_CORE_PEN			(.A(w_DCDC_CORE_PEN		),	.B(1'b0),	.S(w_SCAN_MD),	.Y(O_DCDC_CORE_PEN		));//AON2ANA
CLK_MUX u_DCDC_REF_PEN			(.A(w_DCDC_REF_PEN		),	.B(1'b0),	.S(w_SCAN_MD),	.Y(O_DCDC_REF_PEN		));//AON2ANA
CLK_MUX u_DCDC_POK_EN			(.A(w_DCDC_POK_EN		),	.B(1'b0),	.S(w_SCAN_MD),	.Y(O_DCDC_POK_EN		));//AON2ANA
CLK_MUX u_NFC_EN				(.A(w_NFC_EN_TM			),	.B(1'b0),	.S(w_SCAN_MD),	.Y(O_NFC_EN				));//AON2ANA
CLK_MUX u_RET_LDO_EN			(.A(w_RET_LDO_EN		),	.B(1'b0),	.S(w_SCAN_MD),	.Y(O_RET_LDO_EN			));//AON2ANA
CLK_MUX u_BOD_EN				(.A(w_BOD_EN			),	.B(1'b0),	.S(w_SCAN_MD),	.Y(O_BOD_EN				));//AON2ANA
CLK_MUX u_MBGR_EN				(.A(w_MBGR_EN			),	.B(1'b0),	.S(w_SCAN_MD),	.Y(O_MBGR_EN			));//AON2ANA
CLK_MUX u_BOD_VREFH[1:0]		(.A(w_BOD_VREFH			),	.B(1'b0),	.S(w_SCAN_MD),	.Y(O_BOD_VREFH			));//AON2ANA
CLK_MUX u_BOD_VREFL[1:0]		(.A(w_BOD_VREFL			),	.B(1'b0),	.S(w_SCAN_MD),	.Y(O_BOD_VREFL			));//AON2ANA
CLK_MUX u_DA_LDO_TAIL_CONT[1:0]	(.A(w_DA_LDO_TAIL_CONT	),	.B(1'b0),	.S(w_SCAN_MD),	.Y(O_DA_LDO_TAIL_CONT	));//AON2ANA
//CLK_MUX u_	(.A(),	.B(1'b0),	.S(w_SCAN_MD),	.Y());
// CLK_BUF output
wire [3:0]			w_ABGR_CONT			;			
wire [3:0]			w_ABGR_TC			;
wire [5:0]			w_ALDO_CONT			;
wire				w_RTC_EN_SEL		;
wire [10:0]			w_RTC_SCKF			;
wire [3:0]			w_FLDO_CONT			;
wire				w_FLDO_BYPASS		;
wire [5:0]			w_MLDO_CONT			;
wire				w_DCDC_MODE			;
wire [5:0]			w_DCDC_SET_VOUT		;
wire [2:0]			w_DCDC_CUR_TRIM		;
wire [1:0]			w_FLDO_POK_TRIM		;
wire [1:0]			w_MLDO_POK_TRIM		;
wire [3:0]			w_DCDC_DT_TRIM		;
wire [3:0]			w_DCDC_ISENS_RTRIM	;
wire [2:0]			w_DCDC_ZCD_CTRIM	;
wire [2:0]			w_EXT_PFM_VREF		;
wire [3:0]			w_DCDC_PRECHG_DUR	;
wire [3:0]			w_DCDC_POK_TRIM		;
wire [3:0]			w_MBGR_TC_TRIM		;	//r2
wire [5:0]			w_MBGR_OUT_TRIM		;	//r2
//wire 				w_DA_LDO_BMUX		;	//r2
//wire 				w_GPADC_BMUX		;	//r2	
wire [7:0]			w_SPI_RSV_AON		;
wire				w_NFC_VRECT_RDY_EXT	;
wire [1:0]			w_NFC_TMUX_SEL		;
wire				w_NFC_WUR_THR_SEL	;
wire				w_NFC_VRECT_RDY_WUR	;
wire [3:0]			w_NFC_WUR_THR		;
wire [2:0]			w_NFC_SKP_PULSE		;
wire [6:0]			w_NFC_IF_THR		;

wire [3:0]			w_RET_LDO_CONT		;	// r2
wire [3:0]			w_DCDC_CLIMIT_RTRIMB;	// r2

assign w_SCAN_PAT	= w_SPI_RSV_AON		;

CLK_BUF_H u_ABGR_CONT[3:0]			(.A(w_ABGR_CONT			),	.Y(O_ABGR_CONT			));//AON2ANA
CLK_BUF_H u_ABGR_TC[3:0]			(.A(w_ABGR_TC			),	.Y(O_ABGR_TC			));//AON2ANA
CLK_BUF_H u_ALDO_CONT[5:0]			(.A(w_ALDO_CONT			),	.Y(O_ALDO_CONT			));//AON2ANA
CLK_BUF_H u_RTC_EN_SEL				(.A(w_RTC_EN_SEL		),	.Y(O_RTC_EN_SEL			));//AON2ANA
CLK_BUF_H u_RTC_SCKF[10:0]			(.A(w_RTC_SCKF			),	.Y(O_RTC_SCKF			));//AON2ANA
CLK_BUF_H u_FLDO_CONT[3:0]			(.A(w_FLDO_CONT			),	.Y(O_FLDO_CONT			));//AON2ANA
CLK_BUF_H u_FLDO_BYPASS				(.A(w_FLDO_BYPASS		),	.Y(O_FLDO_BYPASS		));//AON2ANA
CLK_BUF_H u_MLDO_CONT[5:0]			(.A(w_MLDO_CONT			),	.Y(O_MLDO_CONT			));//AON2ANA
CLK_BUF_H u_DCDC_MODE				(.A(w_DCDC_MODE			),	.Y(O_DCDC_MODE			));//AON2ANA
CLK_BUF_H u_DCDC_SET_VOUT[5:0]		(.A(w_DCDC_SET_VOUT		),	.Y(O_DCDC_SET_VOUT		));//AON2ANA
CLK_BUF_H u_DCDC_CUR_TRIM[2:0]		(.A(w_DCDC_CUR_TRIM		),	.Y(O_DCDC_CUR_TRIM		));//AON2ANA
CLK_BUF_H u_FLDO_POK_TRIM[1:0]		(.A(w_FLDO_POK_TRIM		),	.Y(O_FLDO_POK_TRIM		));//AON2ANA
CLK_BUF_H u_MLDO_POK_TRIM[1:0]		(.A(w_MLDO_POK_TRIM		),	.Y(O_MLDO_POK_TRIM		));//AON2ANA
CLK_BUF_H u_DCDC_DT_TRIM[3:0]		(.A(w_DCDC_DT_TRIM		),	.Y(O_DCDC_DT_TRIM		));//AON2ANA
CLK_BUF_H u_DCDC_ISENS_RTRIM[3:0]	(.A(w_DCDC_ISENS_RTRIM	),	.Y(O_DCDC_ISENS_RTRIM	));//AON2ANA
CLK_BUF_H u_DCDC_ZCD_CTRIM[2:0]		(.A(w_DCDC_ZCD_CTRIM	),	.Y(O_DCDC_ZCD_CTRIM		));//AON2ANA
CLK_BUF_H u_EXT_PFM_VREF[2:0]		(.A(w_EXT_PFM_VREF		),	.Y(O_EXT_PFM_VREF		));//AON2ANA
CLK_BUF_H u_DCDC_PRECHG_DUR[3:0]	(.A(w_DCDC_PRECHG_DUR	),	.Y(O_DCDC_PRECHG_DUR	));//AON2ANA
CLK_BUF_H u_DCDC_POK_TRIM[3:0]		(.A(w_DCDC_POK_TRIM		),	.Y(O_DCDC_POK_TRIM		));//AON2ANA
CLK_BUF_H u_MBGR_TC_TRIM[3:0]		(.A(w_MBGR_TC_TRIM		),	.Y(O_MBGR_TC_TRIM		));//AON2ANA
CLK_BUF_H u_MBGR_OUT_TRIM[5:0]		(.A(w_MBGR_OUT_TRIM		),	.Y(O_MBGR_OUT_TRIM		));//AON2ANA
//CLK_BUF_H u_DA_LDO_BMUX				(.A(w_DA_LDO_BMUX		),	.Y(O_DA_LDO_BMUX		));//AON2ANA
//CLK_BUF_H u_GPADC_BMUX				(.A(w_GPADC_BMUX		),	.Y(O_GPADC_BMUX			));//AON2ANA	
CLK_BUF_H u_SPI_RSV_AON[7:0]		(.A(w_SPI_RSV_AON		),	.Y(O_SPI_RSV_AON		));//AON2ANA
CLK_BUF_H u_NFC_VRECT_RDY_EXT		(.A(w_NFC_VRECT_RDY_EXT	),	.Y(O_NFC_VRECT_RDY_EXT	));//AON2ANA
CLK_BUF_H u_NFC_TMUX_SEL[1:0]		(.A(w_NFC_TMUX_SEL		),	.Y(O_NFC_TMUX_SEL		));//AON2ANA
CLK_BUF_H u_NFC_WUR_THR_SEL			(.A(w_NFC_WUR_THR_SEL	),	.Y(O_NFC_WUR_THR_SEL	));//AON2ANA
CLK_BUF_H u_NFC_VRECT_RDY_WUR		(.A(w_NFC_VRECT_RDY_WUR	),	.Y(O_NFC_VRECT_RDY_WUR	));//AON2ANA
CLK_BUF_H u_NFC_WUR_THR[3:0]		(.A(w_NFC_WUR_THR		),	.Y(O_NFC_WUR_THR		));//AON2ANA
CLK_BUF_H u_NFC_SKP_PULSE[2:0]		(.A(w_NFC_SKP_PULSE		),	.Y(O_NFC_SKP_PULSE		));//AON2ANA
CLK_BUF_H u_NFC_IF_THR[6:0]			(.A(w_NFC_IF_THR		),	.Y(O_NFC_IF_THR			));//AON2ANA
CLK_BUF_H u_RET_LDO_CONT[3:0]		(.A(w_RET_LDO_CONT		),	.Y(O_RET_LDO_CONT		));//AON2ANA	 
CLK_BUF_H u_DCDC_CLIMIT_RTRIMB[3:0]	(.A(w_DCDC_CLIMIT_RTRIMB),	.Y(O_DCDC_CLIMIT_RTRIMB	));//AON2ANA	 
//CLK_BUF_H u_		(.A(),	.Y());

async_clkmux u_RTC_CLK_MUX (
/*input wire	*/	.scan_mode	(w_SCAN_MD			),
/*input wire	*/	.reset0_n	(w_POR_TM[2]		),
/*input wire	*/	.reset1_n	(w_POR_TM[2]		),
/*input wire	*/	.clk_in0	(w_RTC_CLKT_TM		),
/*input wire	*/	.clk_in1	(w_RTC_CLKB_TM		),
/*input wire	*/	.select		(w_RTC_CLK_SEL		),
/*output wire	*/	.clk_out	(w_RTC_CLK[0]			)
);
CLK_MUX u_RTC_CLK_TM_0 (.A(w_RTC_CLK[0]), .B(w_ANAT_LCLK), .S(w_ANAT_MD), .Y(w_RTC_CLK[1]));
CLK_MUX u_RTC_CLK_TM_1 (.A(w_RTC_CLK[1]), .B(w_SCAN_LCLK), .S(w_SCAN_MD), .Y(w_RTC_CLK[2]));

wire [GP_N-1:0]	w_GPIO_PAD_OEN_TM	,w_GPIO_PAD_OEN_TM_0;
wire [GP_N-1:0]	w_GPIO_PAD_OUT_TM	,w_GPIO_PAD_OUT_TM_0;
wire [GP_N-1:0]	w_GPIO_PAD_IE_TM	,w_GPIO_PAD_IE_TM_0	;
wire [GP_N-1:0]	w_GPIO_PAD_PE_TM	,w_GPIO_PAD_PE_TM_0	;
wire [GP_N-1:0]	w_GPIO_PAD_PS_TM	,w_GPIO_PAD_PS_TM_0	;
wire [GP_N-1:0]	w_GPIO_PAD_DS_TM	,w_GPIO_PAD_DS_TM_0	;
wire [GP_N-1:0]	w_GPIO_PAD_IN_TM	,w_GPIO_PAD_IN_TM_0	;

CLK_BUF u_GPIO_PAD_OEN_TM[GP_N-1:0]	(.A(w_GPIO_PAD_OEN_TM	),	.Y(w_GPIO_PAD_OEN_TM_0	));
CLK_BUF u_GPIO_PAD_OUT_TM[GP_N-1:0]	(.A(w_GPIO_PAD_OUT_TM	),	.Y(w_GPIO_PAD_OUT_TM_0	));
CLK_BUF u_GPIO_PAD_IE_TM[GP_N-1:0]	(.A(w_GPIO_PAD_IE_TM	),	.Y(w_GPIO_PAD_IE_TM_0	));
CLK_BUF u_GPIO_PAD_PE_TM[GP_N-1:0]	(.A(w_GPIO_PAD_PE_TM	),	.Y(w_GPIO_PAD_PE_TM_0	));
CLK_BUF u_GPIO_PAD_PS_TM[GP_N-1:0]	(.A(w_GPIO_PAD_PS_TM	),	.Y(w_GPIO_PAD_PS_TM_0	));
CLK_BUF u_GPIO_PAD_DS_TM[GP_N-1:0]	(.A(w_GPIO_PAD_DS_TM	),	.Y(w_GPIO_PAD_DS_TM_0	));
CLK_BUF u_GPIO_PAD_IN_TM[GP_N-1:0]	(.A(w_GPIO_PAD_IN_TM	),	.Y(w_GPIO_PAD_IN_TM_0	));

wire [GP_N-1:0]	w_GPIO_A2C_PAD_OE	;
wire [GP_N-1:0]	w_GPIO_A2C_PAD_OUT	;
wire [GP_N-1:0]	w_GPIO_A2C_PAD_IE	;
wire [GP_N-1:0]	w_GPIO_A2C_PAD_PE	;
wire [GP_N-1:0]	w_GPIO_A2C_PAD_PS	;
wire [GP_N-1:0]	w_GPIO_A2C_PAD_DS	;
wire [GP_N-1:0]	w_GPIO_C2A_PAD_IN	;

wire [GP_N-1:0]	w_GPIO_C2A_PAD_OE	;
wire [GP_N-1:0]	w_GPIO_C2A_PAD_OUT	;
wire [GP_N-1:0]	w_GPIO_C2A_PAD_IE	;
wire [GP_N-1:0]	w_GPIO_C2A_PAD_PE	;
wire [GP_N-1:0]	w_GPIO_C2A_PAD_PS	;
wire [GP_N-1:0]	w_GPIO_C2A_PAD_DS	;
wire [GP_N-1:0]	w_GPIO_A2C_PAD_IN	;

wire [GP_N-1:0]	w_GPIO_PAD_OE	;
wire [GP_N-1:0]	w_GPIO_PAD_OUT	;
wire [GP_N-1:0]	w_GPIO_PAD_IE	;
wire [GP_N-1:0]	w_GPIO_PAD_PE	;
wire [GP_N-1:0]	w_GPIO_PAD_PS	;
wire [GP_N-1:0]	w_GPIO_PAD_DS	;
wire [GP_N-1:0]	w_GPIO_PAD_IN	;

wire			w_SLEEP_ON			;
wire			w_ISO_PEN			;
wire			w_RET_PEN			;

wire			ww_RET_PEN;
wire			ww_RET_PENB;
CLK_BUF_H	u_RET_PEN	(.A(w_RET_PEN),	.Y(ww_RET_PEN));
CLK_BUF_H	u_RET_PENB	(.A(~w_RET_PEN),.Y(ww_RET_PENB));

wire			w_SPI_CSN_PD		;		
wire			w_SPI_SCK_PD		;		
wire			w_SPI_MOSI_PD		;		
wire			w_SPI_MISO_PD		;		

wire			w_GPIO_AON_EN		;

wire	[4:0]		w_AON_GPIO_OEN		; 
wire	[4:0]		w_AON_GPIO_OUT		; 
wire	[4:0]		w_AON_GPIO_IE		; 
wire	[4:0] 		w_AON_GPIO_PE		; 
wire	[4:0] 		w_AON_GPIO_PS		; 
wire	[4:0]		w_AON_GPIO_IN		; 

wire [3:0]	w_AON_XO_STUP_DLY		; 
wire [5:0]	w_AON_xo_cs		   		; 
wire [5:0]	w_AON_xo_cl		   		; 
wire 		w_AON_XO_MODE		   	;
wire		w_AON_XO_PEN_MODE	   	;	
wire		w_AON_XO_PEN		   	; 
wire [5:0]	w_AON_XO_CS_sta   		; 
wire [5:0]	w_AON_XO_CL_sta   		;  
wire		w_AON_XO_CS_MODE	   	;
wire		w_AON_XO_CL_MODE	   	; 
wire [1:0]	w_AON_XO_FAST_STUP_EN	; 

wire	w_ISO_EN_p	/* synthesis syn_keep=1 */;
assign w_ISO_EN_p	= 	(w_SCAN_MD) ? 1'b0 : w_ISO_PEN;
wire	w_ISO_P_EN	/* synthesis syn_keep=1 */;
wire	w_ISO_P_ENB	/* synthesis syn_keep=1 */;
CLK_AND u_ISO_P_EN	(.A(w_ISO_EN_p), .B(!w_SCAN_MD), .Y(w_ISO_P_EN));
CLK_BUF u_ISO_P_ENB	(.A(~w_ISO_P_EN),.Y(w_ISO_P_ENB));

// { BGRIP_AON <=> BGRIP_TOP_WRAP
wire        	w_MASTER1_GCLKEN			;// Master clock enable

wire  [9:0] 	w_FINECNT_32K_SAMP			;// Fine counter retention
wire [27:0] 	w_CLKNCNT_32K_SAMP			;// Base time counter retention
wire        	w_DEEP_SLEEP_STAT_32K		;// Deep sleep status on 32k clock domain
wire        	w_WAKEUP_LP					;// Low power wake-up
wire        	w_TOGGLE_SLEEPREF			;// Sleep reference toggle
wire        	w_DEEP_SLEEP_ON_32K_TRIG	;// Deep sleep on triggered in 32k domain
wire  [31:0] 	w_DEEPSLDUR					;// Duration of the last deep sleep phase

wire         	w_EXTWKUPDSB				;// h/w wakeup disable
wire  [9:0] 	w_FINECNT					;
wire [27:0] 	w_CLKNCNT					;
wire         	w_DEEP_SLEEP_STAT			;// Deep sleep status from SW
wire         	w_WAKEUP_REQ_TRIG			;// Deep sleep status from SW
wire         	w_DEEP_SLEEP_ON				;// Deep sleep request from SW
wire         	w_OSC_SLEEP_ON				;// Enable control of radio_en
wire         	w_RADIO_SLEEP_ON			;// Enable control of radio_en

wire [31:0] 	w_DEEPSLTIME				;// Duration of the last deep sleep phase
wire [10:0] 	w_TWEXT						;
wire [10:0] 	w_TWOSC						;
wire [ 9:0] 	w_TWRM 						;
// }

//PD_RET	
wire			w_NFC_SP_RSTB		;
wire [11:0]		w_NFC_SP_A			;
wire 			w_NFC_SP_CLK		;	
wire  			w_NFC_SP_CEN		;	
wire [ 3:0]		w_NFC_SP_WEN		;	
wire [31:0]		w_NFC_SP_D			;		
wire 			w_NFC_SP_MUXSEL		;
wire 			w_NFC_SP_MUXSEL_TM	;
wire			w_OSC_L_EN			;

`ifdef	RTL
wire	w_DEEP_SLEEP_ON_ISO;				
CLK_MUX u_DEEP_SLEEP_ON_ISO	(.A(w_DEEP_SLEEP_ON	), .B(1'b1), .S(w_ISO_PEN), .Y(w_DEEP_SLEEP_ON_ISO));
`endif

wire	w_I_ROM_EN_C_C2A;

PD_AON u_PD_AON (
/*input  wire			*/	.SE						(w_SCAN_EN				),
/*input  wire			*/	.TE						(w_SCAN_MD				),
/*input  wire			*/	.TRESETN				(w_SCAN_RSTN			),
/*input  wire			*/	.THCLK					(w_SCAN_HCLK			),

// PAD Interface
/*input wire			*/	.I_ROM_EN_C		        (w_I_ROM_EN_C_C2A		),

//// AHB Common
/*input  wire			*/	.I_POR					(w_POR_TM[2]			),
/*input wire			*/	.I_RTC_CLK				(w_RTC_CLK[2]			),
/*input wire			*/	.I_OSC_L_EN				(w_OSC_L_EN				),
// PMU
/*output wire [3:0]		*/	.O_ABGR_CONT			(w_ABGR_CONT			),  		
/*output wire [3:0]		*/	.O_ABGR_TC				(w_ABGR_TC				),
/*output wire [5:0]		*/	.O_ALDO_CONT			(w_ALDO_CONT			),
/*output wire 			*/	.O_ALDO_EN				(w_ALDO_EN				),
/*output wire 			*/	.O_ALDO_EN_SEL			(w_ALDO_EN_SEL			),
/*output wire 			*/	.O_RTC_EN				(w_RTC_EN				),
/*output wire 			*/	.O_RTC_EN_SEL			(w_RTC_EN_SEL			),
/*output wire [10:0]	*/	.O_RTC_SCKF				(w_RTC_SCKF				),
/*output wire			*/	.O_FLDO_PEN				(w_FLDO_PEN				),
/*output wire			*/	.O_FLDO_LP_EN			(w_FLDO_LP_EN			),
/*output wire [3:0]		*/	.O_FLDO_CONT			(w_FLDO_CONT			),
/*output wire			*/	.O_FLDO_BYPASS			(w_FLDO_BYPASS			),
/*output wire			*/	.O_FLDO_POK_EN			(w_FLDO_POK_EN			),
/*input wire			*/	.I_FLDO_POK				(w_FLDO_POK				),
/*output wire			*/	.O_MLDO_PEN				(w_MLDO_PEN				),
/*output wire			*/	.O_MLDO_LP_EN			(w_MLDO_LP_EN			),
/*output wire [5:0]		*/	.O_MLDO_CONT			(w_MLDO_CONT			),
/*output wire			*/	.O_MLDO_POK_EN			(w_MLDO_POK_EN			),
/*input wire			*/	.I_MLDO_POK				(w_MLDO_POK				),
/*output wire			*/	.O_RET_LDO_EN			(w_RET_LDO_EN			),	// r2
/*output wire [3:0]		*/	.O_RET_LDO_CONT			(w_RET_LDO_CONT			),	// r2
/*output wire			*/	.O_BOD_EN				(w_BOD_EN				),	// r2
/*output wire			*/	.O_DCDC_PRECHG_PEN		(w_DCDC_PRECHG_PEN		),
/*output wire			*/	.O_DCDC_CORE_PEN		(w_DCDC_CORE_PEN		),
/*output wire			*/	.O_DCDC_REF_PEN			(w_DCDC_REF_PEN			),
/*output wire [5:0]		*/	.O_DCDC_SET_VOUT		(w_DCDC_SET_VOUT		),
/*output wire [2:0]		*/	.O_DCDC_CUR_TRIM		(w_DCDC_CUR_TRIM 		),  
/*output wire [1:0]		*/	.O_FLDO_POK_TRIM		(w_FLDO_POK_TRIM 		),  
/*output wire [1:0]		*/	.O_MLDO_POK_TRIM		(w_MLDO_POK_TRIM 		),  
/*output wire [3:0]		*/	.O_DCDC_DT_TRIM			(w_DCDC_DT_TRIM	 		),
/*output wire			*/	.O_DCDC_POK_EN			(w_DCDC_POK_EN	  		),
/*output wire [3:0]		*/	.O_DCDC_CLIMIT_RTRIMB	(w_DCDC_CLIMIT_RTRIMB	),	//r2
/*output wire [3:0]		*/	.O_DCDC_ISENS_RTRIM		(w_DCDC_ISENS_RTRIM		),
/*output wire [2:0]		*/	.O_DCDC_ZCD_CTRIM		(w_DCDC_ZCD_CTRIM		),
/*output wire [2:0]		*/	.O_EXT_PFM_VREF			(w_EXT_PFM_VREF			),
/*output wire [3:0]		*/	.O_DCDC_PRECHG_DUR		(w_DCDC_PRECHG_DUR		),
/*output wire [3:0]		*/	.O_DCDC_POK_TRIM		(w_DCDC_POK_TRIM		),
/*output wire [3:0]		*/	.O_MBGR_TC_TRIM			(w_MBGR_TC_TRIM			),	//r2-->r3
/*output wire [5:0]		*/	.O_MBGR_OUT_TRIM		(w_MBGR_OUT_TRIM		),	//r2
/*output wire 			*/	.O_MBGR_EN				(w_MBGR_EN				),	//r2
///*output wire 			*/	.O_DA_LDO_BMUX			(w_DA_LDO_BMUX			),	//r2
///*output wire 			*/	.O_GPADC_BMUX			(w_GPADC_BMUX			),	//r2	
/*output wire [1:0]		*/	.O_BOD_VREFH			(w_BOD_VREFH			),	//r3
/*output wire [1:0]		*/	.O_BOD_VREFL			(w_BOD_VREFL			),	//r3
/*output wire [1:0]		*/	.O_DA_LDO_TAIL_CONT		(w_DA_LDO_TAIL_CONT		),
/*input  wire 			*/	.I_BOD_RSTB				(w_BOD_RSTB				),	//r2
/*input wire			*/	.I_DCDC_POK				(w_DCDC_POK		   		),
/*output wire			*/	.O_DCDC_MODE			(w_DCDC_MODE			),
//ETC
/*output wire [7:0]		*/	.O_SPI_RSV_AON			(w_SPI_RSV_AON			),
//NFC Mask
/*input wire			*/	.I_WAKEUP_MASK			(w_NFC_WAKEUP			),
/*output wire			*/	.O_NFC_EN				(w_NFC_EN				),
/*output wire [1:0]		*/	.O_NFC_TMUX_SEL			(w_NFC_TMUX_SEL			),
/*output wire			*/	.O_NFC_WUR_THR_SEL		(w_NFC_WUR_THR_SEL		),
/*output wire			*/	.O_NFC_VRECT_RDY_WUR	(w_NFC_VRECT_RDY_WUR	),
/*output wire [3:0]		*/	.O_NFC_WUR_THR			(w_NFC_WUR_THR			),
/*output wire			*/	.O_NFC_VRECT_RDY_EXT	(w_NFC_VRECT_RDY_EXT	),
/*output  wire [2:0]	*/	.O_NFC_SKP_PULSE		(w_NFC_SKP_PULSE		),
/*output  wire [6:0]	*/	.O_NFC_IF_THR			(w_NFC_IF_THR			),
/*input  wire			*/	.I_NFC_CLK				(w_NFC_CLK				),
/*input  wire			*/	.I_NFC_WRITE			(w_NFC_WRITE			),
/*input  wire [7:0]		*/	.I_NFC_WDATA			(w_NFC_WDATA			),
/*input wire			*/	.I_NFC_TEST_OUT			(w_NFC_TEST_OUT			),

//PD_RET	
/*output wire 			*/	.O_NFC_SP_RSTB			(w_NFC_SP_RSTB			),
/*output wire [11:0]	*/	.O_NFC_SP_A				(w_NFC_SP_A				),
/*output wire 			*/	.O_NFC_SP_CLK			(w_NFC_SP_CLK			),	
/*output wire  			*/	.O_NFC_SP_CEN			(w_NFC_SP_CEN			),	
/*output wire [ 3:0]	*/	.O_NFC_SP_WEN			(w_NFC_SP_WEN			),	
/*output wire [31:0]	*/	.O_NFC_SP_D				(w_NFC_SP_D				),		
/*output wire 			*/	.O_NFC_SP_MUXSEL		(w_NFC_SP_MUXSEL		),

/*output wire       	*/	.O_SLEEP_ON				(w_SLEEP_ON				),
/*output wire       	*/	.O_ISO_PEN				(w_ISO_PEN				),
/*output wire       	*/	.O_RET_PEN				(w_RET_PEN				),
/*output wire [4:0]		*/	.O_PWR_SRAM_PERI_DIG	(w_PWR_SRAM_PERI_DIG	),
/*output wire [4:0]		*/	.O_PWR_SRAM_CORE_DIG	(w_PWR_SRAM_CORE_DIG	),
/*output wire [4:0]		*/	.O_PWR_SRAM_CORE_RET	(w_PWR_SRAM_CORE_RET	),

/*output wire	[4:0]	*/	.O_AON_GPIO_OEN			(w_AON_GPIO_OEN			), 
/*output wire	[4:0]	*/	.O_AON_GPIO_OUT			(w_AON_GPIO_OUT			), 
/*output wire	[4:0]	*/	.O_AON_GPIO_IE			(w_AON_GPIO_IE			), 
/*output wire [4:0] 	*/	.O_AON_GPIO_PE			(w_AON_GPIO_PE			), 
/*output wire [4:0] 	*/	.O_AON_GPIO_PS			(w_AON_GPIO_PS			), 
/*input wire	[4:0]	*/	.I_AON_GPIO_IN			(w_AON_GPIO_IN			), 
/*input wire			*/	.I_GPIO_AON_EN			(w_GPIO_AON_EN			),

/*output wire [3:0]		*/	.O_AON_XO_STUP_DLY		(w_AON_XO_STUP_DLY		),
/*output wire [5:0]		*/	.O_AON_xo_cs			(w_AON_xo_cs			), 
/*output wire [5:0] 	*/	.O_AON_xo_cl			(w_AON_xo_cl			), 
/*output wire 			*/	.O_AON_XO_MODE			(w_AON_XO_MODE			),
/*output wire			*/	.O_AON_XO_PEN_MODE		(w_AON_XO_PEN_MODE		),	
/*output wire			*/	.O_AON_XO_PEN			(w_AON_XO_PEN			), 
/*output wire [5:0]		*/	.O_AON_XO_CS_sta		(w_AON_XO_CS_sta		), 
/*output wire [5:0]		*/	.O_AON_XO_CL_sta		(w_AON_XO_CL_sta		),  
/*output wire			*/	.O_AON_XO_CS_MODE		(w_AON_XO_CS_MODE		),
/*output wire			*/	.O_AON_XO_CL_MODE		(w_AON_XO_CL_MODE		), 
/*output wire [1:0]		*/	.O_AON_XO_FAST_STUP_EN	(w_AON_XO_FAST_STUP_EN	),  

// BGRIP_AON <=> BGRIP_TOP_WRAP {
/*	output wire        */	.O_MASTER1_GCLKEN		(w_MASTER1_GCLKEN		),

/*	output wire  [9:0] */	.O_FINECNT_32K_SAMP		(w_FINECNT_32K_SAMP		),
/*	output wire [27:0] */	.O_CLKNCNT_32K_SAMP		(w_CLKNCNT_32K_SAMP 	),
/*	output wire        */	.O_DEEP_SLEEP_STAT_32K	(w_DEEP_SLEEP_STAT_32K	),
/*	output wire        */	.O_WAKEUP_LP			(w_WAKEUP_LP			),
/*	output wire        */	.O_TOGGLE_SLEEPREF		(w_TOGGLE_SLEEPREF		),
/*	output wire        */	.O_DEEP_SLEEP_ON_32K_TRIG(w_DEEP_SLEEP_ON_32K_TRIG),
/*	output wire [31:0] */	.O_DEEPSLDUR			(w_DEEPSLDUR			),              

/*	input wire         */	.I_EXTWKUPDSB			(w_EXTWKUPDSB			),
/*	input  wire  [9:0] */	.I_FINECNT				(w_FINECNT				),
/*	input  wire [27:0] */	.I_CLKNCNT				(w_CLKNCNT				),
/*	input wire         */	.I_DEEP_SLEEP_STAT		(w_DEEP_SLEEP_STAT		),
/*	input wire         */	.I_WAKEUP_REQ_TRIG		(w_WAKEUP_REQ_TRIG		),

`ifdef	RTL
/*	input wire         */	.I_DEEP_SLEEP_ON		(w_DEEP_SLEEP_ON_ISO	),
`else
/*	input wire         */	.I_DEEP_SLEEP_ON		(w_DEEP_SLEEP_ON	),
`endif
/*	input wire         */	.I_OSC_SLEEP_ON			(w_OSC_SLEEP_ON		),
/*	input wire         */	.I_RADIO_SLEEP_ON		(w_RADIO_SLEEP_ON	),

/*	input  wire [31:0] */	.I_DEEPSLTIME			(w_DEEPSLTIME		),
/*	input  wire [10:0] */	.I_TWEXT				(w_TWEXT			),
/*	input  wire [10:0] */	.I_TWOSC				(w_TWOSC			),
/*	input  wire [ 9:0] */	.I_TWRM					(w_TWRM				),
// }

//avoid optimization issue
/*input wire [2:0]		*/	.I_GPIO_C2A_PAD_OE		(w_GPIO_C2A_PAD_OE[29:27]	),
/*input wire [2:0]		*/	.I_GPIO_C2A_PAD_OUT		(w_GPIO_C2A_PAD_OUT[29:27]	),
/*input wire [2:0]		*/	.I_GPIO_C2A_PAD_DS		(w_GPIO_C2A_PAD_DS[29:27]	),
/*input wire [2:0]		*/	.I_GPIO_C2A_PAD_IE		(w_GPIO_C2A_PAD_IE[29:27]	),
/*input wire [2:0]		*/	.I_GPIO_C2A_PAD_PE		(w_GPIO_C2A_PAD_PE[29:27]	),
/*input wire [2:0]		*/	.I_GPIO_C2A_PAD_PS		(w_GPIO_C2A_PAD_PS[29:27]	),

// SPI Slave
/*input  wire			*/	.I_SPI_CSN_PD			(w_SPI_CSN_PD		),
/*input  wire			*/	.I_SPI_SCK_PD			(w_SPI_SCK_PD		),
/*input  wire			*/	.I_SPI_MOSI_PD			(w_SPI_MOSI_PD		),
/*output wire			*/	.O_SPI_MISO_PD			(w_SPI_MISO_PD		)
);

wire		w_PD_CORE_RSTB;
wire		w_PD_CORE_RSTB_p	= (w_ISO_P_ENB & w_POR_TM[2]);
CLK_MUX u_PD_CORE_RSTB (.A(w_PD_CORE_RSTB_p), .B(w_SCAN_RSTN), .S(w_SCAN_MD), .Y(w_PD_CORE_RSTB));

wire	w_LS_EN;
TIE_HI	u_LS_EN	(.Y(w_LS_EN));

PD_CORE #(
	.GP_N	(GP_N)
) u_PD_CORE(
`ifdef FPGA
/*input  wire [3:0] 		*/  .PS_AHBS_HPROT			(PS_AHBS_HPROT			),
/*input  wire  				*/	.PS_AHBS_HMSTLOCK		(PS_AHBS_HMSTLOCK		),
/*input  wire [31:0]		*/	.PS_AHBS_HADDR			(PS_AHBS_HADDR			),
/*input  wire [ 1:0]		*/	.PS_AHBS_HTRANS			(PS_AHBS_HTRANS			),
/*input  wire [2:0] 		*/  .PS_AHBS_HBURST			(PS_AHBS_HBURST			),
/*input  wire       		*/	.PS_AHBS_HWRITE			(PS_AHBS_HWRITE			),
/*input  wire [ 2:0]		*/	.PS_AHBS_HSIZE			(PS_AHBS_HSIZE			),
/*input  wire [31:0]		*/	.PS_AHBS_HWDATA			(PS_AHBS_HWDATA			),
/*output wire [31:0]		*/	.PS_AHBS_HRDATA			(PS_AHBS_HRDATA			),
/*output wire [ 1:0]		*/	.PS_AHBS_HRESP			(PS_AHBS_HRESP			),
/*output wire       		*/  .PS_AHBS_HREADY			(PS_AHBS_HREADY			),
/*output wire               */	.O_MCLK					(O_MCLK					),
/*output wire				*/	.BGRIP_ROOT_CLK			(BGRIP_ROOT_CLK			),

/*output wire       		*/	.BBM_XO_EN   			(BBM_XO_EN   			),
/*output wire       		*/	.BBM_CH_EN   			(BBM_CH_EN   			),
/*output wire       		*/	.BBM_RX_EN   			(BBM_RX_EN   			),
/*output wire       		*/	.BBM_TX_EN   			(BBM_TX_EN   			),
/*output wire       		*/	.BBM_SPI_CS  			(BBM_SPI_CS  			),
/*output wire       		*/	.BBM_SPI_CK  			(BBM_SPI_CK  			),
/*output wire       		*/	.BBM_SPI_DW  			(BBM_SPI_DW  			),
/*input  wire       		*/	.BBM_SPI_DR  			(BBM_SPI_DR  			),
/*output wire       		*/	.BBM_SCP_CS  			(BBM_SCP_CS  			),
/*input  wire       		*/	.BBM_SCP_DR  			(BBM_SCP_DR  			),
/*output wire       		*/	.BBM_TXD_LLC 			(BBM_TXD_LLC 			),
/*output wire       		*/	.BBM_Z2C_STB 			(BBM_Z2C_STB 			),
/*output wire [ 3:0]		*/	.BBM_Z2C_DAT 			(BBM_Z2C_DAT 			),
/*input  wire       		*/	.BBM_C2Z_STB 			(BBM_C2Z_STB 			),
/*input  wire [ 3:0]		*/	.BBM_C2Z_DAT 			(BBM_C2Z_DAT 			),
`endif
//eFuse
`ifdef	RTL
	`ifndef	TSMC55_ULP
/*inout wire				*/	.VQPS					(VQPS					),
	`else
/*inout wire				*/	.VDDQ					(VDDQ					),
	`endif
`endif
///*input wire				*/	.I_EFUSE_TEST_VEN		(w_EFUSE_TEST_VEN 		),	
/*input wire				*/	.I_EFUSE_TEST_MD		(w_EFUSE_TEST_MD  		),	
/*input wire				*/	.I_EFUSE_TEST_CSB		(w_EFUSE_TEST_CSB		),
`ifndef TEF55ULP256	
/*input wire				*/	.I_EFUSE_TEST_PGENB		(w_EFUSE_TEST_PGENB		),
/*input wire				*/	.I_EFUSE_TEST_STROBE	(w_EFUSE_TEST_STROBE	),
/*input wire				*/	.I_EFUSE_TEST_LOAD		(w_EFUSE_TEST_LOAD		),
/*output wire	[7:0]		*/	.O_EFUSE_TEST_Q			(w_EFUSE_TEST_Q			),
	`ifdef	TSMC55_ULP                              	                  
/*input wire	[9:0]		*/	.I_EFUSE_TEST_A			(w_EFUSE_TEST_A			),
	`else                                          	                  
/*input wire	[7:0]		*/	.I_EFUSE_TEST_A			(w_EFUSE_TEST_A			),
///*input wire				*/	.I_EFUSE_TEST_SEL		(w_EFUSE_TEST_SEL		),
/*input wire				*/	.I_EFUSE_TEST_PS		(w_EFUSE_TEST_PS		),
	`endif
`else
/*input wire				*/	.I_EFUSE_TEST_SEL		(w_EFUSE_TEST_SEL 		),	
/*input wire				*/	.I_EFUSE_TEST_SCLK		(w_EFUSE_TEST_SCLK		), 	
/*input wire				*/	.I_EFUSE_TEST_PGM		(w_EFUSE_TEST_PGM 		),	
/*input wire				*/	.I_EFUSE_TEST_DIN		(w_EFUSE_TEST_DIN 		),	
/*output wire 				*/	.O_EFUSE_TEST_DOUT		(w_EFUSE_TEST_DOUT		),
`endif

// Analog Interface     	  
/*input wire				*/	.I_LS_EN		        (w_LS_EN				),	//Level Shifter Enable
/*input wire				*/	.I_RET_EN		        (ww_RET_PEN				),	//Retention Enable
/*input wire				*/	.I_RET_ENB		        (ww_RET_PENB			),	//Retention Enable Inversion
/*input wire				*/	.I_POR			        (w_PD_CORE_RSTB			),
/*input wire				*/	.I_RTC_CLK		        (w_RTC_CLK[1]			),
/*input wire				*/	.I_RFC_CLKT		        (I_RFC_CLKT				),
/*input wire				*/	.I_RFC_CLKB		        (I_RFC_CLKB				),
/*input wire				*/	.I_PLL_SDM_CLKT			(I_PLL_SDM_CLKT			),
/*input wire				*/	.I_PLL_SDM_CLKB			(I_PLL_SDM_CLKB			),

/*input wire				*/	.O_RFC_CLKT		        (w_RFC_CLKT				),
/*input wire				*/	.O_RFC_CLKB		        (w_RFC_CLKB				),

//
/*input wire				*/	.I_ANA_TEST_MD			(w_ANAT_MD				),
/*input wire				*/	.I_ANAT_HCLK			(w_ANAT_HCLK			),
// PD_AON
/*output  wire				*/	.O_SPI_CSN_PD			(w_SPI_CSN_PD 			),
/*output  wire				*/	.O_SPI_SCK_PD			(w_SPI_SCK_PD 			),
/*output  wire				*/	.O_SPI_MOSI_PD			(w_SPI_MOSI_PD			),
/*input wire				*/	.I_SPI_MISO_PD			(w_SPI_MISO_PD			),
/*output wire				*/	.O_GPIO_AON_EN			(w_GPIO_AON_EN			),

/*output wire				*/	.O_OSC_L_EN				(w_OSC_L_EN				),

/*input wire				*/	.I_SCAN_MD				(w_SCAN_MD				),
/*input wire				*/	.I_SCAN_EN				(w_SCAN_EN				),
/*input wire				*/	.I_SCAN_HCLK			(w_SCAN_HCLK			),
/*input wire				*/	.I_SCAN_HCLK_1			(w_SCAN_HCLK_1			),
/*input wire				*/	.I_SCAN_LCLK			(w_SCAN_LCLK			),
/*input wire				*/	.I_SCAN_RSTN			(w_SCAN_RSTN			),

/*input wire				*/	.I_BIST_MD				(w_BIST_MD				),
/*input wire				*/	.I_BIST_RSTN			(w_BIST_RSTN			),
/*input wire				*/	.I_BIST_CLK				(w_BIST_CLK				),
/*output wire	[7:0]		*/	.O_BIST_DONE			(w_BIST_DONE			),
/*output wire	[7:0]		*/	.O_BIST_FAIL			(w_BIST_FAIL			),
/*output wire	[7:0]		*/	.O_BIST_MISR			(w_BIST_MISR			),
//
/*output wire				*/	.TEST_EN_ANA			(w_TEST_EN_ANA			),
/*output wire				*/	.TEST_EN_SYS			(w_TEST_EN_SYS			),
/*output wire				*/	.TEST_EN_MASK			(w_TEST_EN_MASK			),

/*input wire 				*/	.I_NFC_SP_RSTB			(w_NFC_SP_RSTB			),
/*input wire [11:0]			*/	.I_NFC_SP_A				(w_NFC_SP_A				),
/*input wire 				*/	.I_NFC_SP_CLK			(w_NFC_SP_CLK			),	
/*input wire  				*/	.I_NFC_SP_CEN			(w_NFC_SP_CEN			),	
/*input wire [ 3:0]			*/	.I_NFC_SP_WEN			(w_NFC_SP_WEN			),	
/*input wire [31:0]			*/	.I_NFC_SP_D				(w_NFC_SP_D				),		
/*input wire 				*/	.I_NFC_SP_MUXSEL		(w_NFC_SP_MUXSEL		),
//
// PMU
/*output wire				*/	.O_DA_LDO_EN			(O_DA_LDO_EN			),	// r2
/*output wire				*/	.O_DA_LDO_BYPASS		(O_DA_LDO_BYPASS		),	// r2
/*output wire [5:0]			*/	.O_DA_LDO_CONT			(O_DA_LDO_CONT			),	// r2
/*output wire 				*/	.O_GPADC_BMUX			(O_GPADC_BMUX			),	//r3	
// PLL
/*output wire				*/	.O_PLL_PEN				(O_PLL_PEN				),
/*output wire				*/	.O_PLL_COARSELOCK	    (O_PLL_COARSELOCK		),
/*output wire				*/	.O_PLL_OUT_PEN		    (O_PLL_OUT_PEN			),
/*output wire				*/	.O_PLL_DIV2_OUT_PEN	    (O_PLL_DIV2_OUT_PEN		),
///*output wire	[1:0]		*/	.O_PLL_CP_BCONT		    (O_PLL_CP_BCONT			),
/*output wire 				*/	.O_PLL_CP_UGB_EN      	(O_PLL_CP_UGB_EN      	),	
/*output wire [2:0]			*/	.O_PLL_CP_UGB_CONT    	(O_PLL_CP_UGB_CONT    	),
/*output wire [2:0]			*/	.O_PLL_CP_LEAK_EN     	(O_PLL_CP_LEAK_EN     	),
/*output wire 				*/	.O_PLL_CP_LEAK_COMP_EN	(O_PLL_CP_LEAK_COMP_EN	),
/*output wire [2:0]			*/	.O_PLL_PFD_DELAY      	(O_PLL_PFD_DELAY      	),
/*output wire	[2:0]		*/	.O_PLL_CP_CELL_EN	    (O_PLL_CP_CELL_EN		),
///*output wire	[4:0]		*/	.O_PLL_CP_LEAK_COMP	    (O_PLL_CP_LEAK_COMP		),
/*output wire	[9:0]		*/	.O_PLL_VCO_CAP		    (O_PLL_VCO_CAP			),
/*output wire	[7:0]		*/	.O_PLL_PM_CAP		    (O_PLL_PM_CAP			),
/*output wire	[4:0]		*/	.O_PLL_PC			    (O_PLL_PC				),
/*output wire	[1:0]		*/	.O_PLL_SC			    (O_PLL_SC				),
/*output wire				*/	.O_PLL_CNT_MASK		    (O_PLL_CNT_MASK			),
/*output wire				*/	.O_PLL_CT_RST		    (O_PLL_CT_RST			),
/*output wire	[2:0]		*/	.O_PLL_CT_VC_CONT	    (O_PLL_CT_VC_CONT		),
/*output wire	[2:0]		*/	.O_PLL_KVCO_VB1		    (O_PLL_KVCO_VB1			),
/*output wire	[2:0]		*/	.O_PLL_KVCO_VB2		    (O_PLL_KVCO_VB2			),
/*input wire 	[12:0]		*/	.I_PLL_CT_CNT		    (I_PLL_CT_CNT			),
// RFRX
/*output wire				*/	.O_TRX_SEL				(O_TRX_SEL				),	
/*output wire				*/	.O_RX_RF_PEN		    (O_RX_RF_PEN			),
/*output wire				*/	.O_MIX_BUF_PEN		    (O_MIX_BUF_PEN			),
/*output wire	[1:0]		*/	.O_RX_RF_GC			    (O_RX_RF_GC				),
/*output wire	[2:0]		*/	.O_LNTA_BIAS		    (O_LNTA_BIAS			),
/*output wire	[2:0]		*/	.O_LNTA_BIAS2		    (O_LNTA_BIAS2			),
/*output wire	[2:0]		*/	.O_MIX_I_BIAS		    (O_MIX_I_BIAS			),
/*output wire	[2:0]		*/	.O_MIX_IB_BIAS		    (O_MIX_IB_BIAS			),
/*output wire	[2:0]		*/	.O_MIX_Q_BIAS		    (O_MIX_Q_BIAS			),
/*output wire	[2:0]		*/	.O_MIX_QB_BIAS		    (O_MIX_QB_BIAS			),
// RFTX                 	                                            		
/*output wire				*/	.O_TX_BUF_PEN		    (O_TX_BUF_PEN			),
/*output wire				*/	.O_TX_PRE_PEN		    (O_TX_PRE_PEN			),
/*output wire				*/	.O_TX_DA_PEN		    (O_TX_DA_PEN			),
/*output wire	[3:0]		*/	.O_TX_DA_GC			    (O_TX_DA_GC				),
// ABB
/*output wire				*/	.O_ABB_PEN				(O_ABB_PEN				),
/*output wire				*/	.O_ABB_BIAS_STUP		(O_ABB_BIAS_STUP		),
/*output wire	[2:0]		*/	.O_ABB_BIAS1		    (O_ABB_BIAS1			),
/*output wire	[2:0]		*/	.O_ABB_BIAS2		    (O_ABB_BIAS2			),
/*output wire	[2:0]		*/	.O_ABB_VCOM			    (O_ABB_VCOM				),	
/*output wire	[4:0]		*/	.O_ABB_IFC_CC		    (O_ABB_IFC_CC			),
/*output wire	[2:0]		*/	.O_ABB_TIA_GC		    (O_ABB_TIA_GC			),
/*output wire				*/	.O_ABB_TIA_RCF_EN	    (O_ABB_TIA_RCF_EN		),
/*output wire				*/	.O_ABB_TIA_CFB_EN	    (O_ABB_TIA_CFB_EN		),
/*output wire	[4:0]		*/	.O_ABB_TIA_CC		    (O_ABB_TIA_CC	  		),
/*output wire	[3:0]		*/	.O_ABB_TIA_STB		    (O_ABB_TIA_STB	  		),
/*output wire				*/	.O_ABB_TIA_MIR		    (O_ABB_TIA_MIR	  		),
/*output wire	[1:0]		*/	.O_ABB_FLT_GC		    (O_ABB_FLT_GC	  		),
/*output wire	[4:0]		*/	.O_ABB_FLT_CC		    (O_ABB_FLT_CC	  		),
/*output wire	[4:0]		*/	.O_ABB_FLT_ZC		    (O_ABB_FLT_ZC	  		),
/*output wire				*/	.O_ABB_FLT_SKIP		    (O_ABB_FLT_SKIP  		),   
/*output wire				*/	.O_ABB_FLT_WB		    (O_ABB_FLT_WB	  		),
/*output wire	[4:0]		*/	.O_ABB_FLT_IF		    (O_ABB_FLT_IF	  		),
///*output wire				*/	.O_ABB_ACC_SWAP_EN	    (O_ABB_ACC_SWAP_EN 		),R3
///*output wire				*/	.O_ABB_ACC_SWAP		    (O_ABB_ACC_SWAP  		),R3   
/*output wire	[2:0]		*/	.O_ABB_ACC_BW		    (O_ABB_ACC_BW	  		),
/*output wire				*/	.O_ABB_ACC_SKIP		    (O_ABB_ACC_SKIP  		),   
/*output wire	[4:0]		*/	.O_ABB_PGA_GC		    (O_ABB_PGA_GC	  		),
/*output wire	[1:0]		*/	.O_ABB_PGA_CFB		    (O_ABB_PGA_CFB	  		),
/*output wire	[2:0]		*/	.O_ABB_DRV_OMODE	    (O_ABB_DRV_OMODE 		),
/*output wire				*/	.O_ABB_DRV_STB_CC	    (O_ABB_DRV_STB_CC  		),
/*output wire	[3:0]		*/	.O_ABB_DRV_TPE		    (O_ABB_DRV_TPE	  		),
/*output wire				*/	.O_ABB_DRV_TP_SWAP	    (O_ABB_DRV_TP_SWAP		),
/*output wire				*/	.O_ABB_TEST_ENI		    (O_ABB_TEST_ENI   		),   
/*output wire				*/	.O_ABB_TEST_ENQ		    (O_ABB_TEST_ENQ   		),   
/*output wire				*/	.O_GPIO01_AN_EN		    (O_GPIO01_AN_EN   		),   
/*output wire				*/	.O_GPIO23_AN_EN		    (O_GPIO23_AN_EN   		),   
/*output wire				*/	.O_AN_TEST_EN		    (O_AN_TEST_EN	   		),
/*output wire				*/	.O_GPIO4_AN_EN		    (O_GPIO4_AN_EN	   		),
/*output wire	[2:0]		*/	.O_AN_TEST_MUX		    (O_AN_TEST_MUX	   		),
/*output wire				*/	.O_GPIO_TEST_BUF_EN		(O_GPIO_TEST_BUF_EN		),
/*output wire				*/	.O_GPIO_TEST_CUR_EN		(O_GPIO_TEST_CUR_EN		),
// FT	                	                                            		  
/*output wire				*/	.O_FT_PEN			    (O_FT_PEN		   		),
/*output wire				*/	.O_FT_RST			    (O_FT_RST		   		),
/*output wire				*/	.O_FT_CLK			    (O_FT_CLK		   		),
/*output wire				*/	.O_FT_BIAS_STUP		    (O_FT_BIAS_STUP	   		),
/*input wire	[4:0]		*/	.I_FT_CC			    (I_FT_CC		   		),
/*input wire				*/	.I_FT_DONE			    (I_FT_DONE		   		),
// ADC                  	                                             		
/*output wire				*/	.O_ADC_PEN			    (O_ADC_PEN		   		),
/*output wire				*/	.O_ADC_CLKT			    (O_ADC_CLKT	 	  		),   
/*output wire				*/	.O_ADC_CLKB			    (O_ADC_CLKB	   			),   
/*output wire	[2:0]		*/	.O_ADC_FS			    (O_ADC_FS		   		),
/*input wire				*/	.I_ADC_ICONV_RDY	    (I_ADC_ICONV_RDY  		),
/*input wire	[7:0]		*/	.I_ADC_IDATA		    (I_ADC_IDATA	   		),
/*input wire				*/	.I_ADC_QCONV_RDY	    (I_ADC_QCONV_RDY  		),
/*input wire	[7:0]		*/	.I_ADC_QDATA		    (I_ADC_QDATA	   		),
/*output wire				*/	.O_ADC_CONV_RDY_MODE    (O_ADC_CONV_RDY_MODE	),
// GPADC                	                                                	 
/*output wire				*/	.O_GPADC_PEN		    (O_GPADC_PEN			),
/*output wire	[3:0]		*/	.O_GPADC_MUXSEL		    (O_GPADC_MUXSEL			),	
/*output wire				*/	.O_GPADC_BUF_EN		    (O_GPADC_BUF_EN			),	
/*output wire				*/	.O_GPADC_AMP_CHOP_EN    (O_GPADC_AMP_CHOP_EN	),
/*output wire				*/	.O_GPADC_CLKT		    (O_GPADC_CLKT			),
/*output wire				*/	.O_GPADC_CLKB		    (O_GPADC_CLKB			),
/*output wire				*/	.O_GPADC_FILT_EN	    (O_GPADC_FILT_EN		),
/*output wire				*/	.O_GPADC_CSTATE		    (O_GPADC_CSTATE			),	
/*output wire	[2:0]		*/	.O_GPADC_INBUF_BIAS	    (O_GPADC_INBUF_BIAS		),	
/*output wire	[2:0]		*/	.O_GPADC_AMP1_BIAS	    (O_GPADC_AMP1_BIAS		),
/*output wire	[2:0]		*/	.O_GPADC_AMP2_BIAS	    (O_GPADC_AMP2_BIAS		),
/*output wire	[2:0]		*/	.O_GPADC_BGR_BIAS	    (O_GPADC_BGR_BIAS		),
/*output wire	[2:0]		*/	.O_GPADC_VCM_BIAS 		(O_GPADC_VCM_BIAS		),
/*output wire	[2:0]		*/	.O_GPADC_VCM_CONT	    (O_GPADC_VCM_CONT		),
/*output wire	[1:0]		*/	.O_GPADC_VREFP_CONT	    (O_GPADC_VREFP_CONT		),
/*output wire	[1:0]		*/	.O_GPADC_VREFN_CONT	    (O_GPADC_VREFN_CONT		),	
/*input wire				*/	.I_GPADC_RSTGEN_CLK	    (I_GPADC_RSTGEN_CLK		),	
/*input wire				*/	.I_GPADC_DSMRST		    (I_GPADC_DSMRST			),	
/*input wire	[1:0]		*/	.I_GPADC_DOUT		    (I_GPADC_DOUT			),
/*input wire				*/	.I_GPADC_DCLK		    (I_GPADC_DCLK			),
/*output wire	[1:0]		*/	.O_GPADC_AMP1_VB		(O_GPADC_AMP1_VB		),
/*output wire	[1:0]		*/	.O_GPADC_AMP2_VB		(O_GPADC_AMP2_VB		),
/*output wire				*/	.O_GPADC_ATT_BYP_EN		(O_GPADC_ATT_BYP_EN		),
/*output wire				*/	.O_GPADC_ATT_VSEL		(O_GPADC_ATT_VSEL		),
// TS                   	                                                	 
/*output wire				*/	.O_TS_PEN			    (O_TS_PEN				),
/*output wire	[3:0]		*/	.O_TS_DEM_CLK		    (O_TS_DEM_CLK			),
/*output wire				*/	.O_TS_CHOP_CLK		    (O_TS_CHOP_CLK			),
/*output wire	[1:0]		*/	.O_TS_CAL			    (O_TS_CAL				),
/*output wire				*/	.O_TS_SEL			    (O_TS_SEL				),
/*output wire				*/	.O_TS_CHOP_ON		    (O_TS_CHOP_ON			),
/*output wire				*/	.O_TS_DEM_ON		    (O_TS_DEM_ON			),
/*output wire	[3:0]		*/	.O_TS_TRIM				(O_TS_TRIM				),
// XO                   	                                          	  
/*output wire				*/	.O_XO_PEN			    (O_XO_PEN				),
/*output wire				*/	.O_XO_MODE			    (O_XO_MODE				),
/*output wire	[5:0]		*/	.O_XO_CS			    (O_XO_CS				),
/*output wire	[5:0]		*/	.O_XO_CL			    (O_XO_CL				),
/*output wire				*/	.O_XO_PLL_CLK_EN	    (O_XO_PLL_CLK_EN		),
/*output wire				*/	.O_XO_RFC_CLK_EN	    (O_XO_RFC_CLK_EN		),
/*input wire				*/	.I_RTC_CLKT				(I_RTC_CLKT				),
//AON XO --> AFE XO
/*input wire [3:0]			*/	.I_AON_XO_STUP_DLY		(w_AON_XO_STUP_DLY		),
/*input wire [5:0]			*/	.I_AON_xo_cs			(w_AON_xo_cs			), 
/*input wire [5:0] 			*/	.I_AON_xo_cl			(w_AON_xo_cl			), 
/*input wire 				*/	.I_AON_XO_MODE			(w_AON_XO_MODE			),
/*input wire				*/	.I_AON_XO_PEN_MODE		(w_AON_XO_PEN_MODE		),	
/*input wire				*/	.I_AON_XO_PEN			(w_AON_XO_PEN			), 
/*input wire [5:0]			*/	.I_AON_XO_CS_sta		(w_AON_XO_CS_sta		), 
/*input wire [5:0]			*/	.I_AON_XO_CL_sta		(w_AON_XO_CL_sta		),  
/*input wire				*/	.I_AON_XO_CS_MODE		(w_AON_XO_CS_MODE		),
/*input wire				*/	.I_AON_XO_CL_MODE		(w_AON_XO_CL_MODE		), 
/*input wire [1:0]			*/	.I_AON_XO_FAST_STUP_EN	(w_AON_XO_FAST_STUP_EN	),  
//PHASE TRACKING RX
///*output wire				*/	.O_PTRX_EN				(O_PTRX_EN				),	//R2 
//NFC Mask
/*input wire				*/	.I_NFC_TEST_OUT			(I_NFC_TEST_OUT			),
// ETC                  	                             
/*output wire	[23:0]		*/	.O_SPI_RSV_CORE	        (O_SPI_RSV_CORE			),
/*input wire 	[15:0]		*/	.I_DEVICE_ID		    (I_DEVICE_ID			),
// BGRIP_AON <=> BGRIP_TOP_WRAP {
/*	input  wire        		*/	.I_MASTER1_GCLKEN		(w_MASTER1_GCLKEN		),

/*	input  wire  [9:0] 		*/	.I_FINECNT_32K_SAMP		(w_FINECNT_32K_SAMP		),
/*	input  wire [27:0] 		*/	.I_CLKNCNT_32K_SAMP		(w_CLKNCNT_32K_SAMP 	),
/*	input  wire        		*/	.I_DEEP_SLEEP_STAT_32K	(w_DEEP_SLEEP_STAT_32K	),
/*	input  wire        		*/	.I_WAKEUP_LP			(w_WAKEUP_LP			),
/*	input  wire        		*/	.I_TOGGLE_SLEEPREF		(w_TOGGLE_SLEEPREF		),
/*	input  wire        		*/	.I_DEEP_SLEEP_ON_32K_TRIG(w_DEEP_SLEEP_ON_32K_TRIG),
/*	input  wire [31:0] 		*/	.I_DEEPSLDUR			(w_DEEPSLDUR			),              

/*	output wire        		*/	.O_EXTWKUPDSB			(w_EXTWKUPDSB			),
/*	output wire  [9:0] 		*/	.O_FINECNT				(w_FINECNT				),
/*	output wire [27:0] 		*/	.O_CLKNCNT				(w_CLKNCNT				),
/*	output wire        		*/	.O_DEEP_SLEEP_STAT		(w_DEEP_SLEEP_STAT		),
/*	output wire        		*/	.O_WAKEUP_REQ_TRIG		(w_WAKEUP_REQ_TRIG		),
/*	output wire        		*/	.O_DEEP_SLEEP_ON		(w_DEEP_SLEEP_ON		),
/*	output wire        		*/	.O_OSC_SLEEP_ON			(w_OSC_SLEEP_ON			),
/*	output wire        		*/	.O_RADIO_SLEEP_ON		(w_RADIO_SLEEP_ON		),

/*	output wire [31:0] 		*/	.O_DEEPSLTIME			(w_DEEPSLTIME			),              
/*	output wire [10:0] 		*/	.O_TWEXT				(w_TWEXT				),              
/*	output wire [10:0] 		*/	.O_TWOSC				(w_TWOSC				),              
/*	output wire [ 9:0] 		*/	.O_TWRM					(w_TWRM					),              
// }
// PAD Interface
/*input wire				*/	.I_ROM_EN_C		        (I_ROM_EN_C				),
/*output wire				*/	.O_ROM_EN_C		        (w_I_ROM_EN_C_C2A		),
/*input wire				*/	.I_DBG_EN_C		        (I_DBG_EN_C				),
//AON->CORE
/*input wire [GP_NUM-1:0]	*/	.O_GPIO_PAD_OE_TM		(w_GPIO_A2C_PAD_OE[35:05]	),
/*input wire [GP_NUM-1:0]	*/	.O_GPIO_PAD_IE_TM		(w_GPIO_A2C_PAD_IE[35:05]	),
/*input wire [GP_NUM-1:0]	*/	.O_GPIO_PAD_OUT_TM		(w_GPIO_A2C_PAD_OUT[35:05]	),
/*input wire [GP_NUM-1:0]	*/	.O_GPIO_PAD_PE_TM		(w_GPIO_A2C_PAD_PE[35:05]	),
/*input wire [GP_NUM-1:0]	*/	.O_GPIO_PAD_PS_TM		(w_GPIO_A2C_PAD_PS[35:05]	),
/*input wire [GP_NUM-1:0]	*/	.O_GPIO_PAD_DS_TM		(w_GPIO_A2C_PAD_DS[35:05]	),
/*output wire [GP_NUM-1:0]	*/	.I_GPIO_PAD_IN_TM		(w_GPIO_C2A_PAD_IN[35:05]	),
//CORE->PAD
/*output wire [GP_NUM-1:0]	*/	.O_GPIO_OE				(w_GPIO_C2A_PAD_OE[35:05]	),
/*output wire [GP_NUM-1:0]	*/	.O_GPIO_IE				(w_GPIO_C2A_PAD_IE[35:05]	),
/*output wire [GP_NUM-1:0]	*/	.O_GPIO_I				(w_GPIO_C2A_PAD_OUT[35:05]	),
/*output wire [GP_NUM-1:0]	*/	.O_GPIO_PE				(w_GPIO_C2A_PAD_PE[35:05]	),
/*output wire [GP_NUM-1:0]	*/	.O_GPIO_PS				(w_GPIO_C2A_PAD_PS[35:05]	),
/*output wire [GP_NUM-1:0]	*/	.O_GPIO_DS				(w_GPIO_C2A_PAD_DS[35:05]	),
/*input wire [GP_NUM-1:0]	*/	.I_GPIO_C				(w_GPIO_A2C_PAD_IN[35:05]	),
//CORE->AON
/*output wire [GP_NUM-1:0]	*/	.O_GPIO_PAD_OEN			(w_GPIO_PAD_OEN_TM		),
/*output wire [GP_NUM-1:0]	*/	.O_GPIO_PAD_IE			(w_GPIO_PAD_IE_TM		),
/*output wire [GP_NUM-1:0]	*/	.O_GPIO_PAD_OUT			(w_GPIO_PAD_OUT_TM		),
/*output wire [GP_NUM-1:0]	*/	.O_GPIO_PAD_PE			(w_GPIO_PAD_PE_TM		),
/*output wire [GP_NUM-1:0]	*/	.O_GPIO_PAD_PS			(w_GPIO_PAD_PS_TM		),
/*output wire [GP_NUM-1:0]	*/	.O_GPIO_PAD_DS			(w_GPIO_PAD_DS_TM		),
/*input reg [GP_NUM-1:0]	*/	.I_GPIO_PAD_IN			(w_GPIO_PAD_IN_TM_0		)
);

////////////////////////////////////////////////////////////////////////////////
//	IO_MUX
IO_MUX # (
	.GP_NUM	(GP_N	)
) u_IO_MUX (
//
/*input wire				*/	.TEST_EN_ANA		(w_TEST_EN_ANA		),
/*input wire				*/	.TEST_EN_SYS		(w_TEST_EN_SYS		),
/*input wire				*/	.TEST_EN_MASK		(w_TEST_EN_MASK		),
//Core Interface
/*input wire [GP_NUM-1:0]	*/	.O_GPIO_OEN_CORE	(w_GPIO_PAD_OEN_TM_0),
/*input wire [GP_NUM-1:0]	*/	.O_GPIO_IE_CORE		(w_GPIO_PAD_IE_TM_0	),
/*input wire [GP_NUM-1:0]	*/	.O_GPIO_OUT_CORE	(w_GPIO_PAD_OUT_TM_0),
/*input wire [GP_NUM-1:0]	*/	.O_GPIO_PE_CORE		(w_GPIO_PAD_PE_TM_0	),
/*input wire [GP_NUM-1:0]	*/	.O_GPIO_PS_CORE		(w_GPIO_PAD_PS_TM_0	),
/*input wire [GP_NUM-1:0]	*/	.O_GPIO_DS_CORE		(w_GPIO_PAD_DS_TM_0	),
/*output reg [GP_NUM-1:0]	*/	.I_GPIO_IN_CORE		(w_GPIO_PAD_IN_TM	),

/*output wire				*/	.O_ANA_TEST_MD		(w_ANAT_MD			),
/*output wire				*/	.O_ANA_TEST_HCLK	(w_ANAT_HCLK		),
/*output wire				*/	.O_ANA_TEST_LCLK	(w_ANAT_LCLK		),
/*output wire				*/	.O_ANA_TEST_RSTN	(w_ANAT_RSTN		),
/*input wire				*/	.I_POR				(I_AON_RSTB			),
/*input wire				*/	.I_RTC_CLKT			(I_RTC_CLKT			),
/*input wire				*/	.I_RTC_CLKB			(I_RTC_CLKB			),
/*input wire				*/	.I_RFC_CLKT			(w_RFC_CLKT			),
/*input wire				*/	.I_RFC_CLKB			(w_RFC_CLKB			),

/*output wire				*/	.O_SCAN_MD			(w_SCAN_MD			),
/*output wire				*/	.O_SCAN_EN			(w_SCAN_EN			),
/*output wire				*/	.O_SCAN_HCLK		(w_SCAN_HCLK		),
/*output wire				*/	.O_SCAN_HCLK_1		(w_SCAN_HCLK_1		),
/*output wire				*/	.O_SCAN_LCLK		(w_SCAN_LCLK		),
/*output wire				*/	.O_SCAN_RSTN		(w_SCAN_RSTN		),

/*input wire				*/	.I_NFC_EN			(w_NFC_EN			),
/*output wire				*/	.O_NFC_EN_TM		(w_NFC_EN_TM		),

/*output wire				*/	.O_BIST_MD			(w_BIST_MD			),
/*output wire				*/	.O_BIST_RSTN		(w_BIST_RSTN		),
/*output wire				*/	.O_BIST_CLK			(w_BIST_CLK			),
/*input wire	[7:0]		*/	.I_BIST_DONE		(w_BIST_DONE		),
/*input wire	[7:0]		*/	.I_BIST_FAIL		(w_BIST_FAIL		),
/*input wire	[7:0]		*/	.I_BIST_MISR		(w_BIST_MISR		),
	
///*output wire				*/	.O_EFUSE_TEST_VEN	(w_EFUSE_TEST_VEN 	),		
/*output wire				*/	.O_EFUSE_TEST_MD	(w_EFUSE_TEST_MD  	),	
/*	input wire				*/	.O_EFUSE_TEST_CSB	(w_EFUSE_TEST_CSB	),
`ifndef TEF55ULP256	
/*	input wire				*/	.O_EFUSE_TEST_PGENB	(w_EFUSE_TEST_PGENB	),
/*	input wire				*/	.O_EFUSE_TEST_STROBE(w_EFUSE_TEST_STROBE),
/*	input wire				*/	.O_EFUSE_TEST_LOAD	(w_EFUSE_TEST_LOAD	),
/*	output wire	[7:0]		*/	.I_EFUSE_TEST_Q		(w_EFUSE_TEST_Q		),
	`ifdef	TSMC55_ULP                                                
/*	input wire	[9:0]		*/	.O_EFUSE_TEST_A		(w_EFUSE_TEST_A		),
	`else                                                             
/*	input wire	[7:0]		*/	.O_EFUSE_TEST_A		(w_EFUSE_TEST_A		),
///*input wire				*/	.O_EFUSE_TEST_SEL	(w_EFUSE_TEST_SEL	),
/*	input wire				*/	.O_EFUSE_TEST_PS	(w_EFUSE_TEST_PS	),
	`endif
`else
/*output wire				*/	.O_EFUSE_TEST_SEL	(w_EFUSE_TEST_SEL 	),		
/*output wire				*/	.O_EFUSE_TEST_SCLK	(w_EFUSE_TEST_SCLK	),	 	
/*output wire				*/	.O_EFUSE_TEST_PGM	(w_EFUSE_TEST_PGM 	),		
/*output wire				*/	.O_EFUSE_TEST_DIN	(w_EFUSE_TEST_DIN 	),		
/*input wire 				*/	.I_EFUSE_TEST_DOUT	(w_EFUSE_TEST_DOUT	),	
`endif

/*input wire        		*/	.I_SLEEP_ON			(w_SLEEP_ON			),
/*input wire        		*/	.I_ISO_PEN			(w_ISO_PEN			),
/*input wire				*/	.I_GPIO_AON_EN		(w_GPIO_AON_EN		),
/*input wire	[4:0]		*/	.I_AON_GPIO_OEN		(w_AON_GPIO_OEN		), 
/*input wire	[4:0]		*/	.I_AON_GPIO_OUT		(w_AON_GPIO_OUT		), 
/*input wire	[4:0]		*/	.I_AON_GPIO_IE		(w_AON_GPIO_IE		), 
/*input wire 	[4:0] 		*/	.I_AON_GPIO_PE		(w_AON_GPIO_PE		), 
/*input wire 	[4:0] 		*/	.I_AON_GPIO_PS		(w_AON_GPIO_PS		), 
/*output wire	[4:0]		*/	.O_AON_GPIO_IN		(w_AON_GPIO_IN		), 

//PAD Interface
/*output reg [GP_NUM-1:0]	*/	.O_GPIO_OE_PAD		(w_GPIO_PAD_OE		),
/*output reg [GP_NUM-1:0]	*/	.O_GPIO_IE_PAD		(w_GPIO_PAD_IE		),
/*output reg [GP_NUM-1:0]	*/	.O_GPIO_OUT_PAD		(w_GPIO_PAD_OUT		),
/*output reg [GP_NUM-1:0]	*/	.O_GPIO_PE_PAD		(w_GPIO_PAD_PE		),
/*output reg [GP_NUM-1:0]	*/	.O_GPIO_PS_PAD		(w_GPIO_PAD_PS		),
/*output reg [GP_NUM-1:0]	*/	.O_GPIO_DS_PAD		(w_GPIO_PAD_DS		),
/*input wire [GP_NUM-1:0]	*/	.I_GPIO_IN_PAD		(w_GPIO_PAD_IN		),
/*input wire				*/	.I_TEST_EN_PAD		(I_TEST_EN_C		)
);

genvar g;
generate for (g = 0; g < GP_N; g = g + 1) begin : GEN_GPIO
	if(g>35) begin
			assign	w_GPIO_PAD_IN[g]	= 1'b0;
			assign	w_GPIO_A2C_PAD_IN[g]= 1'b0;
	end else begin
		if ( (g<5) || (g==27) || (g==28) || (g==29) ) begin	//VDD_AON
			assign	O_GPIO_OE[g] 		= w_GPIO_PAD_OE[g];
			assign	O_GPIO_I[g]  		= w_GPIO_PAD_OUT[g];
			assign	O_GPIO_DS[g] 		= w_GPIO_PAD_DS[g];
			assign	O_GPIO_IE[g] 		= w_GPIO_PAD_IE[g];
			assign	O_GPIO_PE[g] 		= w_GPIO_PAD_PE[g];
			assign	O_GPIO_PS[g] 		= w_GPIO_PAD_PS[g];
			assign	w_GPIO_PAD_IN[g]	= I_GPIO_C[g];
			assign	w_GPIO_A2C_PAD_IN[g]= 1'b0;
		end else begin										//VDD_DIG
			assign	O_GPIO_OE[g] 		= w_GPIO_C2A_PAD_OE[g];
			assign	O_GPIO_I[g]  		= w_GPIO_C2A_PAD_OUT[g];
			assign	O_GPIO_DS[g] 		= w_GPIO_C2A_PAD_DS[g];
			assign	O_GPIO_IE[g] 		= w_GPIO_C2A_PAD_IE[g];
			assign	O_GPIO_PE[g] 		= w_GPIO_C2A_PAD_PE[g];
			assign	O_GPIO_PS[g] 		= w_GPIO_C2A_PAD_PS[g];
			assign	w_GPIO_PAD_IN[g]	= w_GPIO_C2A_PAD_IN[g];
			assign	w_GPIO_A2C_PAD_IN[g]= I_GPIO_C[g];
		end
	end
end endgenerate
                   
//////////////////////////////////////////////////////////////
//	AON-CORE Interface
assign	w_GPIO_A2C_PAD_OE[05] 		= w_GPIO_PAD_OE[05];
assign	w_GPIO_A2C_PAD_OUT[05]  	= w_GPIO_PAD_OUT[05];
assign	w_GPIO_A2C_PAD_DS[05]		= w_GPIO_PAD_DS[05];
assign	w_GPIO_A2C_PAD_IE[05]		= w_GPIO_PAD_IE[05];
assign	w_GPIO_A2C_PAD_PE[05]		= w_GPIO_PAD_PE[05];
assign	w_GPIO_A2C_PAD_PS[05]		= w_GPIO_PAD_PS[05];
                 
assign	w_GPIO_A2C_PAD_OE[06] 		= w_GPIO_PAD_OE[06];
assign	w_GPIO_A2C_PAD_OUT[06]  	= w_GPIO_PAD_OUT[06];
assign	w_GPIO_A2C_PAD_DS[06]		= w_GPIO_PAD_DS[06];
assign	w_GPIO_A2C_PAD_IE[06]		= w_GPIO_PAD_IE[06];
assign	w_GPIO_A2C_PAD_PE[06]		= w_GPIO_PAD_PE[06];
assign	w_GPIO_A2C_PAD_PS[06]		= w_GPIO_PAD_PS[06];
                    
assign	w_GPIO_A2C_PAD_OE[07] 		= w_GPIO_PAD_OE[07];
assign	w_GPIO_A2C_PAD_OUT[07]  	= w_GPIO_PAD_OUT[07];
assign	w_GPIO_A2C_PAD_DS[07]		= w_GPIO_PAD_DS[07];
assign	w_GPIO_A2C_PAD_IE[07]		= w_GPIO_PAD_IE[07];
assign	w_GPIO_A2C_PAD_PE[07]		= w_GPIO_PAD_PE[07];
assign	w_GPIO_A2C_PAD_PS[07]		= w_GPIO_PAD_PS[07];
                 	
assign	w_GPIO_A2C_PAD_OE[08] 		= w_GPIO_PAD_OE[08];
assign	w_GPIO_A2C_PAD_OUT[08]  	= w_GPIO_PAD_OUT[08];
assign	w_GPIO_A2C_PAD_DS[08]		= w_GPIO_PAD_DS[08];
assign	w_GPIO_A2C_PAD_IE[08]		= w_GPIO_PAD_IE[08];
assign	w_GPIO_A2C_PAD_PE[08]		= w_GPIO_PAD_PE[08];
assign	w_GPIO_A2C_PAD_PS[08]		= w_GPIO_PAD_PS[08];
                 	
assign	w_GPIO_A2C_PAD_OE[09] 		= w_GPIO_PAD_OE[09];
assign	w_GPIO_A2C_PAD_OUT[09]  	= w_GPIO_PAD_OUT[09];
assign	w_GPIO_A2C_PAD_DS[09]		= w_GPIO_PAD_DS[09];
assign	w_GPIO_A2C_PAD_IE[09]		= w_GPIO_PAD_IE[09];
assign	w_GPIO_A2C_PAD_PE[09]		= w_GPIO_PAD_PE[09];
assign	w_GPIO_A2C_PAD_PS[09]		= w_GPIO_PAD_PS[09];
                   
assign	w_GPIO_A2C_PAD_OE[10] 		= w_GPIO_PAD_OE[10];
assign	w_GPIO_A2C_PAD_OUT[10]  	= w_GPIO_PAD_OUT[10];
assign	w_GPIO_A2C_PAD_DS[10]		= w_GPIO_PAD_DS[10];
assign	w_GPIO_A2C_PAD_IE[10]		= w_GPIO_PAD_IE[10];
assign	w_GPIO_A2C_PAD_PE[10]		= w_GPIO_PAD_PE[10];
assign	w_GPIO_A2C_PAD_PS[10]		= w_GPIO_PAD_PS[10];
                    
assign	w_GPIO_A2C_PAD_OE[11] 		= w_GPIO_PAD_OE[11];
assign	w_GPIO_A2C_PAD_OUT[11]  	= w_GPIO_PAD_OUT[11];
assign	w_GPIO_A2C_PAD_DS[11]		= w_GPIO_PAD_DS[11];
assign	w_GPIO_A2C_PAD_IE[11]		= w_GPIO_PAD_IE[11];
assign	w_GPIO_A2C_PAD_PE[11]		= w_GPIO_PAD_PE[11];
assign	w_GPIO_A2C_PAD_PS[11]		= w_GPIO_PAD_PS[11];
                   
assign	w_GPIO_A2C_PAD_OE[12] 		= w_GPIO_PAD_OE[12];
assign	w_GPIO_A2C_PAD_OUT[12]  	= w_GPIO_PAD_OUT[12];
assign	w_GPIO_A2C_PAD_DS[12]		= w_GPIO_PAD_DS[12];
assign	w_GPIO_A2C_PAD_IE[12]		= w_GPIO_PAD_IE[12];
assign	w_GPIO_A2C_PAD_PE[12]		= w_GPIO_PAD_PE[12];
assign	w_GPIO_A2C_PAD_PS[12]		= w_GPIO_PAD_PS[12];
                    
assign	w_GPIO_A2C_PAD_OE[13] 		= w_GPIO_PAD_OE[13];
assign	w_GPIO_A2C_PAD_OUT[13]  	= w_GPIO_PAD_OUT[13];
assign	w_GPIO_A2C_PAD_DS[13]		= w_GPIO_PAD_DS[13];
assign	w_GPIO_A2C_PAD_IE[13]		= w_GPIO_PAD_IE[13];
assign	w_GPIO_A2C_PAD_PE[13]		= w_GPIO_PAD_PE[13];
assign	w_GPIO_A2C_PAD_PS[13]		= w_GPIO_PAD_PS[13];
                   
assign	w_GPIO_A2C_PAD_OE[14] 		= w_GPIO_PAD_OE[14];
assign	w_GPIO_A2C_PAD_OUT[14]  	= w_GPIO_PAD_OUT[14];
assign	w_GPIO_A2C_PAD_DS[14]		= w_GPIO_PAD_DS[14];
assign	w_GPIO_A2C_PAD_IE[14]		= w_GPIO_PAD_IE[14];
assign	w_GPIO_A2C_PAD_PE[14]		= w_GPIO_PAD_PE[14];
assign	w_GPIO_A2C_PAD_PS[14]		= w_GPIO_PAD_PS[14];
                    
assign	w_GPIO_A2C_PAD_OE[15] 		= w_GPIO_PAD_OE[15];
assign	w_GPIO_A2C_PAD_OUT[15]  	= w_GPIO_PAD_OUT[15];
assign	w_GPIO_A2C_PAD_DS[15]		= w_GPIO_PAD_DS[15];
assign	w_GPIO_A2C_PAD_IE[15]		= w_GPIO_PAD_IE[15];
assign	w_GPIO_A2C_PAD_PE[15]		= w_GPIO_PAD_PE[15];
assign	w_GPIO_A2C_PAD_PS[15]		= w_GPIO_PAD_PS[15];
                    
assign	w_GPIO_A2C_PAD_OE[16] 		= w_GPIO_PAD_OE[16];
assign	w_GPIO_A2C_PAD_OUT[16]  	= w_GPIO_PAD_OUT[16];
assign	w_GPIO_A2C_PAD_DS[16]		= w_GPIO_PAD_DS[16];
assign	w_GPIO_A2C_PAD_IE[16]		= w_GPIO_PAD_IE[16];
assign	w_GPIO_A2C_PAD_PE[16]		= w_GPIO_PAD_PE[16];
assign	w_GPIO_A2C_PAD_PS[16]		= w_GPIO_PAD_PS[16];
                   
assign	w_GPIO_A2C_PAD_OE[17]	 	= w_GPIO_PAD_OE[17];
assign	w_GPIO_A2C_PAD_OUT[17]  	= w_GPIO_PAD_OUT[17];
assign	w_GPIO_A2C_PAD_DS[17]		= w_GPIO_PAD_DS[17];
assign	w_GPIO_A2C_PAD_IE[17]		= w_GPIO_PAD_IE[17];
assign	w_GPIO_A2C_PAD_PE[17]		= w_GPIO_PAD_PE[17];
assign	w_GPIO_A2C_PAD_PS[17]		= w_GPIO_PAD_PS[17];
                    
assign	w_GPIO_A2C_PAD_OE[18] 		= w_GPIO_PAD_OE[18];
assign	w_GPIO_A2C_PAD_OUT[18]  	= w_GPIO_PAD_OUT[18];
assign	w_GPIO_A2C_PAD_DS[18]		= w_GPIO_PAD_DS[18];
assign	w_GPIO_A2C_PAD_IE[18]		= w_GPIO_PAD_IE[18];
assign	w_GPIO_A2C_PAD_PE[18]		= w_GPIO_PAD_PE[18];
assign	w_GPIO_A2C_PAD_PS[18]		= w_GPIO_PAD_PS[18];
                 
assign	w_GPIO_A2C_PAD_OE[19] 		= w_GPIO_PAD_OE[19];
assign	w_GPIO_A2C_PAD_OUT[19]  	= w_GPIO_PAD_OUT[19];
assign	w_GPIO_A2C_PAD_DS[19]		= w_GPIO_PAD_DS[19];
assign	w_GPIO_A2C_PAD_IE[19]		= w_GPIO_PAD_IE[19];
assign	w_GPIO_A2C_PAD_PE[19]		= w_GPIO_PAD_PE[19];
assign	w_GPIO_A2C_PAD_PS[19]		= w_GPIO_PAD_PS[19];
                    
assign	w_GPIO_A2C_PAD_OE[20] 		= w_GPIO_PAD_OE[20];
assign	w_GPIO_A2C_PAD_OUT[20]  	= w_GPIO_PAD_OUT[20];
assign	w_GPIO_A2C_PAD_DS[20]		= w_GPIO_PAD_DS[20];
assign	w_GPIO_A2C_PAD_IE[20]		= w_GPIO_PAD_IE[20];
assign	w_GPIO_A2C_PAD_PE[20]		= w_GPIO_PAD_PE[20];
assign	w_GPIO_A2C_PAD_PS[20]		= w_GPIO_PAD_PS[20];
                    
assign	w_GPIO_A2C_PAD_OE[21] 		= w_GPIO_PAD_OE[21];
assign	w_GPIO_A2C_PAD_OUT[21]  	= w_GPIO_PAD_OUT[21];
assign	w_GPIO_A2C_PAD_DS[21]		= w_GPIO_PAD_DS[21];
assign	w_GPIO_A2C_PAD_IE[21]		= w_GPIO_PAD_IE[21];
assign	w_GPIO_A2C_PAD_PE[21]		= w_GPIO_PAD_PE[21];
assign	w_GPIO_A2C_PAD_PS[21]		= w_GPIO_PAD_PS[21];
                 
assign	w_GPIO_A2C_PAD_OE[22] 		= w_GPIO_PAD_OE[22];
assign	w_GPIO_A2C_PAD_OUT[22]  	= w_GPIO_PAD_OUT[22];
assign	w_GPIO_A2C_PAD_DS[22]		= w_GPIO_PAD_DS[22];
assign	w_GPIO_A2C_PAD_IE[22]		= w_GPIO_PAD_IE[22];
assign	w_GPIO_A2C_PAD_PE[22]		= w_GPIO_PAD_PE[22];
assign	w_GPIO_A2C_PAD_PS[22]		= w_GPIO_PAD_PS[22];
                    
assign	w_GPIO_A2C_PAD_OE[23] 		= w_GPIO_PAD_OE[23];
assign	w_GPIO_A2C_PAD_OUT[23]  	= w_GPIO_PAD_OUT[23];
assign	w_GPIO_A2C_PAD_DS[23]		= w_GPIO_PAD_DS[23];
assign	w_GPIO_A2C_PAD_IE[23]		= w_GPIO_PAD_IE[23];
assign	w_GPIO_A2C_PAD_PE[23]		= w_GPIO_PAD_PE[23];
assign	w_GPIO_A2C_PAD_PS[23]		= w_GPIO_PAD_PS[23];
                   
assign	w_GPIO_A2C_PAD_OE[24] 		= w_GPIO_PAD_OE[24];
assign	w_GPIO_A2C_PAD_OUT[24]  	= w_GPIO_PAD_OUT[24];
assign	w_GPIO_A2C_PAD_DS[24]		= w_GPIO_PAD_DS[24];
assign	w_GPIO_A2C_PAD_IE[24]		= w_GPIO_PAD_IE[24];
assign	w_GPIO_A2C_PAD_PE[24]		= w_GPIO_PAD_PE[24];
assign	w_GPIO_A2C_PAD_PS[24]		= w_GPIO_PAD_PS[24];
                    
assign	w_GPIO_A2C_PAD_OE[25] 		= w_GPIO_PAD_OE[25];
assign	w_GPIO_A2C_PAD_OUT[25]  	= w_GPIO_PAD_OUT[25];
assign	w_GPIO_A2C_PAD_DS[25]		= w_GPIO_PAD_DS[25];
assign	w_GPIO_A2C_PAD_IE[25]		= w_GPIO_PAD_IE[25];
assign	w_GPIO_A2C_PAD_PE[25]		= w_GPIO_PAD_PE[25];
assign	w_GPIO_A2C_PAD_PS[25]		= w_GPIO_PAD_PS[25];
                    
assign	w_GPIO_A2C_PAD_OE[26] 		= w_GPIO_PAD_OE[26];
assign	w_GPIO_A2C_PAD_OUT[26]  	= w_GPIO_PAD_OUT[26];
assign	w_GPIO_A2C_PAD_DS[26]		= w_GPIO_PAD_DS[26];
assign	w_GPIO_A2C_PAD_IE[26]		= w_GPIO_PAD_IE[26];
assign	w_GPIO_A2C_PAD_PE[26]		= w_GPIO_PAD_PE[26];
assign	w_GPIO_A2C_PAD_PS[26]		= w_GPIO_PAD_PS[26];

assign	w_GPIO_A2C_PAD_OE[27] 		= w_GPIO_PAD_OE[27];
assign	w_GPIO_A2C_PAD_OUT[27]  	= w_GPIO_PAD_OUT[27];
assign	w_GPIO_A2C_PAD_DS[27]		= w_GPIO_PAD_DS[27];
assign	w_GPIO_A2C_PAD_IE[27]		= w_GPIO_PAD_IE[27];
assign	w_GPIO_A2C_PAD_PE[27]		= w_GPIO_PAD_PE[27];
assign	w_GPIO_A2C_PAD_PS[27]		= w_GPIO_PAD_PS[27];
                  
assign	w_GPIO_A2C_PAD_OE[28] 		= w_GPIO_PAD_OE[28];
assign	w_GPIO_A2C_PAD_OUT[28]  	= w_GPIO_PAD_OUT[28];
assign	w_GPIO_A2C_PAD_DS[28]		= w_GPIO_PAD_DS[28];
assign	w_GPIO_A2C_PAD_IE[28]		= w_GPIO_PAD_IE[28];
assign	w_GPIO_A2C_PAD_PE[28]		= w_GPIO_PAD_PE[28];
assign	w_GPIO_A2C_PAD_PS[28]		= w_GPIO_PAD_PS[28];
                   
assign	w_GPIO_A2C_PAD_OE[29] 		= w_GPIO_PAD_OE[29];
assign	w_GPIO_A2C_PAD_OUT[29]  	= w_GPIO_PAD_OUT[29];
assign	w_GPIO_A2C_PAD_DS[29]		= w_GPIO_PAD_DS[29];
assign	w_GPIO_A2C_PAD_IE[29]		= w_GPIO_PAD_IE[29];
assign	w_GPIO_A2C_PAD_PE[29]		= w_GPIO_PAD_PE[29];
assign	w_GPIO_A2C_PAD_PS[29]		= w_GPIO_PAD_PS[29];
                   
assign	w_GPIO_A2C_PAD_OE[30] 		= w_GPIO_PAD_OE[30];
assign	w_GPIO_A2C_PAD_OUT[30]  	= w_GPIO_PAD_OUT[30];
assign	w_GPIO_A2C_PAD_DS[30]		= w_GPIO_PAD_DS[30];
assign	w_GPIO_A2C_PAD_IE[30]		= w_GPIO_PAD_IE[30];
assign	w_GPIO_A2C_PAD_PE[30]		= w_GPIO_PAD_PE[30];
assign	w_GPIO_A2C_PAD_PS[30]		= w_GPIO_PAD_PS[30];
                   
assign	w_GPIO_A2C_PAD_OE[31] 		= w_GPIO_PAD_OE[31];
assign	w_GPIO_A2C_PAD_OUT[31] 	= w_GPIO_PAD_OUT[31];
assign	w_GPIO_A2C_PAD_DS[31]		= w_GPIO_PAD_DS[31];
assign	w_GPIO_A2C_PAD_IE[31]		= w_GPIO_PAD_IE[31];
assign	w_GPIO_A2C_PAD_PE[31]		= w_GPIO_PAD_PE[31];
assign	w_GPIO_A2C_PAD_PS[31]		= w_GPIO_PAD_PS[31];
                 
assign	w_GPIO_A2C_PAD_OE[32] 		= w_GPIO_PAD_OE[32];
assign	w_GPIO_A2C_PAD_OUT[32]  	= w_GPIO_PAD_OUT[32];
assign	w_GPIO_A2C_PAD_DS[32]		= w_GPIO_PAD_DS[32];
assign	w_GPIO_A2C_PAD_IE[32]		= w_GPIO_PAD_IE[32];
assign	w_GPIO_A2C_PAD_PE[32]		= w_GPIO_PAD_PE[32];
assign	w_GPIO_A2C_PAD_PS[32]		= w_GPIO_PAD_PS[32];
                    
assign	w_GPIO_A2C_PAD_OE[33] 		= w_GPIO_PAD_OE[33];
assign	w_GPIO_A2C_PAD_OUT[33]  	= w_GPIO_PAD_OUT[33];
assign	w_GPIO_A2C_PAD_DS[33]		= w_GPIO_PAD_DS[33];
assign	w_GPIO_A2C_PAD_IE[33]		= w_GPIO_PAD_IE[33];
assign	w_GPIO_A2C_PAD_PE[33]		= w_GPIO_PAD_PE[33];
assign	w_GPIO_A2C_PAD_PS[33]		= w_GPIO_PAD_PS[33];
                    
assign	w_GPIO_A2C_PAD_OE[34] 		= w_GPIO_PAD_OE[34];
assign	w_GPIO_A2C_PAD_OUT[34]  	= w_GPIO_PAD_OUT[34];
assign	w_GPIO_A2C_PAD_DS[34]		= w_GPIO_PAD_DS[34];
assign	w_GPIO_A2C_PAD_IE[34]		= w_GPIO_PAD_IE[34];
assign	w_GPIO_A2C_PAD_PE[34]		= w_GPIO_PAD_PE[34];
assign	w_GPIO_A2C_PAD_PS[34]		= w_GPIO_PAD_PS[34];
                    
assign	w_GPIO_A2C_PAD_OE[35] 		= w_GPIO_PAD_OE[35];
assign #2 w_GPIO_A2C_PAD_OUT[35]	= w_GPIO_PAD_OUT[35];
assign	w_GPIO_A2C_PAD_DS[35] 		= w_GPIO_PAD_DS[35];
assign	w_GPIO_A2C_PAD_IE[35] 		= w_GPIO_PAD_IE[35];
assign	w_GPIO_A2C_PAD_PE[35] 		= w_GPIO_PAD_PE[35];
assign	w_GPIO_A2C_PAD_PS[35] 		= w_GPIO_PAD_PS[35];

endmodule
