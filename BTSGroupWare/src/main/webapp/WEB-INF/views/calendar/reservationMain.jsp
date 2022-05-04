<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
 	String ctxPath = request.getContextPath();
%>
    
<%-- 예약 캘린더 소스 --%>    
<link href="<%=ctxPath %>/resources/reservationcalendarcss/mobiscroll.javascript.min.css" rel="stylesheet" />

<!-- 예약 calendar에 관련된 script -->
<script src="<%=ctxPath %>/resources/js/mobiscroll.javascript.min.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		mobiscroll.setOptions({
		    locale: mobiscroll.localeKo,
		    theme: 'ios',
		    themeVariant: 'light'
		});
		
		var calendar,
	    popup,
	    range,
	    oldEvent,
	    tempEvent = {},
	    deleteEvent,
	    restoreEvent,
	    colorPicker,
	    tempColor,
	    titleInput = document.getElementById('event-title'),
	    descriptionTextarea = document.getElementById('event-desc'),
	    allDaySwitch = document.getElementById('event-all-day'),
	    freeSegmented = document.getElementById('event-status-free'),
	    busySegmented = document.getElementById('event-status-busy'),
	    deleteButton = document.getElementById('event-delete'),
	    colorSelect = document.getElementById('event-color-picker'),
	    pickedColor = document.getElementById('event-color'),
	    colorElms = document.querySelectorAll('.crud-color-c'),
	    datePickerResponsive = {
	        medium: {
	            controls: ['calendar'],
	            touchUi: false
	        }
	    },
	    datetimePickerResponsive = {
	        medium: {
	            controls: ['calendar', 'time'],
	            touchUi: false
	        }
	    };

	function createAddPopup(elm) {
	    // hide delete button inside add popup
	    deleteButton.style.display = 'none';

	    deleteEvent = true;
	    restoreEvent = false;

	    // set popup header text and buttons for adding
	    popup.setOptions({
	        headerText: 'New event',
	        buttons: [
	            'cancel',
	            {
	                text: 'Add',
	                keyCode: 'enter',
	                handler: function () {
	                    calendar.updateEvent(tempEvent);
	                    deleteEvent = false;

	                    // navigate the calendar to the correct view
	                    calendar.navigate(tempEvent.start);

	                    popup.close();
	                },
	                cssClass: 'mbsc-popup-button-primary'
	            }
	        ]
	    });

	    // fill popup with a new event data
	    mobiscroll.getInst(titleInput).value = tempEvent.title;
	    mobiscroll.getInst(descriptionTextarea).value = '';
	    mobiscroll.getInst(allDaySwitch).checked = tempEvent.allDay;
	    range.setVal([tempEvent.start, tempEvent.end]);
	    mobiscroll.getInst(busySegmented).checked = true;
	    range.setOptions({
	        controls: tempEvent.allDay ? ['date'] : ['datetime'],
	        responsive: tempEvent.allDay ? datePickerResponsive : datetimePickerResponsive
	    });
	    pickedColor.style.background = '';

	    // set anchor for the popup
	    popup.setOptions({ anchor: elm });

	    popup.open();
	}

	function createEditPopup(args) {
	    var ev = args.event;

	    // show delete button inside edit popup
	    deleteButton.style.display = 'block';

	    deleteEvent = false;
	    restoreEvent = true;

	    // set popup header text and buttons for editing
	    popup.setOptions({
	        headerText: 'Edit event',
	        buttons: [
	            'cancel',
	            {
	                text: 'Save',
	                keyCode: 'enter',
	                handler: function () {
	                    var date = range.getVal();
	                    // update event with the new properties on save button click
	                    calendar.updateEvent({
	                        id: ev.id,
	                        title: titleInput.value,
	                        description: descriptionTextarea.value,
	                        allDay: mobiscroll.getInst(allDaySwitch).checked,
	                        start: date[0],
	                        end: date[1],
	                        free: mobiscroll.getInst(freeSegmented).checked,
	                        color: ev.color,
	                    });

	                    // navigate the calendar to the correct view
	                    calendar.navigate(date[0]);;

	                    restoreEvent = false;
	                    popup.close();
	                },
	                cssClass: 'mbsc-popup-button-primary'
	            }
	        ]
	    });

	    // fill popup with the selected event data
	    mobiscroll.getInst(titleInput).value = ev.title || '';
	    mobiscroll.getInst(descriptionTextarea).value = ev.description || '';
	    mobiscroll.getInst(allDaySwitch).checked = ev.allDay || false;
	    range.setVal([ev.start, ev.end]);
	    pickedColor.style.background = ev.color || '';

	    if (ev.free) {
	        mobiscroll.getInst(freeSegmented).checked = true;
	    } else {
	        mobiscroll.getInst(busySegmented).checked = true;
	    }

	    // change range settings based on the allDay
	    range.setOptions({
	        controls: ev.allDay ? ['date'] : ['datetime'],
	        responsive: ev.allDay ? datePickerResponsive : datetimePickerResponsive
	    });

	    // set anchor for the popup
	    popup.setOptions({ anchor: args.domEvent.currentTarget });
	    popup.open();
	}
	
	 calendar = mobiscroll.eventcalendar('#day-work-week-view', {
		    view: {
		        timeline: {
		            type: 'day'
		        }
		    },
		    data: [{
	            start: '2022-05-02T07:00',
	            end: '2022-05-02T09:00',
	            title: 'Stakeholder mtg.',
	            resource: [1, 2, 4]
	        }, {
	            start: '2022-05-05T18:00',
	            end: '2022-05-05T19:30',
	            title: 'Wrapup mtg.',
	            resource: [2, 3, 5]
	        }, {
	            start: '2022-05-02T14:00',
	            end: '2022-05-02T18:00',
	            title: 'Business of Software Conference',
	            resource: [1, 3]
	        }, {
	            start: '2022-05-03T20:00',
	            end: '2022-05-03T21:50',
	            title: 'Product Team mtg.',
	            resource: [2, 3, 4]
	        }, {
	            start: '2022-05-01T13:00',
	            end: '2022-05-01T15:00',
	            title: 'Decision Making mtg.',
	            resource: [1, 4, 5]
	        }, {
	            start: '2022-05-03T13:00',
	            end: '2022-05-03T14:00',
	            title: 'Quick mtg. with Martin',
	            resource: 3
	        }, {
	            start: '2022-05-05T12:00',
	            end: '2022-05-05T16:00',
	            title: 'Team-Building',
	            resource: [1, 2, 3, 4, 5]
	        }],
	        resources: [{
	            id: 1,
	            name: 'Resource A',
	            color: '#fdf500'
	        }, {
	            id: 2,
	            name: 'Resource B',
	            color: '#ff0101'
	        }, {
	            id: 3,
	            name: 'Resource C',
	            color: '#01adff'
	        }, {
	            id: 4,
	            name: 'Resource D',
	            color: '#239a21'
	        }, {
	            id: 5,
	            name: 'Resource E',
	            color: '#ff4600'
	        }],
		    renderHeader: function () {
		        return '<div mbsc-calendar-nav class="md-work-week-nav"></div>' +
		            '<div class="md-work-week-picker">' +
		            '<label>Day<input mbsc-segmented type="radio" name="view" value="day" class="md-view-change"></label>' +
		            '<label>Week<input mbsc-segmented type="radio" name="view" value="week" class="md-view-change" checked></label>' +
		            '</div>' +
		            '<div mbsc-calendar-prev class="md-work-week-prev"></div>' +
		            '<div mbsc-calendar-today class="md-work-week-today"></div>' +
		            '<div mbsc-calendar-next class="md-work-week-next"></div>';
		    },
		    
		    clickToCreate: 'double',
		    onEventClick: function (args) {
		        oldEvent = Object.assign({}, args.event);
		        tempEvent = args.event;

		        if (!popup.isVisible()) {
		            createEditPopup(args);
		        }
		    },
		    onEventCreated: function (args) {
		        popup.close();
		        // store temporary event
		        tempEvent = args.event;
		        createAddPopup(args.target);
		    },
		    onEventDeleted: function (args) {
		        mobiscroll.snackbar({            button: {
		                action: function () {
		                    calendar.addEvent(args.event);
		                },
		                text: '확인'
		            },
		            message: 'Event deleted'
		        });
		    },
		    dragToCreate: true,
		    dragToMove: true,
		    dragToResize: true,
		    dragTimeStep: 15
		   
		});
		
		document.querySelectorAll('.md-view-change').forEach(function (elm) {
		    elm.addEventListener('change', function (ev) {
		        switch (ev.target.value) {
		            case 'day':
		                calendar.setOptions({
		                    view: {
		                        timeline: { type: 'day' }
		                    }
		                })
		                break;
		            case 'week':
		                calendar.setOptions({
		                    view: {
		                        timeline: {
		                            type: 'week'
		                        }
		                    }
		                })
		                break;
		        }
		    });
		});// end

	
	popup = mobiscroll.popup('#demo-add-popup', {
	    display: 'bottom',
	    contentPadding: false,
	    fullScreen: true,
	    onClose: function () {
	        if (deleteEvent) {
	            calendar.removeEvent(tempEvent);
	        } else if (restoreEvent) {
	            calendar.updateEvent(oldEvent);
	        }
	    },
	    responsive: {
	        medium: {
	            display: 'anchored',
	            width: 400,
	            fullScreen: false,
	            touchUi: false
	        }
	    }
	});

	titleInput.addEventListener('input', function (ev) {
	    // update current event's title
	    tempEvent.title = ev.target.value;
	});

	descriptionTextarea.addEventListener('change', function (ev) {
	    // update current event's title
	    tempEvent.description = ev.target.value;
	});

	allDaySwitch.addEventListener('change', function () {
	    var checked = this.checked
	    // change range settings based on the allDay
	    range.setOptions({
	        controls: checked ? ['date'] : ['datetime'],
	        responsive: checked ? datePickerResponsive : datetimePickerResponsive
	    });

	    // update current event's allDay property
	    tempEvent.allDay = checked;
	});

	range = mobiscroll.datepicker('#event-date', {
	    controls: ['date'],
	    select: 'range',
	    startInput: '#start-input',
	    endInput: '#end-input',
	    showRangeLabels: false,
	    touchUi: true,
	    responsive: datePickerResponsive,
	    onChange: function (args) {
	        var date = args.value;
	        // update event's start date
	        tempEvent.start = date[0];
	        tempEvent.end = date[1];
	    }
	});

	document.querySelectorAll('input[name=event-status]').forEach(function (elm) {
	    elm.addEventListener('change', function () {
	        // update current event's free property
	        tempEvent.free = mobiscroll.getInst(freeSegmented).checked;
	    });
	});


	deleteButton.addEventListener('click', function () {
	    // delete current event on button click
	    calendar.removeEvent(tempEvent);
	    popup.close();

	    // save a local reference to the deleted event
	    var deletedEvent = tempEvent;

	    mobiscroll.snackbar({        button: {
	            action: function () {
	                calendar.addEvent(deletedEvent);
	            },
	            text: 'Undo'
	        },
	        message: 'Event deleted'
	    });
	});

	colorPicker = mobiscroll.popup('#demo-event-color', {
	    display: 'bottom',
	    contentPadding: false,
	    showArrow: false,
	    showOverlay: false,
	    buttons: [
	        'cancel',
	        {
	            text: 'Set',
	            keyCode: 'enter',
	            handler: function (ev) {
	                setSelectedColor();
	            },
	            cssClass: 'mbsc-popup-button-primary'
	        }
	    ],
	    responsive: {
	        medium: {
	            display: 'anchored',
	            anchor: document.getElementById('event-color-cont'),
	            buttons: [],
	        }
	    }
	});

	function selectColor(color, setColor) {
	    var selectedElm = document.querySelector('.crud-color-c.selected');
	    var newSelected = document.querySelector('.crud-color-c[data-value="' + color + '"]');

	    if (selectedElm) {
	        selectedElm.classList.remove('selected')
	    }
	    if (newSelected) {
	        newSelected.classList.add('selected')
	    }
	    if (setColor) {
	        pickedColor.style.background = color || '';
	    }
	}

	function setSelectedColor() {
	    tempEvent.color = tempColor;
	    pickedColor.style.background = tempColor;
	    colorPicker.close();
	}

	colorSelect.addEventListener('click', function () {
	    selectColor(tempEvent.color || '');
	    colorPicker.open();
	});

	colorElms.forEach(function (elm) {
	    elm.addEventListener('click', function () {
	        tempColor = elm.getAttribute('data-value');
	        selectColor(tempColor);

	        if (!colorPicker.s.buttons.length) {
	            setSelectedColor();
	        }
	    });
	});
});// end of $(document).ready(function(){}----------------------------
	
