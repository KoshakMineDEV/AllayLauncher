add_rules('mode.debug', 'mode.release')

add_repositories('allaymc-repo https://github.com/AllayMC/xmake-repo.git')

add_requires('argparse      3.1')
add_requires('spdlog        1.14.1')
add_requires('nlohmann_json 3.11.3')
add_requires('cpr           1.11.0')

target('allay')
    set_kind('binary')
    add_files('src/**.cpp')
    add_includedirs('src')
    add_includedirs('build/config')
    set_version("1.0.0-BETA")

    add_packages(
        'argparse',
        'spdlog',
        'nlohmann_json',
        'cpr'
    )

    if is_plat('windows') then
        add_links('winhttp.lib')
        add_cxflags('/utf-8')
    else 
        remove_files("src/**_win32.*")
        -- workaround for clangd-18 bug.
        add_defines('__cpp_lib_expected')
    end

    if is_plat("linux") then
        set_symbols("hidden")
        set_strip("all")
    end

    set_languages('c++23')
    set_optimize('smallest')

    set_pcxxheader('src/pch.h')

    set_configdir("$(buildir)/config")
    add_configfiles("src/config.h.in")

    if is_mode('debug') then 
        add_defines('DEBUG')
    end