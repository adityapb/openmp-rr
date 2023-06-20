; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals --include-generated-funcs
; RUN: opt -data-layout=A5 -amdgpu-lower-enqueued-block -S < %s | FileCheck %s

%struct.ndrange_t = type { i32 }
%opencl.queue_t = type opaque

define amdgpu_kernel void @non_caller(i8 addrspace(1)* %a, i8 %b, i64 addrspace(1)* %c, i64 %d) {
  ret void
}

define amdgpu_kernel void @caller_indirect(i8 addrspace(1)* %a, i8 %b, i64 addrspace(1)* %c, i64 %d) {
  call void @caller(i8 addrspace(1)* %a, i8 %b, i64 addrspace(1)* %c, i64 %d)
  ret void
}

define amdgpu_kernel void @caller(i8 addrspace(1)* %a, i8 %b, i64 addrspace(1)* %c, i64 %d) {
entry:
  %block = alloca <{ i32, i32, i8 addrspace(1)*, i8 }>, align 8, addrspace(5)
  %inst = alloca %struct.ndrange_t, align 4, addrspace(5)
  %block2 = alloca <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }>, align 8, addrspace(5)
  %inst3 = alloca %struct.ndrange_t, align 4, addrspace(5)
  %block.size = getelementptr inbounds <{ i32, i32, i8 addrspace(1)*, i8 }>, <{ i32, i32, i8 addrspace(1)*, i8 }> addrspace(5)* %block, i32 0, i32 0
  store i32 25, i32 addrspace(5)* %block.size, align 8
  %block.align = getelementptr inbounds <{ i32, i32, i8 addrspace(1)*, i8 }>, <{ i32, i32, i8 addrspace(1)*, i8 }> addrspace(5)* %block, i32 0, i32 1
  store i32 8, i32 addrspace(5)* %block.align, align 4
  %block.captured = getelementptr inbounds <{ i32, i32, i8 addrspace(1)*, i8 }>, <{ i32, i32, i8 addrspace(1)*, i8 }> addrspace(5)* %block, i32 0, i32 2
  store i8 addrspace(1)* %a, i8 addrspace(1)* addrspace(5)* %block.captured, align 8
  %block.captured1 = getelementptr inbounds <{ i32, i32, i8 addrspace(1)*, i8 }>, <{ i32, i32, i8 addrspace(1)*, i8 }> addrspace(5)* %block, i32 0, i32 3
  store i8 %b, i8 addrspace(5)* %block.captured1, align 8
  %inst1 = bitcast <{ i32, i32, i8 addrspace(1)*, i8 }> addrspace(5)* %block to void () addrspace(5)*
  %inst4 = addrspacecast void () addrspace(5)* %inst1 to i8*
  %inst5 = call i32 @__enqueue_kernel_basic(%opencl.queue_t addrspace(1)* undef, i32 0, %struct.ndrange_t addrspace(5)* byval(%struct.ndrange_t) nonnull %inst,
  i8* bitcast (void (<{ i32, i32, i8 addrspace(1)*, i8 }>)* @__test_block_invoke_kernel to i8*), i8* nonnull %inst4) #2
  %inst10 = call i32 @__enqueue_kernel_basic(%opencl.queue_t addrspace(1)* undef, i32 0, %struct.ndrange_t addrspace(5)* byval(%struct.ndrange_t) nonnull %inst,
  i8* bitcast (void (<{ i32, i32, i8 addrspace(1)*, i8 }>)* @__test_block_invoke_kernel to i8*), i8* nonnull %inst4) #2
  %inst11 = call i32 @__enqueue_kernel_basic(%opencl.queue_t addrspace(1)* undef, i32 0, %struct.ndrange_t addrspace(5)* byval(%struct.ndrange_t) nonnull %inst,
  i8* bitcast (void (<{ i32, i32, i8 addrspace(1)*, i8 }>)* @0 to i8*), i8* nonnull %inst4) #2
  %inst12 = call i32 @__enqueue_kernel_basic(%opencl.queue_t addrspace(1)* undef, i32 0, %struct.ndrange_t addrspace(5)* byval(%struct.ndrange_t) nonnull %inst,
  i8* bitcast (void (<{ i32, i32, i8 addrspace(1)*, i8 }>)* @1 to i8*), i8* nonnull %inst4) #2
  %block.size4 = getelementptr inbounds <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }>, <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> addrspace(5)* %block2, i32 0, i32 0
  store i32 41, i32 addrspace(5)* %block.size4, align 8
  %block.align5 = getelementptr inbounds <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }>, <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> addrspace(5)* %block2, i32 0, i32 1
  store i32 8, i32 addrspace(5)* %block.align5, align 4
  %block.captured7 = getelementptr inbounds <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }>, <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> addrspace(5)* %block2, i32 0, i32 2
  store i8 addrspace(1)* %a, i8 addrspace(1)* addrspace(5)* %block.captured7, align 8
  %block.captured8 = getelementptr inbounds <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }>, <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> addrspace(5)* %block2, i32 0, i32 5
  store i8 %b, i8 addrspace(5)* %block.captured8, align 8
  %block.captured9 = getelementptr inbounds <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }>, <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> addrspace(5)* %block2, i32 0, i32 3
  store i64 addrspace(1)* %c, i64 addrspace(1)* addrspace(5)* %block.captured9, align 8
  %block.captured10 = getelementptr inbounds <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }>, <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> addrspace(5)* %block2, i32 0, i32 4
  store i64 %d, i64 addrspace(5)* %block.captured10, align 8
  %inst6 = bitcast <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> addrspace(5)* %block2 to void () addrspace(5)*
  %inst8 = addrspacecast void () addrspace(5)* %inst6 to i8*
  %inst9 = call i32 @__enqueue_kernel_basic(%opencl.queue_t addrspace(1)* undef, i32 0, %struct.ndrange_t addrspace(5)* byval(%struct.ndrange_t) nonnull %inst3,
  i8* bitcast (void (<{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }>)* @__test_block_invoke_2_kernel to i8*), i8* nonnull %inst8) #2
  ret void
}

