document.getElementById('trigger').addEventListener('click',()=>{
    document.getElementById('files').click();
});

//정규표현식을 이용한 생성자 함수 만들기
//fileload시 형식제한 함수
//실행파일(exe 파일) 막기
//이미지파일 가능
//생성자파일을 만들때는 시작 \ 끝$ 
const regExp = new RegExp("\.(exe|sh|bat|msi|dll|js)$"); //실행파일 
const regExpImg = new RegExp("\.(jpg|jpeg|png|gif)$"); // 이미지파일
const maxSize = 1024*1024*20; //20MB보다 큰지 체크

function fileSizeVaildation(fileName, fileSize){
    if(regExp.test(fileName)){ //실행파일이 있으면 리턴 0
        return 0;
    }else if(!regExpImg.test(fileName)){ //이미지 파일이 아니면 리턴 0
        return 0;
    }else if(fileSize > maxSize){ // 사이즈가 너무 크면
        return 0;
    }else{
        return 1;
    }
}

document.addEventListener('change',(e)=>{

    if(e.target.id == "files"){
        document.getElementById('regBtn').disabled = false; // 수정완료 버튼 활성화 
        //input type="file"을 가지고 오는 element는 fileObject 객체로 리턴
        const fileObject = document.getElementById('files').files;  //멀티플이기때문에 files
        console.log(fileObject);

        let div = document.getElementById('fileZone');
        div.innerHTML="";
        let ul = '<ul class="list-group list-group-flush">';
        let isOk = 1; //fileSizeVaildation의function을 통과한 아이만
        for(let file of fileObject){
            let validResult = fileSizeVaildation(file.name, file.size); //0 또는 1이 출력됨
            //모든 파일이 1이어야 등록가능
            isOk *=validResult; //0이 하나라도 발생하면 결과값 0
            ul+=`<li class="list-group-item d-flex justify-content-between align-items-start">`;
            //업로드 가능여부 표시
            ul += `${validResult ? '<div class="fw-bold"> 업로드 가능' : '<div class="fw-bold text-danger"> 업로드 불가'}</div>`;   //각 파일이 업로드 가능여부
            ul += `${file.name}`;
            ul += `<span class="badge bg-${validResult ? 'sucess' : 'danger'} rounded-pill">${file.size} Bytes</span></li>`; 
        }
        ul+=`</ul>`;
        div.innerHTML = ul;
        if(isOk ==0){
            document.getElementById('regBtn').disabled = true;  //수정완료 버튼 비활성화 : 들어오면 안되는 첨부파일이 있을 때 클릭되는 것을 방지
        }
    }
})



