// Frontend-specific JavaScript for the public layout.

if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", function () {
        initCartPage();
        initAboutPage();
    });
} else {
    initCartPage();
    initAboutPage();
}

function initAboutPage() {
    const aboutPage =
        document.querySelector(".about-page");

    if (!aboutPage) {
        return;
    }

    const revealElements =
        aboutPage.querySelectorAll(".reveal");

    if ("IntersectionObserver" in window) {
        const revealObserver =
            new IntersectionObserver(
                function (entries) {
                    entries.forEach(function (entry) {
                        if (entry.isIntersecting) {
                            entry.target.classList.add("reveal-visible");
                            revealObserver.unobserve(entry.target);
                        }
                    });
                },
                {
                    threshold: 0.12
                }
            );

        revealElements.forEach(function (element) {
            revealObserver.observe(element);
        });
    } else {
        revealElements.forEach(function (element) {
            element.classList.add("reveal-visible");
        });
    }

    const visionSection =
        aboutPage.querySelector(".about-vision-section");

    if (!visionSection) {
        return;
    }

    let ticking = false;

    const updateParallax = function () {
        const rect =
            visionSection.getBoundingClientRect();

        if (
            rect.top < window.innerHeight
            && rect.bottom > 0
        ) {
            const offset =
                Math.round(rect.top * 0.06);

            visionSection.style.setProperty(
                "--about-parallax-y",
                offset + "px"
            );
        }

        ticking = false;
    };

    window.addEventListener(
        "scroll",
        function () {
            if (!ticking) {
                window.requestAnimationFrame(updateParallax);
                ticking = true;
            }
        },
        {
            passive: true
        }
    );

    updateParallax();
}

function initCartPage() {
    const cartPage = document.querySelector(".cart-page");

    if (!cartPage) {
        return;
    }

    const selectAllInputs =
        cartPage.querySelectorAll(".cart-select-all");

    const totalCount =
        cartPage.querySelector(".cart-total-count");

    const selectedCount =
        cartPage.querySelector(".cart-selected-count");

    const totalAmount =
        cartPage.querySelector(".cart-total-amount");

    const formatMoney = function (value) {
        return new Intl.NumberFormat("vi-VN").format(value) + " VNĐ";
    };

    const getItems = function () {
        return Array.from(
            cartPage.querySelectorAll(".cart-item-row")
        );
    };

    const getItemCheckbox = function (item) {
        if (!item) {
            return null;
        }

        return item.querySelector(".cart-item-check");
    };

    const getQuantityInput = function (item) {
        if (!item) {
            return null;
        }

        return item.querySelector(".cart-qty-input");
    };

    const getPrice = function (item) {
        if (!item) {
            return 0;
        }

        return Number(item.dataset.price || 0);
    };

    const updateItemSubtotal = function (item) {
        const quantityInput =
            getQuantityInput(item);

        const subtotal =
            item.querySelector(".cart-subtotal");

        if (!quantityInput || !subtotal) {
            return;
        }

        const quantity =
            Number(quantityInput.value || 1);

        subtotal.textContent =
            formatMoney(getPrice(item) * quantity);
    };

    const syncTotals = function () {
        const items =
            getItems();

        let selectedItems = 0;
        let selectedTotal = 0;

        items.forEach(function (item) {
            updateItemSubtotal(item);

            const checkbox =
                getItemCheckbox(item);

            if (checkbox && checkbox.checked) {
                const quantity =
                    Number(getQuantityInput(item).value || 1);

                selectedItems += 1;
                selectedTotal += getPrice(item) * quantity;
            }

            const shopRow =
                item.previousElementSibling;

            if (shopRow && shopRow.classList.contains("cart-shop-row")) {
                const shopCheckbox =
                    shopRow.querySelector(".cart-shop-check");

                if (shopCheckbox && checkbox) {
                    shopCheckbox.checked = checkbox.checked;
                }
            }
        });

        if (totalCount) {
            totalCount.textContent =
                "(" + items.length + ")";
        }

        if (selectedCount) {
            selectedCount.textContent =
                "(" + selectedItems + " sản phẩm)";
        }

        if (totalAmount) {
            totalAmount.textContent =
                formatMoney(selectedTotal);
        }

        const checkoutBar =
            cartPage.querySelector(".cart-checkout-bar");

        if (checkoutBar && items.length === 0) {
            checkoutBar.style.display = "none";
        }

        const allChecked =
            items.length > 0
            && selectedItems === items.length;

        selectAllInputs.forEach(function (input) {
            input.checked = allChecked;
        });
    };

    const removeItem = function (item) {
        if (!item) {
            return;
        }

        const shopRow =
            item.previousElementSibling;

        const serviceRow =
            item.nextElementSibling;

        if (shopRow && shopRow.classList.contains("cart-shop-row")) {
            shopRow.remove();
        }

        if (serviceRow && serviceRow.classList.contains("cart-service-row")) {
            serviceRow.remove();
        }

        item.remove();
        syncTotals();
    };

    cartPage.addEventListener("click", function (event) {
        const minusButton =
            event.target.closest(".cart-qty-minus");

        const plusButton =
            event.target.closest(".cart-qty-plus");

        const removeButton =
            event.target.closest(".cart-remove-item");

        const removeSelectedButton =
            event.target.closest(".cart-remove-selected");

        const checkoutButton =
            event.target.closest(".cart-checkout-button");

        if (minusButton || plusButton) {
            event.preventDefault();

            const item =
                event.target.closest(".cart-item-row");

            const quantityInput =
                getQuantityInput(item);

            if (!quantityInput) {
                return;
            }

            let quantity =
                Number(quantityInput.value || 1);

            if (minusButton) {
                quantity =
                    Math.max(1, quantity - 1);
            }

            if (plusButton) {
                quantity += 1;
            }

            quantityInput.value = quantity;
            syncTotals();
        }

        if (removeButton) {
            event.preventDefault();

            const item =
                removeButton.closest(".cart-item-row");

            removeItem(item);
        }

        if (removeSelectedButton) {
            event.preventDefault();

            getItems()
                .filter(function (item) {
                    const checkbox =
                        getItemCheckbox(item);

                    return checkbox && checkbox.checked;
                })
                .forEach(removeItem);
        }

        if (checkoutButton) {
            const checkedItems =
                getItems().filter(function (item) {
                    const checkbox =
                        getItemCheckbox(item);

                    return checkbox && checkbox.checked;
                });

            if (checkedItems.length === 0) {
                window.alert("Vui lòng chọn sản phẩm trước khi mua hàng.");
                return;
            }

            window.alert("Đây là giao diện giỏ hàng mẫu. Chức năng đặt hàng sẽ được xử lý ở backend sau.");
        }
    });

    cartPage.addEventListener("change", function (event) {
        if (event.target.classList.contains("cart-select-all")) {
            const checked =
                event.target.checked;

            cartPage
                .querySelectorAll(".cart-item-check")
                .forEach(function (input) {
                    input.checked = checked;
                });
        }

        if (event.target.classList.contains("cart-shop-check")) {
            const shopRow =
                event.target.closest(".cart-shop-row");

            const item =
                shopRow ? shopRow.nextElementSibling : null;

            if (item && item.classList.contains("cart-item-row")) {
                const checkbox =
                    getItemCheckbox(item);

                if (checkbox) {
                    checkbox.checked = event.target.checked;
                }
            }
        }

        syncTotals();
    });

    syncTotals();
}
