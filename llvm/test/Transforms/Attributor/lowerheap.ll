; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -max-heap-to-stack-size=-1 -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=2 -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -max-heap-to-stack-size=-1 -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

declare i64 @subfn(ptr) #0

declare noalias ptr @malloc(i64) allockind("alloc,uninitialized") allocsize(0) "alloc-family"="malloc"
declare noalias ptr @calloc(i64, i64) allockind("alloc,zeroed") allocsize(0,1) "alloc-family"="malloc"
declare void @free(ptr) allockind("free") "alloc-family"="malloc"

define i64 @f(i64 %len) {
; CHECK-LABEL: define {{[^@]+}}@f
; CHECK-SAME: (i64 [[LEN:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MEM_H2S:%.*]] = alloca i8, i64 [[LEN]], align 1
; CHECK-NEXT:    [[RES:%.*]] = call i64 @subfn(ptr [[MEM_H2S]]) #[[ATTR5:[0-9]+]]
; CHECK-NEXT:    ret i64 [[RES]]
;
entry:
  %mem = call ptr @malloc(i64 %len)
  %res = call i64 @subfn(ptr %mem)
  call void @free(ptr %mem)
  ret i64 %res
}


define i64 @g(i64 %len) {
; CHECK-LABEL: define {{[^@]+}}@g
; CHECK-SAME: (i64 [[LEN:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = mul i64 [[LEN]], 8
; CHECK-NEXT:    [[MEM_H2S:%.*]] = alloca i8, i64 [[TMP0]], align 1
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr [[MEM_H2S]], i8 0, i64 [[TMP0]], i1 false)
; CHECK-NEXT:    [[RES:%.*]] = call i64 @subfn(ptr [[MEM_H2S]]) #[[ATTR5]]
; CHECK-NEXT:    ret i64 [[RES]]
;
entry:
  %mem = call ptr @calloc(i64 %len, i64 8)
  %res = call i64 @subfn(ptr %mem)
  call void @free(ptr %mem)
  ret i64 %res
}

attributes #0 = { nounwind willreturn }
;.
; CHECK: attributes #[[ATTR0:[0-9]+]] = { nounwind willreturn }
; CHECK: attributes #[[ATTR1:[0-9]+]] = { allockind("alloc,uninitialized") allocsize(0) "alloc-family"="malloc" }
; CHECK: attributes #[[ATTR2:[0-9]+]] = { allockind("alloc,zeroed") allocsize(0,1) "alloc-family"="malloc" }
; CHECK: attributes #[[ATTR3:[0-9]+]] = { allockind("free") "alloc-family"="malloc" }
; CHECK: attributes #[[ATTR4:[0-9]+]] = { nocallback nofree nounwind willreturn memory(argmem: write) }
; CHECK: attributes #[[ATTR5]] = { nounwind }
;.
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CGSCC: {{.*}}
; TUNIT: {{.*}}