</script>

<div id="reservationMain" >
<h4 style="margin: 0 80px">예약하기</h4>
	<div id="day-work-week-view" class="md-switching-timeline-view-cont" style="margin: 60px 30px 50px 80px;"></div>
	<div>
		<h5 style="margin: 0 80px">내 예약 현황</h5>
		<table style="width:90%; margin-top:60px; text-align: center;">
			<thead>
				<tr>
					<th>자산</th>
					<th>이름</th>
					<th>예약 시간</th>
					<th>취소/반납</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>빔프로젝터</td>
					<td>1번 프로젝터</td>
					<td>2022-05-02 09:00~2022-05-02 14:00</td>
					<td><button type="button">반납</button></td>
				</tr>
			</tbody>
		</table>
	</div>

</div>


<!--  
<div id="reservationPopup" >
    <div class="mbsc-form-group">
        <table>
        	<tr>
        		<th>예약일</th>
        		<td>
        			<input type="date" id="startDate" value="${requestScope.chooseDate}" style="height: 30px;"/>&nbsp; 
					<select id="startHour" class="schedule"></select> 시
					<select id="startMinute" class="schedule"></select> 분
					- <input type="date" id="endDate" value="${requestScope.chooseDate}" style="height: 30px;"/>&nbsp;
					<select id="endHour" class="schedule"></select> 시
					<select id="endMinute" class="schedule"></select> 분&nbsp;
					<input type="checkbox" id="allday" name="allday"/><label for="allday"> &nbsp;종일</label>&nbsp;&nbsp;&nbsp;
					<input type="checkbox" id="repeat" name="repeat"/><label for="repeat">&nbsp;반복</label>
					
					<input type="hidden" name="startdate"/>
					<input type="hidden" name="enddate"/>
				</td>
        	</tr>
        	<tr>
        		<th>예약자</th>
        		<td></td>
        	</tr>
        	<tr>
        		<th>목적</th>
        		<td><textarea name="res_content" id="res_content"></textarea></td>
        	</tr>
        </table>
    </div>
