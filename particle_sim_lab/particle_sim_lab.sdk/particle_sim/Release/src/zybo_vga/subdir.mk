################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/zybo_vga/display_ctrl.c \
../src/zybo_vga/dynclk.c 

OBJS += \
./src/zybo_vga/display_ctrl.o \
./src/zybo_vga/dynclk.o 

C_DEPS += \
./src/zybo_vga/display_ctrl.d \
./src/zybo_vga/dynclk.d 


# Each subdirectory must supply rules for building sources it contributes
src/zybo_vga/%.o: ../src/zybo_vga/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O2 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../particle_sim_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


