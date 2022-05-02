<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
%>        
<!DOCTYPE html>
<html>
<head>

<script type="text/javascript" src="<%= ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<script>
    let oEditors = []

    smartEditor = function() {
      console.log("Naver SmartEditor")
      nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "editorTxt",
        sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
        fCreator: "createSEditor2"
      })
    }

    $(document).ready(function() {
      smartEditor()
    })
  </script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <h3>Naver Smart Editor 2.0</h3>
    <form action="insertStudentInfoForm" method="post">
      <div id="smarteditor">
        <textarea name="editorTxt" id="editorTxt" 
                  rows="20" cols="10" 
                  placeholder="내용을 입력해주세요"
                  style="width: 500px"></textarea>
      </div>
      <input type="button" />
    </form>
</body>
</html>