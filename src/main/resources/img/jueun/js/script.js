const info = document.querySelector(".info");
const title = document.querySelector(".title");
let lastX = 0;
let lastY = 0; 
let startX = 0; 
let startY = 0; 

// 1.
title.addEventListener('mousedown', function(e){
  e.preventDefault();  // 기본 이벤트 막기
  startX = e.clientX;  
  startY = e.clientY; 
	
  // 2.  
  title.classList.add('active');
  
  // 3.
  document.addEventListener('mouseup', onRemoveEvent); 
  
  // 4.
  document.addEventListener('mousemove', onMove); 
});

function onRemoveEvent() { 
  title.classList.remove('active');
  document.removeEventListener('mouseup', onRemoveEvent); 
  document.removeEventListener('mousemove', onMove); 
} 

function onMove(e) { 
  e.preventDefault(); 
  lastX = startX - e.clientX; 
  lastY = startY - e.clientY; 

  startX = e.clientX; 
  startY = e.clientY; 

  info.style.top = `${info.offsetTop - lastY}px`;
  info.style.left = `${info.offsetLeft - lastX}px`;
}