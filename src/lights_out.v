/*
 * Copyright (c) 2024 Yannick Reiß
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_yannickreiss_lights_out (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_oe  = 8'b00000010;

  // Matrix (input)
  wire [8:0] buttons = ui_in[7:0] & uio_in[0];

  // Matrix (current field)
  reg field1;
  reg field2;
  reg field3;
  reg field4;
  reg field5;
  reg field6;
  reg field7;
  reg field8;
  reg field9;

  // Matrix (output)
  assign uo_out[0] = field1;
  assign uo_out[1] = field2;
  assign uo_out[2] = field3;
  assign uo_out[3] = field4;
  assign uo_out[4] = field5;
  assign uo_out[5] = field6;
  assign uo_out[6] = field7;
  assign uo_out[7] = field8;
  assign uio_out[0] = field9;

  // uio_out map to zero
  assign uio_out[7:1] = 7'b0;

  always @(posedge clk) begin
    if (ena == 1'b1) begin
      if (rst_n == 1'b1) begin

        // Do act normal
        case ( buttons )
            9'b000000001: begin
                field1 <= !field1;
                field2 <= !field2;
                field4 <= !field4;
            end
            9'b000000010: begin
                field1 <= !field1;
                field2 <= !field2;
                field3 <= !field3;
                field5 <= !field5;
            end
            9'b000000100: begin
                field2 <= !field2;
                field3 <= !field3;
                field6 <= !field6;
            end
            9'b000001000: begin
                field1 <= !field1;
                field4 <= !field4;
                field5 <= !field5;
                field7 <= !field7;
            end
            9'b000010000: begin
                field2 <= !field2;
                field4 <= !field4;
                field5 <= !field5;
                field6 <= !field6;
                field8 <= !field8;
            end
            9'b000100000: begin
                field3 <= !field3;
                field5 <= !field5;
                field6 <= !field6;
                field9 <= !field9;
            end
            9'b001000000: begin
                field4 <= !field4;
                field7 <= !field7;
                field8 <= !field8;
            end
            9'b010000000: begin
                field5 <= !field5;
                field7 <= !field7;
                field8 <= !field8;
                field9 <= !field9;
            end
            9'b100000000: begin
                field6 <= !field6;
                field8 <= !field8;
                field9 <= !field9;
            end
            default: begin

            end
        endcase
      end
      else begin

        // set new matrix in a pseudo random way
        field1 <= 1'b0;
        field2 <= 1'b0;
        field3 <= 1'b0;
        field4 <= 1'b0;
        field5 <= 1'b1;
        field6 <= 1'b0;
        field7 <= 1'b0;
        field8 <= 1'b0;
        field9 <= 1'b0;
      end
    end
  end

endmodule
