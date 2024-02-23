import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns


# Загрузка данных из файла CSV
df = pd.read_csv('players.csv')  # Замените 'players.csv' на путь к вашему файлу CSV

# Группировка данных по странам и подсчет игроков
grouped_data = df['Страна'].value_counts().reset_index()
grouped_data.columns = ['Страна', 'Количество игроков']

# Расчет процентного соотношения игроков по странам
grouped_data['Процент от общего числа'] = (grouped_data['Количество игроков'] / grouped_data['Количество игроков'].sum()) * 100

# Фильтрация данных для категорий с долей менее 1%
less_than_1_percent = grouped_data[grouped_data['Процент от общего числа'] < 1]
filtered_data = grouped_data[grouped_data['Процент от общего числа'] >= 1]

# Создание графика с двумя подграфиками
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(19, 9))

# Круговая диаграмма для категорий с долей >= 1%
ax1.pie(filtered_data['Количество игроков'], labels=filtered_data['Страна'], autopct='%1.1f%%')
ax1.set_aspect('equal')
# ax1.set_title('Распределение игроков по странам')

# Горизонтальная бар-диаграмма для категорий с долей < 1%
if not less_than_1_percent.empty:
    ax2.barh(less_than_1_percent['Страна'], less_than_1_percent['Количество игроков'], color='skyblue')
    ax2.set_xlabel('Количество игроков', fontsize=12)
    ax2.set_yticks(range(len(less_than_1_percent)))
    ax2.set_xticks(range(0, max(less_than_1_percent['Количество игроков']) + 1, 1))  # Устанавливаем деления оси X с шагом 1
    ax2.set_title('Страны с долей < 1%', fontsize=12)

# Фильтрация данных для категорий с долей менее 1% без изменений
less_than_1_percent = grouped_data[grouped_data['Процент от общего числа'] < 1]

# Вывод топ 6
print(grouped_data.head(6))
plt.savefig('output.png')
