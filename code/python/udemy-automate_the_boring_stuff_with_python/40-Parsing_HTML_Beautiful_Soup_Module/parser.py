import bs4, requests

def getAmazonPrice(productURL):
    res = requests.get(productURL)
    res.raise_for_status()

    soup = bs4.BeautifulSoup(res.text, 'html.parser')
    elems = soup.select('html.a-js.a-audio.a-video.a-canvas.a-svg.a-drag-drop.a-geolocation.a-history.a-webworker.a-autofocus.a-input-placeholder.a-textarea-placeholder.a-local-storage.a-gradients.a-transform3d.-scrolling.a-text-shadow.a-text-stroke.a-box-shadow.a-border-radius.a-border-image.a-opacity.a-transform.a-transition.a-ember.a-ws body.a-m-us.a-aui_72554-c.a-aui_control_group_273125-t1.a-aui_dropdown_274033-t1.a-aui_link_rel_noreferrer_noopener_274172-c.a-aui_mm_desktop_exp_291916-c.a-aui_mm_desktop_launch_291918-c.a-aui_mm_desktop_targeted_exp_291928-t1.a-aui_mm_desktop_targeted_launch_291922-t1.a-aui_pci_risk_banner_210084-c.a-aui_perf_130093-c.a-aui_preload_261698-c.a-aui_tnr_v2_180836-c div#a-page div#dp.book.en_US div#dp-container.a-container div#rightCol div#desktop_buybox.celwidget div#buybox div#exports_desktop_buybox.celwidget div#exportsBuybox div#exports_desktop_qualifiedBuybox.celwidget div.a-section form#addToCart.a-content div.a-box-group div.a-box.a-last div.a-box-inner div.a-section.a-spacing-none.a-padding-none div#exports_desktop_qualifiedBuybox_priceInsideBuyBox.celwidget div#newBooksSingleBuyingOptionHeader_feature_div.celwidget h5 div#booksHeaderSection.a-section.a-spacing-none div.a-row div.a-column.a-span8.a-text-right.a-span-last span#price.a-size-medium.a-color-price.header-price.a-text-normal')
    return elems[0].text.strip()


price = getAmazonPrice('http://www.amazon.com/Python-Crash-Course-2nd-Edition/dp/1593279280/')
price('The price is ' + price)
