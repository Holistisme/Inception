/******************************************************************************
 * JavaScript animations and counter retrieval for Rickception
 ******************************************************************************/
document.addEventListener('DOMContentLoaded', () => {
  // Simple fade-in effect for the header
  const header = document.querySelector('h1');
  if (header) {
    header.style.opacity = 0;
    header.style.transform = 'scale(0.8)';
    header.style.transition = 'opacity 1s ease-out, transform 1s ease-out';
    setTimeout(() => {
      header.style.opacity = 1;
      header.style.transform = 'scale(1)';
    }, 500);
  }

  // Sequential fade-up effect for paragraph elements
  const paragraphs = document.querySelectorAll('p');
  paragraphs.forEach((p, index) => {
    p.style.opacity = 0;
    p.style.transform = 'translateY(20px)';
    p.style.transition = 'opacity 1s ease-out, transform 1s ease-out';
    setTimeout(() => {
      p.style.opacity = 1;
      p.style.transform = 'translateY(0)';
    }, 700 + index * 300);
  });

  // Rotate-in effect for the embedded video container
  const videoContainer = document.querySelector('.video-container');
  if (videoContainer) {
    videoContainer.style.opacity = 0;
    videoContainer.style.transform = 'rotate(5deg)';
    videoContainer.style.transition = 'opacity 1s ease-out, transform 1s ease-out';
    setTimeout(() => {
      videoContainer.style.opacity = 1;
      videoContainer.style.transform = 'rotate(0deg)';
    }, 1000);
  }

  // Fetch a counter from an external endpoint (Node.js service)
  fetch('https://${IP_ADDRESS}:3001/rickroll?cacheBuster=' + Date.now())
    .then(response => response.text())
    .then(data => {
      const counterElem = document.getElementById('counter');
      if (counterElem) {
        counterElem.innerText = data;
      }
    })
    .catch(error => console.error('Error fetching counter:', error));

  console.log('Rickception loaded successfully.');
});