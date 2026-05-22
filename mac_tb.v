module mactb();
    reg clk, rst_n;
    reg [7:0] a, b;
    wire [15:0] acc;

    mac DUT(
        .clk(clk),
        .rst_n(rst_n),
        .a(a),
        .b(b),
        .acc(acc)
    );

    initial begin
        a = 0;
        b = 0;
    end

    initial begin 
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    integer i;

    initial begin
        rst_n = 1'b0;
        #15 rst_n = 1'b1;
        for(i = 0; i <= 19; i += 1) begin
            // @(posedge clk)
            @(negedge clk);
            a = i * 2;
            b = i;
        end
    end

    initial begin
        $monitor("Clock = %0t, rst_n = %d, a = %d, b = %d, mul = %d, acc = %d", $time, rst_n, a, b, DUT.mul, acc);
    end

    initial begin
        $dumpfile("mac.vcd");
        $dumpvars(0, DUT);
    end

    initial begin
        #200 $finish;
    end

endmodule
