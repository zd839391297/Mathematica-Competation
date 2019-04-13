# coding=utf-8
'''
贪心算法：局部最优解。
动态规划算法：多目标、多阶段优化。
穷举算法：万能，受问题规模限制。
遗传算法：只是比漫无目的的穷举搜索算法聪明一点点，通过较小的计算量获得较大的收益。
只要能用解析的方法直接得到的最优解问题，都不要试图用遗传算法。
适合-非线性问题。人工智能、自适应控制、机器学习等领域。
不依赖目标函数。
基于概率论，而不是一个确定的搜索过程，即每一次启发式搜索，可能会得出不同的最优解。
可能得到局部最优解或近似最优解。
迭代流程：
初始化种群
种群N代
个体评价
选择
交叉
变异
种群N+1代
1-编码方式：二进制编码（汉明距离）、格雷编码、符号编码、属性序列编码。
2-适应度评估函数（关键点）：
    固定的问题：运算初期早熟问题（未成熟收敛局部最优解），运算后期竞争区分度不高问题(等概率平均搜索)
    自适应的改进：尺度变换：线性、乘方、指数。
种群大小M：32
交叉概率PC：0.8
变异概率PM：0.15
进化代数T：500

用遗传算法解决0-1背包问题。
1-问题的解收敛了，但没有收敛到最优解 - 通过将最优解与实际结果比较，也可以循环100次，取价值最大的解。
2-self.total_fitness = 1 # 每次计算时，先将总数置0,在循环中，会产生全0的现象
     - envaluateFitness中加入防护，如果某个种群全零，则对其进行调整。
3-本例中，循环执行遗传算法24次，得到全局最优解，且结果收敛。
'''
import os
import random
from copy import deepcopy


class GAType():  # 种群32个
    def __init__(self, obj_count):
        self.gene = [0 for x in range(0, obj_count, 1)]   # 序列编码 0 / 1
        self.fitness = 0  # 适应度
        self.cho_feq = 0  # choose 选择概率
        self.cum_feq = 0  # cumulative 累积概率


