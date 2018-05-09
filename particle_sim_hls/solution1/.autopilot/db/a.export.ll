; ModuleID = 'C:/Users/Matthew/Desktop/embs_open2/particle_sim_hls/solution1/.autopilot/db/a.o.2.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-w64-mingw32"

@toplevel_str = internal unnamed_addr constant [9 x i8] c"toplevel\00"
@numberParticles = global i32 0, align 4
@numberAttractors = global i32 0, align 4
@mode = internal constant [10 x i8] c"s_axilite\00"
@llvm_global_ctors_1 = appending global [1 x void ()*] [void ()* @_GLOBAL__I_a]
@llvm_global_ctors_0 = appending global [1 x i32] [i32 65535]
@bundle = internal constant [1 x i8] zeroinitializer
@p_str7 = private unnamed_addr constant [22 x i8] c"calculateVelocityLoop\00", align 1
@p_str6 = private unnamed_addr constant [19 x i8] c"updateParticleLoop\00", align 1
@p_str5 = private unnamed_addr constant [9 x i8] c"AXILiteS\00", align 1
@p_str4 = private unnamed_addr constant [10 x i8] c"s_axilite\00", align 1
@p_str3 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@p_str2 = private unnamed_addr constant [6 x i8] c"slave\00", align 1
@p_str1 = private unnamed_addr constant [5 x i8] c"MAXI\00", align 1
@p_str = private unnamed_addr constant [6 x i8] c"m_axi\00", align 1

