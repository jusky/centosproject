<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<div class="panelBar">
	<div class="pages">
		<span>每页</span>
		<select class="combox" name="numPerPage" onchange="dialogPageBreak({numPerPage:this.value}<c:if test='${param.rel != null}'>, '${param.rel}'</c:if>)">
			<c:forEach var="s" items="${fn:split('10|20|50|100', '|')}">
				<option value="${s}" ${s eq pageSize? 'selected="selected"' : ''}>${s}</option>
			</c:forEach>
		</select>
		<span> 条, 共 ${page.totalResults} 条, ${page.totalPages} 页</span>
	</div>
	<div class="pagination" <c:if test='${param.rel != null}'>rel="${param.rel}"</c:if> targetType="navTab" totalCount="${page.totalResults}" numPerPage="${pageSize}" pageNumShown="10" currentPage="${currentPage}"></div>
</div>