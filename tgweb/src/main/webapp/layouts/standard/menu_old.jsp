<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript" src="<c:url value='/javascript/common/default.js'/>"></script>
<div id="main_menu">
	<ul>
		<li>
			<a href="#" target="_self" onMouseOver="MM_showHideLayers('menu1','','show','menu2','','hide','menu3','','hide','menu4','','hide','menu5','','hide');MM_swapImage('topmenu3_0','','topmenu3_0.gif','topmenu4_0','','topmenu4_0_1.gif',0);">
				top1
			</a>
		</li>
		<li>
			<a href="#" target="_self" onMouseOver="MM_showHideLayers('menu1','','hide','menu2','','show','menu3','','hide','menu4','','hide','menu5','','hide');MM_swapImage('topmenu3_0','','topmenu3_0.gif','topmenu4_0','','topmenu4_0_1.gif',0);">
				top2
			</a>
		</li>
		<li>
			<a href="#" target="_self" onMouseOver="MM_showHideLayers('menu1','','hide','menu2','','hide','menu3','','show','menu4','','hide','menu5','','hide');MM_swapImage('topmenu3_0','','topmenu3_0.gif','topmenu4_0','','topmenu4_0_1.gif',0);">
				top3
			</a>
		</li>
		<li>
			<a href="#" target="_self" onMouseOver="MM_showHideLayers('menu1','','hide','menu2','','hide','menu3','','hide','menu4','','show','menu5','','hide');MM_swapImage('topmenu3_0','','topmenu3_0.gif','topmenu4_0','','topmenu4_0_1.gif',0);">
				top4
			</a>
		</li>
		<li>
			<a href="#" target="_self" onMouseOver="MM_showHideLayers('menu1','','hide','menu2','','hide','menu3','','hide','menu4','','hide','menu5','','show');MM_swapImage('topmenu3_0','','topmenu3_0.gif','topmenu5_0','','topmenu5_0_1.gif',0);">
				top5
			</a>
		</li>
	</ul>
</div>
<div id="sub_menu">
	<span id="menu1" style="z-index:1; visibility: hidden">
		<a href="#">1</a>
		<a href="#">2</a>
		<a href="#">3</a>
	</span>

	<span id="menu2" style="z-index:2; visibility: hidden">
		<a href="#">21</a>
		<a href="#">22</a>
		<a href="#">23</a>
	</span>

	<span id="menu3" style="z-index:3; visibility: hidden">
		<a href="#">31</a>
		<a href="#">32</a>
		<a href="#">33</a>
	</span>

	<span id="menu4" style="z-index:4; visibility: hidden">
		<a href="#">41</a>
		<a href="#">42</a>
		<a href="#">43</a>
	</span>

	<span id="menu5" style="z-index:5; visibility: hidden">
		<a href="#">51</a>
		<a href="#">52</a>
		<a href="#">53</a>
	</span>
</div>
