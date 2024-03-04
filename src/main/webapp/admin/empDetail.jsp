<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.vo.EmpVO" %>

<%
    List<EmpVO> empList = (List) request.getAttribute("empList");
    EmpVO rmap = empList.get(0);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>사원정보</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/signature_pad/1.5.3/signature_pad.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script type="text/javascript">


        // 직원 정보 수정 함수
        const empInfoUpdate = () => {
            if (validateForm()) {
                // 유효성 검사 성공 시, SweetAlert를 사용하여 성공 메시지 표시 후 폼 제출
                Swal.fire("사원수정 완료!", "", "success")
                    .then((result) => {
                        if (result.isConfirmed || result.isDismissed) {
                            document.querySelector("#f_member").submit();
                        }
                    });
            } else {
                // 유효성 검사 실패 시, SweetAlert를 사용하여 오류 메시지 표시
                Swal.fire("오류!", "사원수정 양식을 올바르게 입력해주세요.", "error");
            }
        };

        // 취소 버튼 클릭 시, 사원 목록 페이지로 이동하는 함수
        const btn_Cancel = () =>{
            location.href = "/admin/empList";
        }

        // 이미지 클릭 시 파일 업로드 input 클릭 이벤트를 발생시키는 함수
        function handleImgClick() {
            document.getElementById('profileImgInput').click();
        }

        // 파일 선택 시 이미지 미리보기 함수
        function preview(event) {
            var input = event.target;
            var preview = document.getElementById('previewImage');

            // 파일 업로드가 변경된 경우
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                // 이미지를 미리보기로 읽어들임
                reader.onload = function(e) {
                    preview.src = e.target.result;
                }

                // 파일을 읽어들임
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>

</head>
<body class="hold-transition sidebar-mini sidebar-collapse">
<div class="wrapper">
    <!-- header start -->
    <%@include file="/include/KGW_bar.jsp"%>
<div class="content-wrapper">
    <!-- 페이지 path start    -->
    <!-- <div class="card"> -->
    <div class="box-header p-4">
        <div class="d-flex align-items-center">
            <div class="d-flex align-items-center me-2">
                <a class="text-muted fs-6" href="#">관리자페이지</a>
                <div class="ms-2">></div>
            </div>
            <div class="d-flex align-items-center">
                <div class="text-dark fs-6">사원관리</div>
                <div class="ms-2">></div>
            </div>
            <div class="d-flex align-items-center">
                <div class="text-dark fs-6">사원정보</div>
            </div>
        </div>
        <div class="d-flex align-items-center mt-3">
            <div class="position-relative">
                <div class="position-absolute top-0 start-0"></div>
            </div>
            <div class="d-flex align-items-center ms-2">
                <div class="fw-bold fs-5">사원정보</div>
                <div class="text-muted ms-3">사원정보를 관리 및 수정 할 수 있는 페이지입니다.</div>
            </div>
        </div>
    </div>
    <div class="content">
        <div class="box">
            <div class="container">
                <div class="box-header">
                    <h4 style="font-weight: bold; margin-left: 2rem" >사원정보</h4>
                    <hr />
                </div>
                <div class="box-header">
                    <p style="display: flex; align-items: center; justify-content: flex-end;" >생성일 : <%=rmap.getReg_date()%></p>
                    <p style="display: flex; align-items: center; justify-content: flex-end;" >수정일 : <%=rmap.getMod_date()%></p>

                </div>
                <div class="box-header">
                    <h3 style="display: flex; align-items: center; justify-content: center;" ><%=rmap.getName()%>님 정보</h3>
                </div>

                <div class="box-header" style="display: flex;">

                    <div class="col-2">
                        <div class="signImg" style="border: 2px solid grey; width: 200px; height: 200px">
                            <img id="signImage" src="/fileUpload/sign/<%=rmap.getEmp_no()%>.png" style="width: 190px; height: 190px" class="sign" alt="sign" data-bs-toggle="modal" data-bs-target="#signSelect">
                        </div>
                    </div>
                    <div class="col-8">
                        <div class="box-header" style="display: flex; align-items: center; justify-content: center;">
                            <img src="/fileUpload/profile/<%=rmap.getEmp_no()%>.png" id="previewImage" class="img-circle m-5" alt='' style="width: 200px; height: 200px; cursor: pointer;" onclick="handleImgClick()">
                        </div>
                    </div>
                </div>

                <form id="f_member" method="post" action="/admin/empInfoUpdate" enctype="multipart/form-data">
                    <input type="file" id="profileImgInput" name="profiles" onchange="preview(event)" style="display: none;">
                    <input type="hidden" name="emp_no" value="<%=rmap.getEmp_no()%>">
                    <div class="row">
                    <div class="col-6 mb-3 mt-3">
                        <label for="name">이름 <span class="text-danger">*</span>
                            <span id="name_" class="text-danger" style="display:none" > 2~5글자로 입력해주세요. </span>
                        </label>
                        <input type="text" class="form-control" id="name" name="name" onblur="validateName()" value="<%=rmap.getName()%>">
                    </div>
                    <div class="col-6 mb-3 mt-3">
                        <label for="password">비밀번호 <span class="text-danger">*</span>
                            <span id="password_" class="text-danger" style="display:none"> 대소문자와 숫자 4~12자리로 입력하세요.</span></label>
                        <input type="password" class="form-control" id="password" name="password"  onblur="validatePassword()" value="<%=rmap.getPassword()%>">
                    </div>
                    </div>

                    <div class="row">
                        <div class="col-6 mb-3 mt-3">
                        <label for="birthdate">생년월일 <span class="text-danger">*</span>
                            <span id="birthdate_" class="text-danger" style="display:none"  >생년월일 형식이 아닙니다.</span> </label>
                        <input type="date" class="form-control" id="birthdate"  name="birthdate" onblur="validateBirthdate()" value="<%=rmap.getBirthdate()%>" >
                    </div>
                    <div class="col-6 mb-3 mt-3">
                        <label for="phone_num">전화번호 <span class="text-danger">*</span>
                            <span id="phone_num_" class="text-danger" style="display:none"  >전화번호 형식이 아닙니다.</span> </label>
                        <input type="tel" class="form-control" id="phone_num" name="phone_num" onblur="validatePhone()" value="<%=rmap.getPhone_num()%>">
                    </div>
                    </div>

                    <div class="row">
                        <div class="col-6 mb-3 mt-3">
                        <label for="email">이메일 <span class="text-danger">*</span>
                            <span id="email_" class="text-danger" style="display:none"  >이메일형식이 아닙니다.</span> </label>
                        <input type="email" class="form-control" id="email" name="email" onblur="validateEmail()" value="<%=rmap.getEmail()%>">
                    </div>
                    <div class="col-6 mb-3 mt-3">
                        <label for="address">주소
                            <span id="address_" class="text-danger" style="display:none"  >주소형식이 아닙니다.</span>
                        </label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="address" name="address" onblur="validateAddress()" placeholder="우편번호" aria-describedby="search-btn" value="<%=rmap.getAddress()%>">
                            <div class="input-group-append">
                                <button class="btn btn-success" type="button" id="search-btn" onclick="openZipcode()">검색</button>
                            </div>
                        </div>
                    </div>
                    </div>

                    <div class="row">
                        <div class="col-6 mb-3 mt-3">
                        <label for="team_no">부서
                            <span id="team_no_" class="text-danger" style="display:none">부서형식이 아닙니다.</span>
                        </label>
                        <select class="form-control" id="team_no" name="team_no" onblur="validateTeam()">
                            <option value="<%=rmap.getTeam_no()%>" selected> <%=rmap.getTeam_name()%> </option>
                            <hr class="dropdown-divider">
                            <option value="1">경영지원팀</option>
                            <option value="2">운영팀</option>
                            <!-- Add more options as needed -->
                        </select>
                    </div>
                    <div class="col-6 mb-3 mt-3">
                        <label for="emp_position">직급
                            <span id="emp_position_" class="text-danger" style="display:none">직급형식이 아닙니다.</span>
                        </label>
                        <select class="form-control" id="emp_position" name="emp_position" onblur="validatePosition()">
                            <option value="<%=rmap.getEmp_position()%>" selected><%=rmap.getEmp_position()%></option>
                            <hr class="dropdown-divider">
                            <option value="사원">사원</option>
                            <option value="팀장">팀장</option>
                            <!-- Add more options as needed -->
                        </select>
                    </div>
                    </div>

                    <div class="row">
                        <div class="col-6 mb-3 mt-3">
                            <label for="hire_date">입사일 <span class="text-danger">*</span>
                                <span id="hire_date_" class="text-danger" style="display:none"  >형식이 아닙니다.</span> </label>
                            <input type="date" class="form-control" id="hire_date" name="hire_date" onblur="validateHire()" value="<%=rmap.getHire_date()%>">
                        </div>
                        <div class="col-6 mb-3 mt-3">
                            <label for="retire_date">퇴사일 <span class="text-danger">*</span>
                                <span id="retire_date_" class="text-danger" style="display:none"  >형식이 아닙니다.</span> </label>
                            <input type="date" class="form-control" id="retire_date" name="retire_date" onblur="validate()" value="<%=rmap.getRetire_date()%>">
                        </div>

                    </div>


                    <div class="row">
                        <div class="col-6 mb-3 mt-3">
                            <label for="emp_state">상태
                                <span id="emp_state_" class="text-danger" style="display:none">형식이 아닙니다.</span>
                            </label>
                            <select class="form-control" id="emp_state" name="emp_state" >
                                    <% if (rmap.getEmp_state().equals("0")){ %>
                                <option value="<%=rmap.getEmp_state()%>" selected>퇴직</option>
                                    <% }else{ %>
                                <option value="<%=rmap.getEmp_state()%>" selected>재직</option>
                                <%  } %>
                                <hr class="dropdown-divider">
                                <option value="0">퇴직</option>
                                <option value="1">재직</option>

                                <!-- Add more options as needed -->
                            </select>
                        </div>
                        <div class="col-6 mb-3 mt-3">
                            <label for="emp_access">권한
                                <span id="emp_access_" class="text-danger" style="display:none">형식이 아닙니다.</span>
                            </label>
                            <select class="form-control" id="emp_access" name="emp_access" >
                                <option value="<%=rmap.getEmp_access()%>" selected><%=rmap.getEmp_position()%></option>
                                <hr class="dropdown-divider">
                                <option value="ROLE_USER">사원</option>
                                <option value="ROLE_ADMIN">경영지원팀</option>
                                <option value="ROLE_MANAGE">운영팀</option>
                                <!-- Add more options as needed -->
                            </select>
                        </div>
                    </div>
                    <br>
                    <br>
                    <br>
                    <div class="row">
                        <div class="col-6 mb-3 mt-3" style="display: flex; align-items: center; justify-content: center;">
                        <input
                                type="button"
                                class="btn btn-primary float-right"
                                onclick="btn_Cancel()"
                                value="취소"
                        />

                    </div>
                        <div class="col-6 mb-3 mt-3" style="display: flex; align-items: center; justify-content: center;">
                        <input
                                type="button"
                                class="btn btn-primary float-right"
                                onclick="empInfoUpdate()"
                                value="수정"
                        />

                    </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

    <script>
        // 정규표현식 패턴 상수 선언

        // 아이디 정규식표현
        const expIdText = /^[A-Za-z0-9]{4,12}$/;

        // 비밀번호 정규식표현
        const expPwText = /^[A-Za-z0-9]{4,12}$/;

        // 이름 정규식표현
        const expNameText = /^[가-힣]{2,5}$/;

        // 핸드폰 정규식표현
        const expPhoneText = /^\d{3}-\d{3,4}-\d{4}$/;

        // 생년월일 정규식표현
        const expDateText = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;

        // 이메일 정규식표현
        const expEmailText = /^[a-zA-Z0-9._+=-]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,4}$/;

        // 부서 정규식표현
        const expTeamText = /^[1-9]{1,2}$/;

        // 권한 정규식표현
        const expRoleText = /ROLE/;

        // 주소 정규식표현
        const expAddressText = /^[가-힣a-zA-Z0-9-.,\s]{1,60}$/;

        // 각 입력 필드의 유효성을 검사하는 함수
        const validateForm = () => {
            // 각 입력 필드에 대한 유효성 검사 함수 호출
            const isPasswordValid = validatePassword();
            const isNameValid = validateName();
            const isBirthdateValid = validateBirthdate();
            const isPhoneValid = validatePhone();
            const isEmailValid = validateEmail();
            const idHireValid = validateHire();
            const isAccessValid = validateAccess();
            const isStateValid = validateState();
            const isTeamValid = validateTeam();
            const isAddressValid = validateAddress();
            const isPositionValid = validatePosition();

            // 모든 검사가 통과되면 true를 반환하고, 그렇지 않으면 false를 반환합니다.
            return isPasswordValid && isNameValid && isBirthdateValid && isPhoneValid && isEmailValid && idHireValid && isAccessValid && isStateValid && isTeamValid && isAddressValid && isPositionValid;
        }

        // 이름 유효성 검사 함수
        const validateName = () => {
            const nmSpan = document.getElementById('name_');
            const mbrNmInput = document.getElementById('name');
            const isValid = expNameText.test(mbrNmInput.value);

            // 유효성에 따라 오류 메시지 표시 여부 결정
            if (isValid) {
                nmSpan.style.display = 'none';
            } else {
                nmSpan.style.display = 'inline';
            }
            return isValid;
        }

        // 비밀번호 유효성 검사 함수
        const validatePassword = () => {
            // 오류 메시지를 표시할 span 요소 및 비밀번호 input 요소 가져오기
            const pwSpan = document.getElementById('password_');
            const mbrPwInput = document.getElementById('password');
            const isValid = expPwText.test(mbrPwInput.value);

            // 유효성에 따라 오류 메시지 표시 여부 결정
            if (isValid) {
                pwSpan.style.display = 'none';
            } else {
                pwSpan.style.display = 'inline';
            }
            return isValid;
        }

        // 생년월일 유효성 검사 함수
        const validateBirthdate = () => {
            // 오류 메시지를 표시할 span 요소 및 생년월일 input 요소 가져오기
            const dateSpan = document.getElementById('birthdate_');
            const mbrBirthdateInput = document.getElementById('birthdate');
            const isValid = expDateText.test(mbrBirthdateInput.value);

            // 유효성에 따라 오류 메시지 표시 여부 결정
            if (isValid) {
                dateSpan.style.display = 'none';
            } else {
                dateSpan.style.display = 'inline';
            }
            return isValid;
        }

        // 핸드폰 번호 유효성 검사 함수
        const validatePhone = () => {
            // 오류 메시지를 표시할 span 요소 및 핸드폰 번호 input 요소 가져오기
            const numberSpan = document.getElementById('phone_num_');
            const mbrPhoneInput = document.getElementById('phone_num');
            const isValid = expPhoneText.test(mbrPhoneInput.value);

            // 유효성에 따라 오류 메시지 표시 여부 결정
            if (isValid) {
                numberSpan.style.display = 'none';
            } else {
                numberSpan.style.display = 'inline';
            }
            return isValid;
        }

        // 이메일 유효성 검사 함수
        const validateEmail = () => {
            // 오류 메시지를 표시할 span 요소 및 이메일 input 요소 가져오기
            const emailSpan = document.getElementById('email_');
            const mbrEmailInput = document.getElementById('email');
            const isValid = expEmailText.test(mbrEmailInput.value);

            // 유효성에 따라 오류 메시지 표시 여부 결정
            if (isValid) {
                emailSpan.style.display = 'none';
            } else {
                emailSpan.style.display = 'inline';
            }
            return isValid;
        }

        // 부서 유효성 검사 함수
        const validateTeam = () => {
            // 오류 메시지를 표시할 span 요소 및 부서 input 요소 가져오기
            const teamSpan = document.getElementById('team_no_');
            const mbrNmInput = document.getElementById('team_no');
            const isValid = expTeamText.test(mbrNmInput.value);

            // 유효성에 따라 오류 메시지 표시 여부 결정
            if (isValid) {
                teamSpan.style.display = 'none';
            } else {
                teamSpan.style.display = 'inline';
            }
            return isValid;
        }

        // 직위(직책) 유효성 검사 함수
        const validatePosition = () => {
            const positionSpan = document.getElementById('emp_position_'); // 오류 메시지를 표시할 span 요소 가져오기
            const mbrNmInput = document.getElementById('emp_position'); // 직위 입력 필드 가져오기
            const isValid = expNameText.test(mbrNmInput.value); // 정규식 패턴을 사용하여 입력값을 검사

            // 유효한 경우 오류 메시지를 숨기고, 그렇지 않은 경우 표시
            if (isValid) {
                positionSpan.style.display = 'none';
            } else {
                positionSpan.style.display = 'inline';
            }
            return isValid; // 유효성 여부 반환
        }

        // 상태(재직/퇴직) 유효성 검사 함수
        const validateState  = () => {
            const stateSpan = document.getElementById('emp_state_'); // 오류 메시지를 표시할 span 요소 가져오기
            const mbrNmInput = document.getElementById('emp_state'); // 상태 입력 필드 가져오기
            const isValid = expTeamText.test(mbrNmInput.value); // 정규식 패턴을 사용하여 입력값을 검사

            // 유효한 경우 오류 메시지를 숨기고, 그렇지 않은 경우 표시
            if (isValid) {
                stateSpan.style.display = 'none';
            } else {
                stateSpan.style.display = 'inline';
            }
            return isValid; // 유효성 여부 반환
        }

        // 권한 유효성 검사 함수
        const validateAccess  = () => {
            const acSpan = document.getElementById('emp_access_'); // 오류 메시지를 표시할 span 요소 가져오기
            const mbrNmInput = document.getElementById('emp_access'); // 권한 입력 필드 가져오기
            const isValid = expRoleText.test(mbrNmInput.value); // 정규식 패턴을 사용하여 입력값을 검사

            // 유효한 경우 오류 메시지를 숨기고, 그렇지 않은 경우 표시
            if (isValid) {
                acSpan.style.display = 'none';
            } else {
                acSpan.style.display = 'inline';
            }
            return isValid; // 유효성 여부 반환
        }

        // 입사일 유효성 검사 함수
        const validateHire  = () => {
            const hireSpan = document.getElementById('hire_date_'); // 오류 메시지를 표시할 span 요소 가져오기
            const mbrNmInput = document.getElementById('hire_date'); // 입사일 입력 필드 가져오기
            const isValid = expDateText.test(mbrNmInput.value); // 정규식 패턴을 사용하여 입력값을 검사

            // 유효한 경우 오류 메시지를 숨기고, 그렇지 않은 경우 표시
            if (isValid) {
                hireSpan.style.display = 'none';
            } else {
                hireSpan.style.display = 'inline';
            }
            return isValid; // 유효성 여부 반환
        }

        // 주소 유효성 검사 함수
        const validateAddress  = () => {
            const addressSpan = document.getElementById('address_'); // 오류 메시지를 표시할 span 요소 가져오기
            const mbrNmInput = document.getElementById('address'); // 주소 입력 필드 가져오기
            const isValid = expAddressText.test(mbrNmInput.value); // 정규식 패턴을 사용하여 입력값을 검사

            // 유효한 경우 오류 메시지를 숨기고, 그렇지 않은 경우 표시
            if (isValid) {
                addressSpan.style.display = 'none';
            } else {
                addressSpan.style.display = 'inline';
            }
            return isValid; // 유효성 여부 반환
        }
    </script>

    <div class="modal" id="signSelect">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content rounded-4 shadow">
                <div class="modal-header p-5 pb-0 border-bottom-0" style="margin-bottom: -20px;">
                    <h1 class="fw-bold  fs-2" >전자서명변경</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-5 pt-0">
                    <form id="signInsert" method="post" action="/fileSave" enctype="multipart/form-data">
                        <canvas id="signature-pad" width=400 height=200 style="margin-bottom: 20px; border: 2px solid black"></canvas>
                        <input type="hidden" id="emp_no" name="emp_no" value="<%=rmap.getEmp_no()%>">
                        <div>
                            <button type="button" id="clear" class="btn btn-danger">초기화</button>
                            <button type="button" id="save" class="btn btn-danger">저장</button>
                            <button type="button" class="btn btn-danger button save" data-action="save-png">내 pc에 저장</button>
                        </div>
                        <script>
                            // 캔버스 및 서명 패드 생성
                            let canvas = document.getElementById('signature-pad');
                            let signaturePad = new SignaturePad(canvas);

                            // Clear 버튼 클릭 이벤트
                            document.getElementById('clear').addEventListener('click', function () {
                                signaturePad.clear(); // 서명 지우기
                            });

                            // PNG로 저장 버튼 클릭 이벤트
                            document.querySelector('[data-action="save-png"]').addEventListener('click', function () {
                                let dataURL = signaturePad.toDataURL(); // 서명을 데이터 URL로 변환

                                let downloadLink = document.createElement('a');
                                downloadLink.href = dataURL;
                                downloadLink.download = '<%=rmap.getEmp_no()%>.png'; // 다운로드할 파일 이름 설정

                                // 다운로드 링크 생성 및 클릭하여 다운로드
                                document.body.appendChild(downloadLink);
                                downloadLink.click();
                                document.body.removeChild(downloadLink);
                            });

                            // 서명 저장 버튼 클릭 이벤트
                            document.getElementById('save').addEventListener('click', function () {
                                let canvas = document.getElementById('signature-pad');
                                let dataURL = canvas.toDataURL('image/png'); // 캔버스 내용을 데이터 URL로 가져옴

                                // 데이터 URL을 Blob 객체로 변환
                                let blob = dataURItoBlob(dataURL);

                                // FormData 객체 생성
                                let formData = new FormData();
                                formData.append('image', blob, '<%=rmap.getEmp_no()%>.png'); // 이미지 파일 및 이름 설정

                                // 서명 이미지를 서버로 전송
                                $.ajax({
                                    type: 'POST',
                                    url: '/fileSave',
                                    data: formData,
                                    processData: false, // FormData를 처리하지 않도록 설정
                                    contentType: false, // 컨텐츠 타입을 false로 설정하여 jQuery가 컨텐츠 타입을 설정하지 않도록 함
                                    success: function (response) {
                                        console.log('파일 전송 성공');
                                        $('.modal').modal('hide'); // 모달 숨기기
                                        document.querySelector("#signImage").src = "/fileUpload/sign/<%=rmap.getEmp_no()%>.png"; // 서명 이미지 업데이트
                                        signaturePad.clear(); // 서명 지우기
                                    },
                                    error: function (xhr, status, error) {
                                        console.error('파일 전송 실패:', error);
                                        // 실패한 경우 처리할 내용 추가
                                    }
                                });

                                // 데이터 URL을 Blob 객체로 변환하는 함수
                                function dataURItoBlob(dataURI) {
                                    // Base64 데이터 부분 분리
                                    let byteString = atob(dataURI.split(',')[1]);
                                    let mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];
                                    // Blob 객체 생성
                                    let arrayBuffer = new ArrayBuffer(byteString.length);
                                    let intArray = new Uint8Array(arrayBuffer);
                                    for (let i = 0; i < byteString.length; i++) {
                                        intArray[i] = byteString.charCodeAt(i);
                                    }
                                    return new Blob([arrayBuffer], {type: mimeString});
                                }
                            });

                        </script>
                    </form>

                </div>
            </div>
        </div>
    </div>

</body>
</html>
