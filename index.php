<?php
declare(strict_types = 1);
require_once 'helpers.php';
$cards = [
    [
        'card_id' => 1,
        'title' => 'Цитата',
        'type' => 'post-quote',
        'content' => 'Мы в жизни любим только раз, а после ищем лишь похожих',
        'username' => 'Лариса',
        'avatar' => 'userpic-larisa-small.jpg',
        'created_at' => generate_random_date(1)
    ],
    [
        'card_id' => 2,
        'title' => 'Очарование гор',
        'type' => 'post-text',
        'content' => 'Сложно побывать в горах и в них не влюбиться. Такой вид отдыха очень емкий: всего за неделю можно полностью переключиться, испытать «позитивный стресс», очистить голову и испытать себя. Тот, кто смог взойти на настоящую вершину, будет совсем по-другому смотреть на рабочие неурядицы, работать в группе и подходить к решению задач. Горы приучают к ответственности. При этом, чтобы заняться альпинизмом, каких-то экстраординарных способностей не требуется. Есть два вида восхождений: коммерческие и спортивные. Первые, как правило, не требуют больших усилий: человека почти до вершины подвозят на канатках и ратраках, не нагружают оборудованием и припасами, инструкторы следят за каждым шагом. Спортивное восхождение – другое дело. Здесь уже потребуется выносливость, смекалка и умение работать в команде. Зато и впечатления на порядок сильнее.',
        'username' => 'Владик',
        'avatar' => 'userpic.jpg',
        'created_at' => generate_random_date(2)
    ],
    [
        'card_id' => 3,
        'title' => 'Игра престолов',
        'type' => 'post-text',
        'content' => 'Не могу дождаться начала финального сезона своего любимого сериала!',
        'username' => 'Владик',
        'avatar' => 'userpic.jpg',
        'created_at' => generate_random_date(3)
    ],
    [
        'card_id' => 4,
        'title' => 'Наконец, обработал фотки!',
        'type' => 'post-photo',
        'content' => 'rock-medium.jpg',
        'username' => 'Виктор',
        'avatar' => 'userpic-mark.jpg',
        'created_at' => generate_random_date(4)
    ],
    [
        'card_id' => 5,
        'title' => 'Моя мечта',
        'type' => 'post-photo',
        'content' => 'coast-medium.jpg',
        'username' => 'Лариса',
        'avatar' => 'userpic-larisa-small.jpg',
        'created_at' => generate_random_date(5)
    ],
    [
        'card_id' => 6,
        'title' => 'Лучшие курсы',
        'type' => 'post-link',
        'content' => 'www.htmlacademy.ru',
        'username' => 'Владик',
        'avatar' => 'userpic.jpg',
        'created_at' => generate_random_date(6)
    ],
];

function trimContent(string $content, int $contentLimit = 300): string
{
    $content = trim($content);
    if (mb_strlen($content) <= $contentLimit) {
        return $content;
    }

    $trimmedContentLenchth = 0;
    $contentArray = explode(' ', $content);
    $trimmedContentArray = [];

    foreach ($contentArray as $contentItem) {
        if (($trimmedContentLenchth + mb_strlen($contentItem)) >= $contentLimit){
            break;
        }
        $trimmedContentLenchth += mb_strlen($contentItem) + 1;
        $trimmedContentArray[] = $contentItem;
    }

    return '<p>' . implode(' ', $trimmedContentArray) . '...</p>' . '<a class="post-text__more-link" href="#">Читать далее</a>';
}

function getRelativeData(int $index, $postDate)
{
    $currentDate = (new DateTime())->getTimestamp();
    $postDate = (new DateTime($postDate))->getTimestamp();
    $dateDiff = $currentDate - $postDate;
    $secInMonthes = 60 * 60 * 24 * 7 * 5;
    $secInWeeks = 60 * 60 * 24 * 7;
    $secInDays = 60 * 60 * 24;
    $secInHours = 60 * 60;
    $secInMinutes = 60;
    $res = '';

    if ($dateDiff > $secInMonthes) {
        $monthes = (int) floor($dateDiff / $secInMonthes);
        $res = $monthes . get_noun_plural_form($monthes, ' месяц', ' месяца', ' месяцев');
    } else if ($dateDiff > $secInWeeks){
        $weeks =  (int) floor($dateDiff / $secInWeeks);
        $res = $weeks . get_noun_plural_form($weeks, ' неделя', ' недели', ' недель');
    } else if ($dateDiff > $secInDays){
        $days = (int) floor($dateDiff / $secInDays);
        $res = $days . get_noun_plural_form($days, ' день', ' дня', ' дней');
    } else if ($dateDiff > $secInHours) {
        $hours = (int) floor($dateDiff / $secInHours);
        $res = $hours . get_noun_plural_form($hours, ' час', ' часа', ' часов');
    } else if ($dateDiff > $secInMinutes) {
        $minutes = (int) floor($dateDiff / $secInMinutes);
        $res = $minutes . get_noun_plural_form($minutes, ' минута', ' минуты', ' минут');
    } else {
        $res = $dateDiff . get_noun_plural_form($dateDiff, ' секунда', ' секунды', ' секунд');
    }

    if (!$res) {
        return '';
    }
    return $res . ' назад';

}

$mainContent = include_template('main.php', [
    'cards' => $cards
] );

$allContent = include_template('layout.php', [
    'content' => $mainContent,
    'user_name' => 'Alexander',
    'title' => 'readme: популярное'
] );

print $allContent;
