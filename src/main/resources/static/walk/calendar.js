// ================================
// START YOUR APP HERE
// ================================
const init = {
  monList: [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ],
  dayList: [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ],
  today: new Date(),
  monForChange: new Date().getMonth(),
  activeDate: new Date(),
  getFirstDay: (yy, mm) => new Date(yy, mm, 1),
  getLastDay: (yy, mm) => new Date(yy, mm + 1, 0),
  nextMonth: function () {
    let d = new Date();
    d.setDate(1);
    d.setMonth(++this.monForChange);
    this.activeDate = d;
    return d;
  },
  prevMonth: function () {
    let d = new Date();
    d.setDate(1);
    d.setMonth(--this.monForChange);
    this.activeDate = d;
    return d;
  },
  addZero: (num) => (num < 10 ? "0" + num : num),
  activeDTag: null,
  getIndex: function (node) {
    let index = 0;
    while ((node = node.previousElementSibling)) {
      index++;
    }
    return index;
  },
};

const $calBody = document.querySelector(".cal-body");
const $btnNext = document.querySelector(".btn-cal.next");
const $btnPrev = document.querySelector(".btn-cal.prev");

/**
 * @param {number} date
 * @param {number} dayIn
 */
function loadDate(date, dayIn) {
  document.querySelector(".cal-date").textContent = date;
  document.querySelector(".cal-day").textContent = init.dayList[dayIn];
}

function loadDate2(year, month, date) {
  alert(year);
  alert(month);
  alert(date);
}

/**
 * @param {date} fullDate
 */
function loadYYMM(fullDate) {
  let yy = fullDate.getFullYear();
  let mm = fullDate.getMonth();
  let firstDay = init.getFirstDay(yy, mm);
  let lastDay = init.getLastDay(yy, mm);
  let markToday; // for marking today date

  if (mm === init.today.getMonth() && yy === init.today.getFullYear()) {
    markToday = init.today.getDate();
  }

  document.querySelector(".cal-month").textContent = init.monList[mm];
  document.querySelector(".cal-year").textContent = yy;

  let trtd = "";
  let startCount;
  let countDay = 0;

  for (let i = 0; i < 6; i++) {
    trtd += "<tr>";
    for (let j = 0; j < 7; j++) {
      if (i === 0 && !startCount && j === firstDay.getDay()) {
        startCount = 1;
      }
      if (!startCount) {
        trtd += "<td>";
      } else {
        let fullDate =
          yy + "-" + init.addZero(mm + 1) + "-" + init.addZero(countDay + 1);
        trtd += '<td class="day';
        trtd += markToday && markToday === countDay + 1 ? ' today" ' : '"';
        trtd += ` data-date="${countDay + 1}" data-fdate="${fullDate}">`;
      }
      trtd += startCount ? ++countDay : "";
      if (countDay === lastDay.getDate()) {
        startCount = 0;
      }
      trtd += "</td>";
    }
    trtd += "</tr>";
  }
  $calBody.innerHTML = trtd;
}

/**
 * @param {string} val
 */
function createNewList(val) {
  let id = new Date().getTime() + "";
  let yy = init.activeDate.getFullYear();
  let mm = init.activeDate.getMonth() + 1;
  let dd = init.activeDate.getDate();
  const $target = $calBody.querySelector(`.day[data-date="${dd}"]`);

  let date = yy + "." + init.addZero(mm) + "." + init.addZero(dd);
  alert(date);

  let eventData = {};
  eventData["date"] = date;
  eventData["memo"] = val;
  eventData["complete"] = false;
  eventData["id"] = id;
  init.event.push(eventData);
  $todoList.appendChild(createLi(id, val, date));
}

loadYYMM(init.today);
loadDate(init.today.getDate(), init.today.getDay());

$btnNext.addEventListener("click", () => loadYYMM(init.nextMonth()));
$btnPrev.addEventListener("click", () => loadYYMM(init.prevMonth()));

$calBody.addEventListener("click", (e) => {
  if (e.target.classList.contains("day")) {
    if (init.activeDTag) {
      init.activeDTag.classList.remove("day-active");
    }
    let day = Number(e.target.textContent);
    loadDate(day, e.target.cellIndex);
    e.target.classList.add("day-active");
    init.activeDTag = e.target;
    init.activeDate.setDate(day);
    reloadTodo();
  }
});

//동적으로 생성된 것도 클릭하면 이벤트 발생
$(document).on("click", ".day", function () {  
  $.ajax({
	url:"/walk/myWalk2",
	data:{date:$(this).attr("data-fdate")} ,
	type: "get",
	success: function(result){
		console.log(result)
		$("#walkDog").empty();
		$.each(result, function(k, v) {
			let dog =	'<a class="walk-modal" data-toggle="modal" data-target="#calendarModal">'
					+'<li class="walk-list">시간 <span class="walk-color">'
					+ result[k]["walkTime"]+
					'</span>분'
					 +	'&nbsp; 거리 <span class="text-primary">'
					 + result[k]["walkDistance"] +
					 '</span>m '
					 +'<input type="hidden" value='+ result[k]["walkId"] +' />'
					 +'</li>'
					 +'</a>';
					 
		$("#walkDog").append(dog);			 			
		})
	}
})
});
