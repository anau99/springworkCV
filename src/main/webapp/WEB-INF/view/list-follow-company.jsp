<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Work CV</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700&display=swap" rel="stylesheet">

  <!-- CSS -->
    <link rel="stylesheet" href="../resources/assets/css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="../resources/assets/css/animate.css">
    <link rel="stylesheet" href="../resources/assets/css/owl.carousel.min.css">
    <link rel="stylesheet" href="../resources/assets/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="../resources/assets/css/magnific-popup.css">
    <link rel="stylesheet" href="../resources/assets/css/owl.carousel.min.css">
    <link rel="stylesheet" href="../resources/assets/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="../resources/assets/css/aos.css">
    <link rel="stylesheet" href="../resources/assets/css/ionicons.min.css">
    <link rel="stylesheet" href="../resources/assets/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="../resources/assets/css/jquery.timepicker.css">
    <link rel="stylesheet" href="../resources/assets/css/css/bootstrap-reboot.css">
    <link rel="stylesheet" href="../resources/assets/css/css/mixins/_text-hide.css">
    <link rel="stylesheet" href="../resources/assets/css/flaticon.css">
    <link rel="stylesheet" href="../resources/assets/css/icomoon.css">
    <link rel="stylesheet" href="../resources/assets/css/style.css">
    <link rel="stylesheet" href="../resources/assets/css/bootstrap/bootstrap-grid.css">
    <link rel="stylesheet" href="../resources/assets/css/bootstrap/bootstrap-reboot.css">

    <!-- JS -->
    <script src="../resources/assets/js/jquery.min.js"></script>
    <script src="../resources/assets/js/jquery-migrate-3.0.1.min.js"></script>
    <script src="../resources/assets/js/popper.min.js"></script>
    <script src="../resources/assets/js/bootstrap.min.js"></script>
    <script src="../resources/assets/js/jquery.easing.1.3.js"></script>
    <script src="../resources/assets/js/jquery.waypoints.min.js"></script>
    <script src="../resources/assets/js/jquery.stellar.min.js"></script>
    <script src="../resources/assets/js/owl.carousel.min.js"></script>
    <script src="../resources/assets/js/jquery.magnific-popup.min.js"></script>
    <script src="../resources/assets/js/aos.js"></script>
    <script src="../resources/assets/js/jquery.animateNumber.min.js"></script>
    <script src="../resources/assets/js/scrollax.min.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
    <script src="../resources/assets/js/google-map.js"></script>
    <script src="../resources/assets/js/main.js"></script>
    <script src="https://cdn.ckeditor.com/ckeditor5/29.0.0/classic/ckeditor.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
         <div class="container-fluid px-md-4">
             <a class="navbar-brand" href="/">Work CV</a>

             <div class="collapse navbar-collapse" id="ftco-nav">
                 <ul class="navbar-nav ml-auto">
                     <li class="nav-item active"><a href="${pageContext.request.contextPath}/Home/intro" class="nav-link">Trang chủ</a></li>
                     <c:if test="${not sessionScope.loggedIn}">
                         <li class="nav-item cta cta-colored"><a href="${pageContext.request.contextPath}" class="nav-link">Đăng nhập</a></li>
                     </c:if>
                     <c:if test="${sessionScope.loggedIn}">
                         <c:if test="${user.role.id == 1}">
                             <li  class="nav-item"><a href="${pageContext.request.contextPath}/user/save-jobs" class="nav-link">Công việc đã lưu/ứng tuyển</a></li>

                         </c:if>
                         <li class="nav-item"><a href="${pageContext.request.contextPath}/user/information" class="nav-link">Hồ Sơ</a></li>
                         <li class="nav-item"><a href="${pageContext.request.contextPath}/Home/logout" class="nav-link">Đăng xuất</a></li>
                     </c:if>

                 </ul>
             </div>
         </div>
     </nav>
<!-- END nav -->

<!-- END nav -->
<div class="hero-wrap hero-wrap-2" style="background-image:url(../resources/assets/images/bg_1.jpg);" data-stellar-background-ratio="0.5" th:if="${session.user.role.id == 1 }">
    <div class="overlay"></div>
    <div class="container">
        <div class="row no-gutters slider-text align-items-end justify-content-start">
            <div class="col-md-12 text-center mb-5">
                <p class="breadcrumbs mb-0"><span class="mr-3"><a href="/">Trang chủ <i class="ion-ios-arrow-forward"></i></a></span>Công ty <span></span></p>
                <h1 class="mb-3 bread">Danh sách công ty đã theo dõi</h1>
            </div>
        </div>
    </div>
</div>
<c:if test="${companies.size() == 0}">
<div class="hero-wrap hero-wrap-2" style="background-image: url(../resources/assets/images/bg_1.jpg);" data-stellar-background-ratio="0.5" th:if="${session.user.role.id == 2 }">
    <div class="overlay"></div>
    <div class="container">
        <div class="row no-gutters slider-text align-items-end justify-content-start">
            <div class="col-md-12 text-center mb-5">

                <h1 class="mb-3 bread">Không tìm thấy trang yêu cầu</h1>
            </div>
        </div>
    </div>
