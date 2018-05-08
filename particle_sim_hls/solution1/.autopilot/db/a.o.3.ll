; ModuleID = '/home/userfs/m/ms1516/w2k/embs_open2/particle_sim_hls/solution1/.autopilot/db/a.o.3.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@toplevel_str = internal unnamed_addr constant [9 x i8] c"toplevel\00" ; [#uses=1 type=[9 x i8]*]
@numberParticles = global i32 0, align 4          ; [#uses=1 type=i32*]
@numberAttractors = global i32 0, align 4         ; [#uses=2 type=i32*]
@mode = internal constant [10 x i8] c"s_axilite\00" ; [#uses=1 type=[10 x i8]*]
@llvm_global_ctors_1 = appending global [1 x void ()*] [void ()* @_GLOBAL__I_a] ; [#uses=0 type=[1 x void ()*]*]
@llvm_global_ctors_0 = appending global [1 x i32] [i32 65535] ; [#uses=0 type=[1 x i32]*]
@bundle = internal constant [1 x i8] zeroinitializer ; [#uses=1 type=[1 x i8]*]
@p_str7 = private unnamed_addr constant [22 x i8] c"calculateVelocityLoop\00", align 1 ; [#uses=3 type=[22 x i8]*]
@p_str6 = private unnamed_addr constant [19 x i8] c"updateParticleLoop\00", align 1 ; [#uses=3 type=[19 x i8]*]
@p_str5 = private unnamed_addr constant [9 x i8] c"AXILiteS\00", align 1 ; [#uses=3 type=[9 x i8]*]
@p_str4 = private unnamed_addr constant [10 x i8] c"s_axilite\00", align 1 ; [#uses=3 type=[10 x i8]*]
@p_str3 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1 ; [#uses=16 type=[1 x i8]*]
@p_str2 = private unnamed_addr constant [6 x i8] c"slave\00", align 1 ; [#uses=2 type=[6 x i8]*]
@p_str1 = private unnamed_addr constant [5 x i8] c"MAXI\00", align 1 ; [#uses=1 type=[5 x i8]*]
@p_str = private unnamed_addr constant [6 x i8] c"m_axi\00", align 1 ; [#uses=1 type=[6 x i8]*]

; [#uses=0]
define void @toplevel(float* %MAXI, i32 %ram, i32* %numP, i32* %numA) {
  %ram_read = call i32 @_ssdm_op_Read.s_axilite.i32(i32 %ram) ; [#uses=1 type=i32]
  call void @llvm.dbg.value(metadata !{i32 %ram_read}, i64 0, metadata !26), !dbg !38 ; [debug line = 7:22] [debug variable = ram]
  %tmp_1 = call i30 @_ssdm_op_PartSelect.i30.i32.i32.i32(i32 %ram_read, i32 2, i32 31) ; [#uses=1 type=i30]
  %tmp_62_cast = zext i30 %tmp_1 to i33           ; [#uses=7 type=i33]
  call void (...)* @_ssdm_op_SpecBitsMap(float* %MAXI), !map !39
  call void (...)* @_ssdm_op_SpecBitsMap(i32* %numP) nounwind, !map !43
  call void (...)* @_ssdm_op_SpecBitsMap(i32* %numA) nounwind, !map !47
  call void (...)* @_ssdm_op_SpecTopModule([9 x i8]* @toplevel_str) nounwind
  call void @llvm.dbg.value(metadata !{i32 %ram}, i64 0, metadata !26), !dbg !38 ; [debug line = 7:22] [debug variable = ram]
  call void @llvm.dbg.value(metadata !{i32* %numP}, i64 0, metadata !51), !dbg !52 ; [debug line = 7:35] [debug variable = numP]
  call void @llvm.dbg.value(metadata !{i32* %numA}, i64 0, metadata !53), !dbg !54 ; [debug line = 7:49] [debug variable = numA]
  call void (...)* @_ssdm_op_SpecInterface(float* %MAXI, [6 x i8]* @p_str, i32 0, i32 0, i32 0, i32 0, [5 x i8]* @p_str1, [6 x i8]* @p_str2, [1 x i8]* @p_str3, i32 16, i32 16, i32 16, i32 16, [1 x i8]* @p_str3) nounwind, !dbg !55 ; [debug line = 8:1]
  call void (...)* @_ssdm_op_SpecInterface(i32 %ram, [10 x i8]* @mode, i32 0, i32 0, i32 0, i32 0, [1 x i8]* @bundle, [6 x i8]* @p_str2, [1 x i8]* @p_str3, i32 16, i32 16, i32 16, i32 16, [1 x i8]* @p_str3) nounwind, !dbg !55 ; [debug line = 8:1]
  call void (...)* @_ssdm_op_SpecInterface(i32* %numP, [10 x i8]* @p_str4, i32 1, i32 1, i32 0, i32 0, [9 x i8]* @p_str5, [1 x i8]* @p_str3, [1 x i8]* @p_str3, i32 0, i32 0, i32 0, i32 0, [1 x i8]* @p_str3) nounwind, !dbg !57 ; [debug line = 9:1]
  call void (...)* @_ssdm_op_SpecInterface(i32* %numA, [10 x i8]* @p_str4, i32 1, i32 1, i32 0, i32 0, [9 x i8]* @p_str5, [1 x i8]* @p_str3, [1 x i8]* @p_str3, i32 0, i32 0, i32 0, i32 0, [1 x i8]* @p_str3) nounwind, !dbg !58 ; [debug line = 10:1]
  call void (...)* @_ssdm_op_SpecInterface(i32 0, [10 x i8]* @p_str4, i32 1, i32 1, i32 0, i32 0, [9 x i8]* @p_str5, [1 x i8]* @p_str3, [1 x i8]* @p_str3, i32 0, i32 0, i32 0, i32 0, [1 x i8]* @p_str3) nounwind, !dbg !59 ; [debug line = 11:1]
  %numP_read = call i32 @_ssdm_op_Read.s_axilite.i32P(i32* %numP), !dbg !60 ; [#uses=2 type=i32] [debug line = 17:2]
  store i32 %numP_read, i32* @numberParticles, align 4, !dbg !60 ; [debug line = 17:2]
  %numA_read = call i32 @_ssdm_op_Read.s_axilite.i32P(i32* %numA), !dbg !61 ; [#uses=1 type=i32] [debug line = 18:2]
  store i32 %numA_read, i32* @numberAttractors, align 4, !dbg !61 ; [debug line = 18:2]
  %loopend = shl i32 %numP_read, 2, !dbg !62      ; [#uses=1 type=i32] [debug line = 20:35]
  call void @llvm.dbg.value(metadata !{i32 %loopend}, i64 0, metadata !63), !dbg !62 ; [debug line = 20:35] [debug variable = loopend]
  br label %1, !dbg !65                           ; [debug line = 21:39]

; <label>:1                                       ; preds = %11, %0
  %i = phi i32 [ 0, %0 ], [ %i_1, %11 ]           ; [#uses=6 type=i32]
  %tmp = icmp ult i32 %i, %loopend, !dbg !65      ; [#uses=1 type=i1] [debug line = 21:39]
  br i1 %tmp, label %2, label %12, !dbg !65       ; [debug line = 21:39]

; <label>:2                                       ; preds = %1
  call void (...)* @_ssdm_op_SpecLoopName([19 x i8]* @p_str6) nounwind, !dbg !67 ; [debug line = 21:62]
  %tmp_s = call i32 (...)* @_ssdm_op_SpecRegionBegin([19 x i8]* @p_str6) nounwind, !dbg !67 ; [#uses=1 type=i32] [debug line = 21:62]
  call void (...)* @_ssdm_op_SpecLoopTripCount(i32 0, i32 12000, i32 12000, [1 x i8]* @p_str3) nounwind, !dbg !69 ; [debug line = 22:1]
  %tmp_1_cast = zext i32 %i to i33, !dbg !70      ; [#uses=1 type=i33] [debug line = 24:21]
  %ram2_sum = add i33 %tmp_62_cast, %tmp_1_cast, !dbg !70 ; [#uses=1 type=i33] [debug line = 24:21]
  %ram2_sum_cast = zext i33 %ram2_sum to i64, !dbg !70 ; [#uses=1 type=i64] [debug line = 24:21]
  %px = getelementptr inbounds float* %MAXI, i64 %ram2_sum_cast, !dbg !70 ; [#uses=11 type=float*] [debug line = 24:21]
  call void @llvm.dbg.value(metadata !{float* %px}, i64 0, metadata !71), !dbg !70 ; [debug line = 24:21] [debug variable = px]
  %tmp_2 = or i32 %i, 1, !dbg !72                 ; [#uses=1 type=i32] [debug line = 25:26]
  %tmp_3_cast = zext i32 %tmp_2 to i33, !dbg !72  ; [#uses=1 type=i33] [debug line = 25:26]
  %ram2_sum3 = add i33 %tmp_62_cast, %tmp_3_cast, !dbg !72 ; [#uses=1 type=i33] [debug line = 25:26]
  %ram2_sum3_cast = zext i33 %ram2_sum3 to i64, !dbg !72 ; [#uses=1 type=i64] [debug line = 25:26]
  %py = getelementptr inbounds float* %MAXI, i64 %ram2_sum3_cast, !dbg !72 ; [#uses=11 type=float*] [debug line = 25:26]
  call void @llvm.dbg.value(metadata !{float* %py}, i64 0, metadata !73), !dbg !72 ; [debug line = 25:26] [debug variable = py]
  %tmp_4 = or i32 %i, 2, !dbg !74                 ; [#uses=1 type=i32] [debug line = 26:27]
  %tmp_5_cast = zext i32 %tmp_4 to i33, !dbg !74  ; [#uses=1 type=i33] [debug line = 26:27]
  %ram2_sum4 = add i33 %tmp_62_cast, %tmp_5_cast, !dbg !74 ; [#uses=1 type=i33] [debug line = 26:27]
  %ram2_sum4_cast = zext i33 %ram2_sum4 to i64, !dbg !74 ; [#uses=1 type=i64] [debug line = 26:27]
  %pvx = getelementptr inbounds float* %MAXI, i64 %ram2_sum4_cast, !dbg !74 ; [#uses=11 type=float*] [debug line = 26:27]
  call void @llvm.dbg.value(metadata !{float* %pvx}, i64 0, metadata !75), !dbg !74 ; [debug line = 26:27] [debug variable = pvx]
  %tmp_6 = or i32 %i, 3, !dbg !76                 ; [#uses=1 type=i32] [debug line = 27:27]
  %tmp_7_cast = zext i32 %tmp_6 to i33, !dbg !76  ; [#uses=1 type=i33] [debug line = 27:27]
  %ram2_sum5 = add i33 %tmp_62_cast, %tmp_7_cast, !dbg !76 ; [#uses=1 type=i33] [debug line = 27:27]
  %ram2_sum5_cast = zext i33 %ram2_sum5 to i64, !dbg !76 ; [#uses=1 type=i64] [debug line = 27:27]
  %pvy = getelementptr inbounds float* %MAXI, i64 %ram2_sum5_cast, !dbg !76 ; [#uses=11 type=float*] [debug line = 27:27]
  call void @llvm.dbg.value(metadata !{float* %pvy}, i64 0, metadata !77), !dbg !76 ; [debug line = 27:27] [debug variable = pvy]
  %pvx_load_req = call i1 @_ssdm_op_ReadReq.m_axi.floatP(float* %pvx, i32 1), !dbg !78 ; [#uses=0 type=i1] [debug line = 29:3]
  %pvx_read = call float @_ssdm_op_Read.m_axi.floatP(float* %pvx), !dbg !78 ; [#uses=2 type=float] [debug line = 29:3]
  %px_load_req = call i1 @_ssdm_op_ReadReq.m_axi.floatP(float* %px, i32 1), !dbg !78 ; [#uses=0 type=i1] [debug line = 29:3]
  %px_read = call float @_ssdm_op_Read.m_axi.floatP(float* %px), !dbg !78 ; [#uses=1 type=float] [debug line = 29:3]
  %tmp_8 = fadd float %px_read, %pvx_read, !dbg !78 ; [#uses=4 type=float] [debug line = 29:3]
  %px_req24 = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %px, i32 1), !dbg !78 ; [#uses=0 type=i1] [debug line = 29:3]
  call void @_ssdm_op_Write.m_axi.floatP(float* %px, float %tmp_8, i4 -1), !dbg !78 ; [debug line = 29:3]
  %px_resp25 = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %px), !dbg !78 ; [#uses=0 type=i1] [debug line = 29:3]
  %pvy_load_req = call i1 @_ssdm_op_ReadReq.m_axi.floatP(float* %pvy, i32 1), !dbg !79 ; [#uses=0 type=i1] [debug line = 30:3]
  %pvy_read = call float @_ssdm_op_Read.m_axi.floatP(float* %pvy), !dbg !79 ; [#uses=2 type=float] [debug line = 30:3]
  %py_load_req = call i1 @_ssdm_op_ReadReq.m_axi.floatP(float* %py, i32 1), !dbg !79 ; [#uses=0 type=i1] [debug line = 30:3]
  %py_read = call float @_ssdm_op_Read.m_axi.floatP(float* %py), !dbg !79 ; [#uses=1 type=float] [debug line = 30:3]
  %tmp_9 = fadd float %py_read, %pvy_read, !dbg !79 ; [#uses=4 type=float] [debug line = 30:3]
  %py_req20 = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %py, i32 1), !dbg !79 ; [#uses=0 type=i1] [debug line = 30:3]
  call void @_ssdm_op_Write.m_axi.floatP(float* %py, float %tmp_9, i4 -1), !dbg !79 ; [debug line = 30:3]
  %py_resp21 = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %py), !dbg !79 ; [#uses=0 type=i1] [debug line = 30:3]
  %tmp_8_to_int = bitcast float %tmp_8 to i32     ; [#uses=2 type=i32]
  %tmp_3 = call i8 @_ssdm_op_PartSelect.i8.i32.i32.i32(i32 %tmp_8_to_int, i32 23, i32 30) ; [#uses=1 type=i8]
  %tmp_5 = trunc i32 %tmp_8_to_int to i23         ; [#uses=1 type=i23]
  %notlhs = icmp ne i8 %tmp_3, -1                 ; [#uses=1 type=i1]
  %notrhs = icmp eq i23 %tmp_5, 0                 ; [#uses=1 type=i1]
  %tmp_7 = or i1 %notrhs, %notlhs                 ; [#uses=1 type=i1]
  %tmp_12 = fcmp ole float %tmp_8, 0.000000e+00, !dbg !80 ; [#uses=1 type=i1] [debug line = 32:3]
  %tmp_15 = and i1 %tmp_7, %tmp_12, !dbg !80      ; [#uses=1 type=i1] [debug line = 32:3]
  br i1 %tmp_15, label %3, label %._crit_edge, !dbg !80 ; [debug line = 32:3]

; <label>:3                                       ; preds = %2
  %px_req22 = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %px, i32 1), !dbg !81 ; [#uses=0 type=i1] [debug line = 33:4]
  call void @_ssdm_op_Write.m_axi.floatP(float* %px, float 0.000000e+00, i4 -1), !dbg !81 ; [debug line = 33:4]
  %px_resp23 = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %px), !dbg !81 ; [#uses=0 type=i1] [debug line = 33:4]
  %pvx_req16 = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %pvx, i32 1), !dbg !83 ; [#uses=0 type=i1] [debug line = 34:4]
  call void @_ssdm_op_Write.m_axi.floatP(float* %pvx, float 0.000000e+00, i4 -1), !dbg !83 ; [debug line = 34:4]
  %pvx_resp17 = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %pvx), !dbg !83 ; [#uses=0 type=i1] [debug line = 34:4]
  br label %._crit_edge, !dbg !84                 ; [debug line = 35:3]

._crit_edge:                                      ; preds = %3, %2
  %tmp_10 = phi float [ 0.000000e+00, %3 ], [ %pvx_read, %2 ] ; [#uses=1 type=float]
  %tmp_11 = phi float [ 0.000000e+00, %3 ], [ %tmp_8, %2 ] ; [#uses=3 type=float]
  %tmp_9_to_int = bitcast float %tmp_9 to i32     ; [#uses=2 type=i32]
  %tmp_18 = call i8 @_ssdm_op_PartSelect.i8.i32.i32.i32(i32 %tmp_9_to_int, i32 23, i32 30) ; [#uses=1 type=i8]
  %tmp_26 = trunc i32 %tmp_9_to_int to i23        ; [#uses=1 type=i23]
  %notlhs7 = icmp ne i8 %tmp_18, -1               ; [#uses=1 type=i1]
  %notrhs8 = icmp eq i23 %tmp_26, 0               ; [#uses=1 type=i1]
  %tmp_28 = or i1 %notrhs8, %notlhs7              ; [#uses=1 type=i1]
  %tmp_29 = fcmp ole float %tmp_9, 0.000000e+00, !dbg !85 ; [#uses=1 type=i1] [debug line = 36:3]
  %tmp_32 = and i1 %tmp_28, %tmp_29, !dbg !85     ; [#uses=1 type=i1] [debug line = 36:3]
  br i1 %tmp_32, label %4, label %._crit_edge2, !dbg !85 ; [debug line = 36:3]

; <label>:4                                       ; preds = %._crit_edge
  %py_req18 = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %py, i32 1), !dbg !86 ; [#uses=0 type=i1] [debug line = 37:4]
  call void @_ssdm_op_Write.m_axi.floatP(float* %py, float 0.000000e+00, i4 -1), !dbg !86 ; [debug line = 37:4]
  %py_resp19 = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %py), !dbg !86 ; [#uses=0 type=i1] [debug line = 37:4]
  %pvy_req12 = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %pvy, i32 1), !dbg !88 ; [#uses=0 type=i1] [debug line = 38:4]
  call void @_ssdm_op_Write.m_axi.floatP(float* %pvy, float 0.000000e+00, i4 -1), !dbg !88 ; [debug line = 38:4]
  %pvy_resp13 = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %pvy), !dbg !88 ; [#uses=0 type=i1] [debug line = 38:4]
  br label %._crit_edge2, !dbg !89                ; [debug line = 39:3]

._crit_edge2:                                     ; preds = %4, %._crit_edge
  %tmp_13 = phi float [ 0.000000e+00, %4 ], [ %pvy_read, %._crit_edge ] ; [#uses=1 type=float]
  %tmp_14 = phi float [ 0.000000e+00, %4 ], [ %tmp_9, %._crit_edge ] ; [#uses=3 type=float]
  %tmp_11_to_int = bitcast float %tmp_11 to i32   ; [#uses=2 type=i32]
  %tmp_33 = call i8 @_ssdm_op_PartSelect.i8.i32.i32.i32(i32 %tmp_11_to_int, i32 23, i32 30) ; [#uses=1 type=i8]
  %tmp_41 = trunc i32 %tmp_11_to_int to i23       ; [#uses=1 type=i23]
  %notlhs9 = icmp ne i8 %tmp_33, -1               ; [#uses=1 type=i1]
  %notrhs1 = icmp eq i23 %tmp_41, 0               ; [#uses=1 type=i1]
  %tmp_43 = or i1 %notrhs1, %notlhs9              ; [#uses=1 type=i1]
  %tmp_44 = fcmp oge float %tmp_11, 1.440000e+03, !dbg !90 ; [#uses=1 type=i1] [debug line = 40:3]
  %tmp_45 = and i1 %tmp_43, %tmp_44, !dbg !90     ; [#uses=1 type=i1] [debug line = 40:3]
  br i1 %tmp_45, label %5, label %._crit_edge3, !dbg !90 ; [debug line = 40:3]

; <label>:5                                       ; preds = %._crit_edge2
  %px_req = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %px, i32 1), !dbg !91 ; [#uses=0 type=i1] [debug line = 41:4]
  call void @_ssdm_op_Write.m_axi.floatP(float* %px, float 1.440000e+03, i4 -1), !dbg !91 ; [debug line = 41:4]
  %px_resp = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %px), !dbg !91 ; [#uses=0 type=i1] [debug line = 41:4]
  %pvx_req14 = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %pvx, i32 1), !dbg !93 ; [#uses=0 type=i1] [debug line = 42:4]
  call void @_ssdm_op_Write.m_axi.floatP(float* %pvx, float 0.000000e+00, i4 -1), !dbg !93 ; [debug line = 42:4]
  %pvx_resp15 = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %pvx), !dbg !93 ; [#uses=0 type=i1] [debug line = 42:4]
  br label %._crit_edge3, !dbg !94                ; [debug line = 43:3]

._crit_edge3:                                     ; preds = %5, %._crit_edge2
  %tmp_16 = phi float [ 0.000000e+00, %5 ], [ %tmp_10, %._crit_edge2 ] ; [#uses=1 type=float]
  %tmp_17 = phi float [ 1.440000e+03, %5 ], [ %tmp_11, %._crit_edge2 ] ; [#uses=1 type=float]
  %tmp_14_to_int = bitcast float %tmp_14 to i32   ; [#uses=2 type=i32]
  %tmp_46 = call i8 @_ssdm_op_PartSelect.i8.i32.i32.i32(i32 %tmp_14_to_int, i32 23, i32 30) ; [#uses=1 type=i8]
  %tmp_47 = trunc i32 %tmp_14_to_int to i23       ; [#uses=1 type=i23]
  %notlhs1 = icmp ne i8 %tmp_46, -1               ; [#uses=1 type=i1]
  %notrhs2 = icmp eq i23 %tmp_47, 0               ; [#uses=1 type=i1]
  %tmp_48 = or i1 %notrhs2, %notlhs1              ; [#uses=1 type=i1]
  %tmp_49 = fcmp oge float %tmp_14, 9.000000e+02, !dbg !95 ; [#uses=1 type=i1] [debug line = 44:3]
  %tmp_50 = and i1 %tmp_48, %tmp_49, !dbg !95     ; [#uses=1 type=i1] [debug line = 44:3]
  br i1 %tmp_50, label %6, label %._crit_edge4, !dbg !95 ; [debug line = 44:3]

; <label>:6                                       ; preds = %._crit_edge3
  %py_req = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %py, i32 1), !dbg !96 ; [#uses=0 type=i1] [debug line = 45:4]
  call void @_ssdm_op_Write.m_axi.floatP(float* %py, float 9.000000e+02, i4 -1), !dbg !96 ; [debug line = 45:4]
  %py_resp = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %py), !dbg !96 ; [#uses=0 type=i1] [debug line = 45:4]
  %pvy_req10 = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %pvy, i32 1), !dbg !98 ; [#uses=0 type=i1] [debug line = 46:4]
  call void @_ssdm_op_Write.m_axi.floatP(float* %pvy, float 0.000000e+00, i4 -1), !dbg !98 ; [debug line = 46:4]
  %pvy_resp11 = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %pvy), !dbg !98 ; [#uses=0 type=i1] [debug line = 46:4]
  br label %._crit_edge4, !dbg !99                ; [debug line = 47:3]

._crit_edge4:                                     ; preds = %6, %._crit_edge3
  %tmp_19 = phi float [ 0.000000e+00, %6 ], [ %tmp_13, %._crit_edge3 ] ; [#uses=1 type=float]
  %tmp_20 = phi float [ 9.000000e+02, %6 ], [ %tmp_14, %._crit_edge3 ] ; [#uses=1 type=float]
  %numberAttractors_load = load i32* @numberAttractors, align 4, !dbg !100 ; [#uses=2 type=i32] [debug line = 49:86]
  %tmp_51 = shl i32 %numberAttractors_load, 2, !dbg !100 ; [#uses=1 type=i32] [debug line = 49:86]
  %tmp_21 = sub i32 %tmp_51, %numberAttractors_load, !dbg !100 ; [#uses=1 type=i32] [debug line = 49:86]
  %loopend_1 = add i32 48000, %tmp_21, !dbg !100  ; [#uses=1 type=i32] [debug line = 49:86]
  call void @llvm.dbg.value(metadata !{i32 %loopend_1}, i64 0, metadata !101), !dbg !100 ; [debug line = 49:86] [debug variable = loopend]
  br label %7, !dbg !102                          ; [debug line = 50:83]

; <label>:7                                       ; preds = %._crit_edge5, %._crit_edge4
  %tmp_22 = phi float [ %tmp_19, %._crit_edge4 ], [ %tmp_39, %._crit_edge5 ] ; [#uses=2 type=float]
  %tmp_23 = phi float [ %tmp_16, %._crit_edge4 ], [ %tmp_40, %._crit_edge5 ] ; [#uses=2 type=float]
  %j = phi i32 [ 48000, %._crit_edge4 ], [ %j_1, %._crit_edge5 ] ; [#uses=4 type=i32]
  %tmp_24 = icmp slt i32 %j, %loopend_1, !dbg !102 ; [#uses=1 type=i1] [debug line = 50:83]
  br i1 %tmp_24, label %8, label %11, !dbg !102   ; [debug line = 50:83]

; <label>:8                                       ; preds = %7
  call void (...)* @_ssdm_op_SpecLoopName([22 x i8]* @p_str7) nounwind, !dbg !104 ; [debug line = 52:9]
  %tmp_42 = call i32 (...)* @_ssdm_op_SpecRegionBegin([22 x i8]* @p_str7) nounwind, !dbg !104 ; [#uses=1 type=i32] [debug line = 52:9]
  call void (...)* @_ssdm_op_SpecPipeline(i32 -1, i32 1, i32 1, i32 0, [1 x i8]* @p_str3) nounwind, !dbg !106 ; [debug line = 53:1]
  call void (...)* @_ssdm_op_SpecLoopTripCount(i32 0, i32 104, i32 104, [1 x i8]* @p_str3) nounwind, !dbg !106 ; [debug line = 53:1]
  %tmp_25 = add nsw i32 1, %j, !dbg !107          ; [#uses=1 type=i32] [debug line = 55:23]
  %tmp_26_cast = sext i32 %tmp_25 to i33, !dbg !107 ; [#uses=1 type=i33] [debug line = 55:23]
  %ram2_sum6 = add i33 %tmp_62_cast, %tmp_26_cast, !dbg !107 ; [#uses=1 type=i33] [debug line = 55:23]
  %ram2_sum6_cast = sext i33 %ram2_sum6 to i64, !dbg !107 ; [#uses=1 type=i64] [debug line = 55:23]
  %MAXI_addr = getelementptr inbounds float* %MAXI, i64 %ram2_sum6_cast, !dbg !107 ; [#uses=2 type=float*] [debug line = 55:23]
  %ax_req = call i1 @_ssdm_op_ReadReq.m_axi.floatP(float* %MAXI_addr, i32 1), !dbg !107 ; [#uses=0 type=i1] [debug line = 55:23]
  %ax = call float @_ssdm_op_Read.m_axi.floatP(float* %MAXI_addr), !dbg !107 ; [#uses=1 type=float] [debug line = 55:23]
  call void @llvm.dbg.value(metadata !{float %ax}, i64 0, metadata !108), !dbg !107 ; [debug line = 55:23] [debug variable = ax]
  %tmp_27 = add nsw i32 2, %j, !dbg !109          ; [#uses=1 type=i32] [debug line = 56:25]
  %tmp_28_cast = sext i32 %tmp_27 to i33, !dbg !109 ; [#uses=1 type=i33] [debug line = 56:25]
  %ram2_sum7 = add i33 %tmp_62_cast, %tmp_28_cast, !dbg !109 ; [#uses=1 type=i33] [debug line = 56:25]
  %ram2_sum7_cast = sext i33 %ram2_sum7 to i64, !dbg !109 ; [#uses=1 type=i64] [debug line = 56:25]
  %MAXI_addr_1 = getelementptr inbounds float* %MAXI, i64 %ram2_sum7_cast, !dbg !109 ; [#uses=2 type=float*] [debug line = 56:25]
  %ay_req = call i1 @_ssdm_op_ReadReq.m_axi.floatP(float* %MAXI_addr_1, i32 1), !dbg !109 ; [#uses=0 type=i1] [debug line = 56:25]
  %ay = call float @_ssdm_op_Read.m_axi.floatP(float* %MAXI_addr_1), !dbg !109 ; [#uses=1 type=float] [debug line = 56:25]
  call void @llvm.dbg.value(metadata !{float %ay}, i64 0, metadata !110), !dbg !109 ; [debug line = 56:25] [debug variable = ay]
  %j_1 = add nsw i32 3, %j, !dbg !111             ; [#uses=2 type=i32] [debug line = 57:24]
  %tmp_29_cast = sext i32 %j_1 to i33, !dbg !111  ; [#uses=1 type=i33] [debug line = 57:24]
  %ram2_sum8 = add i33 %tmp_62_cast, %tmp_29_cast, !dbg !111 ; [#uses=1 type=i33] [debug line = 57:24]
  %ram2_sum8_cast = sext i33 %ram2_sum8 to i64, !dbg !111 ; [#uses=1 type=i64] [debug line = 57:24]
  %MAXI_addr_2 = getelementptr inbounds float* %MAXI, i64 %ram2_sum8_cast, !dbg !111 ; [#uses=2 type=float*] [debug line = 57:24]
  %g_req = call i1 @_ssdm_op_ReadReq.m_axi.floatP(float* %MAXI_addr_2, i32 1), !dbg !111 ; [#uses=0 type=i1] [debug line = 57:24]
  %g = call float @_ssdm_op_Read.m_axi.floatP(float* %MAXI_addr_2), !dbg !111 ; [#uses=2 type=float] [debug line = 57:24]
  call void @llvm.dbg.value(metadata !{float %g}, i64 0, metadata !112), !dbg !111 ; [debug line = 57:24] [debug variable = g]
  %exp1 = fsub float %ax, %tmp_17, !dbg !113      ; [#uses=3 type=float] [debug line = 59:27]
  call void @llvm.dbg.value(metadata !{float %exp1}, i64 0, metadata !114), !dbg !113 ; [debug line = 59:27] [debug variable = exp1]
  %exp2 = fsub float %ay, %tmp_20, !dbg !115      ; [#uses=3 type=float] [debug line = 60:27]
  call void @llvm.dbg.value(metadata !{float %exp2}, i64 0, metadata !116), !dbg !115 ; [debug line = 60:27] [debug variable = exp2]
  %tmp_30 = fmul float %exp1, %exp1, !dbg !117    ; [#uses=1 type=float] [debug line = 61:41]
  %tmp_31 = fmul float %exp2, %exp2, !dbg !117    ; [#uses=1 type=float] [debug line = 61:41]
  %exp = fadd float %tmp_30, %tmp_31, !dbg !117   ; [#uses=1 type=float] [debug line = 61:41]
  call void @llvm.dbg.value(metadata !{float %exp}, i64 0, metadata !118), !dbg !117 ; [debug line = 61:41] [debug variable = exp]
  %d = call float @llvm.sqrt.f32(float %exp), !dbg !119 ; [#uses=6 type=float] [debug line = 62:14]
  call void @llvm.dbg.value(metadata !{float %d}, i64 0, metadata !120), !dbg !119 ; [debug line = 62:14] [debug variable = d]
  %d_to_int = bitcast float %d to i32             ; [#uses=2 type=i32]
  %tmp_52 = call i8 @_ssdm_op_PartSelect.i8.i32.i32.i32(i32 %d_to_int, i32 23, i32 30) ; [#uses=1 type=i8]
  %tmp_53 = trunc i32 %d_to_int to i23            ; [#uses=1 type=i23]
  %notlhs2 = icmp ne i8 %tmp_52, -1               ; [#uses=1 type=i1]
  %notrhs3 = icmp eq i23 %tmp_53, 0               ; [#uses=1 type=i1]
  %tmp_54 = or i1 %notrhs3, %notlhs2              ; [#uses=1 type=i1]
  %tmp_55 = fcmp olt float %d, 5.000000e+02, !dbg !121 ; [#uses=1 type=i1] [debug line = 66:4]
  %tmp_56 = and i1 %tmp_54, %tmp_55, !dbg !121    ; [#uses=1 type=i1] [debug line = 66:4]
  br i1 %tmp_56, label %9, label %._crit_edge5, !dbg !121 ; [debug line = 66:4]

; <label>:9                                       ; preds = %8
  %x_norm = fdiv float %exp1, %d, !dbg !122       ; [#uses=2 type=float] [debug line = 67:5]
  call void @llvm.dbg.value(metadata !{float %x_norm}, i64 0, metadata !124), !dbg !122 ; [debug line = 67:5] [debug variable = x_norm]
  %y_norm = fdiv float %exp2, %d, !dbg !125       ; [#uses=2 type=float] [debug line = 68:5]
  call void @llvm.dbg.value(metadata !{float %y_norm}, i64 0, metadata !126), !dbg !125 ; [debug line = 68:5] [debug variable = y_norm]
  %tmp_57 = fcmp olt float %d, 1.000000e+00, !dbg !127 ; [#uses=1 type=i1] [debug line = 70:5]
  br i1 %tmp_57, label %._crit_edge6, label %10, !dbg !127 ; [debug line = 70:5]

; <label>:10                                      ; preds = %9
  %tmp_34 = fdiv float 1.000000e+00, %d, !dbg !128 ; [#uses=2 type=float] [debug line = 74:6]
  %tmp_35 = fmul float %x_norm, %tmp_34, !dbg !128 ; [#uses=1 type=float] [debug line = 74:6]
  %tmp_36 = fmul float %y_norm, %tmp_34, !dbg !130 ; [#uses=1 type=float] [debug line = 75:6]
  br label %._crit_edge6

._crit_edge6:                                     ; preds = %10, %9
  %p_pn = phi float [ %tmp_35, %10 ], [ %x_norm, %9 ] ; [#uses=1 type=float]
  %p_pn1 = phi float [ %tmp_36, %10 ], [ %y_norm, %9 ] ; [#uses=1 type=float]
  %y_norm_1 = fmul float %p_pn1, %g, !dbg !131    ; [#uses=1 type=float] [debug line = 72:6]
  call void @llvm.dbg.value(metadata !{float %y_norm_1}, i64 0, metadata !126), !dbg !131 ; [debug line = 72:6] [debug variable = y_norm]
  %x_norm_1 = fmul float %p_pn, %g, !dbg !133     ; [#uses=1 type=float] [debug line = 71:6]
  call void @llvm.dbg.value(metadata !{float %x_norm_1}, i64 0, metadata !124), !dbg !133 ; [debug line = 71:6] [debug variable = x_norm]
  %tmp_37 = fadd float %tmp_23, %x_norm_1, !dbg !134 ; [#uses=2 type=float] [debug line = 78:5]
  %pvx_req = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %pvx, i32 1), !dbg !134 ; [#uses=0 type=i1] [debug line = 78:5]
  call void @_ssdm_op_Write.m_axi.floatP(float* %pvx, float %tmp_37, i4 -1), !dbg !134 ; [debug line = 78:5]
  %pvx_resp = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %pvx), !dbg !134 ; [#uses=0 type=i1] [debug line = 78:5]
  %tmp_38 = fadd float %tmp_22, %y_norm_1, !dbg !135 ; [#uses=2 type=float] [debug line = 79:5]
  %pvy_req = call i1 @_ssdm_op_WriteReq.m_axi.floatP(float* %pvy, i32 1), !dbg !135 ; [#uses=0 type=i1] [debug line = 79:5]
  call void @_ssdm_op_Write.m_axi.floatP(float* %pvy, float %tmp_38, i4 -1), !dbg !135 ; [debug line = 79:5]
  %pvy_resp = call i1 @_ssdm_op_WriteResp.m_axi.floatP(float* %pvy), !dbg !135 ; [#uses=0 type=i1] [debug line = 79:5]
  br label %._crit_edge5, !dbg !136               ; [debug line = 80:4]

._crit_edge5:                                     ; preds = %._crit_edge6, %8
  %tmp_39 = phi float [ %tmp_38, %._crit_edge6 ], [ %tmp_22, %8 ] ; [#uses=1 type=float]
  %tmp_40 = phi float [ %tmp_37, %._crit_edge6 ], [ %tmp_23, %8 ] ; [#uses=1 type=float]
  %empty = call i32 (...)* @_ssdm_op_SpecRegionEnd([22 x i8]* @p_str7, i32 %tmp_42) nounwind, !dbg !137 ; [#uses=0 type=i32] [debug line = 81:3]
  call void @llvm.dbg.value(metadata !{i32 %j_1}, i64 0, metadata !138), !dbg !139 ; [debug line = 51:18] [debug variable = j]
  br label %7, !dbg !139                          ; [debug line = 51:18]

; <label>:11                                      ; preds = %7
  %empty_4 = call i32 (...)* @_ssdm_op_SpecRegionEnd([19 x i8]* @p_str6, i32 %tmp_s) nounwind, !dbg !140 ; [#uses=0 type=i32] [debug line = 82:2]
  %i_1 = add i32 %i, 4, !dbg !141                 ; [#uses=1 type=i32] [debug line = 21:54]
  call void @llvm.dbg.value(metadata !{i32 %i_1}, i64 0, metadata !142), !dbg !141 ; [debug line = 21:54] [debug variable = i]
  br label %1, !dbg !141                          ; [debug line = 21:54]

; <label>:12                                      ; preds = %1
  ret void, !dbg !143                             ; [debug line = 83:1]
}

; [#uses=1]
declare float @llvm.sqrt.f32(float) nounwind readonly

; [#uses=2]
declare i32 @llvm.part.select.i32(i32, i32, i32) nounwind readnone

; [#uses=23]
declare void @llvm.dbg.value(metadata, i64, metadata) nounwind readnone

; [#uses=12]
define weak i1 @_ssdm_op_WriteResp.m_axi.floatP(float*) {
entry:
  ret i1 true
}

; [#uses=12]
define weak i1 @_ssdm_op_WriteReq.m_axi.floatP(float*, i32) {
entry:
  ret i1 true
}

; [#uses=12]
define weak void @_ssdm_op_Write.m_axi.floatP(float*, float, i4) {
entry:
  ret void
}

; [#uses=1]
define weak void @_ssdm_op_SpecTopModule(...) {
entry:
  ret void
}

; [#uses=2]
define weak i32 @_ssdm_op_SpecRegionEnd(...) {
entry:
  ret i32 0
}

; [#uses=2]
define weak i32 @_ssdm_op_SpecRegionBegin(...) {
entry:
  ret i32 0
}

; [#uses=1]
define weak void @_ssdm_op_SpecPipeline(...) nounwind {
entry:
  ret void
}

; [#uses=2]
define weak void @_ssdm_op_SpecLoopTripCount(...) nounwind {
entry:
  ret void
}

; [#uses=2]
define weak void @_ssdm_op_SpecLoopName(...) nounwind {
entry:
  ret void
}

; [#uses=5]
define weak void @_ssdm_op_SpecInterface(...) nounwind {
entry:
  ret void
}

; [#uses=3]
define weak void @_ssdm_op_SpecBitsMap(...) {
entry:
  ret void
}

; [#uses=7]
define weak i1 @_ssdm_op_ReadReq.m_axi.floatP(float*, i32) {
entry:
  ret i1 true
}

; [#uses=2]
define weak i32 @_ssdm_op_Read.s_axilite.i32P(i32*) {
entry:
  %empty = load i32* %0                           ; [#uses=1 type=i32]
  ret i32 %empty
}

; [#uses=1]
define weak i32 @_ssdm_op_Read.s_axilite.i32(i32) {
entry:
  ret i32 %0
}

; [#uses=7]
define weak float @_ssdm_op_Read.m_axi.floatP(float*) {
entry:
  %empty = load float* %0                         ; [#uses=1 type=float]
  ret float %empty
}

; [#uses=5]
define weak i8 @_ssdm_op_PartSelect.i8.i32.i32.i32(i32, i32, i32) nounwind readnone {
entry:
  %empty = call i32 @llvm.part.select.i32(i32 %0, i32 %1, i32 %2) ; [#uses=1 type=i32]
  %empty_5 = trunc i32 %empty to i8               ; [#uses=1 type=i8]
  ret i8 %empty_5
}

; [#uses=1]
define weak i30 @_ssdm_op_PartSelect.i30.i32.i32.i32(i32, i32, i32) nounwind readnone {
entry:
  %empty = call i32 @llvm.part.select.i32(i32 %0, i32 %1, i32 %2) ; [#uses=1 type=i32]
  %empty_6 = trunc i32 %empty to i30              ; [#uses=1 type=i30]
  ret i30 %empty_6
}

; [#uses=0]
declare i23 @_ssdm_op_PartSelect.i23.i32.i32.i32(i32, i32, i32) nounwind readnone

; [#uses=0]
declare i32 @_ssdm_op_BitConcatenate.i32.i30.i2(i30, i2) nounwind readnone

; [#uses=1]
declare void @_GLOBAL__I_a() nounwind section ".text.startup"

!opencl.kernels = !{!0}
!hls.encrypted.func = !{}
!llvm.map.gv = !{!7, !14, !19}
!axi4.master.portmap = !{!24}
!axi4.slave.bundlemap = !{!25}

!0 = metadata !{null, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5, metadata !6}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 1}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"uint32*", metadata !"uint32*"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_name", metadata !"ram", metadata !"numP", metadata !"numA"}
!6 = metadata !{metadata !"reqd_work_group_size", i32 1, i32 1, i32 1}
!7 = metadata !{metadata !8, i32* @numberParticles}
!8 = metadata !{metadata !9}
!9 = metadata !{i32 0, i32 31, metadata !10}
!10 = metadata !{metadata !11}
!11 = metadata !{metadata !"numberParticles", metadata !12, metadata !"unsigned int", i32 0, i32 31}
!12 = metadata !{metadata !13}
!13 = metadata !{i32 0, i32 0, i32 1}
!14 = metadata !{metadata !15, i32* @numberAttractors}
!15 = metadata !{metadata !16}
!16 = metadata !{i32 0, i32 31, metadata !17}
!17 = metadata !{metadata !18}
!18 = metadata !{metadata !"numberAttractors", metadata !12, metadata !"unsigned int", i32 0, i32 31}
!19 = metadata !{metadata !20, [1 x i32]* @llvm_global_ctors_0}
!20 = metadata !{metadata !21}
!21 = metadata !{i32 0, i32 31, metadata !22}
!22 = metadata !{metadata !23}
!23 = metadata !{metadata !"llvm.global_ctors.0", metadata !12, metadata !"", i32 0, i32 31}
!24 = metadata !{metadata !"MAXI", metadata !"ram", metadata !"READWRITE"}
!25 = metadata !{metadata !"ram", metadata !""}
!26 = metadata !{i32 786689, metadata !27, metadata !"ram", metadata !28, i32 16777223, metadata !31, i32 0, i32 0} ; [ DW_TAG_arg_variable ]
!27 = metadata !{i32 786478, i32 0, metadata !28, metadata !"toplevel", metadata !"toplevel", metadata !"_Z8toplevelPfPjS0_", metadata !28, i32 7, metadata !29, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, null, null, null, metadata !36, i32 7} ; [ DW_TAG_subprogram ]
!28 = metadata !{i32 786473, metadata !"particle_sim_hls/toplevel.cpp", metadata !"/home/userfs/m/ms1516/w2k/embs_open2", null} ; [ DW_TAG_file_type ]
!29 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !30, i32 0, i32 0} ; [ DW_TAG_subroutine_type ]
!30 = metadata !{null, metadata !31, metadata !33, metadata !33}
!31 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !32} ; [ DW_TAG_pointer_type ]
!32 = metadata !{i32 786468, null, metadata !"float", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ]
!33 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !34} ; [ DW_TAG_pointer_type ]
!34 = metadata !{i32 786454, null, metadata !"uint32", metadata !28, i32 19, i64 0, i64 0, i64 0, i32 0, metadata !35} ; [ DW_TAG_typedef ]
!35 = metadata !{i32 786468, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ]
!36 = metadata !{metadata !37}
!37 = metadata !{i32 786468}                      ; [ DW_TAG_base_type ]
!38 = metadata !{i32 7, i32 22, metadata !27, null}
!39 = metadata !{metadata !40}
!40 = metadata !{i32 0, i32 31, metadata !41}
!41 = metadata !{metadata !42}
!42 = metadata !{metadata !"ram", metadata !12, metadata !"float", i32 0, i32 31}
!43 = metadata !{metadata !44}
!44 = metadata !{i32 0, i32 31, metadata !45}
!45 = metadata !{metadata !46}
!46 = metadata !{metadata !"numP", metadata !12, metadata !"unsigned int", i32 0, i32 31}
!47 = metadata !{metadata !48}
!48 = metadata !{i32 0, i32 31, metadata !49}
!49 = metadata !{metadata !50}
!50 = metadata !{metadata !"numA", metadata !12, metadata !"unsigned int", i32 0, i32 31}
!51 = metadata !{i32 786689, metadata !27, metadata !"numP", metadata !28, i32 33554439, metadata !33, i32 0, i32 0} ; [ DW_TAG_arg_variable ]
!52 = metadata !{i32 7, i32 35, metadata !27, null}
!53 = metadata !{i32 786689, metadata !27, metadata !"numA", metadata !28, i32 50331655, metadata !33, i32 0, i32 0} ; [ DW_TAG_arg_variable ]
!54 = metadata !{i32 7, i32 49, metadata !27, null}
!55 = metadata !{i32 8, i32 1, metadata !56, null}
!56 = metadata !{i32 786443, metadata !27, i32 7, i32 55, metadata !28, i32 0} ; [ DW_TAG_lexical_block ]
!57 = metadata !{i32 9, i32 1, metadata !56, null}
!58 = metadata !{i32 10, i32 1, metadata !56, null}
!59 = metadata !{i32 11, i32 1, metadata !56, null}
!60 = metadata !{i32 17, i32 2, metadata !56, null}
!61 = metadata !{i32 18, i32 2, metadata !56, null}
!62 = metadata !{i32 20, i32 35, metadata !56, null}
!63 = metadata !{i32 786688, metadata !56, metadata !"loopend", metadata !28, i32 20, metadata !64, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!64 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ]
!65 = metadata !{i32 21, i32 39, metadata !66, null}
!66 = metadata !{i32 786443, metadata !56, i32 21, i32 22, metadata !28, i32 1} ; [ DW_TAG_lexical_block ]
!67 = metadata !{i32 21, i32 62, metadata !68, null}
!68 = metadata !{i32 786443, metadata !66, i32 21, i32 61, metadata !28, i32 2} ; [ DW_TAG_lexical_block ]
!69 = metadata !{i32 22, i32 1, metadata !68, null}
!70 = metadata !{i32 24, i32 21, metadata !68, null}
!71 = metadata !{i32 786688, metadata !68, metadata !"px", metadata !28, i32 24, metadata !31, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!72 = metadata !{i32 25, i32 26, metadata !68, null}
!73 = metadata !{i32 786688, metadata !68, metadata !"py", metadata !28, i32 25, metadata !31, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!74 = metadata !{i32 26, i32 27, metadata !68, null}
!75 = metadata !{i32 786688, metadata !68, metadata !"pvx", metadata !28, i32 26, metadata !31, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!76 = metadata !{i32 27, i32 27, metadata !68, null}
!77 = metadata !{i32 786688, metadata !68, metadata !"pvy", metadata !28, i32 27, metadata !31, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!78 = metadata !{i32 29, i32 3, metadata !68, null}
!79 = metadata !{i32 30, i32 3, metadata !68, null}
!80 = metadata !{i32 32, i32 3, metadata !68, null}
!81 = metadata !{i32 33, i32 4, metadata !82, null}
!82 = metadata !{i32 786443, metadata !68, i32 32, i32 17, metadata !28, i32 3} ; [ DW_TAG_lexical_block ]
!83 = metadata !{i32 34, i32 4, metadata !82, null}
!84 = metadata !{i32 35, i32 3, metadata !82, null}
!85 = metadata !{i32 36, i32 3, metadata !68, null}
!86 = metadata !{i32 37, i32 4, metadata !87, null}
!87 = metadata !{i32 786443, metadata !68, i32 36, i32 17, metadata !28, i32 4} ; [ DW_TAG_lexical_block ]
!88 = metadata !{i32 38, i32 4, metadata !87, null}
!89 = metadata !{i32 39, i32 3, metadata !87, null}
!90 = metadata !{i32 40, i32 3, metadata !68, null}
!91 = metadata !{i32 41, i32 4, metadata !92, null}
!92 = metadata !{i32 786443, metadata !68, i32 40, i32 20, metadata !28, i32 5} ; [ DW_TAG_lexical_block ]
!93 = metadata !{i32 42, i32 4, metadata !92, null}
!94 = metadata !{i32 43, i32 3, metadata !92, null}
!95 = metadata !{i32 44, i32 3, metadata !68, null}
!96 = metadata !{i32 45, i32 4, metadata !97, null}
!97 = metadata !{i32 786443, metadata !68, i32 44, i32 19, metadata !28, i32 6} ; [ DW_TAG_lexical_block ]
!98 = metadata !{i32 46, i32 4, metadata !97, null}
!99 = metadata !{i32 47, i32 3, metadata !97, null}
!100 = metadata !{i32 49, i32 86, metadata !68, null}
!101 = metadata !{i32 786688, metadata !68, metadata !"loopend", metadata !28, i32 49, metadata !64, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!102 = metadata !{i32 50, i32 83, metadata !103, null}
!103 = metadata !{i32 786443, metadata !68, i32 50, i32 26, metadata !28, i32 7} ; [ DW_TAG_lexical_block ]
!104 = metadata !{i32 52, i32 9, metadata !105, null}
!105 = metadata !{i32 786443, metadata !103, i32 52, i32 8, metadata !28, i32 8} ; [ DW_TAG_lexical_block ]
!106 = metadata !{i32 53, i32 1, metadata !105, null}
!107 = metadata !{i32 55, i32 23, metadata !105, null}
!108 = metadata !{i32 786688, metadata !105, metadata !"ax", metadata !28, i32 55, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!109 = metadata !{i32 56, i32 25, metadata !105, null}
!110 = metadata !{i32 786688, metadata !105, metadata !"ay", metadata !28, i32 56, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!111 = metadata !{i32 57, i32 24, metadata !105, null}
!112 = metadata !{i32 786688, metadata !105, metadata !"g", metadata !28, i32 57, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!113 = metadata !{i32 59, i32 27, metadata !105, null}
!114 = metadata !{i32 786688, metadata !105, metadata !"exp1", metadata !28, i32 59, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!115 = metadata !{i32 60, i32 27, metadata !105, null}
!116 = metadata !{i32 786688, metadata !105, metadata !"exp2", metadata !28, i32 60, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!117 = metadata !{i32 61, i32 41, metadata !105, null}
!118 = metadata !{i32 786688, metadata !105, metadata !"exp", metadata !28, i32 61, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!119 = metadata !{i32 62, i32 14, metadata !105, null}
!120 = metadata !{i32 786688, metadata !105, metadata !"d", metadata !28, i32 62, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!121 = metadata !{i32 66, i32 4, metadata !105, null}
!122 = metadata !{i32 67, i32 5, metadata !123, null}
!123 = metadata !{i32 786443, metadata !105, i32 66, i32 17, metadata !28, i32 9} ; [ DW_TAG_lexical_block ]
!124 = metadata !{i32 786688, metadata !105, metadata !"x_norm", metadata !28, i32 64, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!125 = metadata !{i32 68, i32 5, metadata !123, null}
!126 = metadata !{i32 786688, metadata !105, metadata !"y_norm", metadata !28, i32 65, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!127 = metadata !{i32 70, i32 5, metadata !123, null}
!128 = metadata !{i32 74, i32 6, metadata !129, null}
!129 = metadata !{i32 786443, metadata !123, i32 73, i32 12, metadata !28, i32 11} ; [ DW_TAG_lexical_block ]
!130 = metadata !{i32 75, i32 6, metadata !129, null}
!131 = metadata !{i32 72, i32 6, metadata !132, null}
!132 = metadata !{i32 786443, metadata !123, i32 70, i32 18, metadata !28, i32 10} ; [ DW_TAG_lexical_block ]
!133 = metadata !{i32 71, i32 6, metadata !132, null}
!134 = metadata !{i32 78, i32 5, metadata !123, null}
!135 = metadata !{i32 79, i32 5, metadata !123, null}
!136 = metadata !{i32 80, i32 4, metadata !123, null}
!137 = metadata !{i32 81, i32 3, metadata !105, null}
!138 = metadata !{i32 786688, metadata !103, metadata !"j", metadata !28, i32 50, metadata !64, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!139 = metadata !{i32 51, i32 18, metadata !103, null}
!140 = metadata !{i32 82, i32 2, metadata !68, null}
!141 = metadata !{i32 21, i32 54, metadata !66, null}
!142 = metadata !{i32 786688, metadata !66, metadata !"i", metadata !28, i32 21, metadata !34, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!143 = metadata !{i32 83, i32 1, metadata !56, null}