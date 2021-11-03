FROM frankjoshua/ros2

# ** [Optional] Uncomment this section to install additional packages. **
#
USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
   && apt-get -y install --no-install-recommends ros-galactic-xacro ros-galactic-joint-state-publisher \
   #
   # Clean up
   && apt-get autoremove -y \
   && apt-get clean -y \
   && rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=dialog

# Set up auto-source of workspace for ros user
ARG WORKSPACE=/home/ros
RUN echo "if [ -f ${WORKSPACE}/install/setup.bash ]; then source ${WORKSPACE}/install/setup.bash; fi" >> /home/ros/.bashrc

USER ros
WORKDIR ${WORKSPACE}
COPY src ./src/
RUN . /opt/ros/$ROS_DISTRO/setup.sh && colcon build
ENTRYPOINT [ "/bin/bash", "-i", "-c" ]
CMD ["ros2 launch robot_description launch.py"]