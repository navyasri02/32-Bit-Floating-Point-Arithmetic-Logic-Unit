`timescale 1 ns / 1 ps

//////////////////////////////////////////////////////////////////////////////////
// Course: EE 312 - Embedded Systems
// Instructor: Dr. Gaurav Trivedi
// Teaching Assistant: ANKITA TIWARI
// Student namew: Manchikatla Navya Sri 190102050
// 
// Create Date: 26.11.2021 16:38:29
// Design Name: Control Unit
// Module Name: ControlUnit
// Project Name: Experiment 10 (Course Project)
// Target Devices: Nexys4 DDR FPGA
// Tool Versions: Vivado 2020.2
// Description: Control Unit is the top module
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ControlUnit (
    input clock,
    input reset,
    input [7:0] I,
    input [3:0] S,
    output [31:0] O,
    output done
);

    wire [31:0] I_i;

    BinaryToSPFP CUBTSPFP (I, I_i);
    f CUf (clock, reset, I_i, S, O, done);

endmodule
