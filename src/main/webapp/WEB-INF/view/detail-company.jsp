<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="springwork.datastructures.Base64Encoder" %>
<!DOCTYPE html>
<html lang="en">
<head th:replace="public/fragments :: html_head">
    <title>Skillhunt - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700&display=swap" rel="stylesheet">

  <!-- CSS -->
  <link rel="stylesheet" href="../../resources/assets/css/open-iconic-bootstrap.min.css">
  <link rel="stylesheet" href="../../resources/assets/css/animate.css">
  <link rel="stylesheet" href="../../resources/assets/css/owl.carousel.min.css">
  <link rel="stylesheet" href="../../resources/assets/css/owl.theme.default.min.css">
  <link rel="stylesheet" href="../../resources/assets/css/magnific-popup.css">
  <link rel="stylesheet" href="../../resources/assets/css/owl.carousel.min.css">
  <link rel="stylesheet" href="../../resources/assets/css/owl.theme.default.min.css">
  <link rel="stylesheet" href="../../resources/assets/css/aos.css">
  <link rel="stylesheet" href="../../resources/assets/css/ionicons.min.css">
  <link rel="stylesheet" href="../../resources/assets/css/bootstrap-datepicker.css">
  <link rel="stylesheet" href="../../resources/assets/css/jquery.timepicker.css">
  <link rel="stylesheet" href="../../resources/assets/css/css/bootstrap-reboot.css">
  <link rel="stylesheet" href="../../resources/assets/css/css/mixins/_text-hide.css">
  <link rel="stylesheet" href="../../resources/assets/css/flaticon.css">
  <link rel="stylesheet" href="../../resources/assets/css/icomoon.css">
  <link rel="stylesheet" href="../../resources/assets/css/style.css">
  <link rel="stylesheet" href="../../resources/assets/css/bootstrap/bootstrap-grid.css">
  <link rel="stylesheet" href="../../resources/assets/css/bootstrap/bootstrap-reboot.css">

  <!-- JS -->
  <script src="../../resources/assets/js/jquery.min.js"></script>
  <script src="../../resources/assets/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="../../resources/assets/js/popper.min.js"></script>
  <script src="../../resources/assets/js/bootstrap.min.js"></script>
  <script src="../../resources/assets/js/jquery.easing.1.3.js"></script>
  <script src="../../resources/assets/js/jquery.waypoints.min.js"></script>
  <script src="../../resources/assets/js/jquery.stellar.min.js"></script>
  <script src="../../resources/assets/js/owl.carousel.min.js"></script>
  <script src="../../resources/assets/js/jquery.magnific-popup.min.js"></script>
  <script src="../../resources/assets/js/aos.js"></script>
  <script src="../../resources/assets/js/jquery.animateNumber.min.js"></script>
  <script src="../../resources/assets/js/scrollax.min.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="../../resources/assets/js/google-map.js"></script>
  <script src="../../resources/assets/js/main.js"></script>
  <script src="https://cdn.ckeditor.com/ckeditor5/29.0.0/classic/ckeditor.js"></script>
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
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
                  <li class="nav-item"><a href="${pageContext.request.contextPath}/user/save-jobs" class="nav-link">Công việc đã lưu/ứng tuyển</a></li>
                 <li  class="nav-item"><a href="${pageContext.request.contextPath}/user/follow-companies" class="nav-link">Công ty đã theo dõi/các việc theo dõi</a></li>
               </c:if>
                 <li class="nav-item"><a href="${pageContext.request.contextPath}/user/information" class="nav-link">Hồ Sơ</a></li>
                 <li class="nav-item"><a href="${pageContext.request.contextPath}/Home/logout" class="nav-link">Đăng xuất</a></li>
             </c:if>

             </ul>
         </div>
     </div>
 </nav>



<!-- END nav -->



<div class="hero-wrap hero-wrap-2" style="background-image: url('../../resources/assets/images/bg_1.jpg');" data-stellar-background-ratio="0.5">
    <div class="overlay"></div>
    <div class="container">
        <div class="row no-gutters slider-text align-items-end justify-content-start">
            <div class="col-md-12 text-center mb-5">
                <p class="breadcrumbs mb-0"><span class="mr-3"><a href="">Trang chủ <i class="ion-ios-arrow-forward"></i></a></span>Chi tiết <span></span></p>
                <h1 class="mb-3 bread">Chi tiết công ty</h1>
            </div>
        </div>
    </div>
