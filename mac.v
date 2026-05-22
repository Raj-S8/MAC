module mac(
    input [7:0] a, b,
    output reg [15:0] acc,
    input clk, rst_n
);

    wire [15:0] mul;
    assign mul = a * b;

    always @ (posedge clk) begin
        if (!rst_n) begin
            acc <= 16'd0;
        end
        else begin
            acc <= acc + mul;
        end
    end

endmodule

