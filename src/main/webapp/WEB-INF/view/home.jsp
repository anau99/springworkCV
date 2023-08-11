<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="springwork.datastructures.Base64Encoder" %>
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
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid px-md-4	">
          <a class="navbar-brand" href="/">Work CV</a>

         <div class="collapse navbar-collapse" id="ftco-nav">
           <ul class="navbar-nav ml-auto">
             <li class="nav-item active"><a href="${pageContext.request.contextPath}/Home/intro" class="nav-link">Trang chủ</a></li>
             <li class="nav-item"><a href="/" class="nav-link"></a></li>

             <c:if test="${sessionScope.loggedIn}">
               <li class="nav-item">
                 <a class="nav-link dropdown-toggle"  id="candidateDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                     ${user.fullName}
                 </a>
                 <ul class="dropdown-menu" aria-labelledby="candidateDropdown">
                   <li><a href="${pageContext.request.contextPath}/user/information">Hồ Sơ</a></li>

                   <c:if test="${user.role.id != 2}">
                     <li><a href="${pageContext.request.contextPath}/user/save-jobs">Công việc đã lưu/ứng tuyển</a></li>

                     <li><a href="${pageContext.request.contextPath}/user/follow-companies">Công ty đã theo dõi/các việc theo dõi</a></li>
                   </c:if>
                  <c:if test="${user.role.id != 1}">
                   <li><a href="${pageContext.request.contextPath}/recruitment/post-list">Danh sách bài đăng</a></li>
                   <li><a href="${pageContext.request.contextPath}/recruitment/post">Đăng tuyển</a></li>
                  </c:if>
                   <li><a href="logout">Đăng xuất</a></li>
                 </ul>
               </li>

                <c:if test="${user.role.id != 1}">
                    <li class="nav-item cta mr-md-1"><a href="${pageContext.request.contextPath}/recruitment/post" class="nav-link">Đăng tuyển</a></li>
                </c:if>
            </c:if>
            <c:if test="${not sessionScope.loggedIn}">
             <li class="nav-item cta cta-colored"><a href="${pageContext.request.contextPath}" class="nav-link">Đăng nhập</a></li>
             </c:if>
           </ul>
         </div>

        </div>
      </nav>
<!-- END nav -->
<!-- <div th:if="${msg_register_success}" class="toast" data-delay="2000" style="position:fixed;top: 100PX; right: 10PX;z-index: 2000;width: 300px">
    <script>
        swal({
            title: 'Đăng nhập thành công!',
            /* text: 'Redirecting...', */
            icon: 'success',
            timer: 3000,
            buttons: true,
            type: 'success'
        })
    </script>-->
