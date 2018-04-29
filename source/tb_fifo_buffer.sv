`timescale 1ns / 10ps

module tb_fifo_buffer();

	localparam CLK_PERIOD = 10 / 3;	

	reg tb_clk;
	reg tb_nRst;
	reg tb_read;
	reg tb_write;
	reg [127:0] tb_dataIn;
	wire [127:0] tb_dataOut;
	wire tb_empty;
	wire tb_full;

	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end

	fifo_buffer DUT(.clk(tb_clk),
			.nRst(tb_nRst),
			.read(tb_read),
			.write(tb_write),
			.dataIn(tb_dataIn),
			.dataOut(tb_dataOut),
			.empty(tb_empty),
			.full(tb_full));

	initial
	begin
		// Initialize.
		tb_nRst = 1'b1;
		tb_read = 1'b0;
		tb_write = 1'b0;
		#(CLK_PERIOD);

		// Reset.
		tb_nRst = 1'b0;
		#(CLK_PERIOD);
		tb_nRst = 1'b1;

		assert(tb_empty == 1'b1)
		$info("Correct empty flag after reset.");
		else $error("Incorrect empty flag after reset.");

		assert(tb_full == 1'b0)
		$info("Correct full flag after reset.");
		else $error("Incorrect full flag after reset.");

		// Write a value.
		tb_dataIn = 128'h00000000000000000000000000000000;
		tb_write = 1'b1;
		#(CLK_PERIOD);
		tb_write = 1'b0;
		#(CLK_PERIOD);
		#(CLK_PERIOD);

		// Read that value back.
		tb_read = 1'b1;
		#(CLK_PERIOD);
		tb_read = 1'b0;
		#(CLK_PERIOD);
		#(CLK_PERIOD);

		assert(tb_dataOut == 128'h00000000000000000000000000000000)
		$info("Correct single block of data read.");
		else $error("Incorrect single block of data read.");

		// Write two values.
		tb_dataIn = 128'h11111111111111111111111111111111;
		tb_write = 1'b1;
		#(CLK_PERIOD);
		tb_write = 1'b0;
		#(CLK_PERIOD);
		#(CLK_PERIOD);

		tb_dataIn = 128'h22222222222222222222222222222222;
		tb_write = 1'b1;
		#(CLK_PERIOD);
		tb_write = 1'b0;
		#(CLK_PERIOD);
		#(CLK_PERIOD);

		// Read the first value.
		tb_read = 1'b1;
		#(CLK_PERIOD);

		assert(tb_dataOut == 128'h11111111111111111111111111111111)
		$info("Correct first data read.");
		else $error("Incorrect first data read.");

		// Read the second value.
		tb_read = 1'b1;
		#(CLK_PERIOD);
		tb_read = 1'b0;

		assert(tb_dataOut == 128'h22222222222222222222222222222222)
		$info("Correct second data read.");
		else $error("Incorrect second data read.");

		// Write 8 values.
		tb_dataIn = 128'h10000000000000000000000000000001;
		tb_write = 1'b1;
		#(CLK_PERIOD);

		tb_dataIn = 128'h20000000000000000000000000000002;
		#(CLK_PERIOD);

		tb_dataIn = 128'h30000000000000000000000000000003;
		#(CLK_PERIOD);

		tb_dataIn = 128'h40000000000000000000000000000004;
		#(CLK_PERIOD);

		tb_dataIn = 128'h50000000000000000000000000000005;
		#(CLK_PERIOD);

		tb_dataIn = 128'h60000000000000000000000000000006;
		#(CLK_PERIOD);

		tb_dataIn = 128'h70000000000000000000000000000007;
		#(CLK_PERIOD);

		tb_dataIn = 128'h80000000000000000000000000000008;
		#(CLK_PERIOD);

		// Read and write values simultaneously.
		tb_dataIn = 128'hF000000000000000000000000000000F;
		tb_read = 1'b1;
		#(CLK_PERIOD);
		tb_write = 1'b0;

		assert(tb_dataOut == 128'h10000000000000000000000000000001)
		$info("Correct data from simultaneous read/write.");
		else $error("Incorrect data from simultaneous read/write.");

		// Read 1st value.
		#(CLK_PERIOD);

		assert(tb_dataOut == 128'h20000000000000000000000000000002)
		$info("Correct value 1 read.");
		else $error("Incorrect value 1 read.");

		// Read 2nd value.
		#(CLK_PERIOD);

		assert(tb_dataOut == 128'h30000000000000000000000000000003)
		$info("Correct value 2 read.");
		else $error("Incorrect value 2 read.");

		// Read 3rd value.
		#(CLK_PERIOD);

		assert(tb_dataOut == 128'h40000000000000000000000000000004)
		$info("Correct value 3 read.");
		else $error("Incorrect value 3 read.");

		// Read 4th value.
		#(CLK_PERIOD);


		assert(tb_dataOut == 128'h50000000000000000000000000000005)
		$info("Correct value 4 read.");
		else $error("Incorrect value 4 read.");

		// Read 5th value.
		#(CLK_PERIOD);

		assert(tb_dataOut == 128'h60000000000000000000000000000006)
		$info("Correct value 5 read.");
		else $error("Incorrect value 5 read.");

		// Read 6th value.
		#(CLK_PERIOD);

		assert(tb_dataOut == 128'h70000000000000000000000000000007)
		$info("Correct value 6 read.");
		else $error("Incorrect value 6 read.");

		// Read 7th value.
		#(CLK_PERIOD);

		assert(tb_dataOut == 128'h80000000000000000000000000000008)
		$info("Correct value 7 read.");
		else $error("Incorrect value 7 read.");

		// Read 8th value.
		#(CLK_PERIOD);
		tb_read = 1'b0;

		assert(tb_dataOut == 128'hF000000000000000000000000000000F)
		$info("Correct value 8 read.");
		else $error("Incorrect value 8 read.");
	end

endmodule