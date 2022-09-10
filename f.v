`timescale 1 ns / 1 ps

//////////////////////////////////////////////////////////////////////////////////
// Course: EE 312 - Embedded Systems
// Instructor: Dr. Gaurav Trivedi
// Teaching Assistant:ANKITA TIWARI
// Student name: Manchikatla Navya Sri 190102050
// 
// Create Date: 26.11.2021 16:38:29
// Design Name: f(x)
// Module Name: f
// Project Name: Experiment 10 (Course Project)
// Target Devices: Nexys4 DDR FPGA
// Tool Versions: Vivado 2020.2
// Description: f(x) calculates the values of 9 functions for a given input x
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module f(
    input clock,
    input reset,
    input [31:0] x,
    input [3:0] S,
    output reg [31:0] y,
    output reg done
);

    wire [31:0] y0, y1, y2, y3, y4, y5, y6, y7, y8;
    wire done0, done1, done2, done3, done4, done5, done6, done7, done8;

    f0 ff0 (clock, reset, x, y0, done0);
    f1 ff1 (clock, reset, x, y1, done1);
    f2 ff2 (clock, reset, x, y2, done2);
    f3 ff3 (clock, reset, x, y3, done3);
    f4 ff4 (clock, reset, x, y4, done4);
    f5 ff5 (clock, reset, x, y5, done5);
    f6 ff6 (clock, reset, x, y6, done6);
    f7 ff7 (clock, reset, x, y7, done7);
    f8 ff8 (clock, reset, x, y8, done8);

    always @ (posedge clock or negedge reset)
        begin

            if (~reset)
				begin
					y <= 32'd0;
					done <= 1'b0;
				end
            else if (~|S)
                begin
                    y <= y0;
                    done <= done0;
                end
            else if ((~|S[3:1]) & S[0])
                begin
                    y <= y1;
                    done <= done1;
                end
            else if ((~|S[3:2]) & S[1] & (~S[0]))
                begin
                    y <= y2;
                    done <= done2;
                end
            else if ((~|S[3:2]) & (|S[1:0]))
                begin
                    y <= y3;
                    done <= done3;
                end
            else if ((~S[3]) & S[2] & (~|S[1:0]))
                begin
                    y <= y4;
                    done <= done4;
                end
            else if ((~S[3]) & S[2] & (~S[1]) & S[0])
                begin
                    y <= y5;
                    done <= done5;
                end
            else if ((~S[3]) & (|S[2:1]) & (~S[0]))
                begin
                    y <= y6;
                    done <= done6;
                end
            else if ((~S[3]) & (|S[2:0]))
                begin
                    y <= y7;
                    done <= done7;
                end
            else if (S[3] & (~|S[2:0]))
                begin
                    y <= y8;
                    done <= done8;
                end
            else
                begin
                    y <= 32'd0;
                    done <= 1'b0;
                end

        end

endmodule

module f0 (
    input clock,
    input reset,
    input [31:0] x,
    output [31:0] y,
    output done
);

    FPU FPUf0 (clock, reset, {1'b0, 8'd127, 23'd0}, x, 2'b11, y, done);

endmodule

module f1 (
    input clock,
    input reset,
    input [31:0] x,
    output [31:0] y,
    output done
);

    assign y = 32'd0;
    assign done = 1'b0;

endmodule

module f2 (
    input clock,
    input reset,
    input [31:0] x,
    output reg [31:0] y,
    output reg done
);

    wire [31:0] y_i, y_f;
    wire done_i, done_f;

    f3 f2f3 (clock, reset, x, y_i, done_i);
    FPU FPUf2inv (clock, reset, {1'b0, 8'd127, 23'd0}, y_i, 2'b11, y_f, done_f);

    always @ (posedge clock or negedge reset)
        begin

            if (~reset)
                begin
                    y <= 32'd0;
                    done <= 1'b0;
                end

            else
                begin
                    if (done_i & done_f)
                        begin
                            y <= y_f;
                            done <= done_f;
                        end
                end

        end

endmodule

module f3 (
    input clock,
    input reset,
    input [31:0] x,
    output reg [31:0] y,
    output reg done,
    output done_d, done_i,
    output reg [31:0] x_i, y_i,
    output [31:0] x_d, y_j
);

//    reg [31:0] x_i, y_i;
//    wire [31:0] x_d, y_j;
//    wire done_d, done_i;

    FPU FPUf3Dcrx (clock, reset, x_i, {1'b0, 8'd127, 23'd0}, 2'b01, x_d, done_d);
    FPU FPUf3pow (clock, reset, y_i, 32'b0_10000000_01011011111100001010100, 2'b10, y_j, done_i);

    always @ (posedge clock or negedge reset)
        begin

            if (~reset)
                begin
                    x_i <= x;
                    y_i <= {1'b0, 8'd127, 23'd0};
                    y <= 32'd0;
                    done <= 1'b0;
                end

            else
                begin
                    if (~|x_i[30:0])
                        begin
                            y <= y_i;
                            done <= 1'b1;
                        end
                    else if (done_d | done_i)
                        begin
                            x_i <= x_d;
                            y_i <= y_j;
                        end
                end

        end

endmodule

module f4 (
    input clock,
    input reset,
    input [31:0] x,
    output [31:0] y,
    output done
);

    assign y = 32'd0;
    assign done = 1'b0;

endmodule

module f5 (
    input clock,
    input reset,
    input [31:0] x,
    output reg [31:0] y,
    output reg done
);

	wire donex2, doney, doned;
	wire [31:0] x2, y2, x_d;
	reg [31:0] x_i;

    FPU squaref5 (clock, reset, x, x, 2'b10, x2, donex2);
	FPU pow2f5 (clock, reset, 32'b0_10000000_00000000000000000000000, 32'b0_10000000_00000000000000000000000, y2, doney);
    FPU FPUf5Dcrx2 (clock, reset, x_i, {1'b1, 8'd127, 23'd0}, 2'b00, x_d, doned);

	always @ (posedge clock or negedge reset)
		begin

			if (~reset)
				begin
					x_i <= x2;
					y <= 32'd0;
					done <= 1'b0;
				end

			else
				begin
					if ((|x_i[30:0]) & doned)
						x_i <= x_d;
					else if (|x_i[30:0])
						x_i <= x_i;
					else
						begin
							y <= y2;
							done <= doney;
						end
				end

		end

endmodule

module f6 (
    input clock,
    input reset,
    input [31:0] x,
    output reg [31:0] y,
    output reg done
);

	wire [31:0] emy, ey, ememy, y_i;
	wire done_emy, done_ey, done_ememy, done_i;

	f2 f6f2 (clock, reset, x, emy, done_emy);
    f3 f6f3 (clock, reset, x, ey, done_ey);

	FPU f6sub (clock, reset, ey, emy, 2'b01, ememy, done_ememy);
	FPU f6d2 (clock, reset, ememy, 32'b0_10000000_00000000000000000000000, 2'b11, y_i, done_i);

	always @ (posedge clock or negedge reset)
		begin

			if (~reset)
				begin
					y <= 32'd0;
					done <= 1'b0;
				end

			else if (done_emy & done_ey & done_ememy & done_i)
				begin
					y <= y_i;
					done <= done_i;
				end

		end

endmodule

module f7 (
    input clock,
    input reset,
    input [31:0] x,
    output reg [31:0] y,
    output reg done
);

	wire [31:0] emy, ey, epemy, y_i;
	wire done_emy, done_ey, done_epemy, done_i;

	f2 f6f2 (clock, reset, x, emy, done_emy);
    f3 f6f3 (clock, reset, x, ey, done_ey);

	FPU f6sub (clock, reset, ey, emy, 2'b00, epemy, done_epemy);
	FPU f6d2 (clock, reset, epemy, 32'b0_10000000_00000000000000000000000, 2'b11, y_i, done_i);

	always @ (posedge clock or negedge reset)
		begin

			if (~reset)
				begin
					y <= 32'd0;
					done <= 1'b0;
				end

			else if (done_emy & done_ey & done_epemy & done_i)
				begin
					y <= y_i;
					done <= done_i;
				end

		end

endmodule

module f8 (
    input clock,
    input reset,
    input [31:0] x,
    output reg [31:0] y,
    output reg done
);

    wire [31:0] sinh, cosh, tanh;
	wire done_s, done_c, done_t;

	f6 f8f6 (clock, reset, x, sinh, done_s);
	f7 f8f7 (clock, reset, x, cosh, done_c);

	FPU f8div (clock, reset, sihn, cosh, 2'b11, tanh, done_t);

	always @ (posedge clock or negedge reset)
		begin

			if (~reset)
				begin
					y <= 32'd0;
					done <= 1'b0;
				end

			else if (done_s & done_c & done_t)
				begin
					y <= tanh;
					done <= done_t;
				end

		end

endmodule