define void @toplevel(float* %MAXI, i32 %ram, i32* %numP, i32* %numA) {
  %ram_read = call i32 @_ssdm_op_Read.s_axilite.i32(i32 %ram)
  %tmp_1 = call i30 @_ssdm_op_PartSelect.i30.i32.i32.i32(i32 %ram_read, i32 2, i32 31)
  %tmp_62_cast = zext i30 %tmp_1 to i33
  call void (...)* @_ssdm_op_SpecBitsMap(float* %MAXI), !map !19
  call void (...)* @_ssdm_op_SpecBitsMap(i32* %numP) nounwind, !map !23
  call void (...)* @_ssdm_op_SpecBitsMap(i32* %numA) nounwind, !map !27
  call void (...)* @_ssdm_op_SpecTopModule([9 x i8]* @toplevel_str) nounwind
  call void (...)* @_ssdm_op_SpecInterface(float* %MAXI, [6 x i8]* @p_str, i32 0, i32 0, i32 0, i32 0, [5 x i8]* @p_str1, [6 x i8]* @p_str2, [1 x i8]* @p_str3, i32 16, i32 16, i32 16, i32 16, [1 x i8]* @p_str3) nounwind
  call void (...)* @_ssdm_op_SpecInterface(i32 %ram, [10 x i8]* @mode, i32 0, i32 0, i32 0, i32 0, [1 x i8]* @bundle, [6 x i8]* @p_str2, [1 x i8]* @p_str3, i32 16, i32 16, i32 16, i32 16, [1 x i8]* @p_str3) nounwind
  call void (...)* @_ssdm_op_SpecInterface(i32* %numP, [10 x i8]* @p_str4, i32 1, i32 1, i32 0, i32 0, [9 x i8]* @p_str5, [1 x i8]* @p_str3, [1 x i8]* @p_str3, i32 0, i32 0, i32 0, i32 0, [1 x i8]* @p_str3) nounwind
  call void (...)* @_ssdm_op_SpecInterface(i32* %numA, [10 x i8]* @p_str4, i32 1, i32 1, i32 0, i32 0, [9 x i8]* @p_str5, [1 x i8]* @p_str3, [1 x i8]* @p_str3, i32 0, i32 0, i32 0, i32 0, [1 x i8]* @p_str3) nounwind
  call void (...)* @_ssdm_op_SpecInterface(i32 0, [10 x i8]* @p_str4, i32 1, i32 1, i32 0, i32 0, [9 x i8]* @p_str5, [1 x i8]* @p_str3, [1 x i8]* @p_str3, i32 0, i32 0, i32 0, i32 0, [1 x i8]* @p_str3) nounwind
  %numP_read = call i32 @_ssdm_op_Read.s_axilite.i32P(i32* %numP)
  store i32 %numP_read, i32* @numberParticles, align 4
  %numA_read = call i32 @_ssdm_op_Read.s_axilite.i32P(i32* %numA)
  store i32 %numA_read, i32* @numberAttractors, align 4
  %loopend = shl i32 %numP_read, 2
  br label %1

; <label>:1                                       ; preds = %11, %0
  %i = phi i32 [ 0, %0 ], [ %i_1, %11 ]
  %tmp = icmp ult i32 %i, %loopend
  br i1 %tmp, label %2, label %12

; <label>:2                                       ; preds = %1
  call void (...)* @_ssdm_op_SpecLoopName([19 x i8]* @p_str6) nounwind
  %tmp_s = call i32 (...)* @_ssdm_op_SpecRegionBegin([19 x i8]* @p_str6) nounwind
  call void (...)* @_ssdm_op_SpecPipeline(i32 -1, i32 1, i32 1, i32 0, [1 x i8]* @p_str3) nounwind
  call void (...)* @_ssdm_op_SpecLoopTripCount(i32 0, i32 12000, i32 12000, [1 x i8]* @p_str3) nounwind
  %tmp_1_cast = zext i32 %i to i33
  %ram2_sum = add i33 %tmp_62_cast, %tmp_1_cast
  %ram2_sum_cast = zext i33 %ram2_sum to i64
  %px = getelementptr inbounds float* %MAXI, i64 %ram2_sum_cast
  %tmp_2 = or i32 %i, 1
  %tmp_3_cast = zext i32 %tmp_2 to i33
  %ram2_sum3 = add i33 %tmp_62_cast, %tmp_3_cast
  %ram2_sum3_cast = zext i33 %ram2_sum3 to i64
  %py = getelementptr inbounds float* %MAXI, i64 %ram2_sum3_cast
  %tmp_4 = or i32 %i, 2
  %tmp_5_cast = zext i32 %tmp_4 to i33
  %ram2_sum4 = add i33 %tmp_62_cast, %tmp_5_cast
  %ram2_sum4_cast = zext i33 %ram2_sum4 to i64
  %pvx = getelementptr inbounds float* %MAXI, i64 %ram2_sum4_cast
  %tmp_6 = or i32 %i, 3
  %tmp_7_cast = zext i32 %tmp_6 to i33
  %ram2_sum5 = add i33 %tmp_62_cast, %tmp_7_cast
  %ram2_sum5_cast = zext i33 %ram2_sum5 to i64
  %pvy = getelementptr inbounds float* %MAXI, i64 %ram2_sum5_cast
  %pvx_load_req = call i1 @_ssdm_op_ReadReq.m_axi.floatP(float* %pvx, i32 1)
  %pvx_read = call float @_ssdm_op_Read.m_axi.floatP(float* %pvx)
  %px_load_req = call i1 @_ssdm_op_ReadReq.m_axi.floatP(float* %px, i32 1)
  %px_read = call float @_ssdm_op_Read.m_axi.floatP(float* %px)
  %tmp_8 = fadd float %px_read, %pvx_read
  %px_req24 = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %px, i32 1)
  call void @_ssdm_op_Write.m_axi.floatP(float* %px, float %tmp_8, i4 -1)
  %px_resp25 = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %px)
  %pvy_load_req = call i1 @_ssdm_op_ReadReq.m_axi.floatP(float* %pvy, i32 1)
  %pvy_read = call float @_ssdm_op_Read.m_axi.floatP(float* %pvy)
  %py_load_req = call i1 @_ssdm_op_ReadReq.m_axi.floatP(float* %py, i32 1)
  %py_read = call float @_ssdm_op_Read.m_axi.floatP(float* %py)
  %tmp_9 = fadd float %py_read, %pvy_read
  %py_req20 = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %py, i32 1)
  call void @_ssdm_op_Write.m_axi.floatP(float* %py, float %tmp_9, i4 -1)
  %py_resp21 = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %py)
  %tmp_8_to_int = bitcast float %tmp_8 to i32
  %tmp_3 = call i8 @_ssdm_op_PartSelect.i8.i32.i32.i32(i32 %tmp_8_to_int, i32 23, i32 30)
  %tmp_5 = trunc i32 %tmp_8_to_int to i23
  %notlhs = icmp ne i8 %tmp_3, -1
  %notrhs = icmp eq i23 %tmp_5, 0
  %tmp_7 = or i1 %notrhs, %notlhs
  %tmp_12 = fcmp ole float %tmp_8, 0.000000e+00
  %tmp_15 = and i1 %tmp_7, %tmp_12
  br i1 %tmp_15, label %3, label %._crit_edge

