////////////////////////////////////////////////////////
//
//  Module: OASIS_ANA
//  Project: OASIS
//  Description: 
// 
//  Change history: 
//
////////////////////////////////////////////////////////
`timescale 1ns/10ps

module  OASIS_ANA ( 
	// PAD
	inout wire	P_TEST_EN							,
	inout wire	P_ROM_EN							,
	inout wire	P_DBG_EN							,
`ifdef	FPGA
	inout wire	P_OSC_H								,
	inout wire	P_OSC_L								,
	output wire O_MCUP_BSTA							,
	input wire  FCLK_CLK1       					,
`endif
	//GPIO
	inout wire	P_GPIO_00							,
	inout wire	P_GPIO_01							,
	inout wire	P_GPIO_02							,
	inout wire	P_GPIO_03							,
	inout wire	P_GPIO_04							,
	inout wire	P_GPIO_05							,
	inout wire	P_GPIO_06							,
	inout wire	P_GPIO_07							,
	inout wire	P_GPIO_08							,
	inout wire	P_GPIO_09							,
	inout wire	P_GPIO_10							,
	inout wire	P_GPIO_11							,
	inout wire	P_GPIO_12							,
	inout wire	P_GPIO_13							,
	inout wire	P_GPIO_14							,
	inout wire	P_GPIO_15							,
	inout wire	P_GPIO_16							,
	inout wire	P_GPIO_17							,
	inout wire	P_GPIO_18							,
	inout wire	P_GPIO_19							,
	inout wire	P_GPIO_20							,
	inout wire	P_GPIO_21							,
	inout wire	P_GPIO_22							,
	inout wire	P_GPIO_23							,
	inout wire	P_GPIO_24							,
	inout wire	P_GPIO_25							,
	inout wire	P_GPIO_26							,
	inout wire	P_GPIO_27							,
	inout wire	P_GPIO_28							,
	inout wire	P_GPIO_29							,
	inout wire	P_GPIO_30							,
	inout wire	P_GPIO_31							,
	inout wire	P_GPIO_32							,
	inout wire	P_GPIO_33							,
	inout wire	P_GPIO_34							,
	inout wire	P_GPIO_35							,
`ifdef	PG_PIN
	output  VDD_0p90 		,
	output  VDD_SRAM_PERI_0 ,
	output  VDD_SRAM_PERI_1 ,
	output  VDD_SRAM_PERI_2 ,
	output  VDD_SRAM_PERI_3 ,
	output  VDD_SRAM_CORE_0 ,
	output  VDD_SRAM_CORE_1 ,
	output  VDD_SRAM_CORE_2 ,
	output  VDD_SRAM_CORE_3 ,
	output  VDD_0p81 		,
	output  VDDQ 			,
	output  VSS 			,
