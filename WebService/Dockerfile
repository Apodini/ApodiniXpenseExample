# ================================
# Build image
# ================================
FROM swiftlang/swift:nightly-5.5-focal as build

# Install OS updates and, if needed, sqlite3
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    && apt-get -q update \
    && apt-get -q dist-upgrade -y \
    && apt-get install -y libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# Set up a build area
WORKDIR /build

# Copy all source files
COPY . .

# Build everything, with optimizations
RUN swift build -Xswiftc -Xfrontend -Xswiftc -sil-verify-none -c release --package-path ./WebService

# Switch to the staging area
WORKDIR /staging

# Copy main executable to staging area
RUN cp "$(swift build --package-path /build/WebService -c release --show-bin-path)/WebService" ./

# Copy resources from the resources directory if the directories exist
# Ensure that by default, neither the directory nor any of its contents are writable.
RUN [ -d "$(swift build --package-path /build/WebService -c release --show-bin-path)/Apodini_ApodiniOpenAPI.resources" ] \
    && mv "$(swift build --package-path /build/WebService -c release --show-bin-path)/Apodini_ApodiniOpenAPI.resources" ./ \
    && chmod -R a-w ./Apodini_ApodiniOpenAPI.resources \
    || echo No resources to copy
RUN [ -d "$(swift build --package-path /build/WebService -c release --show-bin-path)/WebService_WebService.resources" ] \
    && mv "$(swift build --package-path /build/WebService -c release --show-bin-path)/WebService_WebService.resources" ./ \
    && chmod -R a-w ./WebService_WebService.resources \
    || echo No resources to copy

# Create a database directory
RUN mkdir database

# ================================
# Run image
# ================================
FROM swiftlang/swift:nightly-5.5-focal-slim as run

# Make sure all system packages are up to date.
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    && apt-get -q update \
    && apt-get -q dist-upgrade -y \
    && rm -r /var/lib/apt/lists/*

# Create a apodini user and group with /app as its home directory
RUN useradd --user-group --create-home --system --skel /dev/null --home-dir /app apodini

# Switch to the new home directory
WORKDIR /app

# Copy built executable and any staged resources from builder
COPY --from=build --chown=apodini:apodini /staging /app

RUN chown apodini: ./database \
    && chmod u+w ./database

# Ensure all further commands run as the apodini user
USER apodini:apodini

# Start the Apodini service when the image is run.
# The default port is 8080. Can be adapted using the `--port` argument
ENTRYPOINT ["./WebService"]