</div>
<div class="hero-wrap img" style="background-image: url(../resources/assets/images/bg_1.jpg);">
    <div class="overlay"></div>
    <div class="container">
        <div class="row d-md-flex no-gutters slider-text align-items-center justify-content-center">
            <div class="col-md-10 d-flex align-items-center ">
                <div class="text text-center pt-5 mt-md-5">
                    <p class="mb-4">Tìm việc làm, Cơ hội việc làm và Nghề nghiệp</p>
                    <h1 class="mb-5">Cách dễ dàng nhất để có được công việc mới của bạn</h1>
                    <div class="ftco-counter ftco-no-pt ftco-no-pb">
                        <div class="row">
                            <div class="col-md-4 d-flex justify-content-center counter-wrap ">
                                <div class="block-18">
                                    <div class="text d-flex">
                                        <div class="icon mr-2">
                                            <span class="flaticon-visitor"></span>
                                        </div>
                                        <div class="desc text-left">
                                            <strong class="number" data-number="46" >${numberOfAddresses}</strong>
                                            <span>Địa điểm</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 d-flex justify-content-center counter-wrap ">
                                <div class="block-18 text-center">
                                    <div class="text d-flex">
                                        <div class="icon mr-2">
                                            <span class="flaticon-visitor"></span>
                                        </div>
                                        <div class="desc text-left">
                                            <strong class="number" data-number="450">${numberOfCompanies}</strong>
                                            <span>Công ty</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 d-flex justify-content-center counter-wrap">
                                <div class="block-18 text-center">
                                    <div class="text d-flex">
                                        <div class="icon mr-2">
                                            <span class="flaticon-resume"></span>
                                        </div>
                                        <div class="desc text-left">
                                            <strong class="number" data-number="80000" >${numberOfRecruitment}</strong>
                                            <span>Tuyển dụng</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="ftco-search my-md-5">
                        <div class="row">
                            <div class="col-md-12 nav-link-wrap">
                                <div class="nav nav-pills text-center" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                                    <a class="nav-link active mr-md-1" id="v-pills-1-tab" data-toggle="pill" href="#v-pills-1" role="tab" aria-controls="v-pills-1" aria-selected="true">Tìm công việc</a>

                                    <a class="nav-link" id="v-pills-2-tab" data-toggle="pill" href="#v-pills-2" role="tab" aria-controls="v-pills-2" aria-selected="false">Tìm công ty</a>
                                    <a class="nav-link" id="v-pills-3-tab" data-toggle="pill" href="#v-pills-3" role="tab" aria-controls="v-pills-3" aria-selected="false">Tìm theo địa điểm</a>

                                </div>
                            </div>
                            <div class="col-md-12 tab-wrap">

                                <div class="tab-content p-4" id="v-pills-tabContent">

                                    <div class="tab-pane fade show active" id="v-pills-1" role="tabpanel" aria-labelledby="v-pills-nextgen-tab">
                                        <form action="search" method="post" class="search-job">
                                            <div class="row no-gutters">
                                                <div class="col-md-10 mr-md-2">
                                                    <div class="form-group">
                                                        <div class="form-field">
                                                            <div class="icon"><span class="icon-map-marker"></span></div>
                                                            <input type="text" name="keySearch" class="form-control" placeholder="Tìm kiếm công việc">
                                                        </div>
                                                    </div>
                                                </div>
                                                 <div class="col-md">
                                                    <div class="form-group">
                                                        <div class="form-field">
                                                            <button type="submit" class="form-control btn btn-primary">Tìm kiếm</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>

                                    <div class="tab-pane fade" id="v-pills-2" role="tabpanel" aria-labelledby="v-pills-performance-tab">
                                        <form action="search" method="post" class="search-job">
                                            <div class="row no-gutters">

                                                <div class="col-md-10 mr-md-2">
                                                    <div class="form-group">
                                                        <div class="form-field">
                                                            <div class="icon"><span class="icon-map-marker"></span></div>
                                                            <input type="text" name="keySearch" class="form-control" placeholder="Tìm theo công ty">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md">
                                                    <div class="form-group">
                                                        <div class="form-field">
                                                            <button type="submit" class="form-control btn btn-primary">Tìm kiếm</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="tab-pane fade" id="v-pills-3" role="tabpanel" aria-labelledby="v-pills-performance-tab">
                                        <form action="search" method="post" class="search-job">
                                            <div class="row no-gutters">

                                                <div class="col-md-10 mr-md-2">
                                                    <div class="form-group">
                                                        <div class="form-field">
                                                            <div class="icon"><span class="icon-map-marker"></span></div>
                                                            <input type="text" name="keySearch" class="form-control" placeholder="Tìm kiếm theo địa điểm">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md">
                                                    <div class="form-group">
                                                        <div class="form-field">
                                                            <button type="submit" class="form-control btn btn-primary">Tìm kiếm</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<section class="ftco-section">
    <div class="container">
        <div class="row justify-content-center mb-5">

            <div style="display: block" class="col-md-7 heading-section text-center">
                <span class="subheading">Danh mục công việc</span>
                <h2 class="mb-0">Top Danh Mục</h2>
            </div>
        </div>
        <div class="row">
            <c:forEach items="${categories}" var="category">
                <div class="col-md-3 ">
                    <ul class="category text-center">
                        <li>
                            <a style="text-decoration: none !important;" href="">
                                <p >${category.getName()}</p>
                                <span class="number" >${category.getNumberChoose()}</span>
                                <span>Vị trí</span><i class="ion-ios-arrow-forward"></i>
                            </a>
                        </li>
                    </ul>
                </div>
           </c:forEach>
        </div>
    </div>
