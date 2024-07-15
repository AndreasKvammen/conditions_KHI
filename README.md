# Conditions for the Kelvin-Helmholtz Instability in the Polar Ionosphere

## Overview
This repository contains the data, source code, and supplementary materials for the research article titled
"Conditions for the Kelvin-Helmholtz Instability in the Polar Ionosphere" by Andreas Kvammen, Andres Spicher, Matthew Zettergren, Devin Huyghebaert, Theresa Rexer, Björn Gustavsson, and Juha Vierinen.

The study investigates the formation and evolution of the Kelvin-Helmholtz instability (KHI) under various
conditions in the polar ionosphere through plasma simulations. 

<p align="center">
  <img src="KHI.gif" alt="animated" />
</p>

## Repository Structure
movies/: This folder contains movies of the simulations illustrating the development of KHI under different conditions. These movies are supplementary materials that visually demonstrate the findings discussed in the article.

data/: This folder contains the electron density simulation outputs at the F-region maximum (330 km altitude). The data is organized in subfolders according to the resolution:
- 250m_resolution/: Contains the simulation frames with 250 m horizontal resolution.
- 1000m_resoltion/: Contains the simulation frames with 1000 m horizontal resolution.
The naming of each file describes the initial conditions. For example, the file named "5Ne11_L06_V13.nc" contains the simulation frames initiated with:
  - 5Ne11 - electron density = 5*10e11
  - L06 - velocity shear width = 6 km
  - V13 - velocity shear strength = 1.3 km/s

source/: This folder includes the source code to reproduce the figures presented in the
article. The folder is further organized into subfolders corresponding to each figure.
- figure1/: Contains the data and scripts to reproduce Figure 1 of the article.
- figure2/: Contains the data and scripts to reproduce Figure 2 of the article.
- figure3/: Contains the data and scripts to reproduce Figure 3 of the article.
- figure4/: Contains the data and scripts to reproduce Figure 4 of the article.
- figure5/: Contains the data and scripts to reproduce Figure 5 of the article.
- initialize_250m_resolution/: Contains the code to initialize GEMINI with various initial conditions and 250 m horizontal resolution.
- initialize_1000m_resolution/: Contains the code to initialize GEMINI with various initial conditions and 1000 m horizontal resolution.
   
## Getting Started
To reproduce the figures from the article, navigate to the appropriate subfolder in the source/ directory and run the provided scripts using MATLAB.

To set up the GEMINI simulation, use: 

gemini3d.model.setup("config.nml","output directory name") 

where the config.nml is in the initialization folder (e.g. Ne11_L06_V13)

GEMINI can then be run in a command window using the command: mpiexec -np build/gemini.bin

for example: mpiexec -np 64 build/gemini.bin home/simulations/Ne11_L06_V13/

For more information on how to set up GEMINI, please visit: https://github.com/gemini3d

## Prerequisites
Ensure you have MATLAB 2022b installed. The scripts may also require additional MATLAB toolboxes or
functions.

## Running the Code
1. Clone the repository to your local machine:
git clone https://github.com/yourusername/conditions_KHI.git

2. Navigate to the desired figure folder:
cd conditions_KHI/source/Figure1

3. Follow the instructions in the MATLAB script to run and generate the figure.

## Contact
For questions or further information, please contact:
Andreas Kvammen (andreas.kvammen@uit.no)

## License
This project is licensed under the MIT License - see the LICENSE file for details.

