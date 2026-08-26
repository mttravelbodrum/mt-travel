/* ==========================================================================
   interactions.js — tabs, accordion, quantity counters, live activity bar
   ========================================================================== */

(function () {
  "use strict";
  const { qs, qsa } = MTUtils;

  /* ---------------- Tabs ---------------- */
  function initTabs() {
    qsa("[data-tabs]").forEach((wrap) => {
      const btns = qsa(".tabs__btn", wrap);
      const panels = qsa(".tabs__panel", wrap);
      btns.forEach((btn) => {
        btn.addEventListener("click", () => {
          const target = btn.dataset.tabTarget;
          btns.forEach((b) => b.classList.toggle("is-active", b === btn));
          panels.forEach((p) => p.classList.toggle("is-active", p.dataset.tabPanel === target));
          history.replaceState(null, "", "#" + target);
        });
      });
      const hash = location.hash.replace("#", "");
      if (hash) {
        const match = btns.find((b) => b.dataset.tabTarget === hash);
        if (match) match.click();
      }
    });
  }

  /* ---------------- Accordion (FAQ) ---------------- */
  const Accordion = {
    bind(container) {
      qsa(".accordion-item", container).forEach((item) => {
        const trigger = qs(".accordion-trigger", item);
        const panel = qs(".accordion-panel", item);
        if (!trigger || !panel || trigger.dataset.bound) return;
        trigger.dataset.bound = "1";
        trigger.addEventListener("click", () => {
          const isOpen = item.classList.contains("is-open");
          const group = item.closest("[data-accordion-group]");
          if (group) {
            qsa(".accordion-item.is-open", group).forEach((other) => {
              if (other !== item) {
                other.classList.remove("is-open");
                qs(".accordion-panel", other).style.maxHeight = "0px";
                qs(".accordion-trigger", other).setAttribute("aria-expanded", "false");
              }
            });
          }
          item.classList.toggle("is-open", !isOpen);
          trigger.setAttribute("aria-expanded", String(!isOpen));
          panel.style.maxHeight = !isOpen ? panel.scrollHeight + "px" : "0px";
        });
        if (item.classList.contains("is-open")) {
          panel.style.maxHeight = panel.scrollHeight + "px";
        }
      });
    },
    rebind(container) {
      qsa(".accordion-trigger", container).forEach((t) => { delete t.dataset.bound; });
      this.bind(container);
    }
  };
  window.MTAccordion = Accordion;

  /* ---------------- Quantity counters (adults/children/infants) ---------------- */
  function initCounters() {
    qsa("[data-counter]").forEach((counter) => {
      const valueEl = qs(".counter__value", counter);
      const minus = qs('[data-counter-action="minus"]', counter);
      const plus = qs('[data-counter-action="plus"]', counter);
      const min = parseInt(counter.dataset.min || "0", 10);
      const max = parseInt(counter.dataset.max || "20", 10);
      const sync = () => {
        let v = parseInt(valueEl.textContent, 10) || min;
        v = Math.max(min, Math.min(max, v));
        valueEl.textContent = v;
        if (minus) minus.disabled = v <= min;
        if (plus) plus.disabled = v >= max;
        counter.dispatchEvent(new CustomEvent("mt:counterchange", { detail: { value: v }, bubbles: true }));
      };
      minus && minus.addEventListener("click", () => {
        valueEl.textContent = (parseInt(valueEl.textContent, 10) || min) - 1;
        sync();
      });
      plus && plus.addEventListener("click", () => {
        valueEl.textContent = (parseInt(valueEl.textContent, 10) || min) + 1;
        sync();
      });
      sync();
    });
  }

  function initTourGallery() {
    const heroWrap = document.getElementById("tourHeroWrap");
    const heroImg = document.getElementById("tourHeroImg");
    const strip = document.getElementById("tourThumbsStrip");
    const thumbs = document.querySelectorAll(".tour-thumbs__item");
    if (!heroImg || !thumbs.length) return;

    // Single source of truth: an index (matching each thumb's data-index)
    // rather than tracking "which thumbnail is active" and "what's the
    // hero src" as two separate things that could drift apart. Every way
    // of changing the photo - tapping a thumbnail, swiping the hero image
    // - goes through this one function, so the two can never disagree
    // about which photo is showing.
    function goTo(index) {
      const target = Array.from(thumbs).find((b) => Number(b.dataset.index) === index);
      if (!target) return;
      const full = target.getAttribute("data-full");
      if (full) heroImg.src = full;
      if (heroWrap) heroWrap.dataset.index = String(index);
      thumbs.forEach((b) => b.classList.toggle("is-active", b === target));
      // If the newly-active thumbnail is off the edge of the visible
      // strip (e.g. the hero was swiped several photos forward), bring it
      // into view instead of leaving the highlighted thumb invisible.
      target.scrollIntoView({ behavior: "smooth", inline: "nearest", block: "nearest" });
    }

    thumbs.forEach((btn) => {
      btn.addEventListener("click", () => goTo(Number(btn.dataset.index)));
    });

    // Swiping the large hero image moves through the same photo set,
    // wrapping at either end (browsing photos feels continuous, not like
    // hitting a wall) - the active thumbnail updates to match, same as
    // tapping it directly would.
    if (heroWrap) {
      let touchStartX = 0;
      let touchStartY = 0;
      heroWrap.addEventListener("touchstart", (e) => {
        touchStartX = e.touches[0].clientX;
        touchStartY = e.touches[0].clientY;
      }, { passive: true });
      heroWrap.addEventListener("touchend", (e) => {
        const dx = e.changedTouches[0].clientX - touchStartX;
        const dy = e.changedTouches[0].clientY - touchStartY;
        // Ignore mostly-vertical drags (the visitor is scrolling the page,
        // not swiping the gallery).
        if (Math.abs(dx) < 40 || Math.abs(dx) < Math.abs(dy)) return;
        const count = thumbs.length;
        const current = Number(heroWrap.dataset.index) || 1;
        const next = dx < 0 ? (current % count) + 1 : ((current - 2 + count) % count) + 1;
        goTo(next);
      });
    }
  }

  document.addEventListener("DOMContentLoaded", () => {
    initTabs();
    Accordion.bind(document);
    initCounters();
    initTourGallery();
  });
})();