; <label>:3                                       ; preds = %2
  %px_req22 = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %px, i32 1)
  call void @_ssdm_op_Write.m_axi.floatP(float* %px, float 0.000000e+00, i4 -1)
  %px_resp23 = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %px)
  %pvx_req16 = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %pvx, i32 1)
  call void @_ssdm_op_Write.m_axi.floatP(float* %pvx, float 0.000000e+00, i4 -1)
  %pvx_resp17 = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %pvx)
  br label %._crit_edge

._crit_edge:                                      ; preds = %3, %2
  %tmp_10 = phi float [ 0.000000e+00, %3 ], [ %pvx_read, %2 ]
  %tmp_11 = phi float [ 0.000000e+00, %3 ], [ %tmp_8, %2 ]
  %tmp_9_to_int = bitcast float %tmp_9 to i32
  %tmp_18 = call i8 @_ssdm_op_PartSelect.i8.i32.i32.i32(i32 %tmp_9_to_int, i32 23, i32 30)
  %tmp_26 = trunc i32 %tmp_9_to_int to i23
  %notlhs7 = icmp ne i8 %tmp_18, -1
  %notrhs8 = icmp eq i23 %tmp_26, 0
  %tmp_28 = or i1 %notrhs8, %notlhs7
  %tmp_29 = fcmp ole float %tmp_9, 0.000000e+00
  %tmp_32 = and i1 %tmp_28, %tmp_29
  br i1 %tmp_32, label %4, label %._crit_edge2

; <label>:4                                       ; preds = %._crit_edge
  %py_req18 = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %py, i32 1)
  call void @_ssdm_op_Write.m_axi.floatP(float* %py, float 0.000000e+00, i4 -1)
  %py_resp19 = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %py)
  %pvy_req12 = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %pvy, i32 1)
  call void @_ssdm_op_Write.m_axi.floatP(float* %pvy, float 0.000000e+00, i4 -1)
  %pvy_resp13 = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %pvy)
  br label %._crit_edge2

._crit_edge2:                                     ; preds = %4, %._crit_edge
  %tmp_13 = phi float [ 0.000000e+00, %4 ], [ %pvy_read, %._crit_edge ]
  %tmp_14 = phi float [ 0.000000e+00, %4 ], [ %tmp_9, %._crit_edge ]
  %tmp_11_to_int = bitcast float %tmp_11 to i32
  %tmp_33 = call i8 @_ssdm_op_PartSelect.i8.i32.i32.i32(i32 %tmp_11_to_int, i32 23, i32 30)
  %tmp_41 = trunc i32 %tmp_11_to_int to i23
  %notlhs9 = icmp ne i8 %tmp_33, -1
  %notrhs1 = icmp eq i23 %tmp_41, 0
  %tmp_43 = or i1 %notrhs1, %notlhs9
  %tmp_44 = fcmp oge float %tmp_11, 1.440000e+03
  %tmp_45 = and i1 %tmp_43, %tmp_44
  br i1 %tmp_45, label %5, label %._crit_edge3

; <label>:5                                       ; preds = %._crit_edge2
  %px_req = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %px, i32 1)
  call void @_ssdm_op_Write.m_axi.floatP(float* %px, float 1.440000e+03, i4 -1)
  %px_resp = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %px)
  %pvx_req14 = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %pvx, i32 1)
  call void @_ssdm_op_Write.m_axi.floatP(float* %pvx, float 0.000000e+00, i4 -1)
  %pvx_resp15 = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %pvx)
  br label %._crit_edge3

._crit_edge3:                                     ; preds = %5, %._crit_edge2
  %tmp_16 = phi float [ 0.000000e+00, %5 ], [ %tmp_10, %._crit_edge2 ]
  %tmp_17 = phi float [ 1.440000e+03, %5 ], [ %tmp_11, %._crit_edge2 ]
  %tmp_14_to_int = bitcast float %tmp_14 to i32
  %tmp_46 = call i8 @_ssdm_op_PartSelect.i8.i32.i32.i32(i32 %tmp_14_to_int, i32 23, i32 30)
  %tmp_47 = trunc i32 %tmp_14_to_int to i23
  %notlhs1 = icmp ne i8 %tmp_46, -1
  %notrhs2 = icmp eq i23 %tmp_47, 0
  %tmp_48 = or i1 %notrhs2, %notlhs1
  %tmp_49 = fcmp oge float %tmp_14, 9.000000e+02
  %tmp_50 = and i1 %tmp_48, %tmp_49
  br i1 %tmp_50, label %6, label %._crit_edge4

