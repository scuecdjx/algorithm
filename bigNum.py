#-*- coding:utf-8 -*-
'''
样例输入
123456489798421654164-351515645132
'''

def brk(s1):#拆分字符串
    s = ''
    ss = ''
    s2 = list(s1)
    for q in s1:
        if q == '-':
            break
        s += q
    for p in s2:
        temp = s2.pop()
        if temp == '-':
            break
        ss = temp + ss
    return s, ss


def minus(m, n):#两个数相减后转化为str
    t = m - n
    return str(m - n)


def solve(a, b):#两个字符串相减，结果返回字符串
    i = 1
    j = 1
    result = '' #存放结果
    aa = list(map(int, list(a)))
    bb = list(map(int, list(b)))
    while i <= len(bb):
        if aa[-j] >= bb[-i]:
            c = minus(aa[-j], bb[-i])
            result = c + result
        else:
            c = minus(aa[-j] + 10, bb[-i])
            aa[-j - 1] = (aa[-j - 1]) - 1
            result = c + result
        if len(a) == len(b) and i == len(b):  #借位有问题
            result = result.strip('0')
        i += 1
        j += 1
    while j <= len(aa):
        result = str(aa[-j]) + result
        j += 1
    return result

str1 = input()
big, small = brk(str1)
print(solve(big, small))