; __enqueue_kernel* functions may get inlined
define amdgpu_kernel void @inlined_caller(i8 addrspace(1)* %a, i8 %b, i64 addrspace(1)* %c, i64 %d) {
entry:
  %inst = load i64, i64 addrspace(1)* addrspacecast (i64* bitcast (void (<{ i32, i32, i8 addrspace(1)*, i8 }>)* @__test_block_invoke_kernel to i64*) to i64 addrspace(1)*)
  store i64 %inst, i64 addrspace(1)* %c
  ret void
}

define internal amdgpu_kernel void @__test_block_invoke_kernel(<{ i32, i32, i8 addrspace(1)*, i8 }> %arg) #0 {
entry:
  %.fca.3.extract = extractvalue <{ i32, i32, i8 addrspace(1)*, i8 }> %arg, 2
  %.fca.4.extract = extractvalue <{ i32, i32, i8 addrspace(1)*, i8 }> %arg, 3
  store i8 %.fca.4.extract, i8 addrspace(1)* %.fca.3.extract, align 1
  ret void
}

declare i32 @__enqueue_kernel_basic(%opencl.queue_t addrspace(1)*, i32, %struct.ndrange_t addrspace(5)*, i8*, i8*) local_unnamed_addr

define internal amdgpu_kernel void @__test_block_invoke_2_kernel(<{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> %arg) #0 {
entry:
  %.fca.3.extract = extractvalue <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> %arg, 2
  %.fca.4.extract = extractvalue <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> %arg, 3
  %.fca.5.extract = extractvalue <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> %arg, 4
  %.fca.6.extract = extractvalue <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> %arg, 5
  store i8 %.fca.6.extract, i8 addrspace(1)* %.fca.3.extract, align 1
  store i64 %.fca.5.extract, i64 addrspace(1)* %.fca.4.extract, align 8
  ret void
}

define internal amdgpu_kernel void @0(<{ i32, i32, i8 addrspace(1)*, i8 }> %arg) #0 {
  ret void
}

define internal amdgpu_kernel void @1(<{ i32, i32, i8 addrspace(1)*, i8 }> %arg) #0 {
  ret void
}

