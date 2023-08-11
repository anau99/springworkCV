<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Work CV</title>
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
<nav class="header_menu" class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
    <div class="container-fluid px-md-4	">
        <a class="navbar-brand" href="/">Work CV</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="oi oi-menu"></span> Menu
        </button>

        <div class="collapse navbar-collapse" id="ftco-nav">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item active"><a href="${pageContext.request.contextPath}/Home/intro" class="nav-link">Trang chủ</a></li>
            <li class="'nav-item"><a href="#" class="nav-link">Công việc</a></li>
            <li class="nav-item"><a href="#" class="nav-link">Ứng cử viên</a></li>
    <!--        <li class="nav-item"><a href="blog.html" class="nav-link">Công ty</a></li>-->
    <!--
            <li th:if="${session.user}" class="nav-item"><a th:href="@{'/user/profile/'+${session.user.id}}" th:text="${session.user.fullName}" class="nav-link" ></a> -->

              <ul class="dropdown">
                <li><a href="/">Hồ Sơ</a></li>
    <!--            <li><a href="service-single.html">Đổi mật khẩu</a></li>-->

    <!--            <li th:if="${session.user.role.id == 2}"><a href="/auth/logout" >Ứng cử viên tiềm năng</a></li>-->
                <li><a href="${pageContext.request.contextPath}/Home/logout" >Đăng xuất</a></li>

              </ul>
            </li>



              <li class="nav-item cta mr-md-1"><a href="${pageContext.request.contextPath}/recruitment/post" class="nav-link">Đăng tuyển</a></li>


          </ul>
        </div>
      </div>
</nav>

<div class="hero-wrap hero-wrap-2" style="background-image: url(../resources/assets/images/bg_1.jpg);" data-stellar-background-ratio="0.5" th:if="${session.user.role.id == 2 }">
    <div class="overlay"></div>
    <div class="container">
        <div class="row no-gutters slider-text align-items-end justify-content-start">
            <div class="col-md-12 text-center mb-5">
                <p class="breadcrumbs mb-0"><span class="mr-3"><a href="index.html">Trang chủ <i class="ion-ios-arrow-forward"></i></a></span>Danh sách <span></span></p>
                <h1 class="mb-3 bread">Danh sách bài đăng</h1>
            </div>
        </div>
    </div>
</div>
<div th:if="${success}" class="toast" data-delay="2500" style="position:fixed; top: 100PX; left: 10PX;z-index: 2000;width: 300px">
    <script>
        swal({
            title: 'Thành công!',
            /* text: 'Redirecting...', */
            icon: 'success',
            timer: 3000,
            buttons: true,
            type: 'success'
        })
    </script>
</div>
<!--    <div th:if="${error}" class="toast" data-delay="2500" style="position:fixed; top: 100PX; left: 10PX;z-index: 2000;width: 300px">
    <script>
        swal({
            title: 'Bài đăng đang có người ứng tuyển!',
            /* text: 'Redirecting...', */
            icon: 'error',
            timer: 3000,
            buttons: true,
            type: 'error'
        })
    </script>
</div>-->
<c:if test="${empty recruitments}">
    <div class="hero-wrap hero-wrap-2" style="background-image: url(../resources/assets/images/bg_1.jpg);" data-stellar-background-ratio="0.5" th:if="${session.user.role.id == 1 }">
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
<section class="ftco-section bg-light" th:if="${session.user.role.id == 2 }">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 pr-lg-4">
                <div class="row">
                    <c:if test="${empty recruitments}">
                        <div class="row form-group" >
                            <label for="company-website-tw d-block">Danh sách bài tuyển dụng </label> <br>
                            <div class="col-md-12">
                                <a href="${pageContext.request.contextPath}/recruitment/post" class="btn px-4 btn-primary text-white">Đăng tuyển</a>
                            </div>
                        </div>

                    </c:if>

                    <c:if test="${not empty recruitments}">
                       <c:forEach items="${recruitments}" var="recruitment">
                        <div class="col-md-12 ">
                            <div class="job-post-item p-4 d-block d-lg-flex align-items-center">
                                <div class="one-third mb-4 mb-md-0">
                                    <div class="job-post-item-header align-items-center">
                                        <span class="subadge">${recruitment.type}</span>
                                        <h2 class="mr-3 text-black" ><a th:href="${'/recruitment/detail/'} +${recruitment.id}">${recruitment.title}</a></h2>
                                    </div>
                                    <div class="job-post-item-body d-block d-md-flex">
                                        <div class="mr-3"><span class="icon-layers"></span> <a href="#" >${nameCompany}</a></div>
                                        <div><span class="icon-my_location"></span> <span >${recruitment.address}</span></div>
                                    </div>
                                </div>

                                <div class="one-forth ml-auto d-flex align-items-center mt-4 md-md-0" style="width: 330px !important;">
