FROM store/oracle/serverjre:1.8.0_241-b07
WORKDIR rlcraft-server
COPY default default
COPY run.sh .
CMD ["./run.sh"]
# CMD ["bash"]
