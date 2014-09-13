
QML_IMPORT_PATH += $$PWD

QUICK_ANDROID_FILES += \
    $$PWD/QuickAndroid/res.js \
    $$PWD/QuickAndroid/android.js \
    $$PWD/QuickAndroid/util.js \
    $$PWD/QuickAndroid/Dialog.qml \
    $$PWD/QuickAndroid/Drawable.qml \
    $$PWD/QuickAndroid/DrawableGrowBehaviour.qml \
    $$PWD/QuickAndroid/ActionBar.qml \
    $$PWD/QuickAndroid/PopupMenu.qml \
    $$PWD/QuickAndroid/Spinner.qml \
    $$PWD/QuickAndroid/Application.qml \
    $$PWD/QuickAndroid/QuickButton.qml \
    $$PWD/QuickAndroid/StateListDrawable.qml \
    $$PWD/QuickAndroid/MaterialShadow.qml \
    $$PWD/QuickAndroid/Shadow.qml \
    $$PWD/QuickAndroid/RectToRectMatrix.qml \
    $$PWD/QuickAndroid/AnimationLoader.qml \
    $$PWD/QuickAndroid/QueuedSignal.qml \
    $$PWD/QuickAndroid/PopupArea.qml \
    $$PWD/QuickAndroid/Activity.qml \
    $$PWD/QuickAndroid/InverseMouseArea.qml \
    $$PWD/QuickAndroid/qmldir \
    $$PWD/QuickAndroid/item/DropDownList.qml \
    $$PWD/QuickAndroid/item/qmldir \
    $$PWD/QuickAndroid/drawable/BtnDefault.qml \
    $$PWD/QuickAndroid/drawable/ActionBarBackground.qml \
    $$PWD/QuickAndroid/drawable/DividerHorizontalHoloLight.qml \
    $$PWD/QuickAndroid/drawable/BtnDropdown.qml \
    $$PWD/QuickAndroid/drawable/MenuDropdownPanelHoloLight.qml \
    $$PWD/QuickAndroid/drawable/SpinnerAbHoloLight.qml \
    $$PWD/QuickAndroid/drawable/ItemBackgroundHoloLight.qml \
    $$PWD/QuickAndroid/drawable/SpinnerDropdownBackground.qml \
    $$PWD/QuickAndroid/drawable/ListSelectorHoloLight.qml \
    $$PWD/QuickAndroid/drawable/BackgroundHoloLight.qml \
    $$PWD/QuickAndroid/drawable/Triangle.qml \
    $$PWD/QuickAndroid/drawable/ic_ab_back_holo_light_am.png \
    $$PWD/QuickAndroid/anim/ActivityEnter.qml \
    $$PWD/QuickAndroid/anim/ShrinkFadeOut.qml \
    $$PWD/QuickAndroid/anim/GrowFadeIn.qml \
    $$PWD/QuickAndroid/anim/ActivityExit.qml \
    $$PWD/QuickAndroid/drawable-xxhdpi/menu_dropdown_panel_holo_light.png \
    $$PWD/QuickAndroid/drawable-xxhdpi/ic_ab_back_holo_light_am.png

OTHER_FILES = $$QUICK_ANDROID_FILES

QUICK_ANDROID_RESOURCE = $$OUT_PWD/quickandroid.qrc

RESOURCE_CONTENT = \
    "<RCC>" \
    "<qresource prefix=\"/QuickAndroid\">"

for(resourcefile, QUICK_ANDROID_FILES) {
    resourcefileabsolutepath = $$absolute_path($$resourcefile)
    relativepath_in = $$relative_path($$resourcefileabsolutepath, $$PWD/QuickAndroid)
    relativepath_out = $$relative_path($$resourcefileabsolutepath, $$OUT_PWD)
    RESOURCE_CONTENT += "<file alias=\"$$relativepath_in\">$$relativepath_out</file>"
}

RESOURCE_CONTENT += \
    "</qresource>" \
    "</RCC>"

write_file($$QUICK_ANDROID_RESOURCE, RESOURCE_CONTENT)|error("Aborting.")

RESOURCES += $$QUICK_ANDROID_RESOURCE
