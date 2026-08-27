/* ==========================================================================
   slider.js — lightweight dependency-free carousel
   Usage: <div class="carousel" data-carousel data-autoplay="true" data-speed="4000">
            <div class="carousel__viewport"><div class="carousel__track">...slides...</div></div>
            <button data-carousel-prev>...</button> <button data-carousel-next>...</button>
            <div class="carousel__dots" data-carousel-dots></div>
          </div>
   ========================================================================== */

(function () {
  "use strict";
  const { qs, qsa } = MTUtils;

  class Carousel {
    constructor(root) {
      this.root = root;
      this.viewport = qs(".carousel__viewport", root) || root;
      this.track = qs(".carousel__track", root);
      if (!this.track) return;
      this.slides = qsa(".carousel__slide", this.track);
      this.autoplay = root.dataset.autoplay === "true";
      this.speed = parseInt(root.dataset.speed || "3800", 10);
      this.gap = 24;
      this.index = 0;
      this.timer = null;
      this.isDragging = false;
      this.dragStartX = 0;
      this.dragStartScroll = 0;

      this.prevBtn = root.parentElement ? qs(`[data-carousel-prev="${root.id}"]`, document) : null;
      this.nextBtn = root.parentElement ? qs(`[data-carousel-next="${root.id}"]`, document) : null;
      if (!this.prevBtn) this.prevBtn = qs(".carousel__arrow.prev", root.closest(".carousel-wrap") || root.parentElement || document);
      if (!this.nextBtn) this.nextBtn = qs(".carousel__arrow.next", root.closest(".carousel-wrap") || root.parentElement || document);
      this.dotsWrap = qs(`[data-carousel-dots="${root.id}"]`) || qs(".carousel__dots", root.closest(".carousel-wrap") || root.parentElement || document);

      this.init();
    }

    perView() {
      const w = window.innerWidth;
      const slideW = this.slides[0] ? this.slides[0].getBoundingClientRect().width : 280;
      return Math.max(1, Math.floor(this.viewport.clientWidth / (slideW + this.gap)));
    }

    maxIndex() {
      return Math.max(0, this.slides.length - this.perView());
    }

    init() {
      this.buildDots();
      this.bindArrows();
      this.bindDrag();
      this.update();
      if (this.autoplay && this.slides.length > this.perView()) this.start();
      this.root.addEventListener("mouseenter", () => this.stop());
      this.root.addEventListener("mouseleave", () => { if (this.autoplay) this.start(); });
      window.addEventListener("resize", MTUtils.debounce(() => this.update(), 150));
    }

    buildDots() {
      if (!this.dotsWrap) return;
      const count = this.maxIndex() + 1;
      this.dotsWrap.innerHTML = "";
      if (count <= 1) return;
      for (let i = 0; i < count; i++) {
        const b = document.createElement("button");
        b.className = "carousel__dot" + (i === 0 ? " is-active" : "");
        b.setAttribute("aria-label", (typeof mtT === "function" ? mtT("carousel.go_to_slide") : "Go to slide") + " " + (i + 1));
        b.addEventListener("click", () => this.goTo(i));
        this.dotsWrap.appendChild(b);
      }
    }

    bindArrows() {
      this.prevBtn && this.prevBtn.addEventListener("click", () => this.goTo(this.index - 1));
      this.nextBtn && this.nextBtn.addEventListener("click", () => this.goTo(this.index + 1));
    }

    bindDrag() {
      const track = this.track;
      const start = (x) => {
        this.isDragging = true;
        this.dragStartX = x;
        this.stop();
        track.style.transition = "none";
      };
      const move = (x) => {
        if (!this.isDragging) return;
        const dx = x - this.dragStartX;
        const base = -(this.index * (this.slideStep()));
        track.style.transform = `translateX(${base + dx}px)`;
      };
      const end = (x) => {
        if (!this.isDragging) return;
        this.isDragging = false;
        track.style.transition = "";
        const dx = x - this.dragStartX;
        if (Math.abs(dx) > 60) {
          this.goTo(this.index + (dx < 0 ? 1 : -1));
        } else {
          this.update();
        }
        if (this.autoplay) this.start();
      };
      track.addEventListener("mousedown", (e) => { start(e.clientX); e.preventDefault(); });
      window.addEventListener("mousemove", (e) => move(e.clientX));
      window.addEventListener("mouseup", (e) => end(e.clientX));
      track.addEventListener("touchstart", (e) => start(e.touches[0].clientX), { passive: true });
      track.addEventListener("touchmove", (e) => move(e.touches[0].clientX), { passive: true });
      track.addEventListener("touchend", (e) => end(e.changedTouches[0].clientX));
    }

    slideStep() {
      const slide = this.slides[0];
      if (!slide) return 0;
      return slide.getBoundingClientRect().width + this.gap;
    }

    goTo(i) {
      const max = this.maxIndex();
      this.index = Math.max(0, Math.min(i, max));
      this.update();
    }

    update() {
      const max = this.maxIndex();
      this.index = Math.min(this.index, max);
      const offset = -(this.index * this.slideStep());
      this.track.style.transform = `translateX(${offset}px)`;
      if (this.prevBtn) this.prevBtn.disabled = this.index <= 0;
      if (this.nextBtn) this.nextBtn.disabled = this.index >= max;
      if (this.dotsWrap) {
        qsa(".carousel__dot", this.dotsWrap).forEach((d, i) => d.classList.toggle("is-active", i === this.index));
      }
    }

    start() {
      if (this.slides.length <= this.perView()) return;
      this.stop();
      this.timer = setInterval(() => {
        const max = this.maxIndex();
        this.index = this.index >= max ? 0 : this.index + 1;
        this.update();
      }, this.speed);
    }

    stop() {
      if (this.timer) clearInterval(this.timer);
      this.timer = null;
    }
  }

  function initAll() {
    qsa("[data-carousel]").forEach((el) => {
      if (!el.id) el.id = MTUtils.uid("carousel");
      new Carousel(el);
    });
  }

  document.addEventListener("DOMContentLoaded", initAll);
  window.MTCarousel = Carousel;
})();
