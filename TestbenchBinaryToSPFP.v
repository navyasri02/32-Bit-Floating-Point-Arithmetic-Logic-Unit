`timescale 1 ns / 1 ps

module TestbenchBinaryToSPFP;

    reg [7:0] I;
    wire [31:0] O;

    integer i;

    BinaryToSPFP BTSPFPT (I, O);

    initial
        begin
            for (i = 0; i < 256; i = i + 1)
                begin
                    I = i;
                    #10;
                end
            $finish;
        end

endmodule