
create_clock -name dco_clk -period 1500 -waveform {0 750} [get_ports dco_clk]
set_clock_latency -source -early -rise 150 [get_clocks dco_clk]
set_clock_latency -source -early -fall 151 [get_clocks dco_clk]
set_clock_latency -source -late -rise 152 [get_clocks dco_clk]
set_clock_latency -source -late -fall 153 [get_clocks dco_clk]
set_clock_transition -rise -min 154 [get_clocks dco_clk]
set_clock_transition -fall -min 155 [get_clocks dco_clk]
set_clock_transition -rise -max 156 [get_clocks dco_clk]
set_clock_transition -fall -max 157 [get_clocks dco_clk]
create_clock -name lfxt_clk -period 1600 -waveform {0 960} [get_ports lfxt_clk]
set_clock_latency -source -early -rise 151 [get_clocks lfxt_clk]
set_clock_latency -source -early -fall 152 [get_clocks lfxt_clk]
set_clock_latency -source -late -rise 153 [get_clocks lfxt_clk]
set_clock_latency -source -late -fall 154 [get_clocks lfxt_clk]
set_clock_transition -rise -min 155 [get_clocks lfxt_clk]
set_clock_transition -fall -min 156 [get_clocks lfxt_clk]
set_clock_transition -rise -max 157 [get_clocks lfxt_clk]
set_clock_transition -fall -max 158 [get_clocks lfxt_clk]
set_input_delay -clock [get_clocks dco_clk] -max -rise 100 [get_ports cpu_en]
set_input_delay -clock [get_clocks dco_clk] -max -fall 101 [get_ports cpu_en]
set_input_delay -clock [get_clocks dco_clk] -min -rise 102 [get_ports cpu_en]
set_input_delay -clock [get_clocks dco_clk] -min -fall 103 [get_ports cpu_en]
set_input_transition -clock [get_clocks dco_clk] -max -rise  150 [get_ports cpu_en]
set_input_transition -clock [get_clocks dco_clk] -max -fall  151 [get_ports cpu_en]
set_input_transition -clock [get_clocks dco_clk] -min -rise   152 [get_ports cpu_en]
set_input_transition -clock [get_clocks dco_clk] -min -fall   153 [get_ports cpu_en]
set_input_delay -clock [get_clocks dco_clk] -max -rise 101 [get_ports dbg_en]
set_input_delay -clock [get_clocks dco_clk] -max -fall 102 [get_ports dbg_en]
set_input_delay -clock [get_clocks dco_clk] -min -rise 103 [get_ports dbg_en]
set_input_delay -clock [get_clocks dco_clk] -min -fall 104 [get_ports dbg_en]
set_input_transition -clock [get_clocks dco_clk] -max -rise  151 [get_ports dbg_en]
set_input_transition -clock [get_clocks dco_clk] -max -fall  152 [get_ports dbg_en]
set_input_transition -clock [get_clocks dco_clk] -min -rise   153 [get_ports dbg_en]
set_input_transition -clock [get_clocks dco_clk] -min -fall   154 [get_ports dbg_en]
set_input_delay -clock [get_clocks dco_clk] -max -rise 102 [get_ports dbg_i2c_addr*]
set_input_delay -clock [get_clocks dco_clk] -max -fall 103 [get_ports dbg_i2c_addr*]
set_input_delay -clock [get_clocks dco_clk] -min -rise 104 [get_ports dbg_i2c_addr*]
set_input_delay -clock [get_clocks dco_clk] -min -fall 105 [get_ports dbg_i2c_addr*]
set_input_transition -clock [get_clocks dco_clk] -max -rise  152 [get_ports dbg_i2c_addr*]
set_input_transition -clock [get_clocks dco_clk] -max -fall  153 [get_ports dbg_i2c_addr*]
set_input_transition -clock [get_clocks dco_clk] -min -rise   154 [get_ports dbg_i2c_addr*]
set_input_transition -clock [get_clocks dco_clk] -min -fall   155 [get_ports dbg_i2c_addr*]
set_input_delay -clock [get_clocks dco_clk] -max -rise 103 [get_ports dbg_i2c_broadcast*]
set_input_delay -clock [get_clocks dco_clk] -max -fall 104 [get_ports dbg_i2c_broadcast*]
set_input_delay -clock [get_clocks dco_clk] -min -rise 105 [get_ports dbg_i2c_broadcast*]
set_input_delay -clock [get_clocks dco_clk] -min -fall 106 [get_ports dbg_i2c_broadcast*]
set_input_transition -clock [get_clocks dco_clk] -max -rise  153 [get_ports dbg_i2c_broadcast*]
set_input_transition -clock [get_clocks dco_clk] -max -fall  154 [get_ports dbg_i2c_broadcast*]
set_input_transition -clock [get_clocks dco_clk] -min -rise   155 [get_ports dbg_i2c_broadcast*]
set_input_transition -clock [get_clocks dco_clk] -min -fall   156 [get_ports dbg_i2c_broadcast*]
set_input_delay -clock [get_clocks dco_clk] -max -rise 104 [get_ports dbg_i2c_scl]
set_input_delay -clock [get_clocks dco_clk] -max -fall 105 [get_ports dbg_i2c_scl]
set_input_delay -clock [get_clocks dco_clk] -min -rise 106 [get_ports dbg_i2c_scl]
set_input_delay -clock [get_clocks dco_clk] -min -fall 107 [get_ports dbg_i2c_scl]
set_input_transition -clock [get_clocks dco_clk] -max -rise  154 [get_ports dbg_i2c_scl]
set_input_transition -clock [get_clocks dco_clk] -max -fall  155 [get_ports dbg_i2c_scl]
set_input_transition -clock [get_clocks dco_clk] -min -rise   156 [get_ports dbg_i2c_scl]
set_input_transition -clock [get_clocks dco_clk] -min -fall   157 [get_ports dbg_i2c_scl]
set_input_delay -clock [get_clocks dco_clk] -max -rise 105 [get_ports dbg_i2c_sda_in]
set_input_delay -clock [get_clocks dco_clk] -max -fall 106 [get_ports dbg_i2c_sda_in]
set_input_delay -clock [get_clocks dco_clk] -min -rise 107 [get_ports dbg_i2c_sda_in]
set_input_delay -clock [get_clocks dco_clk] -min -fall 108 [get_ports dbg_i2c_sda_in]
set_input_transition -clock [get_clocks dco_clk] -max -rise  155 [get_ports dbg_i2c_sda_in]
set_input_transition -clock [get_clocks dco_clk] -max -fall  156 [get_ports dbg_i2c_sda_in]
set_input_transition -clock [get_clocks dco_clk] -min -rise   157 [get_ports dbg_i2c_sda_in]
set_input_transition -clock [get_clocks dco_clk] -min -fall   158 [get_ports dbg_i2c_sda_in]
set_input_delay -clock [get_clocks dco_clk] -max -rise 106 [get_ports dbg_uart_rxd]
set_input_delay -clock [get_clocks dco_clk] -max -fall 107 [get_ports dbg_uart_rxd]
set_input_delay -clock [get_clocks dco_clk] -min -rise 108 [get_ports dbg_uart_rxd]
set_input_delay -clock [get_clocks dco_clk] -min -fall 109 [get_ports dbg_uart_rxd]
set_input_transition -clock [get_clocks dco_clk] -max -rise  156 [get_ports dbg_uart_rxd]
set_input_transition -clock [get_clocks dco_clk] -max -fall  157 [get_ports dbg_uart_rxd]
set_input_transition -clock [get_clocks dco_clk] -min -rise   158 [get_ports dbg_uart_rxd]
set_input_transition -clock [get_clocks dco_clk] -min -fall   159 [get_ports dbg_uart_rxd]
set_input_delay -clock [get_clocks dco_clk] -max -rise 108 [get_ports dmem_dout*]
set_input_delay -clock [get_clocks dco_clk] -max -fall 109 [get_ports dmem_dout*]
set_input_delay -clock [get_clocks dco_clk] -min -rise 110 [get_ports dmem_dout*]
set_input_delay -clock [get_clocks dco_clk] -min -fall 111 [get_ports dmem_dout*]
set_input_transition -clock [get_clocks dco_clk] -max -rise  158 [get_ports dmem_dout*]
set_input_transition -clock [get_clocks dco_clk] -max -fall  159 [get_ports dmem_dout*]
set_input_transition -clock [get_clocks dco_clk] -min -rise   160 [get_ports dmem_dout*]
set_input_transition -clock [get_clocks dco_clk] -min -fall   161 [get_ports dmem_dout*]
set_input_delay -clock [get_clocks dco_clk] -max -rise 109 [get_ports irq*]
set_input_delay -clock [get_clocks dco_clk] -max -fall 110 [get_ports irq*]
set_input_delay -clock [get_clocks dco_clk] -min -rise 111 [get_ports irq*]
set_input_delay -clock [get_clocks dco_clk] -min -fall 112 [get_ports irq*]
set_input_transition -clock [get_clocks dco_clk] -max -rise  159 [get_ports irq*]
set_input_transition -clock [get_clocks dco_clk] -max -fall  160 [get_ports irq*]
set_input_transition -clock [get_clocks dco_clk] -min -rise   161 [get_ports irq*]
set_input_transition -clock [get_clocks dco_clk] -min -fall   162 [get_ports irq*]
set_input_delay -clock [get_clocks dco_clk] -max -rise 111 [get_ports dma_addr*]
set_input_delay -clock [get_clocks dco_clk] -max -fall 112 [get_ports dma_addr*]
set_input_delay -clock [get_clocks dco_clk] -min -rise 113 [get_ports dma_addr*]
set_input_delay -clock [get_clocks dco_clk] -min -fall 114 [get_ports dma_addr*]
set_input_transition -clock [get_clocks dco_clk] -max -rise  161 [get_ports dma_addr*]
set_input_transition -clock [get_clocks dco_clk] -max -fall  162 [get_ports dma_addr*]
set_input_transition -clock [get_clocks dco_clk] -min -rise   163 [get_ports dma_addr*]
set_input_transition -clock [get_clocks dco_clk] -min -fall   164 [get_ports dma_addr*]
set_input_delay -clock [get_clocks dco_clk] -max -rise 112 [get_ports dma_din*]
set_input_delay -clock [get_clocks dco_clk] -max -fall 113 [get_ports dma_din*]
set_input_delay -clock [get_clocks dco_clk] -min -rise 114 [get_ports dma_din*]
set_input_delay -clock [get_clocks dco_clk] -min -fall 115 [get_ports dma_din*]
set_input_transition -clock [get_clocks dco_clk] -max -rise  162 [get_ports dma_din*]
set_input_transition -clock [get_clocks dco_clk] -max -fall  163 [get_ports dma_din*]
set_input_transition -clock [get_clocks dco_clk] -min -rise   164 [get_ports dma_din*]
set_input_transition -clock [get_clocks dco_clk] -min -fall   165 [get_ports dma_din*]
set_input_delay -clock [get_clocks dco_clk] -max -rise 113 [get_ports dma_en]
set_input_delay -clock [get_clocks dco_clk] -max -fall 114 [get_ports dma_en]
set_input_delay -clock [get_clocks dco_clk] -min -rise 115 [get_ports dma_en]
set_input_delay -clock [get_clocks dco_clk] -min -fall 116 [get_ports dma_en]
set_input_transition -clock [get_clocks dco_clk] -max -rise  163 [get_ports dma_en]
set_input_transition -clock [get_clocks dco_clk] -max -fall  164 [get_ports dma_en]
set_input_transition -clock [get_clocks dco_clk] -min -rise   165 [get_ports dma_en]
set_input_transition -clock [get_clocks dco_clk] -min -fall   166 [get_ports dma_en]
set_input_delay -clock [get_clocks lfxt_clk] -max -rise 114 [get_ports dma_priority]
set_input_delay -clock [get_clocks lfxt_clk] -max -fall 115 [get_ports dma_priority]
set_input_delay -clock [get_clocks lfxt_clk] -min -rise 116 [get_ports dma_priority]
set_input_delay -clock [get_clocks lfxt_clk] -min -fall 117 [get_ports dma_priority]
set_input_transition -clock [get_clocks lfxt_clk] -max -rise  164 [get_ports dma_priority]
set_input_transition -clock [get_clocks lfxt_clk] -max -fall  165 [get_ports dma_priority]
set_input_transition -clock [get_clocks lfxt_clk] -min -rise   166 [get_ports dma_priority]
set_input_transition -clock [get_clocks lfxt_clk] -min -fall   167 [get_ports dma_priority]
set_input_delay -clock [get_clocks lfxt_clk] -max -rise 115 [get_ports dma_we*]
set_input_delay -clock [get_clocks lfxt_clk] -max -fall 116 [get_ports dma_we*]
set_input_delay -clock [get_clocks lfxt_clk] -min -rise 117 [get_ports dma_we*]
set_input_delay -clock [get_clocks lfxt_clk] -min -fall 118 [get_ports dma_we*]
set_input_transition -clock [get_clocks lfxt_clk] -max -rise  165 [get_ports dma_we*]
set_input_transition -clock [get_clocks lfxt_clk] -max -fall  166 [get_ports dma_we*]
set_input_transition -clock [get_clocks lfxt_clk] -min -rise   167 [get_ports dma_we*]
set_input_transition -clock [get_clocks lfxt_clk] -min -fall   168 [get_ports dma_we*]
set_input_delay -clock [get_clocks lfxt_clk] -max -rise 116 [get_ports dma_wkup]
set_input_delay -clock [get_clocks lfxt_clk] -max -fall 117 [get_ports dma_wkup]
set_input_delay -clock [get_clocks lfxt_clk] -min -rise 118 [get_ports dma_wkup]
set_input_delay -clock [get_clocks lfxt_clk] -min -fall 119 [get_ports dma_wkup]
set_input_transition -clock [get_clocks lfxt_clk] -max -rise  166 [get_ports dma_wkup]
set_input_transition -clock [get_clocks lfxt_clk] -max -fall  167 [get_ports dma_wkup]
set_input_transition -clock [get_clocks lfxt_clk] -min -rise   168 [get_ports dma_wkup]
set_input_transition -clock [get_clocks lfxt_clk] -min -fall   169 [get_ports dma_wkup]
set_input_delay -clock [get_clocks lfxt_clk] -max -rise 117 [get_ports nmi]
set_input_delay -clock [get_clocks lfxt_clk] -max -fall 118 [get_ports nmi]
set_input_delay -clock [get_clocks lfxt_clk] -min -rise 119 [get_ports nmi]
set_input_delay -clock [get_clocks lfxt_clk] -min -fall 120 [get_ports nmi]
set_input_transition -clock [get_clocks lfxt_clk] -max -rise  167 [get_ports nmi]
set_input_transition -clock [get_clocks lfxt_clk] -max -fall  168 [get_ports nmi]
set_input_transition -clock [get_clocks lfxt_clk] -min -rise   169 [get_ports nmi]
set_input_transition -clock [get_clocks lfxt_clk] -min -fall   170 [get_ports nmi]
set_input_delay -clock [get_clocks lfxt_clk] -max -rise 118 [get_ports per_dout*]
set_input_delay -clock [get_clocks lfxt_clk] -max -fall 119 [get_ports per_dout*]
set_input_delay -clock [get_clocks lfxt_clk] -min -rise 120 [get_ports per_dout*]
set_input_delay -clock [get_clocks lfxt_clk] -min -fall 121 [get_ports per_dout*]
set_input_transition -clock [get_clocks lfxt_clk] -max -rise  168 [get_ports per_dout*]
set_input_transition -clock [get_clocks lfxt_clk] -max -fall  169 [get_ports per_dout*]
set_input_transition -clock [get_clocks lfxt_clk] -min -rise   170 [get_ports per_dout*]
set_input_transition -clock [get_clocks lfxt_clk] -min -fall   171 [get_ports per_dout*]
set_input_delay -clock [get_clocks lfxt_clk] -max -rise 119 [get_ports pmem_dout*]
set_input_delay -clock [get_clocks lfxt_clk] -max -fall 120 [get_ports pmem_dout*]
set_input_delay -clock [get_clocks lfxt_clk] -min -rise 121 [get_ports pmem_dout*]
set_input_delay -clock [get_clocks lfxt_clk] -min -fall 122 [get_ports pmem_dout*]
set_input_transition -clock [get_clocks lfxt_clk] -max -rise  169 [get_ports pmem_dout*]
set_input_transition -clock [get_clocks lfxt_clk] -max -fall  170 [get_ports pmem_dout*]
set_input_transition -clock [get_clocks lfxt_clk] -min -rise   171 [get_ports pmem_dout*]
set_input_transition -clock [get_clocks lfxt_clk] -min -fall   172 [get_ports pmem_dout*]
set_input_delay -clock [get_clocks lfxt_clk] -max -rise 120 [get_ports reset_n]
set_input_delay -clock [get_clocks lfxt_clk] -max -fall 121 [get_ports reset_n]
set_input_delay -clock [get_clocks lfxt_clk] -min -rise 122 [get_ports reset_n]
set_input_delay -clock [get_clocks lfxt_clk] -min -fall 123 [get_ports reset_n]
set_input_transition -clock [get_clocks lfxt_clk] -max -rise  170 [get_ports reset_n]
set_input_transition -clock [get_clocks lfxt_clk] -max -fall  171 [get_ports reset_n]
set_input_transition -clock [get_clocks lfxt_clk] -min -rise   172 [get_ports reset_n]
set_input_transition -clock [get_clocks lfxt_clk] -min -fall   173 [get_ports reset_n]
set_input_delay -clock [get_clocks lfxt_clk] -max -rise 121 [get_ports scan_enable]
set_input_delay -clock [get_clocks lfxt_clk] -max -fall 122 [get_ports scan_enable]
set_input_delay -clock [get_clocks lfxt_clk] -min -rise 123 [get_ports scan_enable]
set_input_delay -clock [get_clocks lfxt_clk] -min -fall 124 [get_ports scan_enable]
set_input_transition -clock [get_clocks lfxt_clk] -max -rise  171 [get_ports scan_enable]
set_input_transition -clock [get_clocks lfxt_clk] -max -fall  172 [get_ports scan_enable]
set_input_transition -clock [get_clocks lfxt_clk] -min -rise   173 [get_ports scan_enable]
set_input_transition -clock [get_clocks lfxt_clk] -min -fall   174 [get_ports scan_enable]
set_input_delay -clock [get_clocks lfxt_clk] -max -rise 122 [get_ports scan_mode]
set_input_delay -clock [get_clocks lfxt_clk] -max -fall 123 [get_ports scan_mode]
set_input_delay -clock [get_clocks lfxt_clk] -min -rise 124 [get_ports scan_mode]
set_input_delay -clock [get_clocks lfxt_clk] -min -fall 125 [get_ports scan_mode]
set_input_transition -clock [get_clocks lfxt_clk] -max -rise  172 [get_ports scan_mode]
set_input_transition -clock [get_clocks lfxt_clk] -max -fall  173 [get_ports scan_mode]
set_input_transition -clock [get_clocks lfxt_clk] -min -rise   174 [get_ports scan_mode]
set_input_transition -clock [get_clocks lfxt_clk] -min -fall   175 [get_ports scan_mode]
set_output_delay -clock [get_clocks dco_clk] -max -rise  100 [get_ports aclk]
set_output_delay -clock [get_clocks dco_clk] -max -fall  101 [get_ports aclk]
set_output_delay -clock [get_clocks dco_clk] -min -rise  102 [get_ports aclk]
set_output_delay -clock [get_clocks dco_clk] -min -fall 103 [get_ports aclk]
set_load 10 [get_ports aclk]
set_output_delay -clock [get_clocks dco_clk] -max -rise  101 [get_ports aclk_en]
set_output_delay -clock [get_clocks dco_clk] -max -fall  102 [get_ports aclk_en]
set_output_delay -clock [get_clocks dco_clk] -min -rise  103 [get_ports aclk_en]
set_output_delay -clock [get_clocks dco_clk] -min -fall 104 [get_ports aclk_en]
set_load 11 [get_ports aclk_en]
set_output_delay -clock [get_clocks dco_clk] -max -rise  102 [get_ports dbg_freeze]
set_output_delay -clock [get_clocks dco_clk] -max -fall  103 [get_ports dbg_freeze]
set_output_delay -clock [get_clocks dco_clk] -min -rise  104 [get_ports dbg_freeze]
set_output_delay -clock [get_clocks dco_clk] -min -fall 105 [get_ports dbg_freeze]
set_load 12 [get_ports dbg_freeze]
set_output_delay -clock [get_clocks dco_clk] -max -rise  103 [get_ports dbg_i2c_sda_out]
set_output_delay -clock [get_clocks dco_clk] -max -fall  104 [get_ports dbg_i2c_sda_out]
set_output_delay -clock [get_clocks dco_clk] -min -rise  105 [get_ports dbg_i2c_sda_out]
set_output_delay -clock [get_clocks dco_clk] -min -fall 106 [get_ports dbg_i2c_sda_out]
set_load 13 [get_ports dbg_i2c_sda_out]
set_output_delay -clock [get_clocks dco_clk] -max -rise  104 [get_ports dbg_uart_txd]
set_output_delay -clock [get_clocks dco_clk] -max -fall  105 [get_ports dbg_uart_txd]
set_output_delay -clock [get_clocks dco_clk] -min -rise  106 [get_ports dbg_uart_txd]
set_output_delay -clock [get_clocks dco_clk] -min -fall 107 [get_ports dbg_uart_txd]
set_load 14 [get_ports dbg_uart_txd]
set_output_delay -clock [get_clocks dco_clk] -max -rise  105 [get_ports dco_enable]
set_output_delay -clock [get_clocks dco_clk] -max -fall  106 [get_ports dco_enable]
set_output_delay -clock [get_clocks dco_clk] -min -rise  107 [get_ports dco_enable]
set_output_delay -clock [get_clocks dco_clk] -min -fall 108 [get_ports dco_enable]
set_load 15 [get_ports dco_enable]
set_output_delay -clock [get_clocks dco_clk] -max -rise  106 [get_ports dco_wkup]
set_output_delay -clock [get_clocks dco_clk] -max -fall  107 [get_ports dco_wkup]
set_output_delay -clock [get_clocks dco_clk] -min -rise  108 [get_ports dco_wkup]
set_output_delay -clock [get_clocks dco_clk] -min -fall 109 [get_ports dco_wkup]
set_load 16 [get_ports dco_wkup]
set_output_delay -clock [get_clocks dco_clk] -max -rise  107 [get_ports dmem_addr*]
set_output_delay -clock [get_clocks dco_clk] -max -fall  108 [get_ports dmem_addr*]
set_output_delay -clock [get_clocks dco_clk] -min -rise  109 [get_ports dmem_addr*]
set_output_delay -clock [get_clocks dco_clk] -min -fall 110 [get_ports dmem_addr*]
set_load 17 [get_ports dmem_addr*]
set_output_delay -clock [get_clocks dco_clk] -max -rise  108 [get_ports dmem_cen]
set_output_delay -clock [get_clocks dco_clk] -max -fall  109 [get_ports dmem_cen]
set_output_delay -clock [get_clocks dco_clk] -min -rise  110 [get_ports dmem_cen]
set_output_delay -clock [get_clocks dco_clk] -min -fall 111 [get_ports dmem_cen]
set_load 18 [get_ports dmem_cen]
set_output_delay -clock [get_clocks dco_clk] -max -rise  109 [get_ports dmem_din*]
set_output_delay -clock [get_clocks dco_clk] -max -fall  110 [get_ports dmem_din*]
set_output_delay -clock [get_clocks dco_clk] -min -rise  111 [get_ports dmem_din*]
set_output_delay -clock [get_clocks dco_clk] -min -fall 112 [get_ports dmem_din*]
set_load 19 [get_ports dmem_din*]
set_output_delay -clock [get_clocks dco_clk] -max -rise  110 [get_ports dmem_wen*]
set_output_delay -clock [get_clocks dco_clk] -max -fall  111 [get_ports dmem_wen*]
set_output_delay -clock [get_clocks dco_clk] -min -rise  112 [get_ports dmem_wen*]
set_output_delay -clock [get_clocks dco_clk] -min -fall 113 [get_ports dmem_wen*]
set_load 20 [get_ports dmem_wen*]
set_output_delay -clock [get_clocks dco_clk] -max -rise  111 [get_ports irq_acc*]
set_output_delay -clock [get_clocks dco_clk] -max -fall  112 [get_ports irq_acc*]
set_output_delay -clock [get_clocks dco_clk] -min -rise  113 [get_ports irq_acc*]
set_output_delay -clock [get_clocks dco_clk] -min -fall 114 [get_ports irq_acc*]
set_load 21 [get_ports irq_acc*]
set_output_delay -clock [get_clocks dco_clk] -max -rise  112 [get_ports lfxt_enable]
set_output_delay -clock [get_clocks dco_clk] -max -fall  113 [get_ports lfxt_enable]
set_output_delay -clock [get_clocks dco_clk] -min -rise  114 [get_ports lfxt_enable]
set_output_delay -clock [get_clocks dco_clk] -min -fall 115 [get_ports lfxt_enable]
set_load 22 [get_ports lfxt_enable]
set_output_delay -clock [get_clocks dco_clk] -max -rise  113 [get_ports lfxt_wkup]
set_output_delay -clock [get_clocks dco_clk] -max -fall  114 [get_ports lfxt_wkup]
set_output_delay -clock [get_clocks dco_clk] -min -rise  115 [get_ports lfxt_wkup]
set_output_delay -clock [get_clocks dco_clk] -min -fall 116 [get_ports lfxt_wkup]
set_load 23 [get_ports lfxt_wkup]
set_output_delay -clock [get_clocks dco_clk] -max -rise  114 [get_ports mclk]
set_output_delay -clock [get_clocks dco_clk] -max -fall  115 [get_ports mclk]
set_output_delay -clock [get_clocks dco_clk] -min -rise  116 [get_ports mclk]
set_output_delay -clock [get_clocks dco_clk] -min -fall 117 [get_ports mclk]
set_load 24 [get_ports mclk]
set_output_delay -clock [get_clocks dco_clk] -max -rise  115 [get_ports dma_dout*]
set_output_delay -clock [get_clocks dco_clk] -max -fall  116 [get_ports dma_dout*]
set_output_delay -clock [get_clocks dco_clk] -min -rise  117 [get_ports dma_dout*]
set_output_delay -clock [get_clocks dco_clk] -min -fall 118 [get_ports dma_dout*]
set_load 25 [get_ports dma_dout*]
set_output_delay -clock [get_clocks dco_clk] -max -rise  116 [get_ports dma_ready]
set_output_delay -clock [get_clocks dco_clk] -max -fall  117 [get_ports dma_ready]
set_output_delay -clock [get_clocks dco_clk] -min -rise  118 [get_ports dma_ready]
set_output_delay -clock [get_clocks dco_clk] -min -fall 119 [get_ports dma_ready]
set_load 26 [get_ports dma_ready]
set_output_delay -clock [get_clocks dco_clk] -max -rise  117 [get_ports dma_resp]
set_output_delay -clock [get_clocks dco_clk] -max -fall  118 [get_ports dma_resp]
set_output_delay -clock [get_clocks dco_clk] -min -rise  119 [get_ports dma_resp]
set_output_delay -clock [get_clocks dco_clk] -min -fall 120 [get_ports dma_resp]
set_load 27 [get_ports dma_resp]
set_output_delay -clock [get_clocks lfxt_clk] -max -rise  118 [get_ports per_addr*]
set_output_delay -clock [get_clocks lfxt_clk] -max -fall  119 [get_ports per_addr*]
set_output_delay -clock [get_clocks lfxt_clk] -min -rise  120 [get_ports per_addr*]
set_output_delay -clock [get_clocks lfxt_clk] -min -fall 121 [get_ports per_addr*]
set_load 28 [get_ports per_addr*]
set_output_delay -clock [get_clocks lfxt_clk] -max -rise  119 [get_ports per_din*]
set_output_delay -clock [get_clocks lfxt_clk] -max -fall  120 [get_ports per_din*]
set_output_delay -clock [get_clocks lfxt_clk] -min -rise  121 [get_ports per_din*]
set_output_delay -clock [get_clocks lfxt_clk] -min -fall 122 [get_ports per_din*]
set_load 29 [get_ports per_din*]
set_output_delay -clock [get_clocks lfxt_clk] -max -rise  120 [get_ports per_en]
set_output_delay -clock [get_clocks lfxt_clk] -max -fall  121 [get_ports per_en]
set_output_delay -clock [get_clocks lfxt_clk] -min -rise  122 [get_ports per_en]
set_output_delay -clock [get_clocks lfxt_clk] -min -fall 123 [get_ports per_en]
set_load 30 [get_ports per_en]
set_output_delay -clock [get_clocks lfxt_clk] -max -rise  121 [get_ports per_we*]
set_output_delay -clock [get_clocks lfxt_clk] -max -fall  122 [get_ports per_we*]
set_output_delay -clock [get_clocks lfxt_clk] -min -rise  123 [get_ports per_we*]
set_output_delay -clock [get_clocks lfxt_clk] -min -fall 124 [get_ports per_we*]
set_load 31 [get_ports per_we*]
set_output_delay -clock [get_clocks lfxt_clk] -max -rise  122 [get_ports pmem_addr*]
set_output_delay -clock [get_clocks lfxt_clk] -max -fall  123 [get_ports pmem_addr*]
set_output_delay -clock [get_clocks lfxt_clk] -min -rise  124 [get_ports pmem_addr*]
set_output_delay -clock [get_clocks lfxt_clk] -min -fall 125 [get_ports pmem_addr*]
set_load 32 [get_ports pmem_addr*]
set_output_delay -clock [get_clocks lfxt_clk] -max -rise  123 [get_ports pmem_cen]
set_output_delay -clock [get_clocks lfxt_clk] -max -fall  124 [get_ports pmem_cen]
set_output_delay -clock [get_clocks lfxt_clk] -min -rise  125 [get_ports pmem_cen]
set_output_delay -clock [get_clocks lfxt_clk] -min -fall 126 [get_ports pmem_cen]
set_load 33 [get_ports pmem_cen]
set_output_delay -clock [get_clocks lfxt_clk] -max -rise  124 [get_ports pmem_din*]
set_output_delay -clock [get_clocks lfxt_clk] -max -fall  125 [get_ports pmem_din*]
set_output_delay -clock [get_clocks lfxt_clk] -min -rise  126 [get_ports pmem_din*]
set_output_delay -clock [get_clocks lfxt_clk] -min -fall 127 [get_ports pmem_din*]
set_load 34 [get_ports pmem_din*]
set_output_delay -clock [get_clocks lfxt_clk] -max -rise  125 [get_ports pmem_wen*]
set_output_delay -clock [get_clocks lfxt_clk] -max -fall  126 [get_ports pmem_wen*]
set_output_delay -clock [get_clocks lfxt_clk] -min -rise  127 [get_ports pmem_wen*]
set_output_delay -clock [get_clocks lfxt_clk] -min -fall 128 [get_ports pmem_wen*]
set_load 35 [get_ports pmem_wen*]
set_output_delay -clock [get_clocks lfxt_clk] -max -rise  126 [get_ports puc_rst]
set_output_delay -clock [get_clocks lfxt_clk] -max -fall  127 [get_ports puc_rst]
set_output_delay -clock [get_clocks lfxt_clk] -min -rise  128 [get_ports puc_rst]
set_output_delay -clock [get_clocks lfxt_clk] -min -fall 129 [get_ports puc_rst]
set_load 36 [get_ports puc_rst]
set_output_delay -clock [get_clocks lfxt_clk] -max -rise  127 [get_ports smclk]
set_output_delay -clock [get_clocks lfxt_clk] -max -fall  128 [get_ports smclk]
set_output_delay -clock [get_clocks lfxt_clk] -min -rise  129 [get_ports smclk]
set_output_delay -clock [get_clocks lfxt_clk] -min -fall 130 [get_ports smclk]
set_load 37 [get_ports smclk]
set_output_delay -clock [get_clocks lfxt_clk] -max -rise  128 [get_ports smclk_en]
set_output_delay -clock [get_clocks lfxt_clk] -max -fall  129 [get_ports smclk_en]
set_output_delay -clock [get_clocks lfxt_clk] -min -rise  130 [get_ports smclk_en]
set_output_delay -clock [get_clocks lfxt_clk] -min -fall 131 [get_ports smclk_en]
set_load 38 [get_ports smclk_en]