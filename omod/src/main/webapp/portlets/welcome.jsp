<%@ include file="/WEB-INF/template/include.jsp" %>

<openmrs:htmlInclude file="/moduleResources/@MODULE_ID@/tracportal.css" />

<script type="text/javascript">
	jQuery.noConflict();
	jQuery(document).ready(function() {
		// Hide the OpenMRS logo
		var logo = jQuery('img[src="${pageContext.request.contextPath}/images/openmrs_logo_large.gif"]');
		logo.css('display', 'none');

		// Remove the 3 br's
		logo.next('br').remove();
		logo.next('br').remove();
		logo.next('br').remove();
	});
</script>

<openmrs:globalProperty var="applicationName" key="application.name" defaultValue="OpenMRS"/>

<c:choose>
	<c:when test="${model.authenticatedUser != null}">
		<div>
			<div style="width: 74%; float: left;">
				<div class="box">
					<c:choose>
						<c:when test="${model.showName != 'false'}">
							<openmrs:message code="welcomeUser" htmlEscape="false" arguments="${model.authenticatedUser.personName.givenName},${applicationName}" />
						</c:when>
						<c:otherwise>
							<openmrs:message htmlEscape="false" code="welcome" arguments="${applicationName}" />
						</c:otherwise>
					</c:choose>
					<c:if test="${model.customText != ''}">
						${model.customText}
					</c:if>
				</div>
				<br/>

				<openmrs:portlet id="findPatient" url="findPatient" parameters="size=full|postURL=patientDashboard.form|showIncludeVoided=false|viewType=shortEdit|hideAddNewPatient=true" />

			</div>
			<div style="width: 24%; float: right;">
				<b class="boxHeader">
					<spring:message code="@MODULE_ID@.usefulLinks" />
				</b>
				<div class="box">

					<openmrs:hasPrivilege privilege="View TRAC Portal modules functionalities">

						<openmrs:extensionPoint pointId="org.openmrs.tracmodule.list" type="html">
							<openmrs:hasPrivilege privilege="${extension.requiredPrivilege}">

								<div class="adminMenuList">
									<h4><spring:message code="${extension.title}"/></h4>
									<ul id="menu">
										<c:forEach items="${extension.links}" var="link">
											<c:choose>
												<c:when test="${fn:startsWith(link.key, 'module/')}">
													<%-- Added for backwards compatibility for most links --%>
													<li><a href="${pageContext.request.contextPath}/${link.key}"><spring:message code="${link.value}"/></a></li>
												</c:when>
												<c:otherwise>
													<%-- Allows for external absolute links  --%>
													<li><a href='<c:url value="${link.key}"/>'><spring:message code='${link.value}'/></a></li>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</ul>
								</div>
							</openmrs:hasPrivilege>
						</openmrs:extensionPoint>

					</openmrs:hasPrivilege>

				</div>
			</div>
			<div style="clear: both;"></div>
		</div>


	</c:when>
	<c:otherwise>
		<openmrs:message htmlEscape="false" code="welcome" arguments="${applicationName}" />
		<c:if test="${model.showLogin == 'true'}">
			<br/>
			<openmrs:portlet url="login" parameters="redirect=${model.redirect}" />
		</c:if>
	</c:otherwise>
</c:choose>