; <label>:6                                       ; preds = %._crit_edge3
  %py_req = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %py, i32 1)
  call void @_ssdm_op_Write.m_axi.floatP(float* %py, float 9.000000e+02, i4 -1)
  %py_resp = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %py)
  %pvy_req10 = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %pvy, i32 1)
  call void @_ssdm_op_Write.m_axi.floatP(float* %pvy, float 0.000000e+00, i4 -1)
  %pvy_resp11 = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %pvy)
  br label %._crit_edge4

._crit_edge4:                                     ; preds = %6, %._crit_edge3
  %tmp_19 = phi float [ 0.000000e+00, %6 ], [ %tmp_13, %._crit_edge3 ]
  %tmp_20 = phi float [ 9.000000e+02, %6 ], [ %tmp_14, %._crit_edge3 ]
  %numberAttractors_load = load i32* @numberAttractors, align 4
  %tmp_51 = shl i32 %numberAttractors_load, 2
  %tmp_21 = sub i32 %tmp_51, %numberAttractors_load
  %loopend_1 = add i32 48000, %tmp_21
  br label %7

; <label>:7                                       ; preds = %._crit_edge5, %._crit_edge4
  %tmp_22 = phi float [ %tmp_19, %._crit_edge4 ], [ %tmp_39, %._crit_edge5 ]
  %tmp_23 = phi float [ %tmp_16, %._crit_edge4 ], [ %tmp_40, %._crit_edge5 ]
  %j = phi i32 [ 48000, %._crit_edge4 ], [ %j_1, %._crit_edge5 ]
  %tmp_24 = icmp slt i32 %j, %loopend_1
  br i1 %tmp_24, label %8, label %11

; <label>:8                                       ; preds = %7
  call void (...)* @_ssdm_op_SpecLoopName([22 x i8]* @p_str7) nounwind
  %tmp_42 = call i32 (...)* @_ssdm_op_SpecRegionBegin([22 x i8]* @p_str7) nounwind
  call void (...)* @_ssdm_op_SpecPipeline(i32 -1, i32 1, i32 1, i32 0, [1 x i8]* @p_str3) nounwind
  call void (...)* @_ssdm_op_SpecLoopTripCount(i32 0, i32 104, i32 104, [1 x i8]* @p_str3) nounwind
  %tmp_25 = add nsw i32 1, %j
  %tmp_26_cast = sext i32 %tmp_25 to i33
  %ram2_sum6 = add i33 %tmp_62_cast, %tmp_26_cast
  %ram2_sum6_cast = sext i33 %ram2_sum6 to i64
  %MAXI_addr = getelementptr inbounds float* %MAXI, i64 %ram2_sum6_cast
  %ax_req = call i1 @_ssdm_op_ReadReq.m_axi.floatP(float* %MAXI_addr, i32 1)
  %ax = call float @_ssdm_op_Read.m_axi.floatP(float* %MAXI_addr)
  %tmp_27 = add nsw i32 2, %j
  %tmp_28_cast = sext i32 %tmp_27 to i33
  %ram2_sum7 = add i33 %tmp_62_cast, %tmp_28_cast
  %ram2_sum7_cast = sext i33 %ram2_sum7 to i64
  %MAXI_addr_1 = getelementptr inbounds float* %MAXI, i64 %ram2_sum7_cast
  %ay_req = call i1 @_ssdm_op_ReadReq.m_axi.floatP(float* %MAXI_addr_1, i32 1)
  %ay = call float @_ssdm_op_Read.m_axi.floatP(float* %MAXI_addr_1)
  %j_1 = add nsw i32 3, %j
  %tmp_29_cast = sext i32 %j_1 to i33
  %ram2_sum8 = add i33 %tmp_62_cast, %tmp_29_cast
  %ram2_sum8_cast = sext i33 %ram2_sum8 to i64
  %MAXI_addr_2 = getelementptr inbounds float* %MAXI, i64 %ram2_sum8_cast
  %g_req = call i1 @_ssdm_op_ReadReq.m_axi.floatP(float* %MAXI_addr_2, i32 1)
  %g = call float @_ssdm_op_Read.m_axi.floatP(float* %MAXI_addr_2)
  %exp1 = fsub float %ax, %tmp_17
  %exp2 = fsub float %ay, %tmp_20
  %tmp_30 = fmul float %exp1, %exp1
  %tmp_31 = fmul float %exp2, %exp2
  %exp = fadd float %tmp_30, %tmp_31
  %d = call float @llvm.sqrt.f32(float %exp)
  %d_to_int = bitcast float %d to i32
  %tmp_52 = call i8 @_ssdm_op_PartSelect.i8.i32.i32.i32(i32 %d_to_int, i32 23, i32 30)
  %tmp_53 = trunc i32 %d_to_int to i23
  %notlhs2 = icmp ne i8 %tmp_52, -1
  %notrhs3 = icmp eq i23 %tmp_53, 0
  %tmp_54 = or i1 %notrhs3, %notlhs2
  %tmp_55 = fcmp olt float %d, 5.000000e+02
  %tmp_56 = and i1 %tmp_54, %tmp_55
  br i1 %tmp_56, label %9, label %._crit_edge5

