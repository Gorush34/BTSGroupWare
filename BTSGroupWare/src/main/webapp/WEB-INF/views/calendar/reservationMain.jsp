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
		
		function fillDialog(args) {
		    mobiscroll.getInst(document.getElementById('external-event-job')).value = args.event.title;
		    mobiscroll.getInst(document.getElementById('external-event-details')).value = args.event.details || '';
		    mobiscroll.getInst(document.getElementById('external-event-technician')).value = args.event.technician;
		    dialog.setOptions({ anchor: args.target });
		    dialog.open();
		}

		var calendar = mobiscroll.eventcalendar('#day-work-week-view', {
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
		    
		    clickToCreate: true,
		    onEventCreated: function (args, inst) {
		        fillDialog(args);
		    },
		    dragToCreate: true,
		    dragToMove: true,
		    dragToResize: true,
		    dragTimeStep: 15
		   
		});
		
		var dialog = mobiscroll.popup('#reservationPopup', {
		    display: 'anchored',
		    width: 400,
		    contentPadding: false,
		    touchUi: false,
		    headerText: '예약하기',
		    buttons: ['ok'],
		    onClose: function () {
		        mobiscroll.toast({
		            message: '해당 자원을 예약하셨습니다.'
		        });
		    }
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
		});

		
	});

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