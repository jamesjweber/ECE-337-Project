# AHB Lite Slave Interface

## Official Documentation

More documentation on the AHB-Lite protocol can be found [here](http://www.eecs.umich.edu/courses/eecs373/readings/ARM_IHI0033A_AMBA_AHB-Lite_SPEC.pdf)

## Description

The AHB-Lite Slave Interface allows our chip to recieve data using standard AHB Protocol.
This block is mostly a container for smaller sub-blocks that are used to process all the tasks of the protocol. It is important to note that we use `little endianess` for our data transfer (MSB -> LSB).

## Inputs

  Name | Type |  Size | Function
:-----:|:----:|:-----:|:-------:
`HCLK` | wire |   1   | Clock
`HRESETn` | wire |   1   | Asynchronous reset for all flip flops in block
`HADDR` | wire |   4   | Used to select functionality of decoder (`dest`,`key`,`nonce`,`plaintext`)
`HWDATA` | wire |  128  | Data being sent to serpent chip

## Outputs

  Name | Type |  Size | Function
:-----:|:----:|:-----:|:-------:
`dest` | reg  |  32   | This will be the address that the chip will use to address external SRAM to stor ethe output of encryption
`key`  | reg  |  128  | The key is a unique value that will be used in the encryption
`nonce`| reg  |  128  | The nonce is another unique value that is used in the encryption
`plaintext`|reg| 128  | Plaintext is the original data that needs to be encoded.
