#!/bin/bash
#$ -j y
#$ -l arch=intel*
#$ -l gpu=1
#$ -l gpu_arch=nvidia-m2070
##$ -l gpu=1,gpu_arch=nvidia-k40m
#$ -P gpu
#$ -N p133_1d
#$ -l mem=12G
#$ -l rmem=12G
#$ -l h_rt=168:00:00
module load libs/cuda/6.5.14



cd include
cp iosmaugparams_133_1d.h iosmaugparams.h
cp initialisation_user_p_1d.h initialisation_user.h

cd ..

cd src
cp usersource_133_1d.cu usersource.cu
cp boundary_p_1d.cu boundary.cu
cp init_user_p_1d.cu init_user.cu


make clean
make -f Makefile smaug
cd ..



export TIMECOUNTER=0
source timeused
./smaug a
source timeused

