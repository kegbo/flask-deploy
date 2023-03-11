FROM continuumio/miniconda:latest
ADD . /flask-deploy

WORKDIR /flask-deploy
COPY denvironment.yml ./
COPY app.py ./

RUN conda env create -f denvironment.yml


RUN echo "source activate demo" > ~/.bashrc
ENV PATH /opt/conda/envs/demo/bin:$PATH

EXPOSE 7000

CMD gunicorn --worker-class gevent --workers 8 --bind 0.0.0.0:5000 wsgi:app --max-requests 10000 --timeout 5 --keep-alive 5 --log-level info