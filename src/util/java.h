#pragma once

#include "base/version.h"

namespace allay_launcher::util::java {

std::expected<Version, GetOSJavaVersionError> installed_version();

bool check_java();

} // namespace allay_launcher::util::java
