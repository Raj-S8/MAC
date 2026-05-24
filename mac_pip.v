module mac_pip(
    input clk, rst_n,
    input signed [7:0] a, b,
    output reg signed [31:0] acc
);

    reg signed [15:0] mul;
    reg signed [31:0] add_reg;
    wire overflow;
    wire [31:0] mul_exp;

    // assign overflow = add_reg[31]^(~(mul[15] ^ acc[31]));

    assign mul_exp = {{16{mul[15]}},mul[15:0]};

    assign overflow = ( ~ ( acc[31] ^ mul_exp[31] ) ) && ( add_reg[31] ^ acc[31]); 


    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            acc <= 0;
            mul <= 0;
            add_reg <= 0;
        end

        else begin
            mul <= a * b;
            add_reg <= acc + mul_exp;
            acc <= add_reg;
        end
    end
    
endmodule