</div>

<section style="margin-top: 10px" class="site-section">
    <div class="container">
        <div class="row align-items-center mb-5">
            <div class="col-lg-8 mb-4 mb-lg-0">
                <div class="d-flex align-items-center">

                  <c:if test="${company.getLogo() ne null}">
                    <div class="border p-2 d-inline-block mr-3 rounded">
                        <img width="100" height="100" src="data:image/jpg;base64,${Base64Encoder.encode(company.getLogo())}" alt="Image">
                    </div>
                  </c:if>
                    <div>
                        <h2>${company.getNameCompany()}</h2>
                        <div>
                            <span class="icon-briefcase mr-2"></span><span class="ml-0 mr-2 mb-2">${company.getEmail()}</span>
                            <span  class="icon-room mr-2"></span ><span  class="m-2">${company.getAddress()}</span>

                        </div>
                        <input type="hidden" id="idCompany">
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
              <form action="${pageContext.request.contextPath}/user/followCompany" method="POST">

                <div class="row">
                    <div class="col-6">

                        <c:set var="hashSetIdCompaniesFollowed" value="${sessionScope.hashSetIdCompaniesFollowed}" />
                         <input type="hidden" name="companyID" value="${company.getId()}">
                        <button type="submit" class="btn btn-block btn-light btn-md">
                            <c:choose>
                                <c:when test="${hashSetIdCompaniesFollowed.contains(company.getId())}">
                                    <span class="icon-heart mr-2 text-danger"></span>
                                </c:when>
                                <c:otherwise>
                                    <span class="icon-heart-o mr-2 text-black"></span>
                                </c:otherwise>
                            </c:choose>
                            Theo dõi
                        </button>
                    </div>

                    <div class="col-6">

                    </div>
                </div>
              </form>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-8">
                <div class="mb-5">

                    <h3 class="h5 d-flex align-items-center mb-4 text-primary"><span class="icon-align-left mr-3"></span>Mô tả công việc</h3>
                    <p >${company.getDescription()}</p>
                </div>

            </div>
            <div class="col-lg-4">
                <div class="bg-light p-3 border rounded mb-4">
                    <h3 class="text-primary  mt-3 h5 pl-3 mb-3 ">Tóm tắt công việc</h3>
                    <ul class="list-unstyled pl-3 mb-0">

                        <li class="mb-2"><strong class="text-black">Email công ty: </strong> <span >${company.getEmail()}</span></li>
                        <li class="mb-2"><strong class="text-black">Số điện thoại: </strong> <span>${company.getPhoneNumber()}</span></li>
                        <li class="mb-2"><strong class="text-black">Đại chỉ: </strong> <span>${company.getAddress()}</span></li>
                    </ul>
                </div>

                <div class="bg-light p-3 border rounded">
                    <h3 class="text-primary  mt-3 h5 pl-3 mb-3 ">Share</h3>
                    <div class="px-3">
                        <a href="#" class="pt-3 pb-3 pr-3 pl-0"><span class="icon-facebook"></span></a>
                        <a href="#" class="pt-3 pb-3 pr-3 pl-0"><span class="icon-twitter"></span></a>
                        <a href="#" class="pt-3 pb-3 pr-3 pl-0"><span class="icon-linkedin"></span></a>
                        <a href="#" class="pt-3 pb-3 pr-3 pl-0"><span class="icon-pinterest"></span></a>
                    </div>
                </div>

            </div>
        </div>
    </div>

</section>

<footer class="footer" class="ftco-footer ftco-bg-dark ftco-section">
    <div class="container">

      <div class="row">
        <div class="col-md-12 text-center">

          <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
            Copyright &copy;<script>document.write(new Date().getFullYear());</script>  <i class="icon-heart text-danger" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">MrAn</a>
            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
        </div>
      </div>
    </div>
  </footer>

</footer>
<script>
    window.onload = function() {
        var urlParams = new URLSearchParams(window.location.search);
        var memo = urlParams.get('memo');

        if (memo) {
            alert(memo);

        }
    }
</script>
</body>
</html>