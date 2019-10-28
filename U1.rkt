#lang sicp
;Exercise 1.2

(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7)))

;Exercise 1.3

(define (two-com x y) (if (> x y) y x))
(define (minimum-num-of-three a b c) (two-com a (two-com b c)))
(define (Top-two-sum a b c) (- (+ a b c) (minimum-num-of-three a b c)))

(Top-two-sum 1 2 3)
(Top-two-sum 2 2 3)
(Top-two-sum 10 2 3)

;Exercise 1.4

(define (a-plus-abs-b a b) ((if (> b 0) + -) a b ))
(a-plus-abs-b 1 -1)

;Exercise 1.5

(define (p) (p))

(define (test x y) (if (= x 0) 0 y))

(test 0 (p))

#|首先,可以确定的是,无论解释器使用的是什么求值方式,调用 (p) 总是进入一个无限循环(infinite loop),因为函数 p 会不断调用自身:
(define (p) (p))
具体到解释器中,执行 (p) 调用会让解释器陷入停滞,最后只能强制将解释器进程杀掉:

1 ]=> (p)
^Z
[1]+  已停止               mit-scheme
$ killall mit-scheme
在应用序中,所有被传入的实际参数都会立即被求值,因此,在使用应用序的解释器里执行 (test 0 (p)) 时,实际参数 0 和 (p) 都会被求值,而对 (p) 的求值将使解释器进入无限循环,因此,如果一个解释器在运行 Ben 的测试时陷入停滞,那么这个解释器使用的是应用序求值模式。

另一方面,在正则序中,传入的实际参数只有在有需要时才会被求值,因此,在使用正则序的解释器里运行 (test 0 (p)) 时, 0 和 (p) 都不会立即被求值,当解释进行到 if 语句时,形式参数 x 的实际参数(也即是 0)会被求值(求值结果也是为 0 ),然后和另一个 0 进行对比((= x 0)),因为对比的值为真(#t),所以 if 返回 0 作为值表达式的值,而这个值又作为 test 函数的值被返回。

因为在正则序求值中,调用 (p) 从始到终都没有被执行,所以也就不会产生无限循环,因此,如果一个解释器在运行 Ben 的测试时顺利返回 0 ,那么这个解释器使用的是正则序求值模式。

|#