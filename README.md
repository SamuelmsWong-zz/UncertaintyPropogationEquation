# UncertaintyPropogationEquation
A verilog source for a unit that applies the first-order uncertainty propogation equation to 16-bit inputs.

UPU: Uncertainty Propogation Unit

First-order uncertainty propogation equation:

![](https://latex.codecogs.com/gif.latex?%5Cdpi%7B120%7D%20%5Clarge%20%24%24%5Csigma_z%5E2%20%3D%20%5Cleft%28%7B%7B%5Cpartial%20f%7D%5Cover%7B%5Cpartial%20x%7D%7D%5Csigma_x%5Cright%29%5E2%20&plus;%202%7B%7B%5Cpartial%20f%7D%5Cover%7B%5Cpartial%20x%7D%7D%7B%7B%5Cpartial%20f%7D%5Cover%7B%5Cpartial%20y%7D%7D%5Csigma_%7Bxy%7D%20&plus;%20%5Cleft%28%7B%7B%5Cpartial%20f%7D%5Cover%7B%5Cpartial%20y%7D%7D%5Csigma_y%5Cright%29%5E2%24%24)

The LaTex if you feel you need it:
$$\sigma_z^2 = \left({{\partial f}\over{\partial x}}\sigma_x\right)^2 + 2{{\partial f}\over{\partial x}}{{\partial f}\over{\partial y}}\sigma_{xy} + \left({{\partial f}\over{\partial y}}\sigma_y\right)^2$$

- The UPU verilog code makes use of multiple ice40 DSPs to carry out its addition and multiplication.
- The second term of the UPE requires a 3-operand multiply and a 1-bit shift to the right. This means 3 16-bit inputs will produce a 48-bit output. Is this desired?
- DSP functions are determined by the various input signals and control signals (for some reason yosys does not allow control signals to be non-constant).
- DSPs are capable of being pipelined, using the intermediate registers.

SB_MAC16 DSP Functional Model (Please replace with a higher resolution image if you find one):
![](DSPschematic.png)

This is a basic version.
This design assumes the UPU to be a logic block (in that it is treated just like an ALU - pure combinational logic with no registers), so all values will percolate asychronously. Therefore all values will be non-registered. The quantity of DSP blocks used have not been considered.