<!--                                    <div>-->
<!--                                        <a href="#" class="icon text-center d-flex justify-content-center align-items-center icon mr-2">-->
<!--                                            <span class="icon-heart"></span>-->
<!--                                        </a>-->
<!--                                    </div>-->
                                   <!--      <a th:href="${'/recruitment/detail/'} +${recruitment.id}"  class="btn btn-primary py-2 ml-2">Xem chi tiết</a>-->
                                    <a href="${pageContext.request.contextPath}/recruitment/editPost?id=${recruitment.id}"  class="btn btn-warning py-2 ml-2">Cập nhật</a>
                                    <a class="btn btn-danger py-2 ml-2"  data-toggle="modal" data-target="#idModelDel-${recruitment.id}">Xóa</a>

                                </div>
                            </div>
                        </div><!-- end -->
                        <!-- Modal -->
                       <div class="modal fade" id="idModelDel-${recruitment.id}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                 <div class="modal-dialog" role="document">
                                                     <div class="modal-content">
                                                         <div class="modal-header">
                                                             <h5 class="modal-title" id="exampleModalLabel">Bạn có chắc chắn muốn xóa ?</h5>
                                                             <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                 <span aria-hidden="true">&times;</span>
                                                             </button>
                                                         </div>
                                                         <div class="modal-body">
                                                             Bài đăng : <span >${recruitment.title}</span>
                                                             <form action="deleteAPost" method="post">
                                                                 <input type="hidden" class="form-control" id="id" name="id" value="${recruitment.id}">
                                                                 <div class="modal-footer mt-1">
                                                                     <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                                                                     <button type="submit" class="btn btn-danger">Xóa</button>
                                                                 </div>
                                                             </form>
                                                         </div>

                                                     </div>
                                                 </div>
                                             </div>
                        <!-- Modal -->
                      </c:forEach>
                    </c:if>
                </div>
                <div class="row mt-5">
                    <div class="col text-center">
                        <div class="block-27">
                            <ul>
                                <li th:if="${numberPage>0}"><a th:href="@{/user/list-post(page = ${list.number - 1})}">&lt;</a></li>
                                <th:block th:each="recruitment,state  : ${recruitmentList}">
<!--                                    <th:block th:if="${numberPage == 0}">-->
<!--                                        <li th:class="${numberPage == 0 ? 'active' : null }"><a th:href="@{/user/list-post(page = ${state.index})}" th:text="${state.index + 1}"></a></li>-->
<!--                                    </th:block>-->
                                        <li th:class="${numberPage == state.index  ? 'active' : null }"><a th:href="@{/user/list-post(page = ${state.index})}" th:text="${state.index + 1}"></a></li>
                                </th:block>
                                <li th:if="${numberPage<list.totalPages - 1}"><a th:href="@{/user/list-post(page = ${list.number + 1})}">&gt;</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>



<script>
    ClassicEditor.create(document.querySelector('#editorN')).then(eidt => {
        console.log("da" + eidt);
    })
        .catch(error => {
            console.error(error);
        });
</script>

<footer th:replace="public/fragments :: footer" class="ftco-footer ftco-bg-dark ftco-section">

</footer>
</body>
</html>