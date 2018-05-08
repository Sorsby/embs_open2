################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/fps.c \
../src/input.c \
../src/main.c \
../src/platform.c \
../src/simulation.c \
../src/vga.c 

OBJS += \
./src/fps.o \
./src/input.o \
./src/main.o \
./src/platform.o \
./src/simulation.o \
./src/vga.o 

C_DEPS += \
./src/fps.d \
./src/input.d \
./src/main.d \
./src/platform.d \
./src/simulation.d \
./src/vga.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O2 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../particle_sim_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