; <label>:9                                       ; preds = %8
  %x_norm = fdiv float %exp1, %d
  %y_norm = fdiv float %exp2, %d
  %tmp_57 = fcmp olt float %d, 1.000000e+00
  br i1 %tmp_57, label %._crit_edge6, label %10

; <label>:10                                      ; preds = %9
  %tmp_34 = fdiv float 1.000000e+00, %d
  %tmp_35 = fmul float %x_norm, %tmp_34
  %tmp_36 = fmul float %y_norm, %tmp_34
  br label %._crit_edge6

._crit_edge6:                                     ; preds = %10, %9
  %p_pn = phi float [ %tmp_35, %10 ], [ %x_norm, %9 ]
  %p_pn1 = phi float [ %tmp_36, %10 ], [ %y_norm, %9 ]
  %y_norm_1 = fmul float %p_pn1, %g
  %x_norm_1 = fmul float %p_pn, %g
  %tmp_37 = fadd float %tmp_23, %x_norm_1
  %pvx_req = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %pvx, i32 1)
  call void @_ssdm_op_Write.m_axi.floatP(float* %pvx, float %tmp_37, i4 -1)
  %pvx_resp = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %pvx)
  %tmp_38 = fadd float %tmp_22, %y_norm_1
  %pvy_req = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %pvy, i32 1)
  call void @_ssdm_op_Write.m_axi.floatP(float* %pvy, float %tmp_38, i4 -1)
  %pvy_resp = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %pvy)
  br label %._crit_edge5

._crit_edge5:                                     ; preds = %._crit_edge6, %8
  %tmp_39 = phi float [ %tmp_38, %._crit_edge6 ], [ %tmp_22, %8 ]
  %tmp_40 = phi float [ %tmp_37, %._crit_edge6 ], [ %tmp_23, %8 ]
  %empty = call i32 (...)* @_ssdm_op_SpecRegionEnd([22 x i8]* @p_str7, i32 %tmp_42) nounwind
  br label %7

; <label>:11                                      ; preds = %7
  %empty_4 = call i32 (...)* @_ssdm_op_SpecRegionEnd([19 x i8]* @p_str6, i32 %tmp_s) nounwind
  %i_1 = add i32 %i, 4
  br label %1

; <label>:12                                      ; preds = %1
  ret void
}

declare float @llvm.sqrt.f32(float) nounwind readonly

declare i32 @llvm.part.select.i32(i32, i32, i32) nounwind readnone

declare void @llvm.dbg.value(metadata, i64, metadata) nounwind readnone

define weak i1 @_ssdm_op_WriteResp.m_axi.floatP(float*) {
entry:
  ret i1 true
}

define weak i1 @_ssdm_op_WriteReq.m_axi.floatP(float*, i32) {
entry:
  ret i1 true
}

define weak void @_ssdm_op_Write.m_axi.floatP(float*, float, i4) {
entry:
  ret void
}

define weak void @_ssdm_op_SpecTopModule(...) {
entry:
  ret void
}

