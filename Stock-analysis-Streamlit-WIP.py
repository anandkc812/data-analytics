
import streamlit as st
import pandas as pd 
import numpy as np
#matplotlib inline
import matplotlib.pyplot as plt
import matplotlib.pyplot as plt2
import pydeck as pdk
from PIL import Image
import seaborn as sns
import time
import yfinance as yf



PATH = 'D:/DataScience/'


def main():
        st.title('Stock Analysis Manager')
        st.sidebar.title('Stock Adviser')
        image = Image.open('D:/DataScience/stock-adviser.jpg')
        st.sidebar.image(image, caption='Stock Analysis Dashboard', use_column_width=True)
        st.sidebar.subheader('Stock prediction and analysis. Trends and comparisions with competitors ')

        stik = 'AAPL'
        
        data_df = yf.download(stik, start="2020-02-01", end="2020-03-20")


        if st.checkbox("Stock - "):
                
                               
                st.write(data_df['Close'].plot(figsize=(20,10)))
                st.pyplot()
                st.write(data_df)







        st.title("Anand KC")
        st.subheader("Thanks For Watching")


    
if __name__ == '__main__':

        #demo2()        
        main()
