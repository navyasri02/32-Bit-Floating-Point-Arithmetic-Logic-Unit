`timescale 1 ns / 1 ps

//////////////////////////////////////////////////////////////////////////////////
// Course: EE 312 - Embedded Systems
// Instructor: Dr. Gaurav Trivedi
// Teaching Assistant: ANKITA TIWARI
// Student name: Manchikatla Navya Sri 190102050
// 
// Create Date: 26.11.2021 16:38:29
// Design Name: Binary to Single Precision Floating Point
// Module Name: BinaryToSPFP
// Project Name: Experiment 10 (Course Project)
// Target Devices: Nexys4 DDR FPGA
// Tool Versions: Vivado 2020.2
// Description: BinaryToSPFP converts 8-bit unsigned binary input to equivalent
//              single precision floating point representation
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module BinaryToSPFP (
    input [7:0] I,
    output [31:0] O
);

    reg [7:0] E;
    reg [22:0] M;

    always @ (*)
        begin

            if (I[7])
                begin
                    E <= 8'd134;
                    M <= {I[6:0], 16'd0};
                end
            else if (I[6])
                begin
                    E <= 8'd133;
                    M <= {I[5:0], 17'd0};
                end
            else if (I[5])
                begin
                    E <= 8'd132;
                    M <= {I[4:0], 18'd0};
                end
            else if (I[4])
                begin
                    E <= 8'd131;
                    M <= {I[3:0], 19'd0};
                end
            else if (I[3])
                begin
                    E <= 8'd130;
                    M <= {I[2:0], 20'd0};
                end
            else if (I[2])
                begin
                    E <= 8'd129;
                    M <= {I[1:0], 21'd0};
                end
            else if (I[1])
                begin
                    E <= 8'd128;
                    M <= {I[0], 22'd0};
                end
            else if (I[0])
                begin
                    E <= 8'd127;
                    M <= 23'd0;
                end
            else
                begin
                    E <= 8'd0;
                    M <= 23'd0;
                end

        end

    assign O = {1'b0, E, M};

endmodule
