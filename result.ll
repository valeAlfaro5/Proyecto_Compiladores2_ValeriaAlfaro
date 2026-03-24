@.str = private constant [4 x i8] c"%d\0A\00"
declare i32 @printf(i8*, ...)

define i64 @suma(i64* %a, i64* %b) {
entry:
%t0 = alloca i64
%t1 = load i64, i64* %a
%t2 = load i64, i64* %b
 %t3 = add i64 %t1, %t2store i64 %t3, i64* %t0

%t4 = load i64, i64* %t0
ret i64 %t4


}

define void @printSuma(i64 %a, i64 %b) {
entry:
%t5 = alloca i64
 %t6 = add i64 %a, %bstore i64 %t6, i64* %t5

%t7 = load i64, i64* %t5
  %t8 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t8, i64 %t7)

ret void


}

define void @testAST() {
entry:
%t9 = alloca i64
store i64 10, i64* %t9

%t10 = alloca i64
store i64 3, i64* %t10

%t11 = alloca i64
store i64 0, i64* %t11

%t12 = load i64, i64* %t9

%t13 = load i64, i64* %t10

%t14 = call i64 @suma(i64 %t12, i64 %t13)
 store i64 %t14, i64* 

%t15 = load i64, i64* %t11
  %t16 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t16, i64 %t15)

%t17 = load i64, i64* %t9

%t18 = load i64, i64* %t10

call void @printSuma(i64 %t17, i64 %t18)

%t19 = load i64, i64* %t9

%t20 = load i64, i64* %t10

  %t21 = getelementptr [4 x i8], [4 x i8]* @.str, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %t21, i64 )

ret void


}

