/* Copyright 2014-2016 John de Murga - Licensed under the GPLv2  */
//
// Compile with :
// g++ --static shortcuts.cpp -o ../Shortcuts.exe -mwindows -lole32 -luuid; strip ../Shortcuts.exe
// ../bin/rcedit.exe ../Shortcuts.exe --set-icon setup.ico

#include <shlobj.h>
#include <stdio.h>
#include <windows.h>

void getDesktopPath(wchar_t *strPath) {
    // Localized get-me-the-desktop path
    SHGetSpecialFolderPathW(0, strPath, CSIDL_DESKTOPDIRECTORY, TRUE);
}

void getSendToPath(wchar_t *strPath) {
    // Localized get-me-the-send-to path
    SHGetSpecialFolderPathW(0, strPath, CSIDL_SENDTO, TRUE);
}

void getBasePath(wchar_t *basePath) {
    GetModuleFileNameW(NULL, basePath, 1024);

    wchar_t *ptr = wcsrchr(basePath, '\\');
    ptr[1] = '\0';
}

int createShortcut(const wchar_t *target, const wchar_t *name, const wchar_t *icon, const wchar_t *destination) {
    CoInitialize(NULL);
    IShellLinkW *pShellLink = NULL;
    HRESULT hres;
    hres = CoCreateInstance(CLSID_ShellLink, NULL, CLSCTX_ALL, IID_IShellLinkW, (void **)&pShellLink);

    if (SUCCEEDED(hres)) {
        pShellLink->SetPath(target);
        pShellLink->SetDescription(name);
        pShellLink->SetIconLocation(icon, 0);

        IPersistFile *pPersistFile;
        hres = pShellLink->QueryInterface(IID_IPersistFile, (void **)&pPersistFile);

        if (SUCCEEDED(hres)) {
            hres = pPersistFile->Save(destination, TRUE);

            pPersistFile->Release();
        } else {
            return 2;
        }
        pShellLink->Release();
    } else {
        return 1;
    }

    return 0;
}

int doShortCut(const wchar_t *baseName, wchar_t *exeBasePath, wchar_t *shortcutBasePath) {
    wchar_t currentLauncher[1024];
    wchar_t shortcutPath[1024];

    wcscpy(currentLauncher, exeBasePath);
    wcscat(shortcutPath, L"\\");
    wcscat(currentLauncher, baseName);
    wcscat(currentLauncher, L".exe");

    wcscpy(shortcutPath, shortcutBasePath);
    wcscat(shortcutPath, L"\\");
    wcscat(shortcutPath, baseName);
    wcscat(shortcutPath, L".lnk");

    printf("\"%S\", \"%S\", \"%S\", \"%S\"\n", currentLauncher, baseName, currentLauncher, shortcutPath);

    return (createShortcut(currentLauncher, baseName, currentLauncher, shortcutPath));
}

void createShortcuts() {
    wchar_t basePath[1024];
    getBasePath(basePath);

    wchar_t desktopPath[1024];
    getDesktopPath(desktopPath);

    wchar_t sendToPath[1024];
    getSendToPath(sendToPath);

    doShortCut(L"Atom", basePath, desktopPath);
    doShortCut(L"Vim", basePath, sendToPath);
    doShortCut(L"Bash", basePath, desktopPath);
    doShortCut(L"Meld", basePath, sendToPath);
}

int main() {

    const int result = MessageBox(NULL, "This will create shortcuts for Atom and Bash on the desktop\n"
                                        "And for Vi and Meld in the \"Send to\" menu\n\n"
                                        "Do you want to continue ?\n",
                                  "Atom Portable shortcut setup", MB_OKCANCEL | MB_ICONQUESTION);

    switch (result) {
    case IDOK:
        createShortcuts();
        MessageBox(NULL, "All done !", "Atom Portable shortcut setup", MB_OK | MB_ICONINFORMATION);
        break;
    case IDCANCEL:
        MessageBox(NULL, "ABORTED", "Atom Portable shortcut setup", MB_OK | MB_ICONWARNING);
        break;
    }
}
