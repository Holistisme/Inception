// script.js for Rickception Static Site
// This script enhances the user experience by animating the header, paragraphs, and video container

document.addEventListener('DOMContentLoaded', () => {
  // Select the header element (h1) and animate it with a fade-in and zoom effect
  const header = document.querySelector('h1');
  if (header) {
    header.style.opacity = 0;                                               // Start hidden
    header.style.transform = 'scale(0.8)';                                  // Start slightly scaled down
    header.style.transition = 'opacity 1s ease-out, transform 1s ease-out'; // Smooth transition for both opacity and scale
    setTimeout(() => {
      header.style.opacity = 1;                                             // Fade in to fully visible
      header.style.transform = 'scale(1)';                                  // Scale to normal size
    }, 500);                                                                // Delay of 500ms before starting the animation
  }

  // Select all paragraph elements and animate them with a staggered fade-in and slide-up effect
  const paragraphs = document.querySelectorAll('p');
  paragraphs.forEach((p, index) => {
    p.style.opacity = 0;                                               // Start hidden
    p.style.transform = 'translateY(20px)';                            // Start slightly lower than final position
    p.style.transition = 'opacity 1s ease-out, transform 1s ease-out'; // Smooth transition for both opacity and position
    setTimeout(() => {
      p.style.opacity = 1;                                             // Fade in to fully visible
      p.style.transform = 'translateY(0)';                             // Move to the final position
    }, 700 + index * 300);                                             // Stagger each paragraph's animation
  });

  // Select the video container element and animate it with a fade-in and slight rotation effect
  const videoContainer = document.querySelector('.video-container');
  if (videoContainer) {
    videoContainer.style.opacity = 0;                                               // Start hidden
    videoContainer.style.transform = 'rotate(5deg)';                                // Start with a slight rotation
    videoContainer.style.transition = 'opacity 1s ease-out, transform 1s ease-out'; // Smooth transition for opacity and rotation
    setTimeout(() => {
      videoContainer.style.opacity = 1;                                             // Fade in to fully visible
      videoContainer.style.transform = 'rotate(0deg)';                              // Rotate to normal (0deg)
    }, 1000);                                                                       // Delay of 1000ms before starting the animation
  }

  // Log a welcoming message in the browser console
  console.log('Rickception loaded. Prepare to be Rickrolled!');
});