define weak i32 @_ssdm_op_SpecRegionEnd(...) {
entry:
  ret i32 0
}

define weak i32 @_ssdm_op_SpecRegionBegin(...) {
entry:
  ret i32 0
}

define weak void @_ssdm_op_SpecPipeline(...) nounwind {
entry:
  ret void
}

define weak void @_ssdm_op_SpecLoopTripCount(...) nounwind {
entry:
  ret void
}

define weak void @_ssdm_op_SpecLoopName(...) nounwind {
entry:
  ret void
}

define weak void @_ssdm_op_SpecInterface(...) nounwind {
entry:
  ret void
}

define weak void @_ssdm_op_SpecBitsMap(...) {
entry:
  ret void
}

define weak i1 @_ssdm_op_ReadReq.m_axi.floatP(float*, i32) {
entry:
  ret i1 true
}

define weak i32 @_ssdm_op_Read.s_axilite.i32P(i32*) {
entry:
  %empty = load i32* %0
  ret i32 %empty
}

define weak i32 @_ssdm_op_Read.s_axilite.i32(i32) {
entry:
  ret i32 %0
}

define weak float @_ssdm_op_Read.m_axi.floatP(float*) {
entry:
  %empty = load float* %0
  ret float %empty
}

define weak i8 @_ssdm_op_PartSelect.i8.i32.i32.i32(i32, i32, i32) nounwind readnone {
entry:
  %empty = call i32 @llvm.part.select.i32(i32 %0, i32 %1, i32 %2)
  %empty_5 = trunc i32 %empty to i8
  ret i8 %empty_5
}

define weak i30 @_ssdm_op_PartSelect.i30.i32.i32.i32(i32, i32, i32) nounwind readnone {
entry:
  %empty = call i32 @llvm.part.select.i32(i32 %0, i32 %1, i32 %2)
  %empty_6 = trunc i32 %empty to i30
  ret i30 %empty_6
}

declare i23 @_ssdm_op_PartSelect.i23.i32.i32.i32(i32, i32, i32) nounwind readnone

declare i32 @_ssdm_op_BitConcatenate.i32.i30.i2(i30, i2) nounwind readnone

declare void @_GLOBAL__I_a() nounwind

!hls.encrypted.func = !{}
!llvm.map.gv = !{!0, !7, !12}
!axi4.master.portmap = !{!17}
!axi4.slave.bundlemap = !{!18}

!0 = metadata !{metadata !1, i32* @numberParticles}
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0, i32 31, metadata !3}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !"numberParticles", metadata !5, metadata !"unsigned int", i32 0, i32 31}
!5 = metadata !{metadata !6}
!6 = metadata !{i32 0, i32 0, i32 1}
!7 = metadata !{metadata !8, i32* @numberAttractors}
!8 = metadata !{metadata !9}
!9 = metadata !{i32 0, i32 31, metadata !10}
!10 = metadata !{metadata !11}
!11 = metadata !{metadata !"numberAttractors", metadata !5, metadata !"unsigned int", i32 0, i32 31}
!12 = metadata !{metadata !13, [1 x i32]* @llvm_global_ctors_0}
!13 = metadata !{metadata !14}
!14 = metadata !{i32 0, i32 31, metadata !15}
!15 = metadata !{metadata !16}
!16 = metadata !{metadata !"llvm.global_ctors.0", metadata !5, metadata !"", i32 0, i32 31}
!17 = metadata !{metadata !"MAXI", metadata !"ram", metadata !"READWRITE"}
!18 = metadata !{metadata !"ram", metadata !""}
!19 = metadata !{metadata !20}
!20 = metadata !{i32 0, i32 31, metadata !21}
!21 = metadata !{metadata !22}
!22 = metadata !{metadata !"ram", metadata !5, metadata !"float", i32 0, i32 31}
!23 = metadata !{metadata !24}
!24 = metadata !{i32 0, i32 31, metadata !25}
!25 = metadata !{metadata !26}
!26 = metadata !{metadata !"numP", metadata !5, metadata !"unsigned int", i32 0, i32 31}
!27 = metadata !{metadata !28}
!28 = metadata !{i32 0, i32 31, metadata !29}
!29 = metadata !{metadata !30}
!30 = metadata !{metadata !"numA", metadata !5, metadata !"unsigned int", i32 0, i32 31}