</div>
</c:if>

<c:if test="${companies.size() > 0}">
<section class="ftco-section bg-light">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 pr-lg-5">
                <div  class="row">
                    <c:forEach items="${companies}" var="company">
                        <div class="col-md-12 ">
                            <div class="job-post-item p-4 d-block d-lg-flex align-items-center">
                                <div class="one-third mb-4 mb-md-0">
                                    <div class="job-post-item-header align-items-center">

                                        <h2 class="mr-3 text-black" ><a href="${'/user/detail-company/'}+${saveJob.company.id}">${company.nameCompany}</a></h2>
                                    </div>
                                    <div class="job-post-item-body d-block d-md-flex">
                                        <div class="mr-3"><span class="icon-layers"></span> <a href="#" >${company.email}</a></div>
                                        <div class="mr-3"><span class="icon-my_location"></span> <span>${company.address}</span></div>
                                        <div style="margin-left: 10"><span class="icon-my_location"></span> <span>${company.phoneNumber}</span></div>
                                    </div>
                                </div>
                                <input type="hidden" name="companyId" value="${company.id}">
                                <div class="one-forth ml-auto d-flex align-items-center mt-4 md-md-0" style="width:370px !important;">
                               <!--       <div>
                                        <a  th:href="${'/user/delete-follow/'}+${saveJob.id}" class="icon text-center d-flex justify-content-center align-items-center icon mr-2">
                                            <span class="icon-delete"></span>
                                        </a>
                                    </div> -->
                                    <a href="${pageContext.request.contextPath}/Home/detail-company/${company.id}" class="btn btn-primary py-2">Chi tiết</a>
                                    <a href="${pageContext.request.contextPath}/user/list-post-company/${company.id}" class="btn btn-warning py-2 ml-1">Danh sách bài đăng</a>
                                </div>
                            </div>
                        </div><!-- end -->
                     </c:forEach>

                </div>
            <!--      <div style="text-align: center" th:if="${saveJobList.totalPages < 1}">
                    <p style="color:red;">Danh sách trống</p>
                </div>
                <div class="row mt-5">
                    <div class="col text-center">
                        <div class="block-27">
                            <ul>
                                <li th:if="${numberPage>0}"><a th:href="@{/save-job/get-list(page = ${saveJobList.number - 1})}">&lt;</a></li>
                                <th:block th:each="recruitment,state  : ${recruitmentList}">
                                    <li th:class="${numberPage == state.index  ? 'active' : null }"><a th:href="@{/save-job/get-list(page = ${state.index})}" th:text="${state.index + 1}"></a></li>
                                </th:block>
                                <li th:if="${numberPage<saveJobList.totalPages - 1}"><a th:href="@{/save-job/get-list(page = ${saveJobList.number + 1})}">&gt;</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>-->

        </div>
    </div>
</section>
</c:if>

<script>
//Listening when the dropdown choose
document.querySelectorAll('.selectMethod').forEach(function(select) {
    select.addEventListener('change', function() {
        var selectedValue = this.value;
        var parentModal = this.closest('.modal-content');
        var choose1Div = parentModal.querySelector('#choose_1');
        var choose2Div = parentModal.querySelector('#choose_2');
        var buttonType1 = parentModal.querySelector('#type1');
        var buttonType2 = parentModal.querySelector('#type2');
        var chooseCVInput = parentModal.querySelector('#chooseCV');

        // Checking
        if (selectedValue === '1') {
            choose1Div.style.display = 'block';
            choose2Div.style.display = 'none';
            buttonType1.style.display = 'block';
            buttonType2.style.display = 'none';
            chooseCVInput.required = false;
        } else if (selectedValue === '2') {
            choose1Div.style.display = 'none';
            choose2Div.style.display = 'block';
            buttonType1.style.display = 'none';
            buttonType2.style.display = 'block';
            chooseCVInput.required = true;
        } else {
            choose1Div.style.display = 'none';
            choose2Div.style.display = 'none';
            buttonType1.style.display = 'none';
            buttonType2.style.display = 'none';
        }
    });
});
</script>

<script>
    window.onload = function() {
        var urlParams = new URLSearchParams(window.location.search);
        var memo = urlParams.get('memo');

        if (memo) {
            alert(memo);
           // window.location.href = 'http://localhost:8080/ASM2/Home/intro';
        }
    }
</script>





<footer th:replace="public/fragments :: footer" class="ftco-footer ftco-bg-dark ftco-section">

</footer>


<!-- loader -->
<!--<div th:replace="public/fragments :: loading" id="ftco-loader" class="show fullscreen"></div>-->

</body>
</html>