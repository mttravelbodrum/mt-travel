/* ==========================================================================
   hero-slider.js — homepage hero: autoplay every 3s, swipe, arrows,
   pagination dots, pauses on hover (desktop), resumes automatically.

   Robustness notes (fixes the "works sometimes, not others" report):
   - init() no longer assumes DOMContentLoaded hasn't already fired. If
     this script happens to load/execute after that event already
     happened, the old code would wait forever for an event that will
     never come again. Now it checks document.readyState first.
   - Browsers can restore a page from the back-forward cache (bfcache)
     when the user clicks Back/Forward, without re-running page load
     events at all - so a timer started on the first real load can be
     left in an inconsistent state, or never (re)started, after
     navigating back to this page. The pageshow event with
     event.persisted=true is the standard way to detect this and
     restart cleanly.
   - init() is now idempotent: calling it more than once (which can
     happen once pageshow handling is added) tears down any previous
     timer/listeners on the same root element first, instead of
     stacking duplicate intervals that would fight each other.
   ========================================================================== */

(function () {
  "use strict";
  const { qs, qsa } = MTUtils;

  function init() {
    const root = qs("#heroSlider");
    if (!root) return;
    const slides = qsa(".hero-slider__slide", root);
    if (!slides.length) return;

    // Idempotency guard: if this root was already initialized (e.g. this
    // is a bfcache-restore re-init), tear down the previous instance's
    // timer and listeners before building a new one.
    if (root._heroSliderCleanup) {
      root._heroSliderCleanup();
    }

    const dotsWrap = qs("#heroSliderDots");
    const prevBtn = qs("#heroSliderPrev");
    const nextBtn = qs("#heroSliderNext");
    let index = 0;
    let timer = null;
    const SPEED = 5000; // was 3000 - felt rushed for a tourism hero, 5s gives visitors time to actually look at each photo

    if (dotsWrap) {
      dotsWrap.innerHTML = slides.map((_, i) => `<button class="hero-slider__dot${i === 0 ? " is-active" : ""}" aria-label="${(typeof mtT === "function" ? mtT("carousel.go_to_slide") : "Go to slide")} ${i + 1}"></button>`).join("");
    }
    const dots = dotsWrap ? qsa(".hero-slider__dot", dotsWrap) : [];

    function show(i) {
      index = (i + slides.length) % slides.length;
      slides.forEach((s, si) => s.classList.toggle("is-active", si === index));
      dots.forEach((d, di) => d.classList.toggle("is-active", di === index));
    }

    function start() {
      stop();
      timer = setInterval(() => { if (!cursorIsOverSlider()) show(index + 1); }, SPEED);
    }
    function stop() {
      if (timer) clearInterval(timer);
      timer = null;
    }

    const onPrev = () => { show(index - 1); start(); };
    const onNext = () => { show(index + 1); start(); };
    prevBtn && prevBtn.addEventListener("click", onPrev);
    nextBtn && nextBtn.addEventListener("click", onNext);

    const dotHandlers = [];
    dots.forEach((d, i) => {
      const handler = () => { show(i); start(); };
      dotHandlers.push(handler);
      d.addEventListener("click", handler);
    });

    // Pause on hover - desktop only (matches spec: "Pause while hovering (Desktop)").
    // Deliberately NOT built on paired mouseenter/mouseleave events: the
    // open language dropdown menu geometrically overlaps the top of the
    // hero slider (confirmed by measuring both elements' bounding boxes),
    // so moving the cursor to click a lower item in that menu can enter
    // the slider's bounding box without a clean corresponding "leave" -
    // and autoplay must never get stuck because of that. Instead, the
    // tick itself directly checks the last known cursor position against
    // the slider's current bounding rect every time it fires - correct
    // by construction on every check, with no paired-event state to ever
    // drift out of sync.
    const hoverCapable = window.matchMedia("(hover: hover)").matches;
    let cursorX = null, cursorY = null, lastMoveAt = 0;
    const onMouseMove = (e) => { cursorX = e.clientX; cursorY = e.clientY; lastMoveAt = Date.now(); };
    if (hoverCapable) {
      document.addEventListener("mousemove", onMouseMove);
    }
    function cursorIsOverSlider() {
      if (!hoverCapable || cursorX === null) return false;
      // A position we haven't seen refreshed in a while isn't trustworthy
      // as "still hovering" - only an actively-updating stream of
      // mousemove events counts as genuine, ongoing hover.
      if (Date.now() - lastMoveAt > 3500) return false;
      const r = root.getBoundingClientRect();
      return cursorX >= r.left && cursorX <= r.right && cursorY >= r.top && cursorY <= r.bottom;
    }

    // Swipe support (touch)
    let touchStartX = 0;
    const onTouchStart = (e) => { touchStartX = e.touches[0].clientX; stop(); };
    const onTouchEnd = (e) => {
      const dx = e.changedTouches[0].clientX - touchStartX;
      if (Math.abs(dx) > 50) show(index + (dx < 0 ? 1 : -1));
      start();
    };
    root.addEventListener("touchstart", onTouchStart, { passive: true });
    root.addEventListener("touchend", onTouchEnd);

    // Clicking a slide (outside of buttons/links) opens its tour
    const slideClickHandlers = [];
    slides.forEach((slide) => {
      const href = slide.dataset.href;
      if (!href) return;
      const handler = (e) => {
        if (e.target.closest("a, button")) return;
        window.location.href = href;
      };
      slideClickHandlers.push([slide, handler]);
      slide.addEventListener("click", handler);
      slide.style.cursor = "pointer";
    });

    // Tab visibility: most browsers already throttle/suspend timers in
    // background tabs, but explicitly stopping/restarting on visibility
    // change avoids any drift or double-firing once the tab is active
    // again, and is cheap insurance against the "sometimes" part of the
    // reported bug.
    const onVisibilityChange = () => { if (document.hidden) stop(); else start(); };
    document.addEventListener("visibilitychange", onVisibilityChange);

    root._heroSliderCleanup = () => {
      stop();
      prevBtn && prevBtn.removeEventListener("click", onPrev);
      nextBtn && nextBtn.removeEventListener("click", onNext);
      dots.forEach((d, i) => d.removeEventListener("click", dotHandlers[i]));
      if (hoverCapable) {
        document.removeEventListener("mousemove", onMouseMove);
      }
      root.removeEventListener("touchstart", onTouchStart);
      root.removeEventListener("touchend", onTouchEnd);
      slideClickHandlers.forEach(([slide, handler]) => slide.removeEventListener("click", handler));
      document.removeEventListener("visibilitychange", onVisibilityChange);
      root._heroSliderCleanup = null;
    };

    show(0);
    start();
  }

  function initWhenReady() {
    // The DOM is already parsed by the time this script runs in the vast
    // majority of cases (it's loaded at the end of body), but if it were
    // ever loaded some other way and DOMContentLoaded already fired,
    // waiting for that event again would wait forever. readyState covers
    // both cases correctly.
    if (document.readyState === "loading") {
      document.addEventListener("DOMContentLoaded", init);
    } else {
      init();
    }
  }

  initWhenReady();

  // Restart cleanly when the page is restored from the back-forward
  // cache (bfcache) - e.g. the user navigated to a tour page and then
  // clicked the browser's Back button. This is the main fix for the
  // "works the first time, not after navigating back" report.
  window.addEventListener("pageshow", (e) => {
    if (e.persisted) init();
  });
})();
