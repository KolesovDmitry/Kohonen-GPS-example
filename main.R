library('kohonen')

# Читаем точки
points = read.table('9641.csv', sep=',', header=T)

points = points[c('x', 'y')]

# Выводим на график в порядке прочтения
plot(points, main="Initial state")
lines(points)

# Сколько точек
N = dim(points)[1]

# Обучаем в два приема
points.sc = scale(points)
points.som <- som(data = points.sc, grid = somgrid(1, N, "rectangular"), rlen=10000)
codes = points.som$codes
points.som <- som(data = points.sc, grid = somgrid(1, N, "rectangular"), rlen=100000, init=codes)

# Собираем резульат, выводим на экран. Position - номер точки в линии.
# Часть точек не упорядочилась (у них одинаковые position в конечной таблице)
# Такие точки нужно дообработать (попробовать поменять местами друг с другом)
# эту дообработку в питоновском плагине делал модуль tuning
res = data.frame(x=points$x, y=points$y, position=points.som$unit.classif)
res <- res[order(res$position),]
print(res)
write.csv(res, 'result.csv')

# График упорядоченных точек
plot(res$x, res$y, main='Result')
lines(res$x, res$y)