`endif
	// PAD Interface
	output wire				I_TEST_EN_C				,
	output wire				I_ROM_EN_C				,
	output wire				I_DBG_EN_C				,
	//GPIO
	input wire [35:0]		O_GPIO_OE				,
	input wire [35:0]		O_GPIO_I				,
	input wire [35:0]		O_GPIO_DS				,
	input wire [35:0]		O_GPIO_IE				,
	input wire [35:0]		O_GPIO_PE				,
	input wire [35:0]		O_GPIO_PS				,
	output wire	[35:0]		I_GPIO_C				,
	// Analog Interface
	output wire				I_AON_RSTB				,
	output wire				I_RTC_CLKT				,
	output wire				I_RTC_CLKB				,
	output wire				I_RFC_CLKT				,
	output wire				I_RFC_CLKB				,
	output wire				I_PLL_SDM_CLKT			,
	output wire				I_PLL_SDM_CLKB			,
	// PLL
	input wire				O_PLL_PEN				,
	input wire				O_PLL_COARSELOCK		,
	input wire				O_PLL_OUT_PEN			,
	input wire				O_PLL_DIV2_OUT_PEN		,
//	input wire	[1:0]		O_PLL_CP_BCONT			,
	input wire 				O_PLL_CP_UGB_EN      	,	
	input wire [2:0]		O_PLL_CP_UGB_CONT    	,
	input wire [2:0]		O_PLL_CP_LEAK_EN     	,
	input wire 				O_PLL_CP_LEAK_COMP_EN	,
	input wire [2:0]		O_PLL_PFD_DELAY      	,
	input wire [2:0]		O_PLL_CP_CELL_EN		,
//	input wire [4:0]		O_PLL_CP_LEAK_COMP		,
	input wire [9:0]		O_PLL_VCO_CAP			,
	input wire [7:0]		O_PLL_PM_CAP			,
	input wire [4:0]		O_PLL_PC				,
	input wire [1:0]		O_PLL_SC				,
	input wire				O_PLL_CNT_MASK			,
	input wire				O_PLL_CT_RST			,
	input wire	[2:0]		O_PLL_CT_VC_CONT		,
	input wire	[2:0]		O_PLL_KVCO_VB1			,
	input wire	[2:0]		O_PLL_KVCO_VB2			,
	output wire [12:0]		I_PLL_CT_CNT			,
	// PMU
	input wire	[4:0]		O_PWR_SRAM_PERI_DIG		,
	input wire	[4:0]		O_PWR_SRAM_CORE_DIG		,
	input wire	[4:0]		O_PWR_SRAM_CORE_RET		,
	input wire	[3:0]		O_ABGR_CONT				,
	input wire	[3:0]		O_ABGR_TC				,
	input wire	[5:0]		O_ALDO_CONT				,
	input wire				O_ALDO_EN				,
	input wire				O_ALDO_EN_SEL			,
	input wire				O_RTC_EN				,
	input wire				O_RTC_EN_SEL			,
	input wire	[10:0]		O_RTC_SCKF				,
	input wire				O_FLDO_PEN				,
	input wire				O_FLDO_LP_EN			,
	input wire	[3:0]		O_FLDO_CONT				,
	input wire				O_FLDO_BYPASS			,
	input wire				O_FLDO_POK_EN			,
	output wire				I_FLDO_POK				,
	input wire				O_MLDO_PEN				,
	input wire				O_MLDO_LP_EN			,
	input wire	[5:0]		O_MLDO_CONT				,
	input wire				O_MLDO_POK_EN			,
	output wire				I_MLDO_POK				,
	input wire				O_DCDC_PRECHG_PEN		,
	input wire				O_DCDC_CORE_PEN			,
	input wire				O_DCDC_REF_PEN			,
	input wire				O_DCDC_MODE				,
	input wire	[5:0]		O_DCDC_SET_VOUT			,
	input wire	[2:0]		O_DCDC_CUR_TRIM			,
	input wire	[1:0]		O_FLDO_POK_TRIM			,
	input wire	[1:0]		O_MLDO_POK_TRIM			,
	input wire	[3:0]		O_DCDC_DT_TRIM			,
	input wire				O_DCDC_POK_EN			,
	input wire				O_RET_LDO_EN			,	// r2
	input wire [3:0]		O_RET_LDO_CONT			,	// r2
	input wire				O_BOD_EN				,	// r2
	input wire				O_DA_LDO_EN				,	// r2
	input wire				O_DA_LDO_BYPASS			,	// r2
	input wire [5:0]		O_DA_LDO_CONT			,	// r2
	input wire [3:0]		O_DCDC_CLIMIT_RTRIMB	,	// r2
	input wire [3:0]		O_DCDC_ISENS_RTRIM		,
	input wire [2:0]		O_DCDC_ZCD_CTRIM		,
	input wire [2:0]		O_EXT_PFM_VREF			,
	input wire [3:0]		O_DCDC_PRECHG_DUR		,
	input wire [3:0]		O_DCDC_POK_TRIM			,
	input wire [3:0]		O_MBGR_TC_TRIM			,	//r2
	input wire [5:0]		O_MBGR_OUT_TRIM			,	//r2
	input wire 				O_MBGR_EN				,	//r2
//	input wire 				O_DA_LDO_BMUX			,	//r2
	input wire 				O_GPADC_BMUX			,	//r2	
	input wire [1:0]		O_BOD_VREFH				,	//r3
	input wire [1:0]		O_BOD_VREFL				,	//r3
	input wire [1:0]		O_DA_LDO_TAIL_CONT		,	
	output wire 			I_BOD_RSTB				,	//r2
	output wire				I_DCDC_POK				,
	// RFRX
	input wire				O_TRX_SEL				,
	input wire				O_RX_RF_PEN				,
	input wire				O_MIX_BUF_PEN			,
	input wire	[1:0]		O_RX_RF_GC				,
	input wire	[2:0]		O_LNTA_BIAS				,
	input wire	[2:0]		O_LNTA_BIAS2			,
	input wire	[2:0]		O_MIX_I_BIAS			,
	input wire	[2:0]		O_MIX_IB_BIAS			,
	input wire	[2:0]		O_MIX_Q_BIAS			,
	input wire	[2:0]		O_MIX_QB_BIAS			,
	// RFTX
	input wire				O_TX_BUF_PEN			,
	input wire				O_TX_PRE_PEN			,
	input wire				O_TX_DA_PEN				,
	input wire	[3:0]		O_TX_DA_GC				,
	// ABB
	input wire				O_ABB_PEN				,
	input wire				O_ABB_BIAS_STUP			,
	input wire	[2:0]		O_ABB_BIAS1				,
	input wire	[2:0]		O_ABB_BIAS2				,
	input wire	[2:0]		O_ABB_VCOM				,
	input wire	[4:0]		O_ABB_IFC_CC			,
	input wire	[2:0]		O_ABB_TIA_GC			,
	input wire				O_ABB_TIA_RCF_EN		,
	input wire				O_ABB_TIA_CFB_EN		,
	input wire	[4:0]		O_ABB_TIA_CC			,
	input wire	[3:0]		O_ABB_TIA_STB			,
	input wire				O_ABB_TIA_MIR			,
	input wire	[1:0]		O_ABB_FLT_GC			,
	input wire	[4:0]		O_ABB_FLT_CC			,
	input wire	[4:0]		O_ABB_FLT_ZC			,
	input wire				O_ABB_FLT_SKIP			,
	input wire				O_ABB_FLT_WB			,
	input wire	[4:0]		O_ABB_FLT_IF			,
//	input wire				O_ABB_ACC_SWAP_EN		,
//	input wire				O_ABB_ACC_SWAP			,
	input wire	[2:0]		O_ABB_ACC_BW			,
	input wire				O_ABB_ACC_SKIP			,
	input wire	[4:0]		O_ABB_PGA_GC			,
	input wire	[1:0]		O_ABB_PGA_CFB			,
	input wire	[2:0]		O_ABB_DRV_OMODE			,
	input wire				O_ABB_DRV_STB_CC		,
	input wire	[3:0]		O_ABB_DRV_TPE			,
	input wire				O_ABB_DRV_TP_SWAP		,
	input wire				O_ABB_TEST_ENI			,
	input wire				O_ABB_TEST_ENQ			,
	input wire				O_GPIO01_AN_EN			,
	input wire				O_GPIO23_AN_EN			,
	input wire				O_AN_TEST_EN			,
	input wire				O_GPIO4_AN_EN			,
	input wire	[2:0]		O_AN_TEST_MUX			,
	input wire				O_GPIO_TEST_BUF_EN		,
	input wire				O_GPIO_TEST_CUR_EN		,
	// FT	
	input wire				O_FT_PEN				,
	input wire				O_FT_RST				,
	input wire				O_FT_CLK				,
	input wire				O_FT_BIAS_STUP			,
	output wire	[4:0]		I_FT_CC					,
	output wire				I_FT_DONE				,
	// ADC
	input wire				O_ADC_PEN				,
	input wire				O_ADC_CLKT				,
	input wire				O_ADC_CLKB				,
	input wire	[2:0]		O_ADC_FS				,
	output wire				I_ADC_ICONV_RDY			,
	output wire	[7:0]		I_ADC_IDATA				,
	output wire				I_ADC_QCONV_RDY			,
	output wire	[7:0]		I_ADC_QDATA				,
	input wire				O_ADC_CONV_RDY_MODE		,
	// GPADC
	input wire				O_GPADC_PEN				,
	input wire	[3:0]		O_GPADC_MUXSEL			,
//	input wire				O_GPADC_ATT_EN			,
	input wire				O_GPADC_BUF_EN			,
	input wire				O_GPADC_AMP_CHOP_EN		,
	input wire				O_GPADC_CLKT			,
	input wire				O_GPADC_CLKB			,
	input wire				O_GPADC_FILT_EN			,		// O_FILT_EN
	input wire				O_GPADC_CSTATE			,		// O_CSTATE	
	input wire	[2:0]		O_GPADC_INBUF_BIAS		,
	input wire	[2:0]		O_GPADC_AMP1_BIAS		,
	input wire	[2:0]		O_GPADC_AMP2_BIAS		,
	input wire	[2:0]		O_GPADC_BGR_BIAS		,
	input wire	[2:0]		O_GPADC_VCM_BIAS		,
	input wire	[2:0]		O_GPADC_VCM_CONT		,
	input wire	[1:0]		O_GPADC_VREFP_CONT		,
	input wire	[1:0]		O_GPADC_VREFN_CONT		,
	output wire				I_GPADC_RSTGEN_CLK		,		// I_CLK_RSTGEN
	output wire				I_GPADC_DSMRST			,		// I_DSMRST
	output wire	[1:0]		I_GPADC_DOUT			,		// I_DIN
	output wire				I_GPADC_DCLK			,		// I_CLK_FILTER
	input wire	[1:0]		O_GPADC_AMP1_VB			,
	input wire	[1:0]		O_GPADC_AMP2_VB			,
	input wire				O_GPADC_ATT_BYP_EN		,
	input wire				O_GPADC_ATT_VSEL		,
	// TS
	input wire				O_TS_PEN				,
	input wire	[3:0]		O_TS_DEM_CLK			,
	input wire				O_TS_CHOP_CLK			,
	input wire	[1:0]		O_TS_CAL				,
	input wire				O_TS_SEL				,
	input wire				O_TS_CHOP_ON			, //r2
	input wire				O_TS_DEM_ON				, //r2
	input wire	[3:0]		O_TS_TRIM				,
	// XO
	input wire				O_XO_PEN				,
	input wire				O_XO_MODE				,
	input wire	[5:0]		O_XO_CS					,
	input wire	[5:0]		O_XO_CL					,
	input wire				O_XO_PLL_CLK_EN			,
	input wire				O_XO_RFC_CLK_EN			,
	//PHASE TRACKING RX
//	input wire				O_PTRX_EN				,	//R2 
	// MASK_SPIM
	output wire				I_NFC_TEST_OUT			,
	output wire				I_NFC_WAKEUP			,
	input wire				O_NFC_EN				,
	input wire	[1:0]		O_NFC_TMUX_SEL			,
	input wire				O_NFC_WUR_THR_SEL		,
	input wire [3:0]		O_NFC_WUR_THR			,
    input wire 			 	O_NFC_VRECT_RDY_WUR		,
	input wire				O_NFC_VRECT_RDY_EXT		,
	input wire [2:0]		O_NFC_SKP_PULSE			,
	input wire [6:0]		O_NFC_IF_THR			,
	output wire				I_NFC_CLK				,
	output wire				I_NFC_WRITE				,
	output wire [7:0]		I_NFC_WDATA				,
	// ETC
	input wire	[23:0]		O_SPI_RSV_CORE			,
	input wire	[7:0]		O_SPI_RSV_AON			,
	output wire [15:0]		I_DEVICE_ID		
);


`ifndef	LIB_GEN
	`ifdef	PG_PIN
		supply1 VDD_3p30 ;
		supply1 VDD_0p81 ;
		supply1 VDD_0p90 ;
		supply1 VDDQ ;
		supply0 VSS ;

		supply1 w_VDD;
		supply0 w_VSS;

		assign  VDD_0p90 		= (O_MLDO_PEN) 				? 1'b1 : 1'b0;
		assign  VDD_SRAM_PERI_0 = (O_PWR_SRAM_PERI_DIG[0])	? 1'b1 : 1'b0;
		assign  VDD_SRAM_PERI_1 = (O_PWR_SRAM_PERI_DIG[1])	? 1'b1 : 1'b0;
		assign  VDD_SRAM_PERI_2 = (O_PWR_SRAM_PERI_DIG[2])	? 1'b1 : 1'b0;
		assign  VDD_SRAM_PERI_3 = (O_PWR_SRAM_PERI_DIG[3])	? 1'b1 : 1'b0;
		assign  VDD_SRAM_CORE_0 = (O_PWR_SRAM_CORE_DIG[0])	? 1'b1 : 1'b0;
		assign  VDD_SRAM_CORE_1 = (O_PWR_SRAM_CORE_DIG[1])	? 1'b1 : 1'b0;
		assign  VDD_SRAM_CORE_2 = (O_PWR_SRAM_CORE_DIG[2])	? 1'b1 : 1'b0;
		assign  VDD_SRAM_CORE_3 = (O_PWR_SRAM_CORE_DIG[3])	? 1'b1 : 1'b0;

		wire	w_PAD_AON_PFC	= ~I_AON_RSTB;
		wire	w_PAD_CORE_PFC	= ~O_MLDO_PEN;
	`endif

	`ifdef FPGA
		CLK_BUF u_RFC_CLKT	 (.Y(I_RFC_CLKT	), .A(P_OSC_H	));
		CLK_BUF u_RFC_CLKB	 (.Y(I_RFC_CLKB	), .A(~P_OSC_H	));
		CLK_BUF u_RTC_CLKT	 (.Y(I_RTC_CLKT	), .A(P_OSC_L	));
		CLK_BUF u_RTC_CLKB	 (.Y(I_RTC_CLKB	), .A(~P_OSC_L	));
		CLK_BUF u_TEST_EN_C	 (.Y(I_TEST_EN_C), .A(P_TEST_EN	));
		CLK_BUF u_ROM_EN_C	 (.Y(I_ROM_EN_C	), .A(P_ROM_EN	));
		CLK_BUF u_DBG_EN_C	 (.Y(I_DBG_EN_C	), .A(P_DBG_EN	));

		wire [35:0]	w_GPIO_OE		;
		wire [35:0]	w_GPIO_I		;
		wire [35:0]	w_GPIO_DS		;
		wire [35:0]	w_GPIO_IE		;
		wire [35:0]	w_GPIO_PE		;
		wire [35:0]	w_GPIO_PS		;
		wire [35:0]	w_GPIO_C		;

		CLK_BUF u_GPIO_OE[35:0]	(.A(O_GPIO_OE	), .Y(w_GPIO_OE		));
		CLK_BUF u_GPIO_I[35:0] 	(.A(O_GPIO_I	), .Y(w_GPIO_I 		));
		CLK_BUF u_GPIO_DS[35:0]	(.A(O_GPIO_DS	), .Y(w_GPIO_DS		));
		CLK_BUF u_GPIO_IE[35:0]	(.A(O_GPIO_IE	), .Y(w_GPIO_IE		));
		CLK_BUF u_GPIO_PE[35:0]	(.A(O_GPIO_PE	), .Y(w_GPIO_PE		));
		CLK_BUF u_GPIO_PS[35:0]	(.A(O_GPIO_PS	), .Y(w_GPIO_PS		));
		CLK_BUF u_P_GPIO_00  	(.A(P_GPIO_00	), .Y(w_P_GPIO_00	));
		CLK_BUF u_P_GPIO_01  	(.A(P_GPIO_01	), .Y(w_P_GPIO_01	));
		CLK_BUF u_P_GPIO_02  	(.A(P_GPIO_02	), .Y(w_P_GPIO_02	));
		CLK_BUF u_P_GPIO_03  	(.A(P_GPIO_03	), .Y(w_P_GPIO_03	));
		CLK_BUF u_P_GPIO_04  	(.A(P_GPIO_04	), .Y(w_P_GPIO_04	));
		CLK_BUF u_P_GPIO_05  	(.A(P_GPIO_05	), .Y(w_P_GPIO_05	));
		CLK_BUF u_P_GPIO_06  	(.A(P_GPIO_06	), .Y(w_P_GPIO_06	));
		CLK_BUF u_P_GPIO_07  	(.A(P_GPIO_07	), .Y(w_P_GPIO_07	));
		CLK_BUF u_P_GPIO_08  	(.A(P_GPIO_08	), .Y(w_P_GPIO_08	));
		CLK_BUF u_P_GPIO_09  	(.A(P_GPIO_09	), .Y(w_P_GPIO_09	));
		CLK_BUF u_P_GPIO_10  	(.A(P_GPIO_10	), .Y(w_P_GPIO_10	));
		CLK_BUF u_P_GPIO_11  	(.A(P_GPIO_11	), .Y(w_P_GPIO_11	));
		CLK_BUF u_P_GPIO_12  	(.A(P_GPIO_12	), .Y(w_P_GPIO_12	));
		CLK_BUF u_P_GPIO_13  	(.A(P_GPIO_13	), .Y(w_P_GPIO_13	));
		CLK_BUF u_P_GPIO_14  	(.A(P_GPIO_14	), .Y(w_P_GPIO_14	));
		CLK_BUF u_P_GPIO_15  	(.A(P_GPIO_15	), .Y(w_P_GPIO_15	));
		CLK_BUF u_P_GPIO_16  	(.A(P_GPIO_16	), .Y(w_P_GPIO_16	));
		CLK_BUF u_P_GPIO_17  	(.A(P_GPIO_17	), .Y(w_P_GPIO_17	));
		CLK_BUF u_P_GPIO_18  	(.A(P_GPIO_18	), .Y(w_P_GPIO_18	));
		CLK_BUF u_P_GPIO_19  	(.A(P_GPIO_19	), .Y(w_P_GPIO_19	));
		CLK_BUF u_P_GPIO_20  	(.A(P_GPIO_20	), .Y(w_P_GPIO_20	));
		CLK_BUF u_P_GPIO_21  	(.A(P_GPIO_21	), .Y(w_P_GPIO_21	));
		CLK_BUF u_P_GPIO_22  	(.A(P_GPIO_22	), .Y(w_P_GPIO_22	));
		CLK_BUF u_P_GPIO_23  	(.A(P_GPIO_23	), .Y(w_P_GPIO_23	));
		CLK_BUF u_P_GPIO_24  	(.A(P_GPIO_24	), .Y(w_P_GPIO_24	));
		CLK_BUF u_P_GPIO_25  	(.A(P_GPIO_25	), .Y(w_P_GPIO_25	));
		CLK_BUF u_P_GPIO_26  	(.A(P_GPIO_26	), .Y(w_P_GPIO_26	));
		CLK_BUF u_P_GPIO_27  	(.A(P_GPIO_27	), .Y(w_P_GPIO_27	));
		CLK_BUF u_P_GPIO_28  	(.A(P_GPIO_28	), .Y(w_P_GPIO_28	));
		CLK_BUF u_P_GPIO_29  	(.A(P_GPIO_29	), .Y(w_P_GPIO_29	));
		CLK_BUF u_P_GPIO_30  	(.A(P_GPIO_30	), .Y(w_P_GPIO_30	));
		CLK_BUF u_P_GPIO_31  	(.A(P_GPIO_31	), .Y(w_P_GPIO_31	));
		CLK_BUF u_P_GPIO_32  	(.A(P_GPIO_32	), .Y(w_P_GPIO_32	));
		CLK_BUF u_P_GPIO_33  	(.A(P_GPIO_33	), .Y(w_P_GPIO_33	));
		CLK_BUF u_P_GPIO_34  	(.A(P_GPIO_34	), .Y(w_P_GPIO_34	));
		//CLK_BUF u_P_GPIO_35  	(.A(P_GPIO_35	), .Y(w_P_GPIO_35	));

		assign P_GPIO_00	= (w_GPIO_OE[00] ==1'b1) ? w_GPIO_I[00]: 1'bz;
		assign I_GPIO_C[00]	= (w_GPIO_IE[00] ==1'b1) ? w_P_GPIO_00 : 1'b0;
		assign O_MCUP_BSTA  = w_GPIO_I[00];
		
		assign P_GPIO_01	= (w_GPIO_OE[01] ==1'b1) ? w_GPIO_I[01]: 1'bz;
		assign I_GPIO_C[01]	= (w_GPIO_IE[01] ==1'b1) ? w_P_GPIO_01 : 1'b0;
		                              
		assign P_GPIO_02	= (w_GPIO_OE[02] ==1'b1) ? w_GPIO_I[02]: 1'bz;
		assign I_GPIO_C[02]	= (w_GPIO_IE[02] ==1'b1) ? w_P_GPIO_02 : 1'b0;
		                               
		assign P_GPIO_03	= (w_GPIO_OE[03] ==1'b1) ? w_GPIO_I[03]: 1'bz;
		assign I_GPIO_C[03]	= (w_GPIO_IE[03] ==1'b1) ? w_P_GPIO_03 : 1'b0;
		                               
		assign P_GPIO_04	= (w_GPIO_OE[04] ==1'b1) ? w_GPIO_I[04]: 1'bz;
		assign I_GPIO_C[04]	= (w_GPIO_IE[04] ==1'b1) ? w_P_GPIO_04 : 1'b0;
		                               
		assign P_GPIO_05	= (w_GPIO_OE[05] ==1'b1) ? w_GPIO_I[05]: 1'bz;
		assign I_GPIO_C[05]	= (w_GPIO_IE[05] ==1'b1) ? w_P_GPIO_05 : 1'b0;
		                              
		assign P_GPIO_06	= (w_GPIO_OE[06] ==1'b1) ? w_GPIO_I[06]: 1'bz;
		assign I_GPIO_C[06]	= (w_GPIO_IE[06] ==1'b1) ? w_P_GPIO_06 : 1'b0;
		                               
		//assign P_GPIO_07	= (w_GPIO_OE[07] ==1'b1) ? w_GPIO_I[07]: 1'bz;
		assign I_GPIO_C[07]	= (w_GPIO_IE[07] ==1'b1) ? w_P_GPIO_07 : 1'b0;
		                              
		assign P_GPIO_08	= (w_GPIO_OE[08] ==1'b1) ? w_GPIO_I[08]: 1'bz;
		assign I_GPIO_C[08]	= (w_GPIO_IE[08] ==1'b1) ? w_P_GPIO_08 : 1'b0;
		                               
		assign P_GPIO_09	= (w_GPIO_OE[09] ==1'b1) ? w_GPIO_I[09]: 1'bz;
		assign I_GPIO_C[09]	= (w_GPIO_IE[09] ==1'b1) ? w_P_GPIO_09 : 1'b0;
		                               
		assign P_GPIO_10	= (w_GPIO_OE[10] ==1'b1) ? w_GPIO_I[10]: 1'bz;
		assign I_GPIO_C[10]	= (w_GPIO_IE[10] ==1'b1) ? w_P_GPIO_10 : 1'b0;
		                               
		assign P_GPIO_11	= (w_GPIO_OE[11] ==1'b1) ? w_GPIO_I[11]: 1'bz;
		assign I_GPIO_C[11]	= (w_GPIO_IE[11] ==1'b1) ? w_P_GPIO_11 : 1'b0;
		                               
		assign P_GPIO_12	= (w_GPIO_OE[12] ==1'b1) ? w_GPIO_I[12]: 1'bz;
		assign I_GPIO_C[12]	= (w_GPIO_IE[12] ==1'b1) ? w_P_GPIO_12 : 1'b0;
		                               
		assign P_GPIO_13	= (w_GPIO_OE[13] ==1'b1) ? w_GPIO_I[13]: 1'bz;
		assign I_GPIO_C[13]	= (w_GPIO_IE[13] ==1'b1) ? w_P_GPIO_13 : 1'b0;
		                               
		assign P_GPIO_14	= (w_GPIO_OE[14] ==1'b1) ? w_GPIO_I[14]: 1'bz;
		assign I_GPIO_C[14]	= (w_GPIO_IE[14] ==1'b1) ? w_P_GPIO_14 : 1'b0;
		                               
		assign P_GPIO_15	= (w_GPIO_OE[15] ==1'b1) ? w_GPIO_I[15]: 1'bz;
		assign I_GPIO_C[15]	= (w_GPIO_IE[15] ==1'b1) ? w_P_GPIO_15 : 1'b0;
		                               
		assign P_GPIO_16	= (w_GPIO_OE[16] ==1'b1) ? w_GPIO_I[16]: 1'bz;
		assign I_GPIO_C[16]	= (w_GPIO_IE[16] ==1'b1) ? w_P_GPIO_16 : 1'b0;
		                               
		assign P_GPIO_17	= (w_GPIO_OE[17] ==1'b1) ? w_GPIO_I[17]: 1'bz;
		assign I_GPIO_C[17]	= (w_GPIO_IE[17] ==1'b1) ? w_P_GPIO_17 : 1'b0;
		                               
		assign P_GPIO_18	= (w_GPIO_OE[18] ==1'b1) ? w_GPIO_I[18]: 1'bz;
		assign I_GPIO_C[18]	= (w_GPIO_IE[18] ==1'b1) ? w_P_GPIO_18 : 1'b0;
		                               
//		assign P_GPIO_19	= (w_GPIO_OE[19] ==1'b1) ? w_GPIO_I[19]: 1'bz;
		assign I_GPIO_C[19]	= (w_GPIO_IE[19] ==1'b1) ? w_P_GPIO_19 : 1'b0;
		                               
//		assign P_GPIO_20	= (w_GPIO_OE[20] ==1'b1) ? w_GPIO_I[20]: 1'bz;
		assign I_GPIO_C[20]	= (w_GPIO_IE[20] ==1'b1) ? w_P_GPIO_20 : 1'b0;
		                               
//		assign P_GPIO_21	= (w_GPIO_OE[21] ==1'b1) ? w_GPIO_I[21]: 1'bz;
		assign I_GPIO_C[21]	= (w_GPIO_IE[21] ==1'b1) ? w_P_GPIO_21 : 1'b0;
		                               
//		assign P_GPIO_22	= (w_GPIO_OE[22] ==1'b1) ? w_GPIO_I[22] : 1'bz;
		assign I_GPIO_C[22]	= (w_GPIO_IE[22] ==1'b1) ? w_P_GPIO_22 : 1'b0;
		                               
//		assign P_GPIO_23	= (w_GPIO_OE[23] ==1'b1) ? w_GPIO_I[23]: 1'bz;
		assign I_GPIO_C[23]	= (w_GPIO_IE[23] ==1'b1) ? w_P_GPIO_23 : 1'b0;
		                               
//		assign P_GPIO_24	= (w_GPIO_OE[24] ==1'b1) ? w_GPIO_I[24]: 1'bz;
		assign I_GPIO_C[24]	= (w_GPIO_IE[24] ==1'b1) ? w_P_GPIO_24 : 1'b0;
		                               
		//assign P_GPIO_25	= (w_GPIO_OE[25] ==1'b1) ? w_GPIO_I[25]: 1'bz;
		assign I_GPIO_C[25]	= (w_GPIO_IE[25] ==1'b1) ? w_P_GPIO_25 : 1'b0;
		                               
		assign P_GPIO_26	= (w_GPIO_OE[26] ==1'b1) ? w_GPIO_I[26]: 1'bz;
		assign I_GPIO_C[26]	= (w_GPIO_IE[26] ==1'b1) ? w_P_GPIO_26 : 1'b0;
		                               
		assign P_GPIO_27	= (w_GPIO_OE[27] ==1'b1) ? w_GPIO_I[27]: 1'bz;
		assign I_GPIO_C[27]	= (w_GPIO_IE[27] ==1'b1) ? w_P_GPIO_27 : 1'b0;
		                               
		assign P_GPIO_28	= (w_GPIO_OE[28] ==1'b1) ? w_GPIO_I[28]: 1'bz;
		assign I_GPIO_C[28]	= (w_GPIO_IE[28] ==1'b1) ? w_P_GPIO_28 : 1'b0;
		                               
		assign P_GPIO_29	= (w_GPIO_OE[29] ==1'b1) ? w_GPIO_I[29]: 1'bz;
		assign I_GPIO_C[29]	= (w_GPIO_IE[29] ==1'b1) ? w_P_GPIO_29 : 1'b0;
		                               
		assign P_GPIO_30	= (w_GPIO_OE[30] ==1'b1) ? w_GPIO_I[30]: 1'bz;
		assign I_GPIO_C[30]	= (w_GPIO_IE[30] ==1'b1) ? w_P_GPIO_30 : 1'b0;
		                               
		assign P_GPIO_31	= (w_GPIO_OE[31] ==1'b1) ? w_GPIO_I[31]: 1'bz;
		assign I_GPIO_C[31]	= (w_GPIO_IE[31] ==1'b1) ? w_P_GPIO_31 : 1'b0;
                                       
		assign P_GPIO_32	= (w_GPIO_OE[32] ==1'b1) ? w_GPIO_I[32]: 1'bz;
		assign I_GPIO_C[32]	= (w_GPIO_IE[32] ==1'b1) ? w_P_GPIO_32 : 1'b0;
                                       
		assign P_GPIO_33	= (w_GPIO_OE[33] ==1'b1) ? w_GPIO_I[33]: 1'bz;
		assign I_GPIO_C[33]	= (w_GPIO_IE[33] ==1'b1) ? w_P_GPIO_33 : 1'b0;
                                       
		assign P_GPIO_34	= (w_GPIO_OE[34] ==1'b1) ? w_GPIO_I[34]: 1'bz;
		assign I_GPIO_C[34]	= (w_GPIO_IE[34] ==1'b1) ? w_P_GPIO_34 : 1'b0;
                                       
		//assign P_GPIO_35	= (w_GPIO_OE[35] ==1'b1) ? w_GPIO_I[35]: 1'bz;
		assign w_P_GPIO_35	= (w_GPIO_OE[35] ==1'b1) ? w_GPIO_I[35]: 1'bz;
		assign I_GPIO_C[35]	= (w_GPIO_IE[35] ==1'b1) ? w_P_GPIO_35 : 1'b0;

		//POR Modeling
		//reg	[2:0] r_por_cnt = 3'd0;
		//always@(posedge I_RFC_CLKT) begin
		//	if (r_por_cnt < 3'd5)
		//		r_por_cnt <= r_por_cnt + 1;
		//end
		//assign I_AON_RSTB = (r_por_cnt == 3'd5) ? 1'b1 : 1'b0;
		assign I_AON_RSTB = w_P_GPIO_25;
		
        (* keep = "true" *) wire  w_P_GPIO_35_DELAY_1;
//        (* keep = "true" *) wire  w_P_GPIO_35_DELAY_2;
//        (* keep = "true" *) wire  w_P_GPIO_35_DELAY_3;
//        (* keep = "true" *) wire  w_P_GPIO_35_DELAY_4;
//        (* keep = "true" *) wire  w_P_GPIO_35_DELAY_5;
//        (* keep = "true" *) wire  w_P_GPIO_35_DELAY_6;
//        (* keep = "true" *) wire  w_P_GPIO_35_DELAY_7;
//        (* keep = "true" *) wire  w_P_GPIO_35_DELAY_8;
//        (* keep = "true" *) wire  w_P_GPIO_35_DELAY_9;
        
        
//        (* DONT_TOUCH = "TRUE" *) LUT1 #(.INIT(2'b10)) LUT1_inst_0(.O(w_P_GPIO_35_DELAY_1), .I0(w_P_GPIO_35));
//        (* DONT_TOUCH = "TRUE" *) LUT1 #(.INIT(2'b10)) LUT1_inst_1(.O(w_P_GPIO_35_DELAY_2), .I0(w_P_GPIO_35_DELAY_1));
//        (* DONT_TOUCH = "TRUE" *) LUT1 #(.INIT(2'b10)) LUT1_inst_2(.O(w_P_GPIO_35_DELAY_3), .I0(w_P_GPIO_35_DELAY_2));
//        (* DONT_TOUCH = "TRUE" *) LUT1 #(.INIT(2'b10)) LUT1_inst_3(.O(w_P_GPIO_35_DELAY_4), .I0(w_P_GPIO_35_DELAY_3));
//        (* DONT_TOUCH = "TRUE" *) LUT1 #(.INIT(2'b10)) LUT1_inst_4(.O(w_P_GPIO_35_DELAY_5), .I0(w_P_GPIO_35_DELAY_4));
//        (* DONT_TOUCH = "TRUE" *) LUT1 #(.INIT(2'b10)) LUT1_inst_5(.O(w_P_GPIO_35_DELAY_6), .I0(w_P_GPIO_35_DELAY_5));
//        (* DONT_TOUCH = "TRUE" *) LUT1 #(.INIT(2'b10)) LUT1_inst_6(.O(w_P_GPIO_35_DELAY_7), .I0(w_P_GPIO_35_DELAY_6));
//        (* DONT_TOUCH = "TRUE" *) LUT1 #(.INIT(2'b10)) LUT1_inst_7(.O(w_P_GPIO_35_DELAY_8), .I0(w_P_GPIO_35_DELAY_7));
//        (* DONT_TOUCH = "TRUE" *) LUT1 #(.INIT(2'b10)) LUT1_inst_8(.O(w_P_GPIO_35_DELAY_9), .I0(w_P_GPIO_35_DELAY_8));    
//        (* DONT_TOUCH = "TRUE" *) LUT1 #(.INIT(2'b10)) LUT1_inst_9(.O(P_GPIO_35), .I0(w_P_GPIO_35_DELAY_9));
          FDCE #(.INIT(1'b0)
           ) u_FDCE_35_0 (
	       . Q  (w_P_GPIO_35_DELAY_1), .C  (FCLK_CLK1), .CE (1'b1),
           .CLR(1'b0), .D  (w_P_GPIO_35));
           
          FDCE #(.INIT(1'b0)
           ) u_FDCE_35_1 (
	       . Q  (P_GPIO_35), .C  (FCLK_CLK1), .CE (1'b1),
           .CLR(1'b0), .D  (w_P_GPIO_35_DELAY_1));
            
	`else
		//ADC Filter Modeling
		reg			nc1			;
		reg			r_ADC_EN	;
		wire 		w_ADC_EN	;
		wire		w_MCLK		;	
		reg			r_BMODE		;
		wire		w_BMODE		;
		real	vip;
		real	vin;
		real vcm;
		real vbat;
		
		real	vref1p2	;
		
		initial begin
		$display("\n Status Checking \n");
		$display("******************");
		$display("Time =  %g [us]", $realtime*1e-3);
		
		r_BMODE	=	1;
		vbat = 0; // allowable values = -2, -1, 0, 1, 2
		vcm = 2.5;
		vref1p2 = 1.2;
		$display("vbat = %f, vcm =  %f, vref1p2 = %f",vbat,vcm, vref1p2);
		   
	    $display("******************");
		$display("Simulation End: Time =  %g [us]", $realtime*1e-3);
		//  $finish;
		end
		
		assign w_ADC_EN	= O_GPADC_PEN	;
		assign w_MCLK	= O_GPADC_CLKT ;
		assign w_BMODE	= r_BMODE	;
		assign vip = vcm + vbat/2;
		assign vin = vcm - vbat/2;
		
		ADC_TOP_rev u_ADC_TOP_rev (
		/*	input wire			*/		.POC			(1'b0			),
		/*	input wire			*/		.VREFN			(1'b0			),
		/*	input wire			*/		.VDD5P0			(1'b1			),
		/*	input wire			*/		.REG_CLKDIVSEL	(1'b0			),
		/*	input wire			*/		.VSSH			(1'b0			),
		/*	input wire			*/		.VDD1P5			(1'b1			),
		/*	input wire			*/		.IREF1U			(1'b1			),
		/*	input wire			*/		.VSSL			(1'b0			),
		/*	input wire [3:0] 	*/		.ATBSELH		(4'd0			),
		/*	input wire [31:3]	*/		.DREGH			(28'd0			),

		/*	input wire			*/		.MCLK			(w_MCLK			),		
		/*	input real 			*/		.VREFINT		(vref1p2		),
		/*	input wire			*/		.ADC_EN			(w_ADC_EN		),
		/*	output wire			*/		.ATB			(nc1			),
		/*	input real 			*/		.VINP			(vip			),
		/*	input real 			*/		.VINN			(vin			),
		
		/*	input wire			*/		.FILT_EN		(O_GPADC_FILT_EN),
		/*	input wire			*/		.CSTATE			(O_GPADC_CSTATE	),
		/*	output wire			*/		.RSTGEN_CLK		(I_GPADC_RSTGEN_CLK),
		/*	input wire			*/		.BMODE			(w_BMODE		),
		/*	output wire			*/		.DCLK			(I_GPADC_DCLK	),
		/*	output wire			*/		.DSMRST			(I_GPADC_DSMRST	),
		/*	output wire [1:0] 	*/		.DOUT			(I_GPADC_DOUT	)
		);


assign I_DEVICE_ID		= 16'h8120;	//R1-V1
//assign I_DEVICE_ID	= 16'h8121;	//R1-V2
//assign I_DEVICE_ID	= 16'h8122;	//R1-V3
//assign I_DEVICE_ID	= 16'h8140;	//R2-V1

//assign I_LO_PH_I		= 'd0;	//R2 del
//assign I_LO_PH_IB		= 'd0;	//R2 del
//assign I_LO_PH_Q		= 'd0;	//R2 del
//assign I_LO_PH_QB		= 'd0;	//R2 del

//`define RXADC_R1
`define RXADC_R0

`ifdef RXADC_R0 // {
	event adc_conv_done;
	reg [7:0] r_adc_i, r_adc_q;	// unsigned
	
	initial
	begin
		r_adc_i <= 8'h00;
		r_adc_q <= 8'h81;
	end

`ifdef	FW_TEST
	always @ (posedge O_ADC_CLKT)
	begin
		case (O_ADC_FS)
			2'b00 	: # 60;
			2'b01 	: # 50;
			2'b10 	: # 40;
			default : # 30;
		endcase
		r_adc_i <= r_adc_i + 8'h07;
		r_adc_q <= r_adc_q - 8'h07;
		#10->adc_conv_done;
	end

	assign I_ADC_IDATA = r_adc_i;
	assign I_ADC_QDATA = r_adc_q;
`endif
	
`ifdef BGRIP_RX_TEST
`elsif ESB_TEST
	`define ADC_TYPE1
`else
	`define ADC_TYPE0
`endif

`ifdef ADC_TYPE0 // {
	always @ (posedge O_ADC_CLKT)
	begin
		case (O_ADC_FS)
			2'b00 	: # 60;
			2'b01 	: # 50;
			2'b10 	: # 40;
			default : # 30;
		endcase
		r_adc_i <= r_adc_i + 8'h07;
		r_adc_q <= r_adc_q - 8'h07;
		#10->adc_conv_done;
	end

	assign I_ADC_IDATA = r_adc_i;
	assign I_ADC_QDATA = r_adc_q;
`else // } { ADC_TYPE1 : data from RF receiver with gain change.
	reg [3:0] smp_dt = 4'd0;
	reg [2:0] rot_ph = 3'd0;
	reg signed [15:0] txi, txq;
	reg signed [15:0] rxi, rxq;
	reg signed [7:0] rot_i, rot_q;
	reg signed [15:0] fsk_i, fsk_q;

	always @(posedge O_ADC_CLKT or negedge I_AON_RSTB)
	begin : proc_rot
		if (!I_AON_RSTB) begin
			fsk_i <= 0;
			fsk_q <= 0;
		end else begin
			rot_ph <= rot_ph + 3'd1;
			case (rot_ph)	// Modelling of the +1.5 MHz carrier offset.
				3'b000 : {rot_i, rot_q} = {$signed(+8'd106),$signed(+8'd0)};
				3'b001 : {rot_i, rot_q} = {$signed(+8'd75),$signed(+8'd75)};
				3'b010 : {rot_i, rot_q} = {$signed(+8'd0),$signed(+8'd106)};
				3'b011 : {rot_i, rot_q} = {$signed(-8'd75),$signed(+8'd75)};
				3'b100 : {rot_i, rot_q} = {$signed(-8'd106),$signed(+8'd0)};
				3'b101 : {rot_i, rot_q} = {$signed(-8'd75),$signed(-8'd75)};
				3'b110 : {rot_i, rot_q} = {$signed(-8'd0),$signed(-8'd106)};
				default: {rot_i, rot_q} = {$signed(+8'd75),$signed(-8'd75)};
			endcase
			fsk_i <= rot_i * rxi - rot_q * rxq;
			fsk_q <= rot_i * rxq + rot_q * rxi;
			#10->adc_conv_done;
		end
	end // proc_rot

	// Caution : ADC output is always unsigned.
	assign I_ADC_IDATA = {~fsk_i[15], fsk_i[14:8]};
	assign I_ADC_QDATA = {~fsk_q[15], fsk_q[14:8]};

	reg signed [9:0] df; // -512 ~ +511
	reg r_zif_txd;
	integer fsk_ph;
	integer df_tbl[0:2] = {21, 21, 22};
	always @(posedge O_ADC_CLKT or negedge I_AON_RSTB)
	begin : proc_fsk
		if (!I_AON_RSTB) begin
			df = 0.0;
			r_zif_txd = 1'b0;
			fsk_ph = 2'b00;
		end else begin
			txi = 0;
			txq = 0;
			if (fsk_ph >= 2) begin
				fsk_ph = 0;
			end else begin
				fsk_ph = fsk_ph + 1;
			end
			r_zif_txd = tb_top.bb_rxd;
			if (r_zif_txd == 1'b1) begin
				df = df + df_tbl[fsk_ph]; // +250 kHz
			end else begin
				df = df - df_tbl[fsk_ph]; // -250 kHz
			end
			txi = $rtoi($cos($itor(df)*3.14/512)*120);
			txq = $rtoi($sin($itor(df)*3.14/512)*120);
		end
	end // proc_fsk

	real rf_rxi, rf_rxq;
	real att_dB = 60+50;	// atten in dB
	// offset 50 in initial/default value will be removed later after.
	real att;
	// Channel with attenuation
	initial // att in linear scale
		att = $pow(10,-att_dB/20.0);

	always @(*)
	begin : proc_att
		// Range of (txi, txq) : -120 ~ +120 @ 0 dBm
		rf_rxi = $itor(txi) * att;
		rf_rxq = $itor(txq) * att;
	end // proc_att

// Rx RF+BB chain ~ 12b
// 	obtained from r0.
// Gain Component		dB/Step		Range
// O_RX_RF_GC[1:0]		10			0~3
// O_ABB_TIA_GC[2:0]	6			1~6
// O_ABB_FLT_GC[1:0]	6			0~3
// O_ABB_PGA_GC[4:0]	1			0~21

	integer gain_all_dB;

	real abb_rxi, abb_rxq;
	real gtbl_10dB[0:1] = {3.16, 10.0};
	real gtbl_06dB[0:2] = {2.0, 4.0, 8.0};
	real gtbl_01dB[0:4] = {1.12, 1.26, 1.58, 2.51, 6.31};
	real gain_all;
	integer k;

	reg [1:0] w_RX_RF_GC;  
	reg [2:0] w_ABB_TIA_GC;  
	reg [1:0] w_ABB_FLT_GC;  
	reg [4:0] w_ABB_PGA_GC;  
	
	always @(*)
	begin : proc_pga_rx
		gain_all = 1;
		//w_RX_RF_GC = 2'b00;
		for (k=0; k<2; k = k+1) begin // LNA gain
			if (O_RX_RF_GC[k])
				w_RX_RF_GC[k] = 1'b1;
			else
				w_RX_RF_GC[k] = 1'b0;
			gain_all = gain_all * gtbl_10dB[w_RX_RF_GC[k]];
		end
		//w_ABB_TIA_GC = 3'b000;
		for (k=0; k<3; k = k+1) begin // passive mixer output TIA gain
			if (O_ABB_TIA_GC[k])
				w_ABB_TIA_GC[k] = 1'b1;
			else
				w_ABB_TIA_GC[k] = 1'b0;
			gain_all = gain_all * gtbl_06dB[w_ABB_TIA_GC[k]];
		end
		//w_ABB_FLT_GC = 2'b00;
		for (k=0; k<2; k = k+1) begin // Filter gain
			if (O_ABB_FLT_GC[k])
				w_ABB_FLT_GC[k] = 1'b1;
			else
				w_ABB_FLT_GC[k] = 1'b0;
			gain_all = gain_all * gtbl_06dB[w_ABB_FLT_GC[k]];
		end
		//w_ABB_PGA_GC = 5'b00000;
		for (k=0; k<5; k = k+1) begin // 
			if (O_ABB_PGA_GC[k])
				w_ABB_PGA_GC[k] = 1'b1;
			else
				w_ABB_PGA_GC[k] = 1'b0;
			gain_all = gain_all * gtbl_01dB[w_ABB_PGA_GC[k]];
		end
		gain_all_dB = 
			(w_RX_RF_GC[1:0])*10 +
			(w_ABB_TIA_GC[2:0])*6 + 
			(w_ABB_FLT_GC[1:0])*6 +
			(w_ABB_PGA_GC[4:0])*1 ;
		abb_rxi <= gain_all * rf_rxi;
		abb_rxq <= gain_all * rf_rxq;
		rxi <= $rtoi(abb_rxi);
		rxq <= $rtoi(abb_rxq);
	end // proc_pga_rx
`endif // } ADC TYPE --
	
	
	reg r_adc_rdy;
	always @ (negedge O_ADC_CLKT or adc_conv_done)
	begin
		if (!O_ADC_CLKT) begin
			r_adc_rdy <= 1'b0;
		end else begin
			r_adc_rdy <= 1'b1;
		end
	end
	
	assign I_ADC_ICONV_RDY = r_adc_rdy;
	assign I_ADC_QCONV_RDY = r_adc_rdy;

`else // } ADC_R1 (why ?) { 
	assign I_ADC_ICONV_RDY	= 1'b0;
	assign I_ADC_IDATA		= 8'h56;
	assign I_ADC_QCONV_RDY	= 1'b0;
	assign I_ADC_QDATA		= 8'h78;
`endif // }


		assign I_FT_CC			= 5'h1A;
		assign I_FT_DONE		= 1'b0;

		//POR Modeling
		reg	por;
		initial begin
			por = 0;
		`ifdef	POST_SIM
			#100000;
		`else
			#1000;
		`endif
			por = 1;
		end
		assign I_AON_RSTB = por;

		wire	XOSC;
		OSC_MODEL #(
			.osc_half_period	(20.833/2)	//48MHz
		) u_OSC_H_MODEL (
			.OSC_EN		(O_XO_PEN		),
			.OSC_CLK	(XOSC		)
		);
		assign I_RFC_CLKT 	= (O_XO_RFC_CLK_EN) ? XOSC	: 1'b0;
		assign I_RFC_CLKB 	= (O_XO_RFC_CLK_EN) ? ~XOSC	: 1'b1;

		wire w_RTC_EN = (O_RTC_EN_SEL) ? O_RTC_EN : 1'b1;
		OSC_MODEL #(
			.osc_half_period	(31250/2)	//32KHz
		) u_RTC_MODEL (
			.OSC_EN		(w_RTC_EN		),
			.OSC_CLK	(I_RTC_CLKT		)
		);
		assign I_RTC_CLKB	= ~I_RTC_CLKT;

		//--------------------------------------------------------------------------
		//GPIO
		//--------------------------------------------------------------------------
		`ifdef	HLMC55_ULP
			HPDWUW1012SDGP I_PAD_GPIO_00 (
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p81		),
				.PFC	(w_PAD_AON_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_00			),
				/*input */	.I		(O_GPIO_I[00]		),
				/*input */	.OE		(O_GPIO_OE[00]		),
				/*input */	.DS		(O_GPIO_DS[00]		),
				/*input */	.IE		(O_GPIO_IE[00]		),
				/*output*/	.C		(I_GPIO_C[00]		),
				/*input */	.PE		(O_GPIO_PE[00]		),
				/*input */	.PS		(O_GPIO_PS[00]		)
			);

			HPDWUW1012SDGP I_PAD_GPIO_01 (
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p81		),
				.PFC	(w_PAD_AON_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_01			),
				/*input */	.I		(O_GPIO_I[01]		),
				/*input */	.OE		(O_GPIO_OE[01]		),
				/*input */	.DS		(O_GPIO_DS[01]		),
				/*input */	.IE		(O_GPIO_IE[01]		),
				/*output*/	.C		(I_GPIO_C[01]		),
				/*input */	.PE		(O_GPIO_PE[01]		),
				/*input */	.PS		(O_GPIO_PS[01]		)
			);

			HPDWUW1012SDGP I_PAD_GPIO_02 (
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p81		),
				.PFC	(w_PAD_AON_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_02			),
				/*input */	.I		(O_GPIO_I[02]		),
				/*input */	.OE		(O_GPIO_OE[02]		),
				/*input */	.DS		(O_GPIO_DS[02]		),
				/*input */	.IE		(O_GPIO_IE[02]		),
				/*output*/	.C		(I_GPIO_C[02]		),
				/*input */	.PE		(O_GPIO_PE[02]		),
				/*input */	.PS		(O_GPIO_PS[02]		)
			);

			HPDWUW1012SDGP I_PAD_GPIO_03 (
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p81		),
				.PFC	(w_PAD_AON_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_03			),
				/*input */	.I		(O_GPIO_I[03]		),
				/*input */	.OE		(O_GPIO_OE[03]		),
				/*input */	.DS		(O_GPIO_DS[03]		),
				/*input */	.IE		(O_GPIO_IE[03]		),
				/*output*/	.C		(I_GPIO_C[03]		),
				/*input */	.PE		(O_GPIO_PE[03]		),
				/*input */	.PS		(O_GPIO_PS[03]		)
			);

			HPDWUW1012SDGP I_PAD_GPIO_04 (
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p81		),
				.PFC	(w_PAD_AON_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_04			),
				/*input */	.I		(O_GPIO_I[04]		),
				/*input */	.OE		(O_GPIO_OE[04]		),
				/*input */	.DS		(O_GPIO_DS[04]		),
				/*input */	.IE		(O_GPIO_IE[04]		),
				/*output*/	.C		(I_GPIO_C[04]		),
				/*input */	.PE		(O_GPIO_PE[04]		),
				/*input */	.PS		(O_GPIO_PS[04]		)
			);

			HPDWUW1012SDGP I_PAD_GPIO_05 (
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_05			),
				/*input */	.I		(O_GPIO_I[05]		),
				/*input */	.OE		(O_GPIO_OE[05]		),
				/*input */	.DS		(O_GPIO_DS[05]		),
				/*input */	.IE		(O_GPIO_IE[05]		),
				/*output*/	.C		(I_GPIO_C[05]		),
				/*input */	.PE		(O_GPIO_PE[05]		),
				/*input */	.PS		(O_GPIO_PS[05]		)
			);

			HPDWUW1012SDGP I_PAD_GPIO_06 (
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_06			),
				/*input */	.I		(O_GPIO_I[06]		),
				/*input */	.OE		(O_GPIO_OE[06]		),
				/*input */	.DS		(O_GPIO_DS[06]		),
				/*input */	.IE		(O_GPIO_IE[06]		),
				/*output*/	.C		(I_GPIO_C[06]		),
				/*input */	.PE		(O_GPIO_PE[06]		),
				/*input */	.PS		(O_GPIO_PS[06]		)
			);

			HPDWUW1012SDGP I_PAD_GPIO_07 (
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_07			),
				/*input */	.I		(O_GPIO_I[07]		),
				/*input */	.OE		(O_GPIO_OE[07]		),
				/*input */	.DS		(O_GPIO_DS[07]		),
				/*input */	.IE		(O_GPIO_IE[07]		),
				/*output*/	.C		(I_GPIO_C[07]		),
				/*input */	.PE		(O_GPIO_PE[07]		),
				/*input */	.PS		(O_GPIO_PS[07]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_08 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_08	 		),
				/*input */	.I		(O_GPIO_I[08]		),
				/*input */	.OE		(O_GPIO_OE[08]		),
				/*input */	.DS		(O_GPIO_DS[08]		),
				/*input */	.IE		(O_GPIO_IE[08]		),
				/*output*/	.C		(I_GPIO_C[08]		),
				/*input */	.PE		(O_GPIO_PE[08]		),
				/*input */	.PS		(O_GPIO_PS[08]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_09 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_09	 		),
				/*input */	.I		(O_GPIO_I[09]		),
				/*input */	.OE		(O_GPIO_OE[09]		),
				/*input */	.DS		(O_GPIO_DS[09]		),
				/*input */	.IE		(O_GPIO_IE[09]		),
				/*output*/	.C		(I_GPIO_C[09]		),
				/*input */	.PE		(O_GPIO_PE[09]		),
				/*input */	.PS		(O_GPIO_PS[09]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_10 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_10	 		),
				/*input */	.I		(O_GPIO_I[10]		),
				/*input */	.OE		(O_GPIO_OE[10]		),
				/*input */	.DS		(O_GPIO_DS[10]		),
				/*input */	.IE		(O_GPIO_IE[10]		),
				/*output*/	.C		(I_GPIO_C[10]		),
				/*input */	.PE		(O_GPIO_PE[10]		),
				/*input */	.PS		(O_GPIO_PS[10]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_11 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_11	 		),
				/*input */	.I		(O_GPIO_I[11]		),
				/*input */	.OE		(O_GPIO_OE[11]		),
				/*input */	.DS		(O_GPIO_DS[11]		),
				/*input */	.IE		(O_GPIO_IE[11]		),
				/*output*/	.C		(I_GPIO_C[11]		),
				/*input */	.PE		(O_GPIO_PE[11]		),
				/*input */	.PS		(O_GPIO_PS[11]		)
			);                                   		
														
			HPDWUW1012SDGP I_PAD_GPIO_12 (       		
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_12	 		),
				/*input */	.I		(O_GPIO_I[12]		),
				/*input */	.OE		(O_GPIO_OE[12]		),
				/*input */	.DS		(O_GPIO_DS[12]		),
				/*input */	.IE		(O_GPIO_IE[12]		),
				/*output*/	.C		(I_GPIO_C[12]		),
				/*input */	.PE		(O_GPIO_PE[12]		),
				/*input */	.PS		(O_GPIO_PS[12]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_13 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_13	 		),
				/*input */	.I		(O_GPIO_I[13]		),
				/*input */	.OE		(O_GPIO_OE[13]		),
				/*input */	.DS		(O_GPIO_DS[13]		),
				/*input */	.IE		(O_GPIO_IE[13]		),
				/*output*/	.C		(I_GPIO_C[13]		),
				/*input */	.PE		(O_GPIO_PE[13]		),
				/*input */	.PS		(O_GPIO_PS[13]		)
			);                                  	
													
			HPDWUW1012SDGP I_PAD_GPIO_14 (      	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_14			),
				/*input */	.I		(O_GPIO_I[14]		),
				/*input */	.OE		(O_GPIO_OE[14]		),
				/*input */	.DS		(O_GPIO_DS[14]		),
				/*input */	.IE		(O_GPIO_IE[14]		),
				/*output*/	.C		(I_GPIO_C[14]		),
				/*input */	.PE		(O_GPIO_PE[14]		),
				/*input */	.PS		(O_GPIO_PS[14]		)
			);                                  	
													
			HPDWUW1012SDGP I_PAD_GPIO_15 (      	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_15			),
				/*input */	.I		(O_GPIO_I[15]		),
				/*input */	.OE		(O_GPIO_OE[15]		),
				/*input */	.DS		(O_GPIO_DS[15]		),
				/*input */	.IE		(O_GPIO_IE[15]		),
				/*output*/	.C		(I_GPIO_C[15]		),
				/*input */	.PE		(O_GPIO_PE[15]		),
				/*input */	.PS		(O_GPIO_PS[15]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_16 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_16	 		),
				/*input */	.I		(O_GPIO_I[16]		),
				/*input */	.OE		(O_GPIO_OE[16]		),
				/*input */	.DS		(O_GPIO_DS[16]		),
				/*input */	.IE		(O_GPIO_IE[16]		),
				/*output*/	.C		(I_GPIO_C[16]		),
				/*input */	.PE		(O_GPIO_PE[16]		),
				/*input */	.PS		(O_GPIO_PS[16]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_17 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_17	 		),
				/*input */	.I		(O_GPIO_I[17]		),
				/*input */	.OE		(O_GPIO_OE[17]		),
				/*input */	.DS		(O_GPIO_DS[17]		),
				/*input */	.IE		(O_GPIO_IE[17]		),
				/*output*/	.C		(I_GPIO_C[17]		),
				/*input */	.PE		(O_GPIO_PE[17]		),
				/*input */	.PS		(O_GPIO_PS[17]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_18 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_18	 		),
				/*input */	.I		(O_GPIO_I[18]		),
				/*input */	.OE		(O_GPIO_OE[18]		),
				/*input */	.DS		(O_GPIO_DS[18]		),
				/*input */	.IE		(O_GPIO_IE[18]		),
				/*output*/	.C		(I_GPIO_C[18]		),
				/*input */	.PE		(O_GPIO_PE[18]		),
				/*input */	.PS		(O_GPIO_PS[18]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_19 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_19	 		),
				/*input */	.I		(O_GPIO_I[19]		),
				/*input */	.OE		(O_GPIO_OE[19]		),
				/*input */	.DS		(O_GPIO_DS[19]		),
				/*input */	.IE		(O_GPIO_IE[19]		),
				/*output*/	.C		(I_GPIO_C[19]		),
				/*input */	.PE		(O_GPIO_PE[19]		),
				/*input */	.PS		(O_GPIO_PS[19]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_20 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_20	 		),
				/*input */	.I		(O_GPIO_I[20]		),
				/*input */	.OE		(O_GPIO_OE[20]		),
				/*input */	.DS		(O_GPIO_DS[20]		),
				/*input */	.IE		(O_GPIO_IE[20]		),
				/*output*/	.C		(I_GPIO_C[20]		),
				/*input */	.PE		(O_GPIO_PE[20]		),
				/*input */	.PS		(O_GPIO_PS[20]		)
			);                                 	
												
			HPDWUW1012SDGP I_PAD_GPIO_21 (     	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_21 			),
				/*input */	.I		(O_GPIO_I[21]		),
				/*input */	.OE		(O_GPIO_OE[21]		),
				/*input */	.DS		(O_GPIO_DS[21]		),
				/*input */	.IE		(O_GPIO_IE[21]		),
				/*output*/	.C		(I_GPIO_C[21]		),
				/*input */	.PE		(O_GPIO_PE[21]		),
				/*input */	.PS		(O_GPIO_PS[21]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_22 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_22	 		),
				/*input */	.I		(O_GPIO_I[22]		),
				/*input */	.OE		(O_GPIO_OE[22]		),
				/*input */	.DS		(O_GPIO_DS[22]		),
				/*input */	.IE		(O_GPIO_IE[22]		),
				/*output*/	.C		(I_GPIO_C[22]		),
				/*input */	.PE		(O_GPIO_PE[22]		),
				/*input */	.PS		(O_GPIO_PS[22]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_23 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_23	 		),
				/*input */	.I		(O_GPIO_I[23]		),
				/*input */	.OE		(O_GPIO_OE[23]		),
				/*input */	.DS		(O_GPIO_DS[23]		),
				/*input */	.IE		(O_GPIO_IE[23]		),
				/*output*/	.C		(I_GPIO_C[23]		),
				/*input */	.PE		(O_GPIO_PE[23]		),
				/*input */	.PS		(O_GPIO_PS[23]		)
			);                                  	
													
			HPDWUW1012SDGP I_PAD_GPIO_24 (      	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_24			),
				/*input */	.I		(O_GPIO_I[24]		),
				/*input */	.OE		(O_GPIO_OE[24]		),
				/*input */	.DS		(O_GPIO_DS[24]		),
				/*input */	.IE		(O_GPIO_IE[24]		),
				/*output*/	.C		(I_GPIO_C[24]		),
				/*input */	.PE		(O_GPIO_PE[24]		),
				/*input */	.PS		(O_GPIO_PS[24]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_25 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_25	 		),
				/*input */	.I		(O_GPIO_I[25]		),
				/*input */	.OE		(O_GPIO_OE[25]		),
				/*input */	.DS		(O_GPIO_DS[25]		),
				/*input */	.IE		(O_GPIO_IE[25]		),
				/*output*/	.C		(I_GPIO_C[25]		),
				/*input */	.PE		(O_GPIO_PE[25]		),
				/*input */	.PS		(O_GPIO_PS[25]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_26 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_26	 		),
				/*input */	.I		(O_GPIO_I[26]		),
				/*input */	.OE		(O_GPIO_OE[26]		),
				/*input */	.DS		(O_GPIO_DS[26]		),
				/*input */	.IE		(O_GPIO_IE[26]		),
				/*output*/	.C		(I_GPIO_C[26]		),
				/*input */	.PE		(O_GPIO_PE[26]		),
				/*input */	.PS		(O_GPIO_PS[26]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_27 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_27	 		),
				/*input */	.I		(O_GPIO_I[27]		),
				/*input */	.OE		(O_GPIO_OE[27]		),
				/*input */	.DS		(O_GPIO_DS[27]		),
				/*input */	.IE		(O_GPIO_IE[27]		),
				/*output*/	.C		(I_GPIO_C[27]		),
				/*input */	.PE		(O_GPIO_PE[27]		),
				/*input */	.PS		(O_GPIO_PS[27]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_28 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_28	 		),
				/*input */	.I		(O_GPIO_I[28]		),
				/*input */	.OE		(O_GPIO_OE[28]		),
				/*input */	.DS		(O_GPIO_DS[28]		),
				/*input */	.IE		(O_GPIO_IE[28]		),
				/*output*/	.C		(I_GPIO_C[28]		),
				/*input */	.PE		(O_GPIO_PE[28]		),
				/*input */	.PS		(O_GPIO_PS[28]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_29 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_29	 		),
				/*input */	.I		(O_GPIO_I[29]		),
				/*input */	.OE		(O_GPIO_OE[29]		),
				/*input */	.DS		(O_GPIO_DS[29]		),
				/*input */	.IE		(O_GPIO_IE[29]		),
				/*output*/	.C		(I_GPIO_C[29]		),
				/*input */	.PE		(O_GPIO_PE[29]		),
				/*input */	.PS		(O_GPIO_PS[29]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_30 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_30	 		),
				/*input */	.I		(O_GPIO_I[30]		),
				/*input */	.OE		(O_GPIO_OE[30]		),
				/*input */	.DS		(O_GPIO_DS[30]		),
				/*input */	.IE		(O_GPIO_IE[30]		),
				/*output*/	.C		(I_GPIO_C[30]		),
				/*input */	.PE		(O_GPIO_PE[30]		),
				/*input */	.PS		(O_GPIO_PS[30]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_31 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_31	 		),
				/*input */	.I		(O_GPIO_I[31]		),
				/*input */	.OE		(O_GPIO_OE[31]		),
				/*input */	.DS		(O_GPIO_DS[31]		),
				/*input */	.IE		(O_GPIO_IE[31]		),
				/*output*/	.C		(I_GPIO_C[31]		),
				/*input */	.PE		(O_GPIO_PE[31]		),
				/*input */	.PS		(O_GPIO_PS[31]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_32 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_32	 		),
				/*input */	.I		(O_GPIO_I[32]		),
				/*input */	.OE		(O_GPIO_OE[32]		),
				/*input */	.DS		(O_GPIO_DS[32]		),
				/*input */	.IE		(O_GPIO_IE[32]		),
				/*output*/	.C		(I_GPIO_C[32]		),
				/*input */	.PE		(O_GPIO_PE[32]		),
				/*input */	.PS		(O_GPIO_PS[32]		)
			);                                   	
													
			HPDWUW1012SDGP I_PAD_GPIO_33 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_33	 		),
				/*input */	.I		(O_GPIO_I[33]		),
				/*input */	.OE		(O_GPIO_OE[33]		),
				/*input */	.DS		(O_GPIO_DS[33]		),
				/*input */	.IE		(O_GPIO_IE[33]		),
				/*output*/	.C		(I_GPIO_C[33]		),
				/*input */	.PE		(O_GPIO_PE[33]		),
				/*input */	.PS		(O_GPIO_PS[33]		)
			);                                   	
													
													
			HPDWUW1012SDGP I_PAD_GPIO_34 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_34	 		),
				/*input */	.I		(O_GPIO_I[34]		),
				/*input */	.OE		(O_GPIO_OE[34]		),
				/*input */	.DS		(O_GPIO_DS[34]		),
				/*input */	.IE		(O_GPIO_IE[34]		),
				/*output*/	.C		(I_GPIO_C[34]		),
				/*input */	.PE		(O_GPIO_PE[34]		),
				/*input */	.PS		(O_GPIO_PS[34]		)
			);                                   	
													
													
			HPDWUW1012SDGP I_PAD_GPIO_35 (       	
			`ifdef	PG_PIN
				.VSSIO	(VSS			),	
				.VCCIO	(VDD_3p30		),
				.VSS	(VSS			),
				.VCC	(VDD_0p90		),
				.PFC	(w_PAD_CORE_PFC	),
			`endif
				/*inout */	.PAD	(P_GPIO_35	 		),
				/*input */	.I		(O_GPIO_I[35]		),
				/*input */	.OE		(O_GPIO_OE[35]		),
				/*input */	.DS		(O_GPIO_DS[35]		),
				/*input */	.IE		(O_GPIO_IE[35]		),
				/*output*/	.C		(I_GPIO_C[35]		),
				/*input */	.PE		(O_GPIO_PE[35]		),
				/*input */	.PS		(O_GPIO_PS[35]		)
			);

			`ifdef	PG_PIN
				HPDWUW1012SDGP I_PAD_TEST_EN (       	
				`ifdef	PG_PIN
					.VSSIO	(VSS			),	
					.VCCIO	(VDD_3p30		),
					.VSS	(VSS			),
					.VCC	(VDD_0p90		),
					.PFC	(w_PAD_CORE_PFC	),
				`endif
					/*inout */	.PAD	(P_TEST_EN	 		),
					/*input */	.DS		(1'b0	),
					/*input */	.I		(1'b0	),
					/*input */	.IE		(1'b1	),
					/*input */	.OE		(1'b0	),
					/*input */	.PE		(1'b1	),
					/*input */	.PS		(1'b0	),
					/*output*/	.C		(I_TEST_EN_C		)
				);

				HPDWUW1012SDGP I_PAD_ROM_EN (       	
				`ifdef	PG_PIN
					.VSSIO	(VSS			),	
					.VCCIO	(VDD_3p30		),
					.VSS	(VSS			),
					.VCC	(VDD_0p90		),
					.PFC	(w_PAD_CORE_PFC	),
				`endif
					/*inout */	.PAD	(P_ROM_EN	 		),
					/*input */	.DS		(1'b0	),
					/*input */	.I		(1'b0	),
					/*input */	.IE		(1'b1	),
					/*input */	.OE		(1'b0	),
					/*input */	.PE		(1'b1	),
					/*input */	.PS		(1'b1	),
					/*output*/	.C		(I_ROM_EN_C			)
				);

				HPDWUW1012SDGP I_PAD_DBG_EN (       	
				`ifdef	PG_PIN
					.VSSIO	(VSS			),	
					.VCCIO	(VDD_3p30		),
					.VSS	(VSS			),
					.VCC	(VDD_0p90		),
					.PFC	(w_PAD_CORE_PFC	),
				`endif
					/*inout */	.PAD	(P_DBG_EN	 		),
					/*input */	.DS		(1'b0	),
					/*input */	.I		(1'b0	),
					/*input */	.IE		(1'b1	),
					/*input */	.OE		(1'b0	),
					/*input */	.PE		(1'b1	),
					/*input */	.PS		(1'b0	),
					/*output*/	.C		(I_DBG_EN_C			)
				);
			`else
				assign I_TEST_EN_C	= P_TEST_EN;
				assign I_ROM_EN_C	= P_ROM_EN;
				assign I_DBG_EN_C	= P_DBG_EN;
			`endif
		`else
			////// PAD ///////////////////////////////////////////////////////////////////
			assign I_TEST_EN_C	= P_TEST_EN;
			assign I_ROM_EN_C	= P_ROM_EN;
			assign I_DBG_EN_C	= P_DBG_EN;

			PDUW0812SCDG I_PAD_GPIO_00 (
				/*inout */	.PAD	(P_GPIO_00			),
				/*input */	.I		(O_GPIO_I[00]		),
				/*input */	.OEN	(O_GPIO_OE[00]		),
				/*input */	.DS		(O_GPIO_DS[00]		),
				/*input */	.IE		(O_GPIO_IE[00]		),
				/*output*/	.C		(I_GPIO_C[00]		),
				/*input */	.PE		(O_GPIO_PE[00]		)
			);

			PDUW0812SCDG I_PAD_GPIO_01 (
				/*inout */	.PAD	(P_GPIO_01			),
				/*input */	.I		(O_GPIO_I[01]		),
				/*input */	.OEN	(O_GPIO_OE[01]		),
				/*input */	.DS		(O_GPIO_DS[01]		),
				/*input */	.IE		(O_GPIO_IE[01]		),
				/*output*/	.C		(I_GPIO_C[01]		),
				/*input */	.PE		(O_GPIO_PE[01]		)
			);

			PDUW0812SCDG I_PAD_GPIO_02 (
				/*inout */	.PAD	(P_GPIO_02			),
				/*input */	.I		(O_GPIO_I[02]		),
				/*input */	.OEN	(O_GPIO_OE[02]		),
				/*input */	.DS		(O_GPIO_DS[02]		),
				/*input */	.IE		(O_GPIO_IE[02]		),
				/*output*/	.C		(I_GPIO_C[02]		),
				/*input */	.PE		(O_GPIO_PE[02]		)
			);

			PDUW0812SCDG I_PAD_GPIO_03 (
				/*inout */	.PAD	(P_GPIO_03			),
				/*input */	.I		(O_GPIO_I[03]		),
				/*input */	.OEN	(O_GPIO_OE[03]		),
				/*input */	.DS		(O_GPIO_DS[03]		),
				/*input */	.IE		(O_GPIO_IE[03]		),
				/*output*/	.C		(I_GPIO_C[03]		),
				/*input */	.PE		(O_GPIO_PE[03]		)
			);

			PDUW0812SCDG I_PAD_GPIO_04 (
				/*inout */	.PAD	(P_GPIO_04			),
				/*input */	.I		(O_GPIO_I[04]		),
				/*input */	.OEN	(O_GPIO_OE[04]		),
				/*input */	.DS		(O_GPIO_DS[04]		),
				/*input */	.IE		(O_GPIO_IE[04]		),
				/*output*/	.C		(I_GPIO_C[04]		),
				/*input */	.PE		(O_GPIO_PE[04]		)
			);

			PDUW0812SCDG I_PAD_GPIO_05 (
				/*inout */	.PAD	(P_GPIO_05			),
				/*input */	.I		(O_GPIO_I[05]		),
				/*input */	.OEN	(O_GPIO_OE[05]		),
				/*input */	.DS		(O_GPIO_DS[05]		),
				/*input */	.IE		(O_GPIO_IE[05]		),
				/*output*/	.C		(I_GPIO_C[05]		),
				/*input */	.PE		(O_GPIO_PE[05]		)
			);

			PDUW0812SCDG I_PAD_GPIO_06 (
				/*inout */	.PAD	(P_GPIO_06			),
				/*input */	.I		(O_GPIO_I[06]		),
				/*input */	.OEN	(O_GPIO_OE[06]		),
				/*input */	.DS		(O_GPIO_DS[06]		),
				/*input */	.IE		(O_GPIO_IE[06]		),
				/*output*/	.C		(I_GPIO_C[06]		),
				/*input */	.PE		(O_GPIO_PE[06]		)
			);

			PDUW0812SCDG I_PAD_GPIO_07 (
				/*inout */	.PAD	(P_GPIO_07			),
				/*input */	.I		(O_GPIO_I[07]		),
				/*input */	.OEN	(O_GPIO_OE[07]		),
				/*input */	.DS		(O_GPIO_DS[07]		),
				/*input */	.IE		(O_GPIO_IE[07]		),
				/*output*/	.C		(I_GPIO_C[07]		),
				/*input */	.PE		(O_GPIO_PE[07]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_08 (       	
				/*inout */	.PAD	(P_GPIO_08	 		),
				/*input */	.I		(O_GPIO_I[08]		),
				/*input */	.OEN	(O_GPIO_OE[08]		),
				/*input */	.DS		(O_GPIO_DS[08]		),
				/*input */	.IE		(O_GPIO_IE[08]		),
				/*output*/	.C		(I_GPIO_C[08]		),
				/*input */	.PE		(O_GPIO_PE[08]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_09 (       	
				/*inout */	.PAD	(P_GPIO_09	 		),
				/*input */	.I		(O_GPIO_I[09]		),
				/*input */	.OEN	(O_GPIO_OE[09]		),
				/*input */	.DS		(O_GPIO_DS[09]		),
				/*input */	.IE		(O_GPIO_IE[09]		),
				/*output*/	.C		(I_GPIO_C[09]		),
				/*input */	.PE		(O_GPIO_PE[09]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_10 (       	
				/*inout */	.PAD	(P_GPIO_10	 		),
				/*input */	.I		(O_GPIO_I[10]		),
				/*input */	.OEN	(O_GPIO_OE[10]		),
				/*input */	.DS		(O_GPIO_DS[10]		),
				/*input */	.IE		(O_GPIO_IE[10]		),
				/*output*/	.C		(I_GPIO_C[10]		),
				/*input */	.PE		(O_GPIO_PE[10]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_11 (       	
				/*inout */	.PAD	(P_GPIO_11	 		),
				/*input */	.I		(O_GPIO_I[11]		),
				/*input */	.OEN	(O_GPIO_OE[11]		),
				/*input */	.DS		(O_GPIO_DS[11]		),
				/*input */	.IE		(O_GPIO_IE[11]		),
				/*output*/	.C		(I_GPIO_C[11]		),
				/*input */	.PE		(O_GPIO_PE[11]		)
			);                                   		
														
			PDUW0812SCDG I_PAD_GPIO_12 (       		
				/*inout */	.PAD	(P_GPIO_12	 		),
				/*input */	.I		(O_GPIO_I[12]		),
				/*input */	.OEN	(O_GPIO_OE[12]		),
				/*input */	.DS		(O_GPIO_DS[12]		),
				/*input */	.IE		(O_GPIO_IE[12]		),
				/*output*/	.C		(I_GPIO_C[12]		),
				/*input */	.PE		(O_GPIO_PE[12]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_13 (       	
				/*inout */	.PAD	(P_GPIO_13	 		),
				/*input */	.I		(O_GPIO_I[13]		),
				/*input */	.OEN	(O_GPIO_OE[13]		),
				/*input */	.DS		(O_GPIO_DS[13]		),
				/*input */	.IE		(O_GPIO_IE[13]		),
				/*output*/	.C		(I_GPIO_C[13]		),
				/*input */	.PE		(O_GPIO_PE[13]		)
			);                                  	
													
			PDUW0812SCDG I_PAD_GPIO_14 (      	
				/*inout */	.PAD	(P_GPIO_14			),
				/*input */	.I		(O_GPIO_I[14]		),
				/*input */	.OEN	(O_GPIO_OE[14]		),
				/*input */	.DS		(O_GPIO_DS[14]		),
				/*input */	.IE		(O_GPIO_IE[14]		),
				/*output*/	.C		(I_GPIO_C[14]		),
				/*input */	.PE		(O_GPIO_PE[14]		)
			);                                  	
													
			PDUW0812SCDG I_PAD_GPIO_15 (      	
				/*inout */	.PAD	(P_GPIO_15			),
				/*input */	.I		(O_GPIO_I[15]		),
				/*input */	.OEN	(O_GPIO_OE[15]		),
				/*input */	.DS		(O_GPIO_DS[15]		),
				/*input */	.IE		(O_GPIO_IE[15]		),
				/*output*/	.C		(I_GPIO_C[15]		),
				/*input */	.PE		(O_GPIO_PE[15]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_16 (       	
				/*inout */	.PAD	(P_GPIO_16	 		),
				/*input */	.I		(O_GPIO_I[16]		),
				/*input */	.OEN	(O_GPIO_OE[16]		),
				/*input */	.DS		(O_GPIO_DS[16]		),
				/*input */	.IE		(O_GPIO_IE[16]		),
				/*output*/	.C		(I_GPIO_C[16]		),
				/*input */	.PE		(O_GPIO_PE[16]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_17 (       	
				/*inout */	.PAD	(P_GPIO_17	 		),
				/*input */	.I		(O_GPIO_I[17]		),
				/*input */	.OEN	(O_GPIO_OE[17]		),
				/*input */	.DS		(O_GPIO_DS[17]		),
				/*input */	.IE		(O_GPIO_IE[17]		),
				/*output*/	.C		(I_GPIO_C[17]		),
				/*input */	.PE		(O_GPIO_PE[17]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_18 (       	
				/*inout */	.PAD	(P_GPIO_18	 		),
				/*input */	.I		(O_GPIO_I[18]		),
				/*input */	.OEN	(O_GPIO_OE[18]		),
				/*input */	.DS		(O_GPIO_DS[18]		),
				/*input */	.IE		(O_GPIO_IE[18]		),
				/*output*/	.C		(I_GPIO_C[18]		),
				/*input */	.PE		(O_GPIO_PE[18]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_19 (       	
				/*inout */	.PAD	(P_GPIO_19	 		),
				/*input */	.I		(O_GPIO_I[19]		),
				/*input */	.OEN	(O_GPIO_OE[19]		),
				/*input */	.DS		(O_GPIO_DS[19]		),
				/*input */	.IE		(O_GPIO_IE[19]		),
				/*output*/	.C		(I_GPIO_C[19]		),
				/*input */	.PE		(O_GPIO_PE[19]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_20 (       	
				/*inout */	.PAD	(P_GPIO_20	 		),
				/*input */	.I		(O_GPIO_I[20]		),
				/*input */	.OEN	(O_GPIO_OE[20]		),
				/*input */	.DS		(O_GPIO_DS[20]		),
				/*input */	.IE		(O_GPIO_IE[20]		),
				/*output*/	.C		(I_GPIO_C[20]		),
				/*input */	.PE		(O_GPIO_PE[20]		)
			);                                 	
												
			PDUW0812SCDG I_PAD_GPIO_21 (     	
				/*inout */	.PAD	(P_GPIO_21 			),
				/*input */	.I		(O_GPIO_I[21]		),
				/*input */	.OEN	(O_GPIO_OE[21]		),
				/*input */	.DS		(O_GPIO_DS[21]		),
				/*input */	.IE		(O_GPIO_IE[21]		),
				/*output*/	.C		(I_GPIO_C[21]		),
				/*input */	.PE		(O_GPIO_PE[21]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_22 (       	
				/*inout */	.PAD	(P_GPIO_22	 		),
				/*input */	.I		(O_GPIO_I[22]		),
				/*input */	.OEN	(O_GPIO_OE[22]		),
				/*input */	.DS		(O_GPIO_DS[22]		),
				/*input */	.IE		(O_GPIO_IE[22]		),
				/*output*/	.C		(I_GPIO_C[22]		),
				/*input */	.PE		(O_GPIO_PE[22]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_23 (       	
				/*inout */	.PAD	(P_GPIO_23	 		),
				/*input */	.I		(O_GPIO_I[23]		),
				/*input */	.OEN	(O_GPIO_OE[23]		),
				/*input */	.DS		(O_GPIO_DS[23]		),
				/*input */	.IE		(O_GPIO_IE[23]		),
				/*output*/	.C		(I_GPIO_C[23]		),
				/*input */	.PE		(O_GPIO_PE[23]		)
			);                                  	
													
			PDUW0812SCDG I_PAD_GPIO_24 (      	
				/*inout */	.PAD	(P_GPIO_24			),
				/*input */	.I		(O_GPIO_I[24]		),
				/*input */	.OEN	(O_GPIO_OE[24]		),
				/*input */	.DS		(O_GPIO_DS[24]		),
				/*input */	.IE		(O_GPIO_IE[24]		),
				/*output*/	.C		(I_GPIO_C[24]		),
				/*input */	.PE		(O_GPIO_PE[24]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_25 (       	
				/*inout */	.PAD	(P_GPIO_25	 		),
				/*input */	.I		(O_GPIO_I[25]		),
				/*input */	.OEN	(O_GPIO_OE[25]		),
				/*input */	.DS		(O_GPIO_DS[25]		),
				/*input */	.IE		(O_GPIO_IE[25]		),
				/*output*/	.C		(I_GPIO_C[25]		),
				/*input */	.PE		(O_GPIO_PE[25]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_26 (       	
				/*inout */	.PAD	(P_GPIO_26	 		),
				/*input */	.I		(O_GPIO_I[26]		),
				/*input */	.OEN	(O_GPIO_OE[26]		),
				/*input */	.DS		(O_GPIO_DS[26]		),
				/*input */	.IE		(O_GPIO_IE[26]		),
				/*output*/	.C		(I_GPIO_C[26]		),
				/*input */	.PE		(O_GPIO_PE[26]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_27 (       	
				/*inout */	.PAD	(P_GPIO_27	 		),
				/*input */	.I		(O_GPIO_I[27]		),
				/*input */	.OEN	(O_GPIO_OE[27]		),
				/*input */	.DS		(O_GPIO_DS[27]		),
				/*input */	.IE		(O_GPIO_IE[27]		),
				/*output*/	.C		(I_GPIO_C[27]		),
				/*input */	.PE		(O_GPIO_PE[27]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_28 (       	
				/*inout */	.PAD	(P_GPIO_28	 		),
				/*input */	.I		(O_GPIO_I[28]		),
				/*input */	.OEN	(O_GPIO_OE[28]		),
				/*input */	.DS		(O_GPIO_DS[28]		),
				/*input */	.IE		(O_GPIO_IE[28]		),
				/*output*/	.C		(I_GPIO_C[28]		),
				/*input */	.PE		(O_GPIO_PE[28]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_29 (       	
				/*inout */	.PAD	(P_GPIO_29	 		),
				/*input */	.I		(O_GPIO_I[29]		),
				/*input */	.OEN	(O_GPIO_OE[29]		),
				/*input */	.DS		(O_GPIO_DS[29]		),
				/*input */	.IE		(O_GPIO_IE[29]		),
				/*output*/	.C		(I_GPIO_C[29]		),
				/*input */	.PE		(O_GPIO_PE[29]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_30 (       	
				/*inout */	.PAD	(P_GPIO_30	 		),
				/*input */	.I		(O_GPIO_I[30]		),
				/*input */	.OEN	(O_GPIO_OE[30]		),
				/*input */	.DS		(O_GPIO_DS[30]		),
				/*input */	.IE		(O_GPIO_IE[30]		),
				/*output*/	.C		(I_GPIO_C[30]		),
				/*input */	.PE		(O_GPIO_PE[30]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_31 (       	
				/*inout */	.PAD	(P_GPIO_31	 		),
				/*input */	.I		(O_GPIO_I[31]		),
				/*input */	.OEN	(O_GPIO_OE[31]		),
				/*input */	.DS		(O_GPIO_DS[31]		),
				/*input */	.IE		(O_GPIO_IE[31]		),
				/*output*/	.C		(I_GPIO_C[31]		),
				/*input */	.PE		(O_GPIO_PE[31]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_32 (       	
				/*inout */	.PAD	(P_GPIO_32	 		),
				/*input */	.I		(O_GPIO_I[32]		),
				/*input */	.OEN	(O_GPIO_OE[32]		),
				/*input */	.DS		(O_GPIO_DS[32]		),
				/*input */	.IE		(O_GPIO_IE[32]		),
				/*output*/	.C		(I_GPIO_C[32]		),
				/*input */	.PE		(O_GPIO_PE[32]		)
			);                                   	
													
			PDUW0812SCDG I_PAD_GPIO_33 (       	
				/*inout */	.PAD	(P_GPIO_33	 		),
				/*input */	.I		(O_GPIO_I[33]		),
				/*input */	.OEN	(O_GPIO_OE[33]		),
				/*input */	.DS		(O_GPIO_DS[33]		),
				/*input */	.IE		(O_GPIO_IE[33]		),
				/*output*/	.C		(I_GPIO_C[33]		),
				/*input */	.PE		(O_GPIO_PE[33]		)
			);                                   	
													
													
			PDUW0812SCDG I_PAD_GPIO_34 (       	
				/*inout */	.PAD	(P_GPIO_34	 		),
				/*input */	.I		(O_GPIO_I[34]		),
				/*input */	.OEN	(O_GPIO_OE[34]		),
				/*input */	.DS		(O_GPIO_DS[34]		),
				/*input */	.IE		(O_GPIO_IE[34]		),
				/*output*/	.C		(I_GPIO_C[34]		),
				/*input */	.PE		(O_GPIO_PE[34]		)
			);                                   	
													
													
			PDUW0812SCDG I_PAD_GPIO_35 (       	
				/*inout */	.PAD	(P_GPIO_35	 		),
				/*input */	.I		(O_GPIO_I[35]		),
				/*input */	.OEN	(O_GPIO_OE[35]		),
				/*input */	.DS		(O_GPIO_DS[35]		),
				/*input */	.IE		(O_GPIO_IE[35]		),
				/*output*/	.C		(I_GPIO_C[35]		),
				/*input */	.PE		(O_GPIO_PE[35]		)
			);
		`endif
	`endif
		assign I_BOD_RSTB = 1'b1;			

	`ifdef AFE_TEST
		//32MHz PLL_VCO modeling
		wire	VCO_32M = 1;
		real    vco_32m_hperiod = (31.25/2.0); //(62.0/2.0);	//(31.25/2.0);
		reg 	vco_32mhz;
		initial begin
			vco_32mhz = 1;
			#5000;
			forever begin
				vco_32mhz = 1;
				wait (VCO_32M);
				#((100*vco_32m_hperiod+$random%10)/100);
				vco_32mhz = 0;
				wait (VCO_32M);
				#((100*vco_32m_hperiod+$random%10)/100);
			end
		end
		assign	I_PLL_SDM_CLKT = (O_XO_PLL_CLK_EN) ? vco_32mhz		: 1'b0;
		assign	I_PLL_SDM_CLKB = (O_XO_PLL_CLK_EN) ? ~I_PLL_SDM_CLKT: 1'b1;
	`elsif FW_TEST
		//32MHz PLL_VCO modeling
		wire	VCO_32M = 1;
		real    vco_32m_hperiod = (31.25/2.0); //(62.0/2.0);	//(31.25/2.0);
		reg 	vco_32mhz;
		initial begin
			vco_32mhz = 1;
			#5000;
			forever begin
				vco_32mhz = 1;
				wait (VCO_32M);
				#((100*vco_32m_hperiod+$random%10)/100);
				vco_32mhz = 0;
				wait (VCO_32M);
				#((100*vco_32m_hperiod+$random%10)/100);
			end
		end
		assign	I_PLL_SDM_CLKT = (O_XO_PLL_CLK_EN) ? vco_32mhz		: 1'b0;
		assign	I_PLL_SDM_CLKB = (O_XO_PLL_CLK_EN) ? ~I_PLL_SDM_CLKT: 1'b1;
//		assign	I_PLL_CT_CNT   = 'b1111;
	`endif
		assign	I_PLL_CT_CNT   = 'b1111;
		// MASK
		wire			VRECT_RDY 		;
		wire			NFC_RXCLK		;
		wire			DIG_RXDATA		;
		wire			VRECT_OVP	=1'b0	;	
		wire 			I_DFF_RST		;
		// -----------------------------------------------------------------------
		// NFC Clock 13.56MHz
		// -----------------------------------------------------------------------
	//	localparam OSC_FREQ = 32.768;
		localparam NFC_FREQ = 13560;

		real osc_derate;
		initial osc_derate = 0.00;

		reg osc_clk;
		initial osc_clk = 1'b0;
	//	always #(1000000.0/(OSC_FREQ*(1+osc_derate)*2)) osc_clk = ~osc_clk;
		always #(1000000.0/(NFC_FREQ*(1+osc_derate)*2)) osc_clk = ~osc_clk;


		wire crc_err_o;
		wire pkt_end;
		reg [2:0 ] osc_div;
		reg [31:0] cor_ref;
		reg [ 5:0] cor_thr;
		reg [15:0] crc_seed;
		wire comp_out;

		// -----------------------------------------------------------------------
		// Data Rate & OSC_DIV[2:0]
		// ---------------------------------------------
		// COMP Out Data Rate        x8 clock   osc_div
		// -----------------------   --------   --------
		// 4.0860000 (= 32.768/8  )   32.768     3'b000
		// 2.0430000 (= 32.768/16 )   16.384     3'b001
		// 1.0215000 (= 32.768/32 )    8.192     3'b010
		// 0.5107500 (= 32.768/64 )    4.096     3'b011
		// 0.2053750 (= 32.768/128)    2.048     3'b100
		// 0.1026875 (= 32.768/256)    1.024     3'b101
		// -----------------------------------------------------------------------
		//initial osc_div = 3'b0; // 0 ~ 5

		// -----------------------------------------------------------------------
		// Correlator Setting ...
		// -----------------------------------------------------------------------
		initial begin
		  cor_ref  = 16'hB24D; // Sync Code
		  cor_thr  = 6'd13;
		  crc_seed = 16'h0000;
		end //

	`ifdef WUR_TEST
		reg vrect_rdy;
	`else 
		wire vrect_rdy;
	`endif

	`ifdef WUR_TEST
		mask_tx_model u_tx (
		  .sdo     (DIG_RXDATA),
		  .nfc_clk (NFC_RXCLK ),
		  .freq_sel(osc_div 	),
		  .por_n   (vrect_rdy   ),
		  .dff_rst (I_DFF_RST	), 
		  .crc_seed(crc_seed	)
		);

		NFC_RX_TOP u_NFC_RX_TOP (
		/*input  wire 		*/	.NFC_CLK				(NFC_RXCLK 			),
		/*input  wire 		*/	.I_VRECT_RDY			(vrect_rdy   		),
		/*input  wire 		*/	.I_DIG_RXDATA			(DIG_RXDATA			),
		/*input  wire 		*/	.I_VRECT_OVP			(VRECT_OVP			),
		/*input  wire [1:0] */	.O_NFC_VRECT_RDY_WUR	(O_NFC_VRECT_RDY_WUR),	
		/*input  wire 	    */	.O_NFC_TMUX_SEL			(O_NFC_TMUX_SEL		),	
		/*input  wire [3:0] */	.O_NFC_WUR_THR_SEL		(O_NFC_WUR_THR_SEL	),	
		/*input  wire 		*/	.O_NFC_WUR_THR			(O_NFC_WUR_THR		),	
		/*input  wire [2:0]	*/	.O_NFC_SKP_PULSE		(O_NFC_SKP_PULSE	),
		/*input  wire [6:0]	*/	.O_NFC_IF_THR			(O_NFC_IF_THR		),
		/*output wire 		*/	.I_NFC_WAKEUP			(I_NFC_WAKEUP 		),
		/*output wire 		*/	.I_NFC_TEST_OUT			(I_NFC_TEST_OUT		),
		/*output wire		*/	.I_NFC_CLK				(I_NFC_CLK			),
		/*output wire		*/	.I_NFC_WRITE			(I_NFC_WRITE		),
		/*output wire [7:0]	*/	.I_NFC_WDATA			(I_NFC_WDATA		),
		/*output wire 		*/	.O_DFF_RST				(I_DFF_RST			)
		);
	`else 
		assign DIG_RXDATA =1'b0;
		assign NFC_RXCLK  =1'b0;	
		assign vrect_rdy    =1'b0;	

		assign I_NFC_WAKEUP 	= 'h0;
		assign I_NFC_TEST_OUT	= 'h0;
		assign I_NFC_CLK		= 'h0;
		assign I_NFC_WRITE		= 'h0;
		assign I_NFC_WDATA		= 'h0;
		assign I_DFF_RST		= 'h0;
	`endif

	`ifdef WUR_TEST

		wire [14*8-1:0] payload [0:2];
		wire fw_done= tb_top.fw_done;
		assign payload[0] = {48'h02DE_E781_6EB6, 16'h7196, 32'h1EE3_C1EA, 16'h48F2};
		assign payload[1] = {48'h6CB7_3579_2468, 16'h6749, 32'hDA23_A1C1, 16'h7777};
		assign payload[2] = {48'h7B33_7544_EEE7, 16'h0000, 32'h0000_0000, 16'h0000};

		assign	I_VRECT_RDY = vrect_rdy; 
		integer i, j;
		initial begin
		  vrect_rdy = 0;
		  //
	//	  #6_800_000;
	//	  for (j = 0; j < 5; j = j + 1 ) begin
			print_clock_info;
	//		for (i = 0; i < 41; i = i + 10) begin
			// osc_clock_derate(i);
		wait (fw_done);
		  $display($stime, " ns : MASK TX is started...\n"); #(5000000);
			vrect_rdy = 1;osc_div = 3'b0; 
			u_tx.packet_format1("CMD0", 8'd15, payload[0]); vrect_rdy = 0; #(15000000);
			vrect_rdy = 1;osc_div = 3'b1; 
			u_tx.packet_format("CMD1", 8'd15, payload[1]); vrect_rdy = 0; #(15000000);
			vrect_rdy = 1;osc_div = 3'b0; 
			u_tx.packet_format("CMD2", 8'd15, payload[2]); vrect_rdy = 0; #(15000000);

			//vrect_rdy = 1;osc_div = 3'b0; 
			//u_tx.packet_format("CMD3", 8'd15, payload[1]); vrect_rdy = 0; #(4000000);
			//vrect_rdy = 1;osc_div = 3'b0; 
			//u_tx.packet_format("CMD4", 8'd15, payload[2]); vrect_rdy = 0; #(4000000);
			//vrect_rdy = 1;osc_div = 3'b0; 
			//u_tx.packet_format_short_error("ERR-PKT", 8'h70, payload[0] ^ payload[1]);vrect_rdy = 0; #(4000000);
			//vrect_rdy = 1;osc_div = 3'b0; 
			//u_tx.packet_format_crc_error("ERR-PKT", 8'h70, payload[0]);vrect_rdy = 0; #(4000000);
			//vrect_rdy = 1;osc_div = 3'b0; 
			//u_tx.packet_format_long_error("ERR-PKT", 8'h70, payload[0]);vrect_rdy = 0; #(4000000);
			//vrect_rdy = 1;osc_div = 3'b0; 
	//	  end // for
		
		  $display($stime, " ns : MASK DEC Done ........... \n");
		  //#(8000000) $finish;
		end // initial

	//	initial begin
	//	#16_000_000;
	//	wait (tb_top.u_dut.u_OASIS_ANA.u_NFC_RX_TOP.u_mask_rx_top.u_rx_dec.skp[2:0] == 7);
	//	#2350;
	//	force tb_top.u_dut.u_OASIS_ANA.u_tx.freq_sel[2:0] = 0;//Error
	//	#2350;
	//	#2350;
	//	#2350;
	//	#2350;
	//	release tb_top.u_dut.u_OASIS_ANA.u_tx.freq_sel[2:0];//Error
	//	end

		task osc_clock_derate;
		  input integer step;
		begin
		  osc_derate = 0.2 - step*0.01;
		  repeat(10) @(posedge osc_clk);
		  $display("-----------------------------------------------");
		  $display("[%1d] osc clock is derated to %f (%0d%% derated)", step/10, 13560*(1+osc_derate), osc_derate*100);
		  repeat(10) @(posedge osc_clk);
		end
		endtask

		task print_clock_info;
		begin
		  $display("\n********************************************************************");
		  $display("Change clocks ... ");
		  case (osc_div)
			3'b000 : $display("OSC_DIV: 0, TX Data Rate: 424KHz, MASK Recovery Clock: 13.56MHz");
			3'b001 : $display("OSC_DIV: 1, TX Data Rate: 212KHz, MASK Recovery Clock: 13.56MHz");
			default: $display("TX Data Rate: Unknwon" );
		  endcase
		  $display("");
		end //
		endtask
	`endif

	`ifdef PMU_TEST
		reg [1:0] r_dcdc_prechg_pen;
		reg [1:0] r_dcdc_core_pen;
		reg [1:0] r_mldo_pen;
		reg [1:0] r_fldo_pen;
		reg		  r_dcdc_pok;	
		reg		  r_mldo_pok;	
		reg		  r_fldo_pok;	

		always @(posedge I_RTC_CLKT or negedge I_AON_RSTB) begin
			if(!I_AON_RSTB) begin
				r_dcdc_prechg_pen	<= `Td 'd0;
				r_dcdc_core_pen		<= `Td 'd0;
				r_mldo_pen			<= `Td 'd0;
				r_fldo_pen			<= `Td 'd0;
			end else begin
				r_dcdc_prechg_pen	<= `Td {r_dcdc_prechg_pen[0],O_DCDC_PRECHG_PEN};
				r_dcdc_core_pen		<= `Td {r_dcdc_core_pen[0],O_DCDC_CORE_PEN};
				r_mldo_pen			<= `Td {r_mldo_pen[0],O_MLDO_PEN};
				r_fldo_pen			<= `Td {r_fldo_pen[0],O_FLDO_PEN};
			end
		end

		always @(posedge I_RTC_CLKT or negedge I_AON_RSTB) begin
			if(!I_AON_RSTB) begin
				r_dcdc_pok	<= `Td 0;
				r_mldo_pok	<= `Td 0;
				r_fldo_pok	<= `Td 0;
			end else begin
				if(O_DCDC_CORE_PEN) begin
					r_dcdc_pok	<= #100000 1;
				end else if(tb_top.u_dut.u_OASIS_DIG.u_PD_AON.state == 10)begin  // S_PWR_DN_W1
					r_dcdc_pok	<= `Td 0;
				end
				if(O_MLDO_PEN) begin
					r_mldo_pok	<= #5000 1;
				end else if(tb_top.u_dut.u_OASIS_DIG.u_PD_AON.state == 10)begin 
					r_mldo_pok	<= `Td 0;
				end
				if(O_FLDO_PEN) begin
					r_fldo_pok	<= #5000 1;
				end else if(tb_top.u_dut.u_OASIS_DIG.u_PD_AON.state == 10)begin 
					r_fldo_pok	<= `Td 0;
				end
			end	
		end

	assign I_DCDC_POK = r_dcdc_pok;
	assign I_MLDO_POK = r_mldo_pok;
	assign I_FLDO_POK = r_fldo_pok;
	assign I_BOD_RSTB = 1'b1;			
	`endif
`endif

`ifdef  FPGA
	assign I_BOD_RSTB = 1'b1;
`endif

`ifdef	POST_SIM
	assign I_BOD_RSTB = 1'b1;			
	assign I_DCDC_POK = 1'b0;
	assign I_MLDO_POK = 1'b0;
	assign I_FLDO_POK = 1'b0;
`elsif	PRE_SIM
	assign I_BOD_RSTB = 1'b1;			
	assign I_DCDC_POK = 1'b1;
	assign I_MLDO_POK = 1'b1;
	assign I_FLDO_POK = 1'b1;
`endif

//
//	RFTX ramping check
//
`ifndef FPGA
// unit : dB
// scale : 0 ~ 60(=15*4)
integer v_rftx_pwr_lvl;
integer rftx_pwr_lvl;

always @ (posedge I_RFC_CLKT)
begin
	v_rftx_pwr_lvl = 0;
	if (O_TX_BUF_PEN)
		v_rftx_pwr_lvl = v_rftx_pwr_lvl + 15;
	if (O_TX_PRE_PEN)
		v_rftx_pwr_lvl = v_rftx_pwr_lvl + 15;
	if (O_TX_DA_PEN)
		v_rftx_pwr_lvl = v_rftx_pwr_lvl + O_TX_DA_GC;
	if (O_TRX_SEL)
		v_rftx_pwr_lvl = v_rftx_pwr_lvl + 15;
	rftx_pwr_lvl <= v_rftx_pwr_lvl;
end
`endif

endmodule
