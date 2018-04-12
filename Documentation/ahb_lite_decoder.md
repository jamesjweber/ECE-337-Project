# AHB Lite Decoder

## Description

The decoder is a simple way to take data from the AHB-Lite data line and send the data to places it may be useful in other parts of the chip. The decoder allows us to use the AHB-Lie data line for multiple uses (i.e. `dest`,`key`,`nonce`,`plaintext`)

## Inputs

  Name | Type |  Size | Function
:-----:|:----:|:-----:|:-------:
`clk`  | wire |   1   | Clock
`nRst` | wire |   1   | Asynchronous reset for all flip flops in block
`addr` | wire |   4   | Used to select functionality of decoder (`dest`,`key`,`nonce`,`plaintext`)
`data` | wire |  128  | Data being sent to serpent chip

## Outputs

  Name | Type |  Size | Function
:-----:|:----:|:-----:|:-------:
`dest` | reg  |  32   | This will be the address that the chip will use to address external SRAM to stor ethe output of encryption
`key`  | reg  |  128  | The key is a unique value that will be used in the encryption
`nonce`| reg  |  128  | The nonce is another unique value that is used in the encryption
`plaintext`|reg| 128  | Plaintext is the original data that needs to be encoded.