</section>

<section class="ftco-section services-section">
    <div class="container">
        <div class="row d-flex">
            <div class="col-md-3 d-flex align-self-stretch ">
                <div class="media block-6 services d-block">
                    <div class="icon"><span class="flaticon-resume"></span></div>
                    <div class="media-body">
                        <h3 class="heading mb-3">Tìm kiếm hàng triệu việc làm</h3>
                        <p>Một con sông nhỏ tên là Duden chảy qua nơi ở và nguồn cung cấp của họ.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 d-flex align-self-stretch ">
                <div class="media block-6 services d-block">
                    <div class="icon"><span class="flaticon-team"></span></div>
                    <div class="media-body">
                        <h3 class="heading mb-3">Dễ dàng quản lý công việc</h3>
                        <p>Một con sông nhỏ tên là Duden chảy qua nơi ở và nguồn cung cấp của họ.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 d-flex align-self-stretch ">
                <div class="media block-6 services d-block">
                    <div class="icon"><span class="flaticon-career"></span></div>
                    <div class="media-body">
                        <h3 class="heading mb-3">Top Nghề nghiệp</h3>
                        <p>Một con sông nhỏ tên là Duden chảy qua nơi ở và nguồn cung cấp của họ.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 d-flex align-self-stretch ">
                <div class="media block-6 services d-block">
                    <div class="icon"><span class="flaticon-employees"></span></div>
                    <div class="media-body">
                        <h3 class="heading mb-3">Ứng viên Chuyên gia Tìm kiếm</h3>
                        <p>Một con sông nhỏ tên là Duden chảy qua nơi ở và nguồn cung cấp của họ.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="ftco-section bg-light">
    <div class="container">
        <div id="memo" style="display:none;">${memo}</div>
        <div class="row">
            <div class="col-lg-9 pr-lg-5">
                <div class="row justify-content-center pb-3">
                    <div class="col-md-12 heading-section ">
                        <span class="subheading">CÔNG VIỆC ĐƯỢC NHIỀU NGƯỜI ỨNG TUYỂN</span>
                        <h2 class="mb-4">Các bài đăng về việc làm nổi bật</h2>

                    </div>
                </div>
               <div class="row">
                   <c:forEach items="${recruitments}" var="recruitment">
                       <div class="col-md-12">
                           <div class="job-post-item p-4 d-block d-lg-flex align-items-center">
                               <div class="one-third mb-4 mb-md-0">
                                   <div class="job-post-item-header align-items-center">
                                       <span class="subadge">${recruitment.type}</span>
                                       <h2 class="mr-3 text-black">
                                           <a href="/recruitment/detail/${recruitment.id}">${recruitment.title}</a>
                                       </h2>
                                   </div>
                                   <div class="job-post-item-body d-block d-md-flex">
                                       <div class="mr-3"><span class="icon-layers"></span> <a href="#">${recruitment.company.nameCompany}</a></div>
                                       <div><span class="icon-my_location"></span> <span>${recruitment.address}</span></div>
                                   </div>
                               </div>
                               <input type="hidden" id="${'idRe'}${recruitment.id}" value="${recruitment.id}">
                               <div class="one-forth ml-auto d-flex align-items-center mt-4 md-md-0">

                                       <form action="${pageContext.request.contextPath}/user/followJob" method="POST">
                                             <c:set var="hashSetIdSaveJobs" value="${sessionScope.hashSetIdSaveJobs}" />
                                            <input type="hidden" name="recruitmentID" value="${recruitment.id}">
                                            <button type="submit" class="icon text-center d-flex justify-content-center align-items-center icon mr-2">
                                                <span id="follow_job_${recruitment.id}" class="icon-heart"
                                                    style="${hashSetIdSaveJobs.contains(recruitment.id) ? 'color: red;' : ''}" ></span>
                                            </button>
                                        </form>
                                    <a data-toggle="modal" data-target="#exampleModal_${recruitment.id}" class="btn btn-primary py-2">Apply Job</a>
                               </div>
                           </div>
                       </div><!-- end -->
                       <!-- Modal -->
                       <div class="modal fade" id="exampleModal_${recruitment.id}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                           <div class="modal-dialog" role="document">
                               <div class="modal-content">
                                   <div class="modal-header">
                                       <h5 class="modal-title" id="exampleModalLabel">Ứng tuyển: <span>${recruitment.title}</span></h5>
                                       <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                           <span aria-hidden="true">&times;</span>
                                       </button>
                                   </div>
                                   <form method="post" action="${pageContext.request.contextPath}/user/applyJob" enctype="multipart/form-data">
                                       <div class="modal-body">
                                           <div class="row">
                                               <div class="col-12">
                                                   <select class="form-control selectMethod" aria-label="Default select example">
                                                       <option selected>Chọn phương thức nộp</option>
                                                       <option value="1">Dùng cv đã cập nhật</option>
                                                       <option value="2">Nộp cv mới</option>
                                                   </select>
                                               </div>
                                               <div id="choose_1" style="display:none" class="col-12">
                                                   <label for="fileUpload" class="col-form-label">Giới thiệu:</label>
                                                   <textarea rows="10" cols="3" class="form-control" name="presentation" ></textarea>
                                               </div>
                                               <div id="choose_2" style="display:none" class="col-12">
                                                   <label for="fileUpload" class="col-form-label">Chọn cv:</label>
                                                   <input id="chooseCV" type="file" class="form-control"  name="file" required>
                                                   <label for="fileUpload" class="col-form-label">Giới thiệu:</label>
                                                   <textarea rows="10" cols="3" class="form-control" name="present" ></textarea>
                                               </div>
                                           </div>
                                           <div class="modal-footer">
                                                 <input type="hidden" class="form-control"  name="idRecruitment" value="${recruitment.id}">
                                               <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                                               <button id="type1" style="display:none" type="submit"  class="btn btn-primary">Nộp</button>
                                               <button id="type2" style="display:none" type="submit"  class="btn btn-primary">Nộp</button>
                                           </div>
                                       </div>
                                   </form>
                               </div>
                           </div>
                       </div>
                   </c:forEach>
               </div>

            </div>
         <c:if test="${not empty companies and companies.size() > 0}">
            <div class="col-lg-3 sidebar">
                <div class="row justify-content-center pb-3">
                    <div class="col-md-12 heading-section ">
                        <h2 class="mb-4">Danh Sách Công Ty</h2>
                    </div>
                </div>
                <c:forEach items="${companies}" var="companyEntry">
                    <div class="sidebar-box">
                        <div class="">
                         <c:if test="${companyEntry.key.getLogo() ne null}">
                            <a href="${pageContext.request.contextPath}/Home/detail-company/${companyEntry.key.id}" class="company-wrap"><img src="data:image/jpg;base64,${Base64Encoder.encode(companyEntry.key.getLogo())}" class="img-fluid" alt="Colorlib Free Template"></a>
                          </c:if>
                            <div class="text p-3">
                                <h3><a href="detail-company/${companyEntry.key.id}">${companyEntry.key.nameCompany}</a></h3>
                                <p><span class="number" style="color: black">${companyEntry.value}</span> <span>Vị trí ứng tuyển</span></p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
         </c:if>
        </div>
    </div>
</section>


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