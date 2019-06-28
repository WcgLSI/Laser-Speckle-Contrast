# Laser-Speckle-Contrast
It is a processing procedure of Laser Speckle Contrast on matlab.This procedure aims to obtain a true flow speckle contrast  and the flow speed from single-exposure LSCI measurements by static scattering removal, and measurement noise estimation and correction .
The main program has two：main program（1）,System calibration and main program（2）,Sample measurement。
Main program（1）,System calibration is to measure the parameters of the whole system. By analyzing the dark current image and processing the results of the reflection standard volume, we can get the system information we need.
Main program（2）,Sample measurement is to measure a true flow speckle contrast  and the flow speed in flow velocity measurement experiments.
The two programs are independent of each other. The data of the first program can be read into the second program, or the parameters of the second program can be set by itself.
In the program, there is a program to read data in raw format. If the data is in other formats, it will replace the program with the corresponding format.
This program is a data demodulation method. If multiple data are needed, add loop structure on this basis.
picture2 is schematic of the experimental setup which is a sample that can be modified to fit oneself。
picture 'procedure' outlines the complete procedure of system calibration, sample measurement, noise correction, and static scattering removal for robust quantitative single-exposure laser speckle imaging.
