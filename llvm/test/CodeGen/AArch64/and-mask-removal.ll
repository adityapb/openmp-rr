; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-apple-darwin -aarch64-enable-collect-loh=false < %s  | FileCheck %s --check-prefixes=CHECK,CHECK-SD
; RUN: llc -mtriple=aarch64-apple-darwin -aarch64-enable-collect-loh=false -global-isel < %s  | FileCheck %s --check-prefixes=CHECK,CHECK-GI

@board = common global [400 x i8] zeroinitializer, align 1
@next_string = common global i32 0, align 4
@string_number = common global [400 x i32] zeroinitializer, align 4

; Function Attrs: nounwind ssp
define void @new_position(i32 %pos) {
; CHECK-SD-LABEL: new_position:
; CHECK-SD:       ; %bb.0: ; %entry
; CHECK-SD-NEXT:    adrp x9, _board@GOTPAGE
; CHECK-SD-NEXT:    ; kill: def $w0 killed $w0 def $x0
; CHECK-SD-NEXT:    sxtw x8, w0
; CHECK-SD-NEXT:    ldr x9, [x9, _board@GOTPAGEOFF]
; CHECK-SD-NEXT:    ldrb w9, [x9, x8]
; CHECK-SD-NEXT:    sub w9, w9, #1
; CHECK-SD-NEXT:    cmp w9, #1
; CHECK-SD-NEXT:    b.hi LBB0_2
; CHECK-SD-NEXT:  ; %bb.1: ; %if.then
; CHECK-SD-NEXT:    adrp x9, _next_string@GOTPAGE
; CHECK-SD-NEXT:    adrp x10, _string_number@GOTPAGE
; CHECK-SD-NEXT:    ldr x9, [x9, _next_string@GOTPAGEOFF]
; CHECK-SD-NEXT:    ldr w9, [x9]
; CHECK-SD-NEXT:    ldr x10, [x10, _string_number@GOTPAGEOFF]
; CHECK-SD-NEXT:    str w9, [x10, x8, lsl #2]
; CHECK-SD-NEXT:  LBB0_2: ; %if.end
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: new_position:
; CHECK-GI:       ; %bb.0: ; %entry
; CHECK-GI-NEXT:    adrp x8, _board@GOTPAGE
; CHECK-GI-NEXT:    ldr x8, [x8, _board@GOTPAGEOFF]
; CHECK-GI-NEXT:    ldrb w8, [x8, w0, sxtw]
; CHECK-GI-NEXT:    sub w8, w8, #1
; CHECK-GI-NEXT:    cmp w8, #2
; CHECK-GI-NEXT:    b.hs LBB0_2
; CHECK-GI-NEXT:  ; %bb.1: ; %if.then
; CHECK-GI-NEXT:    adrp x8, _next_string@GOTPAGE
; CHECK-GI-NEXT:    adrp x9, _string_number@GOTPAGE
; CHECK-GI-NEXT:    ldr x8, [x8, _next_string@GOTPAGEOFF]
; CHECK-GI-NEXT:    ldr w8, [x8]
; CHECK-GI-NEXT:    ldr x9, [x9, _string_number@GOTPAGEOFF]
; CHECK-GI-NEXT:    str w8, [x9, w0, sxtw #2]
; CHECK-GI-NEXT:  LBB0_2: ; %if.end
; CHECK-GI-NEXT:    ret
entry:
  %idxprom = sext i32 %pos to i64
  %arrayidx = getelementptr inbounds [400 x i8], ptr @board, i64 0, i64 %idxprom
  %tmp = load i8, ptr %arrayidx, align 1
  %.off = add i8 %tmp, -1
  %switch = icmp ult i8 %.off, 2
  br i1 %switch, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %tmp1 = load i32, ptr @next_string, align 4
  %arrayidx8 = getelementptr inbounds [400 x i32], ptr @string_number, i64 0, i64 %idxprom
  store i32 %tmp1, ptr %arrayidx8, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

define zeroext i1 @test8_0(i8 zeroext %x)  align 2 {
; CHECK-LABEL: test8_0:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    add w8, w0, #74
; CHECK-NEXT:    and w8, w8, #0xff
; CHECK-NEXT:    cmp w8, #236
; CHECK-NEXT:    cset w0, lo
; CHECK-NEXT:    ret
entry:
  %0 = add i8 %x, 74
  %1 = icmp ult i8 %0, -20
  br i1 %1, label %ret_true, label %ret_false
ret_false:
  ret i1 false
ret_true:
  ret i1 true
}

define zeroext i1 @test8_1(i8 zeroext %x)  align 2 {
; CHECK-SD-LABEL: test8_1:
; CHECK-SD:       ; %bb.0: ; %entry
; CHECK-SD-NEXT:    sub w8, w0, #10
; CHECK-SD-NEXT:    cmp w8, #89
; CHECK-SD-NEXT:    cset w0, hi
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test8_1:
; CHECK-GI:       ; %bb.0: ; %entry
; CHECK-GI-NEXT:    sub w8, w0, #10
; CHECK-GI-NEXT:    cmp w8, #90
; CHECK-GI-NEXT:    cset w0, hs
; CHECK-GI-NEXT:    ret
entry:
  %0 = add i8 %x, 246
  %1 = icmp uge i8 %0, 90
  br i1 %1, label %ret_true, label %ret_false
ret_false:
  ret i1 false
ret_true:
  ret i1 true
}

define zeroext i1 @test8_2(i8 zeroext %x)  align 2 {
; CHECK-SD-LABEL: test8_2:
; CHECK-SD:       ; %bb.0: ; %entry
; CHECK-SD-NEXT:    cmp w0, #208
; CHECK-SD-NEXT:    cset w0, ne
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test8_2:
; CHECK-GI:       ; %bb.0: ; %entry
; CHECK-GI-NEXT:    sub w8, w0, #29
; CHECK-GI-NEXT:    and w8, w8, #0xff
; CHECK-GI-NEXT:    cmp w8, #179
; CHECK-GI-NEXT:    cset w0, ne
; CHECK-GI-NEXT:    ret
entry:
  %0 = add i8 %x, 227
  %1 = icmp ne i8 %0, 179
  br i1 %1, label %ret_true, label %ret_false
ret_false:
  ret i1 false
ret_true:
  ret i1 true
}

define zeroext i1 @test8_3(i8 zeroext %x)  align 2 {
; CHECK-SD-LABEL: test8_3:
; CHECK-SD:       ; %bb.0: ; %entry
; CHECK-SD-NEXT:    cmp w0, #209
; CHECK-SD-NEXT:    cset w0, eq
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test8_3:
; CHECK-GI:       ; %bb.0: ; %entry
; CHECK-GI-NEXT:    sub w8, w0, #55
; CHECK-GI-NEXT:    and w8, w8, #0xff
; CHECK-GI-NEXT:    cmp w8, #154
; CHECK-GI-NEXT:    cset w0, eq
; CHECK-GI-NEXT:    ret
entry:
  %0 = add i8 %x, 201
  %1 = icmp eq i8 %0, 154
  br i1 %1, label %ret_true, label %ret_false
ret_false:
  ret i1 false
ret_true:
  ret i1 true
}

define zeroext i1 @test8_4(i8 zeroext %x)  align 2 {
; CHECK-SD-LABEL: test8_4:
; CHECK-SD:       ; %bb.0: ; %entry
; CHECK-SD-NEXT:    cmp w0, #39
; CHECK-SD-NEXT:    cset w0, ne
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test8_4:
; CHECK-GI:       ; %bb.0: ; %entry
; CHECK-GI-NEXT:    sub w8, w0, #79
; CHECK-GI-NEXT:    and w8, w8, #0xff
; CHECK-GI-NEXT:    cmp w8, #216
; CHECK-GI-NEXT:    cset w0, ne
; CHECK-GI-NEXT:    ret
entry:
  %0 = add i8 %x, -79
  %1 = icmp ne i8 %0, -40
  br i1 %1, label %ret_true, label %ret_false
ret_false:
  ret i1 false
ret_true:
  ret i1 true
}

define zeroext i1 @test8_5(i8 zeroext %x)  align 2 {
; CHECK-SD-LABEL: test8_5:
; CHECK-SD:       ; %bb.0: ; %entry
; CHECK-SD-NEXT:    sub w8, w0, #123
; CHECK-SD-NEXT:    cmn w8, #106
; CHECK-SD-NEXT:    cset w0, hi
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test8_5:
; CHECK-GI:       ; %bb.0: ; %entry
; CHECK-GI-NEXT:    sub w8, w0, #123
; CHECK-GI-NEXT:    cmn w8, #105
; CHECK-GI-NEXT:    cset w0, hs
; CHECK-GI-NEXT:    ret
entry:
  %0 = add i8 %x, 133
  %1 = icmp uge i8 %0, -105
  br i1 %1, label %ret_true, label %ret_false
ret_false:
  ret i1 false
ret_true:
  ret i1 true
}

define zeroext i1 @test8_6(i8 zeroext %x)  align 2 {
; CHECK-SD-LABEL: test8_6:
; CHECK-SD:       ; %bb.0: ; %entry
; CHECK-SD-NEXT:    sub w8, w0, #58
; CHECK-SD-NEXT:    cmp w8, #154
; CHECK-SD-NEXT:    cset w0, hi
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test8_6:
; CHECK-GI:       ; %bb.0: ; %entry
; CHECK-GI-NEXT:    sub w8, w0, #58
; CHECK-GI-NEXT:    cmp w8, #155
; CHECK-GI-NEXT:    cset w0, hs
; CHECK-GI-NEXT:    ret
entry:
  %0 = add i8 %x, -58
  %1 = icmp uge i8 %0, 155
  br i1 %1, label %ret_true, label %ret_false
ret_false:
  ret i1 false
ret_true:
  ret i1 true
}

define zeroext i1 @test8_7(i8 zeroext %x)  align 2 {
; CHECK-LABEL: test8_7:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    sub w8, w0, #31
; CHECK-NEXT:    cmp w8, #124
; CHECK-NEXT:    cset w0, lo
; CHECK-NEXT:    ret
entry:
  %0 = add i8 %x, 225
  %1 = icmp ult i8 %0, 124
  br i1 %1, label %ret_true, label %ret_false
ret_false:
  ret i1 false
ret_true:
  ret i1 true
}



define zeroext i1 @test8_8(i8 zeroext %x)  align 2 {
; CHECK-SD-LABEL: test8_8:
; CHECK-SD:       ; %bb.0: ; %entry
; CHECK-SD-NEXT:    cmp w0, #66
; CHECK-SD-NEXT:    cset w0, ne
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test8_8:
; CHECK-GI:       ; %bb.0: ; %entry
; CHECK-GI-NEXT:    sub w8, w0, #66
; CHECK-GI-NEXT:    cmp w8, #1
; CHECK-GI-NEXT:    cset w0, hs
; CHECK-GI-NEXT:    ret
entry:
  %0 = add i8 %x, 190
  %1 = icmp uge i8 %0, 1
  br i1 %1, label %ret_true, label %ret_false
ret_false:
  ret i1 false
ret_true:
  ret i1 true
}

define zeroext i1 @test16_0(i16 zeroext %x)  align 2 {
; CHECK-SD-LABEL: test16_0:
; CHECK-SD:       ; %bb.0: ; %entry
; CHECK-SD-NEXT:    mov w8, #5086
; CHECK-SD-NEXT:    cmp w0, w8
; CHECK-SD-NEXT:    cset w0, ne
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test16_0:
; CHECK-GI:       ; %bb.0: ; %entry
; CHECK-GI-NEXT:    mov w8, #18547
; CHECK-GI-NEXT:    mov w9, #23633
; CHECK-GI-NEXT:    add w8, w0, w8
; CHECK-GI-NEXT:    cmp w9, w8, uxth
; CHECK-GI-NEXT:    cset w0, ne
; CHECK-GI-NEXT:    ret
entry:
  %0 = add i16 %x, -46989
  %1 = icmp ne i16 %0, -41903
  br i1 %1, label %ret_true, label %ret_false
ret_false:
  ret i1 false
ret_true:
  ret i1 true
}

define zeroext i1 @test16_2(i16 zeroext %x)  align 2 {
; CHECK-SD-LABEL: test16_2:
; CHECK-SD:       ; %bb.0: ; %entry
; CHECK-SD-NEXT:    mov w8, #16882
; CHECK-SD-NEXT:    mov w9, #40700
; CHECK-SD-NEXT:    add w8, w0, w8
; CHECK-SD-NEXT:    cmp w9, w8, uxth
; CHECK-SD-NEXT:    cset w0, hi
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test16_2:
; CHECK-GI:       ; %bb.0: ; %entry
; CHECK-GI-NEXT:    mov w8, #16882
; CHECK-GI-NEXT:    mov w9, #40699
; CHECK-GI-NEXT:    add w8, w0, w8
; CHECK-GI-NEXT:    cmp w9, w8, uxth
; CHECK-GI-NEXT:    cset w0, hs
; CHECK-GI-NEXT:    ret
entry:
  %0 = add i16 %x, 16882
  %1 = icmp ule i16 %0, -24837
  br i1 %1, label %ret_true, label %ret_false
ret_false:
  ret i1 false
ret_true:
  ret i1 true
}

define zeroext i1 @test16_3(i16 zeroext %x)  align 2 {
; CHECK-SD-LABEL: test16_3:
; CHECK-SD:       ; %bb.0: ; %entry
; CHECK-SD-NEXT:    mov w8, #53200
; CHECK-SD-NEXT:    cmp w0, w8
; CHECK-SD-NEXT:    cset w0, ne
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test16_3:
; CHECK-GI:       ; %bb.0: ; %entry
; CHECK-GI-NEXT:    mov w8, #29283
; CHECK-GI-NEXT:    mov w9, #16947
; CHECK-GI-NEXT:    add w8, w0, w8
; CHECK-GI-NEXT:    cmp w9, w8, uxth
; CHECK-GI-NEXT:    cset w0, ne
; CHECK-GI-NEXT:    ret
entry:
  %0 = add i16 %x, 29283
  %1 = icmp ne i16 %0, 16947
  br i1 %1, label %ret_true, label %ret_false
ret_false:
  ret i1 false
ret_true:
  ret i1 true
}

define zeroext i1 @test16_4(i16 zeroext %x)  align 2 {
; CHECK-SD-LABEL: test16_4:
; CHECK-SD:       ; %bb.0: ; %entry
; CHECK-SD-NEXT:    mov w8, #29985
; CHECK-SD-NEXT:    mov w9, #15676
; CHECK-SD-NEXT:    add w8, w0, w8
; CHECK-SD-NEXT:    cmp w9, w8, uxth
; CHECK-SD-NEXT:    cset w0, lo
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test16_4:
; CHECK-GI:       ; %bb.0: ; %entry
; CHECK-GI-NEXT:    mov w8, #29985
; CHECK-GI-NEXT:    mov w9, #15677
; CHECK-GI-NEXT:    add w8, w0, w8
; CHECK-GI-NEXT:    cmp w9, w8, uxth
; CHECK-GI-NEXT:    cset w0, ls
; CHECK-GI-NEXT:    ret
entry:
  %0 = add i16 %x, -35551
  %1 = icmp uge i16 %0, 15677
  br i1 %1, label %ret_true, label %ret_false
ret_false:
  ret i1 false
ret_true:
  ret i1 true
}

define zeroext i1 @test16_5(i16 zeroext %x)  align 2 {
; CHECK-SD-LABEL: test16_5:
; CHECK-SD:       ; %bb.0: ; %entry
; CHECK-SD-NEXT:    mov w8, #23282
; CHECK-SD-NEXT:    cmp w0, w8
; CHECK-SD-NEXT:    cset w0, ne
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test16_5:
; CHECK-GI:       ; %bb.0: ; %entry
; CHECK-GI-NEXT:    mov w8, #-25214
; CHECK-GI-NEXT:    mov w9, #63604
; CHECK-GI-NEXT:    add w8, w0, w8
; CHECK-GI-NEXT:    cmp w9, w8, uxth
; CHECK-GI-NEXT:    cset w0, ne
; CHECK-GI-NEXT:    ret
entry:
  %0 = add i16 %x, -25214
  %1 = icmp ne i16 %0, -1932
  br i1 %1, label %ret_true, label %ret_false
ret_false:
  ret i1 false
ret_true:
  ret i1 true
}

define zeroext i1 @test16_6(i16 zeroext %x)  align 2 {
; CHECK-SD-LABEL: test16_6:
; CHECK-SD:       ; %bb.0: ; %entry
; CHECK-SD-NEXT:    mov w8, #-32194
; CHECK-SD-NEXT:    mov w9, #24320
; CHECK-SD-NEXT:    add w8, w0, w8
; CHECK-SD-NEXT:    cmp w8, w9
; CHECK-SD-NEXT:    cset w0, hi
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test16_6:
; CHECK-GI:       ; %bb.0: ; %entry
; CHECK-GI-NEXT:    mov w8, #-32194
; CHECK-GI-NEXT:    mov w9, #24321
; CHECK-GI-NEXT:    add w8, w0, w8
; CHECK-GI-NEXT:    cmp w8, w9
; CHECK-GI-NEXT:    cset w0, hs
; CHECK-GI-NEXT:    ret
entry:
  %0 = add i16 %x, -32194
  %1 = icmp uge i16 %0, -41215
  br i1 %1, label %ret_true, label %ret_false
ret_false:
  ret i1 false
ret_true:
  ret i1 true
}

define zeroext i1 @test16_7(i16 zeroext %x)  align 2 {
; CHECK-SD-LABEL: test16_7:
; CHECK-SD:       ; %bb.0: ; %entry
; CHECK-SD-NEXT:    mov w8, #9272
; CHECK-SD-NEXT:    mov w9, #22619
; CHECK-SD-NEXT:    add w8, w0, w8
; CHECK-SD-NEXT:    cmp w9, w8, uxth
; CHECK-SD-NEXT:    cset w0, lo
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test16_7:
; CHECK-GI:       ; %bb.0: ; %entry
; CHECK-GI-NEXT:    mov w8, #9272
; CHECK-GI-NEXT:    mov w9, #22620
; CHECK-GI-NEXT:    add w8, w0, w8
; CHECK-GI-NEXT:    cmp w9, w8, uxth
; CHECK-GI-NEXT:    cset w0, ls
; CHECK-GI-NEXT:    ret
entry:
  %0 = add i16 %x, 9272
  %1 = icmp uge i16 %0, -42916
  br i1 %1, label %ret_true, label %ret_false
ret_false:
  ret i1 false
ret_true:
  ret i1 true
}

define zeroext i1 @test16_8(i16 zeroext %x)  align 2 {
; CHECK-SD-LABEL: test16_8:
; CHECK-SD:       ; %bb.0: ; %entry
; CHECK-SD-NEXT:    mov w8, #4919
; CHECK-SD-NEXT:    cmp w0, w8
; CHECK-SD-NEXT:    cset w0, ne
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test16_8:
; CHECK-GI:       ; %bb.0: ; %entry
; CHECK-GI-NEXT:    add w8, w0, #1787
; CHECK-GI-NEXT:    mov w9, #6706
; CHECK-GI-NEXT:    cmp w9, w8, uxth
; CHECK-GI-NEXT:    cset w0, ne
; CHECK-GI-NEXT:    ret
entry:
  %0 = add i16 %x, -63749
  %1 = icmp ne i16 %0, 6706
  br i1 %1, label %ret_true, label %ret_false
ret_false:
  ret i1 false
ret_true:
  ret i1 true
}

define i64 @pr58109(i8 signext %0) {
; CHECK-SD-LABEL: pr58109:
; CHECK-SD:       ; %bb.0:
; CHECK-SD-NEXT:    add w8, w0, #1
; CHECK-SD-NEXT:    and w8, w8, #0xff
; CHECK-SD-NEXT:    subs w8, w8, #1
; CHECK-SD-NEXT:    csel w0, wzr, w8, lo
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: pr58109:
; CHECK-GI:       ; %bb.0:
; CHECK-GI-NEXT:    add w8, w0, #1
; CHECK-GI-NEXT:    and w8, w8, #0xff
; CHECK-GI-NEXT:    sub w8, w8, #1
; CHECK-GI-NEXT:    cmp w8, w8, uxtb
; CHECK-GI-NEXT:    csel w8, wzr, w8, ne
; CHECK-GI-NEXT:    and x0, x8, #0xff
; CHECK-GI-NEXT:    ret
  %2 = add i8 %0, 1
  %3 = call i8 @llvm.usub.sat.i8(i8 %2, i8 1)
  %4 = zext i8 %3 to i64
  ret i64 %4
}

define i64 @pr58109b(i8 signext %0, i64 %a, i64 %b) {
; CHECK-SD-LABEL: pr58109b:
; CHECK-SD:       ; %bb.0:
; CHECK-SD-NEXT:    add w8, w0, #1
; CHECK-SD-NEXT:    cmp w8, #2
; CHECK-SD-NEXT:    csel x0, x1, x2, lo
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: pr58109b:
; CHECK-GI:       ; %bb.0:
; CHECK-GI-NEXT:    add w8, w0, #1
; CHECK-GI-NEXT:    and w8, w8, #0xff
; CHECK-GI-NEXT:    cmp w8, #2
; CHECK-GI-NEXT:    csel x0, x1, x2, lo
; CHECK-GI-NEXT:    ret
  %2 = add i8 %0, 1
  %3 = icmp ult i8 %2, 2
  %4 = select i1 %3, i64 %a, i64 %b
  ret i64 %4
}

declare i8 @llvm.usub.sat.i8(i8, i8) #0