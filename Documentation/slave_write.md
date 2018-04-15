# Slave Write

## Description

This block writes incoming data to the corresponding register. It accounts for many different modes of operation according to the signals **HBURST** and **HTRANS**.

## States
 State Name | `HBURST` | `HTRANS` | Description
:----------:|:--------:|:--------:|:-----------:
S1 | `0` `0` `0` (SINGLE) | `0` `0` (IDLE)| Transfer in idle state, the transfer must be ignored by the slave.
S2 | `0` `0` `0` (SINGLE) | `0` `1` (BUSY)| Nonsensical state. There cannot be a busy signal during a single burst. Error signal should be triggered for this state.
S3 | `0` `0` `0` (SINGLE) | `1` `0` (NONSEQ)| Single burst transfer.
S4 | `0` `0` `0` (SINGLE) | `1` `1` (SEQ)| Nonsensical state. There cannot be a sequential signal during a single burst. Error signal should be triggered for this state.
S5 | `0` `0` `1` (INCR) | `0` `0` (IDLE)| Transfer in idle state, the transfer must be ignored by the slave.
S6 | `0` `0` `1` (INCR) | `0` `1` (BUSY)| Transfer in busy state. This is the only state in which a transfer can end in a busy signal!
S7 | `0` `0` `1` (INCR) | `1` `0` (NONSEQ)| Beginning of undefined-length burst.
S8 | `0` `0` `1` (INCR) | `1` `1` (SEQ)| Subsequent beats following state `S7`.
S9 | `0` `1` `0` (WRAP4) | `0` `0` (IDLE)| Transfer in idle state, the transfer must be ignored by the slave.
S10 | `0` `1` `0` (WRAP4) | `0` `1` (BUSY)| Transfer in busy state, must be followed by state `S12`.
S11 | `0` `1` `0` (WRAP4) | `1` `0` (NONSEQ)| Beginning of `WRAP4` burst.
S12 | `0` `1` `0` (WRAP4) | `1` `1` (SEQ)| Subsequent beats following state `S11`. Address must be `HSIZE` away from previous address (unless it wraps).
S13 | `0` `1` `1` (INCR4) | `0` `0` (IDLE)| Transfer in idle state, the transfer must be ignored by the slave.
S14 | `0` `1` `1` (INCR4) | `0` `1` (BUSY)| Transfer in busy state, must be followed by state `S16`.
S15 | `0` `1` `1` (INCR4) | `1` `0` (NONSEQ)| Beginning of `INCR4` burst.
S16 | `0` `1` `1` (INCR4) | `1` `1` (SEQ)| Subsequent beats following state `S15`. Address must be `HSIZE` away from previous address.
S17 | `1` `0` `0` (WRAP8) | `0` `0` (IDLE)| Transfer in idle state, the transfer must be ignored by the slave.
S18 | `1` `0` `0` (WRAP8) | `0` `1` (BUSY)| Transfer in busy state, must be followed by state `S20`.
S19 | `1` `0` `0` (WRAP8) | `1` `0` (NONSEQ)| Beginning of `WRAP8` burst.
S20 | `1` `0` `0` (WRAP8) | `1` `1` (SEQ)| Subsequent beats following state `S19`. Address must be `HSIZE` away from previous address (unless it wraps).
S21 | `1` `0` `1` (INCR8) | `0` `0` (IDLE)| Transfer in idle state, the transfer must be ignored by the slave.
S22 | `1` `0` `1` (INCR8) | `0` `1` (BUSY)| Transfer in busy state, must be followed by state `S24`.
S23 | `1` `0` `1` (INCR8) | `1` `0` (NONSEQ)| Beginning of `INCR8` burst.
S24 | `1` `0` `1` (INCR8) | `1` `1` (SEQ)| Subsequent beats following state `S23`. Address must be `HSIZE` away from previous address.
S25 | `1` `1` `0` (WRAP16) | `0` `0` (IDLE)| Transfer in idle state, the transfer must be ignored by the slave.
S26 | `1` `1` `0` (WRAP16) | `0` `1` (BUSY)| Transfer in busy state, must be followed by state `S28`.
S27 | `1` `1` `0` (WRAP16) | `1` `0` (NONSEQ)| Beginning of `WRAP16` burst.
S28 | `1` `1` `0` (WRAP16) | `1` `1` (SEQ)| Subsequent beats following state `S27`. Address must be `HSIZE` away from previous address (unless it wraps).
S29 | `1` `1` `1` (INCR16) | `0` `0` (IDLE)| Transfer in idle state, the transfer must be ignored by the slave.
S30 | `1` `1` `1` (INCR16) | `0` `1` (BUSY)| Transfer in busy state, must be followed by state `S32`.
S31 | `1` `1` `1` (INCR16) | `1` `0` (NONSEQ)| Beginning of `INCR16` burst.
S32 | `1` `1` `1` (INCR16) | `1` `1` (SEQ)| Subsequent beats following state `S31`. Address must be `HSIZE` away from previous address (unless it wraps).
