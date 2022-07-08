# echo-server.py

import socket
import mouse

HOST = "192.168.0.19"  # Standard loopback interface address (localhost)
PORT = 1305  # Port to listen on (non-privileged ports are > 1023)


def moveMouse(x,y):
        print(x,y)
        mouse.move(x,y,False)

# def process(data):
#     allCoordinates = data.split(',')
#     print(allCoordinates)
#     for i in range(len(allCoordinates)-1):
#         if((i+1)%2==0):
#             moveMouse(allCoordinates[i-1],allCoordinates[i])

def process(data):
    coords = [int(i) for i in data.split(',') if i]
    dx,dy = 0,0  
    for i in range(0,len(coords),2):
        dx += coords[i]
        dy += coords[i+1]
    moveMouse(dx,dy)
    
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((HOST, PORT))
    s.listen()
    conn, addr = s.accept()
    with conn:
        print(f"Connected by {addr}")
        while True:
            data,addr = conn.recvfrom(1024)
            if not data:
                break
            stringData = (data.decode("utf-8"))
            process(stringData)
            # if (stringData) != "pan down":
            #     coordinates = stringData.split(",")
            #     print(coordinates)
                # mouse.move(int(float(coordinates[0])), int(float(coordinates[1])),False)
            # else:
            #     mouse.click()
    