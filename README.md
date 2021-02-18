# rVISoR-Program
This repository contains the reconstruction and simulation program of rVISoR(rotational-Volumetric Imaging with Synchronized on-the-fly-scan and Readout) system, which is coded by Xiaoou Wang from University of Science and Technology of China(USTC).

## Imaging System
All these program base on the imaging result of rVISoR, which is designed by Prof. Guoqiang Bi's lab from USTC and Shenzhen Institute of Advanced Technology(SIAT). VISoR is an imaging system based on light-sheet microscopy, which can image a whole sliced mouse brain within 2 hours. rVISoR changes the method of sample moving in traditional VISoR from translation to rotation, which make it compatible with sample placed in tube, for instance, blood or spinal-cord. This change also bring the problem of uneven sampling, which point to the re-design for resolution, and need new reconstruction program to fix the distortion and translate the rotational pictures to traditional image stack.

## Reconstruction Program
Reconstruction program include three main part:
* Rotation speed measurement: Get the exact speed of sample retation by computing the correlation of the image series.
* Distortion elimination: Calculate the real rotation axis of tube and eliminate the distortion by processing the raw imaging data.
* Geometric transformation: transfer the raw data from Cylindrical coordinates system to Cartesian one.

The program can also be campatible with all the microscopies which aim to use rotational imaging method, like SPIM, SIM, Confocal M, etc.

Sample imaging and reconstruction result can be watched [here](https://1drv.ms/u/s!AgfnwtX6aI6GzO0sLuV0MmgjOTAXBQ?e=DYVmY0). Specimen is from SIAT, followed the sample processing of standard VISoR, which is a mouse brain slice cutted as a rod and placed in a tube.

## Simulation Program
In order to research the trend of resolution changed by the illumination beam full divergence and radius, I simulate the PSF of points in different coordinates with different numerical aperture for illumination lens using Rayleigh-Sommerfeld Diffraction Intergral and Fourier Optics.