class genetic():
    def __init__(self, value, weight, max_weight):
        self.value = value
        self.weight = weight
        self.max_weight = max_weight
        self.obj_count = len(weight)
        self._gatype = [GAType(self.obj_count)
                        for x in range(0, population_size, 1)]  # 初始化32个种群
        self.total_fitness = 0

    def avoid_zero(self):
        '''防止遗传的下一代为全零，若为全零，则将随机的位数（1-7）置1'''
        flag = 0
        for i in range(0, population_size, 1):
            res = []
            for j in range(0, self.obj_count, 1):
                res.append(self._gatype[i].gene[j])
            if [0 for x in range(0, self.obj_count, 1)] == res:  # 全零
                # print('找到了全零的状态！')
                flag = 1
                set_one = random.randint(1, self.obj_count)
                for k in range(0, set_one, 1):
                    idx = random.randint(0, self.obj_count-1)
                    self._gatype[i].gene[idx] = 1
                # print(self._gatype[i].gene)
        return True if flag else False

    def initialize(self):
        '''初始化种群'''
        for i in range(0, population_size, 1):
            while (1):  # 保证不全为零
                res = []
                for j in range(0, self.obj_count, 1):
                    self._gatype[i].gene[j] = random.randint(0, 1)
                    res.append(self._gatype[i].gene[j])
                if [0 for x in range(0, self.obj_count, 1)] != res:
                    break

    def envaluateFitness(self):
        '''适应度评估 = 背包内装入物品的总价值，如果超出max_weight，则置1（惩罚性措施）'''
        self.total_fitness = 0  # 每次计算时，先将总数置0
        for i in range(0, population_size, 1):
            max_w = 0
            self._gatype[i].fitness = 0  # 置0后再计算
            for j in range(0, self.obj_count, 1):
                if self._gatype[i].gene[j] == 1:
                    self._gatype[i].fitness += self.value[j]  # 适应度
                    max_w += self.weight[j]  # 最大重量限制
            if max_w > self.max_weight:
                self._gatype[i].fitness = 1  # 惩罚性措施
            if 0 == self._gatype[i].fitness:  # 出现了全零的种群
                self.avoid_zero()
                i = i - 1  # 重新计算该种群的fitness
            else:
                self.total_fitness += self._gatype[i].fitness  # 种群的所有适应度
        if 0 == self.total_fitness:
            print('total_fitness = 0 ')

    def select(self):
        '''采用选择概率和累积概率来做选择，得出下一代种群（个数不变）
        对环境适应度高的个体，后代多，反之后代少，最后只剩下强者'''
        last_cho_feq = 0
        for i in range(0, population_size, 1):
            try:
                self._gatype[i].cho_feq = self._gatype[i].fitness / \
                    float(self.total_fitness)  # 选择概率
            except:
                # print('error', self.total_fitness)
                pass
            self._gatype[i].cum_feq = last_cho_feq + \
                self._gatype[i].cho_feq  # 累积概率
            last_cho_feq = self._gatype[i].cum_feq

        # _next = deepcopy(self._gatype)  # 下一代种群，参与到后续的交叉和变异
        _next = [GAType(self.obj_count) for x in range(0, population_size, 1)]
        for i in range(0, population_size, 1):
            choose_standard = random.randint(1, 100) / 100.0
            # print('choose_standard: %f' % choose_standard)
            if choose_standard < self._gatype[0].cum_feq:  # 选出下一代种群
                _next[i] = self._gatype[0]
            else:
                for j in range(1, population_size, 1):
                    if self._gatype[j-1].cum_feq <= choose_standard < self._gatype[j].cum_feq:
                        _next[i] = self._gatype[j]
        self._gatype = deepcopy(_next)
        self.avoid_zero()  # 全零是不可避免的？？

    def crossover(self):
        '''采用交叉概率p_cross进行控制，从所有种群中，选择出两个种群，进行交叉互换'''
        first = -1
        for i in range(0, population_size, 1):
            choose_standard = random.randint(1, 100) / 100.0
            if choose_standard <= p_cross:  # 选出两个需要交叉的种群
                if first < 0:
                    first = i
                else:
                    self.exchangeOver(first, i)
                    first = -1

    def exchangeOver(self, first, second):
        '''交叉互换'''
        exchange_num = random.randint(1, self.obj_count)  # 需要交换的位置数量
        # print(exchange_num)
        for i in range(0, exchange_num, 1):
            idx = random.randint(0, self.obj_count - 1)
            self._gatype[first].gene[idx], self._gatype[second].gene[idx] = \
                self._gatype[second].gene[idx], self._gatype[first].gene[idx]

    def mutation(self):
        '''随机数小于变异概率时，触发变异'''
        for i in range(0, population_size, 1):
            choose_standard = random.randint(1, 100) / 100.0
            if choose_standard <= p_mutation:  # 选出需要变异的种群
                self.reverseGene(i)

    def reverseGene(self, index):
        '''变异，将0置1，将1置0'''
        reverse_num = random.randint(1, self.obj_count)  # 需要变异的位置数量
        for i in range(0, reverse_num, 1):
            idx = random.randint(0, self.obj_count - 1)
            self._gatype[index].gene[idx] = 1 - self._gatype[index].gene[idx]

    def genetic_result(self):
        cnt = 0
        while (1):
            cnt = cnt + 1
            if cnt > 100:
                break
            self.initialize()
            self.envaluateFitness()
            for i in range(0, max_generations, 1):
                self.select()
                self.crossover()
                self.mutation()
                self.envaluateFitness()
            if True == self.is_optimal_solution(self._gatype, opt_result):
                print('循环的次数为：%d' % cnt)
                break
        self.show_res(self._gatype)

    def is_optimal_solution(self, gatype0, opt_result):
        '''判断是否达到了最优解'''
        for i in range(0, population_size, 1):
            res_list = []
            for j in range(0, self.obj_count, 1):
                res_list.append(gatype0[i].gene[j])
            if opt_result == res_list:
                return True
        return False

    def show_res(self, gatype0):
        '''显示所有种群的取值'''
        res = []
        res_list = []
        for i in range(0, population_size, 1):
            print('种群：%d --- ' % i),
            list0 = []
            for j in range(0, self.obj_count, 1):
                list0.append(gatype0[i].gene[j])
                print(gatype0[i].gene[j]),
            print(' --- 总价值：%d' % gatype0[i].fitness)
            res.append(gatype0[i].fitness)
            res_list.append(list0)
        #
        max_index = 0
        for i in range(0, len(res), 1):
            if res[max_index] < res[i]:
                max_index = i
        weight_all = 0
        for j in range(0, self.obj_count, 1):
            if gatype0[max_index].gene[j] == 1:
                weight_all += self.weight[j]
        print('当前算法的最优解(种群%d):' % max_index),
        print(res_list[max_index]),
        print('总重量（不超过%d）：' % self.max_weight),
        print(weight_all),
        print('总价值：'),
        print(res[max_index])


if __name__ == '__main__':
    weight = [35, 30, 60, 50, 40, 10, 25]
    value = [10, 40, 30, 50, 35, 40, 30]
    max_weight = 150
    # 全局最优解：[1,2,4,6,7] - [35,30,50,10,25] = 150 [10,40,50,40,30] = 170
    opt_result = [1, 1, 0, 1, 0, 1, 1]

    population_size = 32  # 种群
    max_generations = 500  # 进化代数
    p_cross = 0.8  # 交叉概率
    p_mutation = 0.15  # 变异概率

    genetic(value, weight, max_weight).genetic_result()
