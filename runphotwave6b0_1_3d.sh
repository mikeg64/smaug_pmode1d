#!/bin/bash
#$ -j y
#$ -l arch=intel*
#$ -l gpu=1
##$ -l gpu_arch=nvidia-m2070
#$ -l gpu=1,gpu_arch=nvidia-k40m
#$ -P gpu
#$ -N rep_p6b0p1_3d
#$ -l mem=12G
#$ -l rmem=12G
#$ -l h_rt=168:00:00
module load libs/cuda/6.5.14



cd include
cp iosmaugparams6b0_1_3d.h iosmaugparams.h
cd ..

cd src
cp usersource6b0_1_3d.cu usersource.cu
cp boundary_3d.cu boundary.cu
make clean
make -f Makefile_3d_k40 smaug
cd ..



export TIMECOUNTER=0
source timeused
./smaug a
source timeused

