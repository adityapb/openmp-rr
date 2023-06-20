; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-globals
; RUN: opt -S -passes=openmp-opt < %s | FileCheck %s
; RUN: opt -passes=openmp-opt -pass-remarks=openmp-opt -pass-remarks-missed=openmp-opt -disable-output < %s 2>&1 | FileCheck %s -check-prefix=CHECK-REMARKS
; RUN: opt -openmp-opt-disable-deglobalization -S -passes=openmp-opt < %s | FileCheck %s --check-prefix=CHECK-DISABLED
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64"

; UTC_ARGS: --disable
; CHECK-REMARKS: remark: remove_globalization.c:4:2: Could not move globalized variable to the stack. Variable is potentially captured in call. Mark parameter as `__attribute__((noescape))` to override.
; CHECK-REMARKS: remark: remove_globalization.c:2:2: Moving globalized variable to the stack.
; CHECK-REMARKS: remark: remove_globalization.c:6:2: Moving globalized variable to the stack.
; CHECK-REMARKS: remark: remove_globalization.c:4:2: Found thread data sharing on the GPU. Expect degraded performance due to data globalization.
; UTC_ARGS: --enable

@S = external local_unnamed_addr global ptr

%struct.ident_t = type { i32, i32, i32, i32, ptr }

; Make it a weak definition so we will apply custom state machine rewriting but can't use the body in the reasoning.
;.
; CHECK: @[[S:[a-zA-Z0-9_$"\\.-]+]] = external local_unnamed_addr global ptr
;.
; CHECK-DISABLED: @[[S:[a-zA-Z0-9_$"\\.-]+]] = external local_unnamed_addr global ptr
;.
define weak i32 @__kmpc_target_init(ptr, i8, i1) {
; CHECK-LABEL: define {{[^@]+}}@__kmpc_target_init
; CHECK-SAME: (ptr [[TMP0:%.*]], i8 [[TMP1:%.*]], i1 [[TMP2:%.*]]) {
; CHECK-NEXT:    ret i32 0
;
; CHECK-DISABLED-LABEL: define {{[^@]+}}@__kmpc_target_init
; CHECK-DISABLED-SAME: (ptr [[TMP0:%.*]], i8 [[TMP1:%.*]], i1 [[TMP2:%.*]]) {
; CHECK-DISABLED-NEXT:    ret i32 0
;
  ret i32 0
}
declare void @__kmpc_target_deinit(ptr, i8)

define void @kernel() {
; CHECK-LABEL: define {{[^@]+}}@kernel() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call i32 @__kmpc_target_init(ptr nonnull null, i8 1, i1 false)
; CHECK-NEXT:    call void @foo() #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    call void @bar() #[[ATTR0]]
; CHECK-NEXT:    call void @convert_and_move_alloca() #[[ATTR0]]
; CHECK-NEXT:    call void @unknown_no_openmp()
; CHECK-NEXT:    call void @__kmpc_target_deinit(ptr nonnull null, i8 1)
; CHECK-NEXT:    ret void
;
; CHECK-DISABLED-LABEL: define {{[^@]+}}@kernel() {
; CHECK-DISABLED-NEXT:  entry:
; CHECK-DISABLED-NEXT:    [[TMP0:%.*]] = call i32 @__kmpc_target_init(ptr nonnull null, i8 1, i1 false)
; CHECK-DISABLED-NEXT:    call void @foo() #[[ATTR0:[0-9]+]]
; CHECK-DISABLED-NEXT:    call void @bar() #[[ATTR0]]
; CHECK-DISABLED-NEXT:    call void @convert_and_move_alloca() #[[ATTR0]]
; CHECK-DISABLED-NEXT:    call void @unknown_no_openmp()
; CHECK-DISABLED-NEXT:    call void @__kmpc_target_deinit(ptr nonnull null, i8 1)
; CHECK-DISABLED-NEXT:    ret void
;
entry:
  %0 = call i32 @__kmpc_target_init(ptr nonnull null, i8 1, i1 true)
  call void @foo()
  call void @bar()
  call void @convert_and_move_alloca()
  call void @unknown_no_openmp()
  call void @__kmpc_target_deinit(ptr nonnull null, i8 1)
  ret void
}

define internal void @foo() {
; CHECK-LABEL: define {{[^@]+}}@foo
; CHECK-SAME: () #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DOTH2S:%.*]] = alloca i8, i64 4, align 1
; CHECK-NEXT:    ret void
;
; CHECK-DISABLED-LABEL: define {{[^@]+}}@foo
; CHECK-DISABLED-SAME: () #[[ATTR0]] {
; CHECK-DISABLED-NEXT:  entry:
; CHECK-DISABLED-NEXT:    [[DOTH2S:%.*]] = alloca i8, i64 4, align 1
; CHECK-DISABLED-NEXT:    ret void
;
entry:
  %0 = call ptr @__kmpc_alloc_shared(i64 4), !dbg !12
  call void @use(ptr %0)
  call void @__kmpc_free_shared(ptr %0, i64 4)
  ret void
}

define internal void @bar() {
; CHECK-LABEL: define {{[^@]+}}@bar
; CHECK-SAME: () #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call ptr @__kmpc_alloc_shared(i64 4) #[[ATTR0]], !dbg [[DBG8:![0-9]+]]
; CHECK-NEXT:    call void @share(ptr nofree [[TMP0]]) #[[ATTR1]], !dbg [[DBG8]]
; CHECK-NEXT:    call void @__kmpc_free_shared(ptr [[TMP0]], i64 4) #[[ATTR0]]
; CHECK-NEXT:    ret void
;
; CHECK-DISABLED-LABEL: define {{[^@]+}}@bar
; CHECK-DISABLED-SAME: () #[[ATTR1:[0-9]+]] {
; CHECK-DISABLED-NEXT:  entry:
; CHECK-DISABLED-NEXT:    [[TMP0:%.*]] = call ptr @__kmpc_alloc_shared(i64 4) #[[ATTR0]], !dbg [[DBG8:![0-9]+]]
; CHECK-DISABLED-NEXT:    call void @share(ptr nofree [[TMP0]]) #[[ATTR1]], !dbg [[DBG8]]
; CHECK-DISABLED-NEXT:    call void @__kmpc_free_shared(ptr [[TMP0]], i64 4) #[[ATTR0]]
; CHECK-DISABLED-NEXT:    ret void
;
entry:
  %0 = call ptr @__kmpc_alloc_shared(i64 4), !dbg !13
  call void @share(ptr %0), !dbg !13
  call void @__kmpc_free_shared(ptr %0, i64 4)
  ret void
}

define internal void @use(ptr %x) {
; CHECK-LABEL: define {{[^@]+}}@use
; CHECK-SAME: (ptr [[X:%.*]]) #[[ATTR2:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret void
;
; CHECK-DISABLED-LABEL: define {{[^@]+}}@use
; CHECK-DISABLED-SAME: (ptr [[X:%.*]]) #[[ATTR2:[0-9]+]] {
; CHECK-DISABLED-NEXT:  entry:
; CHECK-DISABLED-NEXT:    ret void
;
entry:
  ret void
}

define internal void @share(ptr %x) {
; CHECK-LABEL: define {{[^@]+}}@share
; CHECK-SAME: (ptr nofree [[X:%.*]]) #[[ATTR3:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store ptr [[X]], ptr @S, align 8
; CHECK-NEXT:    ret void
;
; CHECK-DISABLED-LABEL: define {{[^@]+}}@share
; CHECK-DISABLED-SAME: (ptr nofree [[X:%.*]]) #[[ATTR3:[0-9]+]] {
; CHECK-DISABLED-NEXT:  entry:
; CHECK-DISABLED-NEXT:    store ptr [[X]], ptr @S, align 8
; CHECK-DISABLED-NEXT:    ret void
;
entry:
  store ptr %x, ptr @S
  ret void
}

define void @unused() {
; CHECK-LABEL: define {{[^@]+}}@unused() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DOTH2S:%.*]] = alloca i8, i64 4, align 1
; CHECK-NEXT:    call void @use(ptr undef)
; CHECK-NEXT:    ret void
;
; CHECK-DISABLED-LABEL: define {{[^@]+}}@unused() {
; CHECK-DISABLED-NEXT:  entry:
; CHECK-DISABLED-NEXT:    [[TMP0:%.*]] = call ptr @__kmpc_alloc_shared(i64 4), !dbg [[DBG11:![0-9]+]]
; CHECK-DISABLED-NEXT:    call void @use(ptr [[TMP0]])
; CHECK-DISABLED-NEXT:    call void @__kmpc_free_shared(ptr [[TMP0]], i64 4)
; CHECK-DISABLED-NEXT:    ret void
;
entry:
  %0 = call ptr @__kmpc_alloc_shared(i64 4), !dbg !14
  call void @use(ptr %0)
  call void @__kmpc_free_shared(ptr %0, i64 4)
  ret void
}

define internal void @convert_and_move_alloca() {
; CHECK-LABEL: define {{[^@]+}}@convert_and_move_alloca
; CHECK-SAME: () #[[ATTR1]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DOTH2S:%.*]] = alloca i8, i64 4, align 1
; CHECK-NEXT:    [[IV_PTR:%.*]] = alloca i32, align 4
; CHECK-NEXT:    br label [[INITLOOP:%.*]]
; CHECK:       initloop:
; CHECK-NEXT:    store i32 0, ptr [[IV_PTR]], align 4
; CHECK-NEXT:    br label [[LOOPBODY:%.*]]
; CHECK:       loopbody:
; CHECK-NEXT:    [[IV:%.*]] = load i32, ptr [[IV_PTR]], align 4
; CHECK-NEXT:    [[TMP0:%.*]] = icmp eq i32 [[IV]], 10
; CHECK-NEXT:    br i1 [[TMP0]], label [[EXIT:%.*]], label [[LOOPINC:%.*]]
; CHECK:       loopinc:
; CHECK-NEXT:    [[INC:%.*]] = add i32 [[IV]], 1
; CHECK-NEXT:    store i32 [[INC]], ptr [[IV_PTR]], align 4
; CHECK-NEXT:    br label [[LOOPBODY]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
; CHECK-DISABLED-LABEL: define {{[^@]+}}@convert_and_move_alloca
; CHECK-DISABLED-SAME: () #[[ATTR1]] {
; CHECK-DISABLED-NEXT:  entry:
; CHECK-DISABLED-NEXT:    [[DOTH2S:%.*]] = alloca i8, i64 4, align 1
; CHECK-DISABLED-NEXT:    [[IV_PTR:%.*]] = alloca i32, align 4
; CHECK-DISABLED-NEXT:    br label [[INITLOOP:%.*]]
; CHECK-DISABLED:       initloop:
; CHECK-DISABLED-NEXT:    store i32 0, ptr [[IV_PTR]], align 4
; CHECK-DISABLED-NEXT:    br label [[LOOPBODY:%.*]]
; CHECK-DISABLED:       loopbody:
; CHECK-DISABLED-NEXT:    [[IV:%.*]] = load i32, ptr [[IV_PTR]], align 4
; CHECK-DISABLED-NEXT:    [[TMP0:%.*]] = icmp eq i32 [[IV]], 10
; CHECK-DISABLED-NEXT:    br i1 [[TMP0]], label [[EXIT:%.*]], label [[LOOPINC:%.*]]
; CHECK-DISABLED:       loopinc:
; CHECK-DISABLED-NEXT:    [[INC:%.*]] = add i32 [[IV]], 1
; CHECK-DISABLED-NEXT:    store i32 [[INC]], ptr [[IV_PTR]], align 4
; CHECK-DISABLED-NEXT:    br label [[LOOPBODY]]
; CHECK-DISABLED:       exit:
; CHECK-DISABLED-NEXT:    ret void
;
entry:
  %iv_ptr = alloca i32, align 4
  %ub_ptr = alloca i32, align 4
  store i32 10, ptr %ub_ptr
  br label %initloop

initloop:
  store i32 0, ptr %iv_ptr
  %ub = load i32, ptr %ub_ptr
  br label %loopbody

loopbody:
  %0 = call ptr @__kmpc_alloc_shared(i64 4), !dbg !16
  call void @use(ptr %0)
  call void @__kmpc_free_shared(ptr %0, i64 4)
  %iv = load i32, ptr %iv_ptr
  %1 = icmp eq i32 %iv, %ub
  br i1 %1, label %exit, label %loopinc

loopinc:
  %inc = add i32 %iv, 1
  store i32 %inc, ptr %iv_ptr
  br label %loopbody

exit:
  ret void
}

; CHECK: declare ptr @__kmpc_alloc_shared(i64)
declare ptr @__kmpc_alloc_shared(i64)

; CHECK: declare void @__kmpc_free_shared(ptr allocptr nocapture, i64)
declare void @__kmpc_free_shared(ptr, i64)

declare void @unknown_no_openmp() "llvm.assume"="omp_no_openmp"

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !6, !7}
!nvvm.annotations = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "remove_globalization.c", directory: "/tmp/remove_globalization.c")
!2 = !{}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{ptr @kernel, !"kernel", i32 1}
!6 = !{i32 7, !"openmp", i32 50}
!7 = !{i32 7, !"openmp-device", i32 50}
!8 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 1, type: !11, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !2)
!9 = distinct !DISubprogram(name: "bar", scope: !1, file: !1, line: 1, type: !11, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !2)
!10 = distinct !DISubprogram(name: "unused", scope: !1, file: !1, line: 1, type: !11, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !2)
!11 = !DISubroutineType(types: !2)
!12 = !DILocation(line: 2, column: 2, scope: !8)
!13 = !DILocation(line: 4, column: 2, scope: !9)
!14 = !DILocation(line: 6, column: 2, scope: !9)
!15 = !DILocation(line: 8, column: 2, scope: !9)
!16 = !DILocation(line: 10, column: 2, scope: !9)
;.
; CHECK: attributes #[[ATTR0]] = { nounwind }
; CHECK: attributes #[[ATTR1]] = { nosync nounwind }
; CHECK: attributes #[[ATTR2]] = { nounwind memory(none) }
; CHECK: attributes #[[ATTR3]] = { nofree norecurse nosync nounwind memory(write) }
; CHECK: attributes #[[ATTR4:[0-9]+]] = { nosync nounwind allocsize(0) }
; CHECK: attributes #[[ATTR5:[0-9]+]] = { "llvm.assume"="omp_no_openmp" }
;.
; CHECK-DISABLED: attributes #[[ATTR0]] = { nounwind }
; CHECK-DISABLED: attributes #[[ATTR1]] = { nosync nounwind }
; CHECK-DISABLED: attributes #[[ATTR2]] = { nounwind memory(none) }
; CHECK-DISABLED: attributes #[[ATTR3]] = { nofree norecurse nosync nounwind memory(write) }
; CHECK-DISABLED: attributes #[[ATTR4:[0-9]+]] = { nosync nounwind allocsize(0) }
; CHECK-DISABLED: attributes #[[ATTR5:[0-9]+]] = { "llvm.assume"="omp_no_openmp" }
;.
; CHECK: [[META0:![0-9]+]] = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
; CHECK: [[META1:![0-9]+]] = !DIFile(filename: "remove_globalization.c", directory: "/tmp/remove_globalization.c")
; CHECK: [[META2:![0-9]+]] = !{}
; CHECK: [[META3:![0-9]+]] = !{i32 2, !"Debug Info Version", i32 3}
; CHECK: [[META4:![0-9]+]] = !{i32 1, !"wchar_size", i32 4}
; CHECK: [[META5:![0-9]+]] = !{i32 7, !"openmp", i32 50}
; CHECK: [[META6:![0-9]+]] = !{i32 7, !"openmp-device", i32 50}
; CHECK: [[META7:![0-9]+]] = !{ptr @kernel, !"kernel", i32 1}
; CHECK: [[DBG8]] = !DILocation(line: 4, column: 2, scope: !9)
; CHECK: [[META9:![0-9]+]] = distinct !DISubprogram(name: "bar", scope: !1, file: !1, line: 1, type: !10, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !2)
; CHECK: [[META10:![0-9]+]] = !DISubroutineType(types: !2)
;.
; CHECK-DISABLED: [[META0:![0-9]+]] = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
; CHECK-DISABLED: [[META1:![0-9]+]] = !DIFile(filename: "remove_globalization.c", directory: "/tmp/remove_globalization.c")
; CHECK-DISABLED: [[META2:![0-9]+]] = !{}
; CHECK-DISABLED: [[META3:![0-9]+]] = !{i32 2, !"Debug Info Version", i32 3}
; CHECK-DISABLED: [[META4:![0-9]+]] = !{i32 1, !"wchar_size", i32 4}
; CHECK-DISABLED: [[META5:![0-9]+]] = !{i32 7, !"openmp", i32 50}
; CHECK-DISABLED: [[META6:![0-9]+]] = !{i32 7, !"openmp-device", i32 50}
; CHECK-DISABLED: [[META7:![0-9]+]] = !{ptr @kernel, !"kernel", i32 1}
; CHECK-DISABLED: [[DBG8]] = !DILocation(line: 4, column: 2, scope: !9)
; CHECK-DISABLED: [[META9:![0-9]+]] = distinct !DISubprogram(name: "bar", scope: !1, file: !1, line: 1, type: !10, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !2)
; CHECK-DISABLED: [[META10:![0-9]+]] = !DISubroutineType(types: !2)
; CHECK-DISABLED: [[DBG11]] = !DILocation(line: 6, column: 2, scope: !9)
;.
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK-REMARKS: {{.*}}