attributes #0 = { "enqueued-block" }
;.
; CHECK: @[[__TEST_BLOCK_INVOKE_KERNEL_RUNTIME_HANDLE:[a-zA-Z0-9_$"\\.-]+]] = addrspace(1) global [2 x i64] zeroinitializer
; CHECK: @[[__TEST_BLOCK_INVOKE_2_KERNEL_RUNTIME_HANDLE:[a-zA-Z0-9_$"\\.-]+]] = addrspace(1) global [2 x i64] zeroinitializer
; CHECK: @[[__AMDGPU_ENQUEUED_KERNEL_RUNTIME_HANDLE:[a-zA-Z0-9_$"\\.-]+]] = addrspace(1) global [2 x i64] zeroinitializer
; CHECK: @[[__AMDGPU_ENQUEUED_KERNEL_1_RUNTIME_HANDLE:[a-zA-Z0-9_$"\\.-]+]] = addrspace(1) global [2 x i64] zeroinitializer
;.
; CHECK-LABEL: define {{[^@]+}}@non_caller
; CHECK-SAME: (i8 addrspace(1)* [[A:%.*]], i8 [[B:%.*]], i64 addrspace(1)* [[C:%.*]], i64 [[D:%.*]]) {
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: define {{[^@]+}}@caller_indirect
; CHECK-SAME: (i8 addrspace(1)* [[A:%.*]], i8 [[B:%.*]], i64 addrspace(1)* [[C:%.*]], i64 [[D:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    call void @caller(i8 addrspace(1)* [[A]], i8 [[B]], i64 addrspace(1)* [[C]], i64 [[D]])
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: define {{[^@]+}}@caller
; CHECK-SAME: (i8 addrspace(1)* [[A:%.*]], i8 [[B:%.*]], i64 addrspace(1)* [[C:%.*]], i64 [[D:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[BLOCK:%.*]] = alloca <{ i32, i32, i8 addrspace(1)*, i8 }>, align 8, addrspace(5)
; CHECK-NEXT:    [[INST:%.*]] = alloca [[STRUCT_NDRANGE_T:%.*]], align 4, addrspace(5)
; CHECK-NEXT:    [[BLOCK2:%.*]] = alloca <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }>, align 8, addrspace(5)
; CHECK-NEXT:    [[INST3:%.*]] = alloca [[STRUCT_NDRANGE_T]], align 4, addrspace(5)
; CHECK-NEXT:    [[BLOCK_SIZE:%.*]] = getelementptr inbounds <{ i32, i32, i8 addrspace(1)*, i8 }>, <{ i32, i32, i8 addrspace(1)*, i8 }> addrspace(5)* [[BLOCK]], i32 0, i32 0
; CHECK-NEXT:    store i32 25, i32 addrspace(5)* [[BLOCK_SIZE]], align 8
; CHECK-NEXT:    [[BLOCK_ALIGN:%.*]] = getelementptr inbounds <{ i32, i32, i8 addrspace(1)*, i8 }>, <{ i32, i32, i8 addrspace(1)*, i8 }> addrspace(5)* [[BLOCK]], i32 0, i32 1
; CHECK-NEXT:    store i32 8, i32 addrspace(5)* [[BLOCK_ALIGN]], align 4
; CHECK-NEXT:    [[BLOCK_CAPTURED:%.*]] = getelementptr inbounds <{ i32, i32, i8 addrspace(1)*, i8 }>, <{ i32, i32, i8 addrspace(1)*, i8 }> addrspace(5)* [[BLOCK]], i32 0, i32 2
; CHECK-NEXT:    store i8 addrspace(1)* [[A]], i8 addrspace(1)* addrspace(5)* [[BLOCK_CAPTURED]], align 8
; CHECK-NEXT:    [[BLOCK_CAPTURED1:%.*]] = getelementptr inbounds <{ i32, i32, i8 addrspace(1)*, i8 }>, <{ i32, i32, i8 addrspace(1)*, i8 }> addrspace(5)* [[BLOCK]], i32 0, i32 3
; CHECK-NEXT:    store i8 [[B]], i8 addrspace(5)* [[BLOCK_CAPTURED1]], align 8
; CHECK-NEXT:    [[INST1:%.*]] = bitcast <{ i32, i32, i8 addrspace(1)*, i8 }> addrspace(5)* [[BLOCK]] to void () addrspace(5)*
; CHECK-NEXT:    [[INST4:%.*]] = addrspacecast void () addrspace(5)* [[INST1]] to i8*
; CHECK-NEXT:    [[INST5:%.*]] = call i32 @__enqueue_kernel_basic([[OPENCL_QUEUE_T:%.*]] addrspace(1)* undef, i32 0, [[STRUCT_NDRANGE_T]] addrspace(5)* nonnull byval([[STRUCT_NDRANGE_T]]) [[INST]], i8* addrspacecast (i8 addrspace(1)* bitcast ([2 x i64] addrspace(1)* @__test_block_invoke_kernel.runtime_handle to i8 addrspace(1)*) to i8*), i8* nonnull [[INST4]])
; CHECK-NEXT:    [[INST10:%.*]] = call i32 @__enqueue_kernel_basic([[OPENCL_QUEUE_T]] addrspace(1)* undef, i32 0, [[STRUCT_NDRANGE_T]] addrspace(5)* nonnull byval([[STRUCT_NDRANGE_T]]) [[INST]], i8* addrspacecast (i8 addrspace(1)* bitcast ([2 x i64] addrspace(1)* @__test_block_invoke_kernel.runtime_handle to i8 addrspace(1)*) to i8*), i8* nonnull [[INST4]])
; CHECK-NEXT:    [[INST11:%.*]] = call i32 @__enqueue_kernel_basic([[OPENCL_QUEUE_T]] addrspace(1)* undef, i32 0, [[STRUCT_NDRANGE_T]] addrspace(5)* nonnull byval([[STRUCT_NDRANGE_T]]) [[INST]], i8* addrspacecast (i8 addrspace(1)* bitcast ([2 x i64] addrspace(1)* @__amdgpu_enqueued_kernel.runtime_handle to i8 addrspace(1)*) to i8*), i8* nonnull [[INST4]])
; CHECK-NEXT:    [[INST12:%.*]] = call i32 @__enqueue_kernel_basic([[OPENCL_QUEUE_T]] addrspace(1)* undef, i32 0, [[STRUCT_NDRANGE_T]] addrspace(5)* nonnull byval([[STRUCT_NDRANGE_T]]) [[INST]], i8* addrspacecast (i8 addrspace(1)* bitcast ([2 x i64] addrspace(1)* @__amdgpu_enqueued_kernel.1.runtime_handle to i8 addrspace(1)*) to i8*), i8* nonnull [[INST4]])
; CHECK-NEXT:    [[BLOCK_SIZE4:%.*]] = getelementptr inbounds <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }>, <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> addrspace(5)* [[BLOCK2]], i32 0, i32 0
; CHECK-NEXT:    store i32 41, i32 addrspace(5)* [[BLOCK_SIZE4]], align 8
; CHECK-NEXT:    [[BLOCK_ALIGN5:%.*]] = getelementptr inbounds <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }>, <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> addrspace(5)* [[BLOCK2]], i32 0, i32 1
; CHECK-NEXT:    store i32 8, i32 addrspace(5)* [[BLOCK_ALIGN5]], align 4
; CHECK-NEXT:    [[BLOCK_CAPTURED7:%.*]] = getelementptr inbounds <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }>, <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> addrspace(5)* [[BLOCK2]], i32 0, i32 2
; CHECK-NEXT:    store i8 addrspace(1)* [[A]], i8 addrspace(1)* addrspace(5)* [[BLOCK_CAPTURED7]], align 8
; CHECK-NEXT:    [[BLOCK_CAPTURED8:%.*]] = getelementptr inbounds <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }>, <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> addrspace(5)* [[BLOCK2]], i32 0, i32 5
; CHECK-NEXT:    store i8 [[B]], i8 addrspace(5)* [[BLOCK_CAPTURED8]], align 8
; CHECK-NEXT:    [[BLOCK_CAPTURED9:%.*]] = getelementptr inbounds <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }>, <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> addrspace(5)* [[BLOCK2]], i32 0, i32 3
; CHECK-NEXT:    store i64 addrspace(1)* [[C]], i64 addrspace(1)* addrspace(5)* [[BLOCK_CAPTURED9]], align 8
; CHECK-NEXT:    [[BLOCK_CAPTURED10:%.*]] = getelementptr inbounds <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }>, <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> addrspace(5)* [[BLOCK2]], i32 0, i32 4
; CHECK-NEXT:    store i64 [[D]], i64 addrspace(5)* [[BLOCK_CAPTURED10]], align 8
; CHECK-NEXT:    [[INST6:%.*]] = bitcast <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> addrspace(5)* [[BLOCK2]] to void () addrspace(5)*
; CHECK-NEXT:    [[INST8:%.*]] = addrspacecast void () addrspace(5)* [[INST6]] to i8*
; CHECK-NEXT:    [[INST9:%.*]] = call i32 @__enqueue_kernel_basic([[OPENCL_QUEUE_T]] addrspace(1)* undef, i32 0, [[STRUCT_NDRANGE_T]] addrspace(5)* nonnull byval([[STRUCT_NDRANGE_T]]) [[INST3]], i8* addrspacecast (i8 addrspace(1)* bitcast ([2 x i64] addrspace(1)* @__test_block_invoke_2_kernel.runtime_handle to i8 addrspace(1)*) to i8*), i8* nonnull [[INST8]])
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: define {{[^@]+}}@inlined_caller
; CHECK-SAME: (i8 addrspace(1)* [[A:%.*]], i8 [[B:%.*]], i64 addrspace(1)* [[C:%.*]], i64 [[D:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[INST:%.*]] = load i64, i64 addrspace(1)* getelementptr inbounds ([2 x i64], [2 x i64] addrspace(1)* @__test_block_invoke_kernel.runtime_handle, i32 0, i32 0), align 4
; CHECK-NEXT:    store i64 [[INST]], i64 addrspace(1)* [[C]], align 4
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: define {{[^@]+}}@__test_block_invoke_kernel
; CHECK-SAME: (<{ i32, i32, i8 addrspace(1)*, i8 }> [[ARG:%.*]]) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DOTFCA_3_EXTRACT:%.*]] = extractvalue <{ i32, i32, i8 addrspace(1)*, i8 }> [[ARG]], 2
; CHECK-NEXT:    [[DOTFCA_4_EXTRACT:%.*]] = extractvalue <{ i32, i32, i8 addrspace(1)*, i8 }> [[ARG]], 3
; CHECK-NEXT:    store i8 [[DOTFCA_4_EXTRACT]], i8 addrspace(1)* [[DOTFCA_3_EXTRACT]], align 1
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: define {{[^@]+}}@__test_block_invoke_2_kernel
; CHECK-SAME: (<{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> [[ARG:%.*]]) #[[ATTR2:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DOTFCA_3_EXTRACT:%.*]] = extractvalue <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> [[ARG]], 2
; CHECK-NEXT:    [[DOTFCA_4_EXTRACT:%.*]] = extractvalue <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> [[ARG]], 3
; CHECK-NEXT:    [[DOTFCA_5_EXTRACT:%.*]] = extractvalue <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> [[ARG]], 4
; CHECK-NEXT:    [[DOTFCA_6_EXTRACT:%.*]] = extractvalue <{ i32, i32, i8 addrspace(1)*, i64 addrspace(1)*, i64, i8 }> [[ARG]], 5
; CHECK-NEXT:    store i8 [[DOTFCA_6_EXTRACT]], i8 addrspace(1)* [[DOTFCA_3_EXTRACT]], align 1
; CHECK-NEXT:    store i64 [[DOTFCA_5_EXTRACT]], i64 addrspace(1)* [[DOTFCA_4_EXTRACT]], align 8
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: define {{[^@]+}}@__amdgpu_enqueued_kernel
; CHECK-SAME: (<{ i32, i32, i8 addrspace(1)*, i8 }> [[ARG:%.*]]) #[[ATTR3:[0-9]+]] {
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: define {{[^@]+}}@__amdgpu_enqueued_kernel.1
; CHECK-SAME: (<{ i32, i32, i8 addrspace(1)*, i8 }> [[ARG:%.*]]) #[[ATTR4:[0-9]+]] {
; CHECK-NEXT:    ret void
;
;.
; CHECK: attributes #[[ATTR0]] = { "calls-enqueue-kernel" }
; CHECK: attributes #[[ATTR1]] = { "enqueued-block" "runtime-handle"="__test_block_invoke_kernel.runtime_handle" }
; CHECK: attributes #[[ATTR2]] = { "enqueued-block" "runtime-handle"="__test_block_invoke_2_kernel.runtime_handle" }
; CHECK: attributes #[[ATTR3]] = { "enqueued-block" "runtime-handle"="__amdgpu_enqueued_kernel.runtime_handle" }
; CHECK: attributes #[[ATTR4]] = { "enqueued-block" "runtime-handle"="__amdgpu_enqueued_kernel.1.runtime_handle" }
;.