</div>
-->

<div id="demo-add-popup">
    <div class="mbsc-form-group">
        <label>
            Title
            <input mbsc-input id="event-title">
        </label>
        <label>
            Description
            <textarea mbsc-textarea id="event-desc"></textarea>
        </label>
    </div>
    <div class="mbsc-form-group">
        <label>
            All-day
            <input mbsc-switch id="event-all-day" type="checkbox" />
        </label>
        <label>
            Starts
            <input mbsc-input id="start-input" />
        </label>
        <label>
            Ends
            <input mbsc-input id="end-input" />
        </label>
        <div id="event-date"></div>
        <div id="event-color-picker" class="event-color-c">
            <div class="event-color-label">Color</div>
            <div id="event-color-cont">
                <div id="event-color" class="event-color"></div>
            </div>
        </div>
        <label>
            Show as busy
            <input id="event-status-busy" mbsc-segmented type="radio" name="event-status" value="busy">
        </label>
        <label>
            Show as free
            <input id="event-status-free" mbsc-segmented type="radio" name="event-status" value="free">
        </label>
        <div class="mbsc-button-group">
            <button class="mbsc-button-block" id="event-delete" mbsc-button data-color="danger" data-variant="outline">Delete event</button>
        </div>
    </div>
</div>

<div id="demo-event-color">
    <div class="crud-color-row">
        <div class="crud-color-c" data-value="#ffeb3c">
            <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#ffeb3c"></div>
        </div>
        <div class="crud-color-c" data-value="#ff9900">
            <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#ff9900"></div>
        </div>
        <div class="crud-color-c" data-value="#f44437">
            <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#f44437"></div>
        </div>
        <div class="crud-color-c" data-value="#ea1e63">
            <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#ea1e63"></div>
        </div>
        <div class="crud-color-c" data-value="#9c26b0">
            <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#9c26b0"></div>
        </div>
    </div>
    <div class="crud-color-row">
        <div class="crud-color-c" data-value="#3f51b5">
            <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#3f51b5"></div>
        </div>
        <div class="crud-color-c" data-value="">
            <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check"></div>
        </div>
        <div class="crud-color-c" data-value="#009788">
            <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#009788"></div>
        </div>
        <div class="crud-color-c" data-value="#4baf4f">
            <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#4baf4f"></div>
        </div>
        <div class="crud-color-c" data-value="#7e5d4e">
            <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#7e5d4e"></div>
        </div>
    </div>
</div>
