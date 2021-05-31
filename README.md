# TWS_Calendar
The World Standardの予定が入っているGoogle Calendarからイベントの情報を取得し、
当日の予定、全ての予定を表示するアプリ。

## Dependency
Swift: 5.4
FSCalendar: 2.8.2

## Usage
![TWS_Calendar-TopView](https://user-images.githubusercontent.com/35756201/120194072-15961500-c258-11eb-8394-e609337d46f2.png)
トップ画面ではアプリを開いた当日の予定を確認することができます。

![TWS_Calendar-TopView](https://user-images.githubusercontent.com/35756201/120194107-25adf480-c258-11eb-9df0-2cb96b1c51d4.png)
画面下部にあるTabBarの左側（Calendar）をタップすることで
全ての予定が表示されるカレンダー画面へと画面を切り替えます。

![TWS_Calendar-CalendarEventView](https://user-images.githubusercontent.com/35756201/120194131-30688980-c258-11eb-84d2-d21bf278f234.png)
![TWS_Calendar-EventDetailsView](https://user-images.githubusercontent.com/35756201/120194171-3cece200-c258-11eb-99db-43807e81c339.png)
カレンダー画面では予定のある日には下に点がついており、その日をタップすると
下からイベントのタイトル、詳細を見ることができるカードを表示します。
カードは予定のない日をタップすることで非表示へと変わります。
