@.str = private constant [4 x i8] c"%d\0A\00"
declare i32 @printf(i8*, ...)

define i64 @suma(i64  %a, i64  %b) {
entry:
%t0 = alloca i64
 %t3 = add i64 %a, %b store i64 %t3, i64* %t0

ret i64 %t0


}

define i64 @esMayor(i64  %a, i64  %b) {
entry:
%t5 = alloca i64
 %t8 = icmp sgt i64 %a, %b store i64 %t8, i64* %t5

ret i64 %t5


}

define void @printSuma(i64  %a, i64  %b) {
entry:
%t10 = alloca i64
 %t13 = add i64 %a, %b store i64 %t13, i64* %t10

  %t15 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t15, i64 %t10)

ret void


}

define void @testAST() {
entry:
%t16 = alloca i64
 store i64 10, i64* %t16

%t17 = alloca i64
 store i64 3, i64* %t17

%t18 = alloca i64
 store i64 0, i64* %t18

 %t21 = add i64 %t16, %t17 store i64 %t21, i64* %t18

  %t23 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t23, i64 %t18)

 %t26 = sub i64 %t16, %t17 store i64 %t26, i64* %t18

  %t28 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t28, i64 %t18)

 %t31 = mul i64 %t16, %t17 store i64 %t31, i64* %t18

  %t33 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t33, i64 %t18)

 %t36 = sdiv i64 %t16, %t17 store i64 %t36, i64* %t18

  %t38 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t38, i64 %t18)

 %t41 = srem i64 %t16, %t17 store i64 %t41, i64* %t18

  %t43 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t43, i64 %t18)

 %t46 = icmp eq i64 %t16, %t17
  %t48 = zext i1 %t46 to i64
  %t47 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t47, i64 %t48)

 %t51 = icmp ne i64 %t16, %t17
  %t53 = zext i1 %t51 to i64
  %t52 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t52, i64 %t53)

 %t56 = icmp slt i64 %t16, %t17  %t58 = zext i1 %t56 to i64
  %t57 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t57, i64 %t58)

 %t61 = icmp sle i64 %t16, %t17  %t63 = zext i1 %t61 to i64
  %t62 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t62, i64 %t63)

 %t66 = icmp sgt i64 %t16, %t17  %t68 = zext i1 %t66 to i64
  %t67 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t67, i64 %t68)

 %t71 = icmp sge i64 %t16, %t17  %t73 = zext i1 %t71 to i64
  %t72 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t72, i64 %t73)

 %t76 = icmp sgt i64 %t16, %t17 %t78 = icmp sgt i64 %t17, 0 %t79 = and i1 %t76, %t78
  %t81 = zext i1 %t79 to i64
  %t80 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t80, i64 %t81)

 %t84 = icmp slt i64 %t16, %t17 %t86 = icmp sgt i64 %t17, 0 %t87 = or i1 %t84, %t86
  %t89 = zext i1 %t87 to i64
  %t88 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t88, i64 %t89)

 %t92 = icmp eq i64 %t16, %t17
  %t93 = xor i1 %t92, true
  %t95 = zext i1 %t93 to i64
  %t94 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t94, i64 %t95)

 %t98 = icmp sgt i64 %t16, %t17br i1 %t98, label %L0, label %L1
L0: 
  %t100 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t100, i64 %t16)

br label %L2
L1: 
  %t102 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t102, i64 %t17)

br label %L2
L2: 

%t103 = alloca i64
 store i64 0, i64* %t103

br label %L3
L3: 
 %t105 = icmp slt i64 %t103, 5br i1 %t105, label %L4, label %L5
L4: 
  %t107 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t107, i64 %t103)

 %t109 = add i64 %t103, 1 store i64 %t109, i64* %t103

br label %L3
L5: 



 store i64 , i64* %t18

  %t113 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t113, i64 %t18)






  %t118 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t118, i64 )

ret void


}

