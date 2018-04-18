# AHB Lite Slave Interface

## Official Documentation

More documentation on the AHB-Lite protocol can be found [here](http://www.eecs.umich.edu/courses/eecs373/readings/ARM_IHI0033A_AMBA_AHB-Lite_SPEC.pdf)

## Description

The AHB-Lite Slave Interface allows our chip to recieve data using standard AHB Protocol.

This block is mostly a container for smaller sub-blocks that are used to process all the tasks of the protocol. It is important to note that we use `little endianess` for our data transfer (MSB -> LSB).

## Inputs

    Name    | Type |  Size | Description
:----------:|:----:|:-----:|:-------:
     `HCLK` | wire |   1   | AHB-Lite Clock.
  `HRESETn` | wire |   1   | Asynchronous active low reset.
    `HSELx` | wire |   1   | Chip select.
    `HADDR` | wire |   32  | Address of slave interface. `HADDR[31:30]` selects the slave, where this slave's address is `0x80000XXX` (MSB is `1`). Notice the last three hex values are not specified. This is because these values specify addresses ***inside*** of the interface. The `key` is stored at `0x80`, the `nonce` is stored at `0x100`, the `destination` is stored at `0x180`, and the `plain_text` is stored at `0x200`.
   `HWRITE` | wire |   1   | When `1` the interface is in write-mode, when `0` the interface is in read-mode.
    `HSIZE` | wire |   3   | Determines the size of data being sent.
   `HBURST` | wire |   3   | Burst mode. (Only `SINGLE` mode is implemented).
   `HTRANS` | wire |   2   | Indicate the transfer type.
   `HREADY` | wire |   1   | Indicates if interface is ready to read or write data.
   `HWDATA` | wire |  128  | Data bus that carries input data that is written to the chip.
`fifo_full` | wire |  128  | Signal from FIFO Buffer that it is full.

## Outputs

         Name | Type  | Size  | Description
:------------:|:-----:|:-----:|:-------:
  `HREADYOUT` |  reg  |   1   | Signal to indicate if chip needs more time for read or write operations.
      `HRESP` |  reg  |   1   | Signal for if an error occurs.
     `HRDATA` |  reg  |  128  | Read out data. The chip will read out the `key`, `nonce`, `destination`, or `plain_text`.
        `key` |  reg  |  128  | Stores and outputs `key` value.
      `nonce` |  reg  |  128  | Stores and outputs `nonce` value.
`destination` |  reg  |  128  | Stores and outputs `destination` value.
 `plain_text` |  reg  |  128  | Stores and outputs `plain_text` value.

## Internal Signals

                Name | Type | Size  | Description
:-------------------:|:----:|:-----:|:--------:
            `SWDATA` | wire |  128  | Stores size modified `HWDATA` (based on `HSIZE`).
`size_control_error` | wire |   1   | Error signal from `size_control` sub-module.
        `read_error` | wire |   1   | Error signal from `slave_read` sub-module.
       `write_error` | wire |   1   | Error signal from `slave_write` sub-module.
        `read_ready` | wire |   1   | Ready signal from `slave_read` sub-module.
       `write_ready` | wire |   1   | Ready signal from `slave_write` sub-module.
             `error` | wire |   1   | `OR` combination of all `error` signals above.
             `ready` | wire |   1   | `AND` combination of all `ready` signals above.

## Sub-modules

* `transfer_response` - Determines transfer response and error signals based on `error` and `ready` signals.
* `size_control` - Resizes `HWDATA` based on `HSIZE`.
* `slave_read` - Sends information out on `HRDATA` bus.
* `slave_write` - Takes in data on the `HWDATA` bus.
