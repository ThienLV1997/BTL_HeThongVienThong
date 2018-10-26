% Bai tap lon: He Thong Vien Thong
% GVHD: TS.Phung Thi Kieu Ha
% Nhom 28 - De tai: Nghien cuu thuat toan, so do khoi thuc hien ma hoa
% thoai trong he thong GSM
% Nghien cuu ma hoa PCM trong he thong GSM



clc;
close all;
clear all;
n=input('Enter n value for n-bit PCM system :  ');
n1=input('Enter number of samples in a period : ');
L=2^n;

% Qua trinh lay mau
 
s=audioread('orig_input.wav');
subplot(3,1,1);
plot(s);
title('Analog Signal');
ylabel('Amplitude--->');
xlabel('Time--->');
subplot(3,1,2);
stem(s);
grid on;  
title('Sampled Sinal'); 
ylabel('Amplitude--->');
xlabel('Time--->');
 % Qua trinh luong tu hoa
 vmax=8;
 vmin=-vmax;
 del=(vmax-vmin)/L;
 part=vmin:del:vmax;                                 
 code=vmin-(del/2):del:vmax+(del/2);        
 [ind,q]=quantiz(s,part,code);                     % Qua trinh luong tu
                                                     % ind: chua chi so luong tu, q: chua
                                                     % gia tri luong tu
                                                                                                                             
 l1=length(ind);
 l2=length(q);
  
 for i=1:l1
    if(ind(i)~=0)                                            % De tao chi muc duoi dang so thap phan bat dau tu 0 denN
       ind(i)=ind(i)-1;
    end 
    i=i+1;
 end   
  for i=1:l2
     if(q(i)==vmin-(del/2))                          %De tao luong tu giua 2 level
         q(i)=vmin+(del/2);
     end
 end    
 subplot(3,1,3);
 stem(q);grid on;                                       % Hien thi gia tri luong tu
 title('Quantized Signal');
 ylabel('Amplitude--->');
 xlabel('Time--->');
  
 %  Qua trinh giai ma
 figure
 code=de2bi(ind,'left-msb');             % Chuyen doi decimal sang binary
 k=1;
for i=1:l1
    for j=1:n
        coded(k)=code(i,j);                  % Chuyen doi tu ma trang sang hang
        j=j+1;
        k=k+1;
    end
    i=i+1;
end
 subplot(2,1,1); grid on;
 stairs(coded);                                 % Hien thi tin hieu duoc giai ma
axis([0 100 -2 3]);  title('Encoded Signal');
 ylabel('Amplitude--->');
 xlabel('Time--->');
 
 % He dieu che tin hieu PCM
 
 qunt=reshape(coded,n,length(coded)/n);
 index=bi2de(qunt','left-msb');                    
 q=del*index+vmin+(del/2);                       
 subplot(2,1,2); grid on;
 plot(q);                                                        
 title('Demodulated Signal');
 ylabel('Amplitude--->');
 xlabel('Time--->');
