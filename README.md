# Greenplum 7의 pgvector와 OpenAI를 이용하여 AI 기반의 검색 환경 구축

현재 Greenplum 7 beta5에 pgvector를 포함되어, pl/python과 openai를 연동하는 예제입니다.
Greenplum pg_vector, openai의 연동 개념은 아래 링크에서 확인하실 수 있습니다.

https://rfriend.tistory.com/804
https://medium.com/greenplum-data-clinics/building-large-scale-ai-powered-search-in-greenplum-using-pgvector-and-openai-4f5c5811f54a

## 환경 구축을 위한 스크립트

```
1.Install_RockeyLinux8.7.txt             --Greenplum 7은 RHEL 8.7 or Rockey Linux 8.7 이상 권고
2.OS_setting.txt                         --Greenplum 7을 설치하기 위한 OS 설정
3.Install_Greenplum7.beta5.txt           --Greenplum 7 beta5 설치 스크립트
4.Install_Data Science Package.txt       --Data Science를 위한 python 라이브러리 설치
5.Install_openai.txt                     --openai 설치
6.plpython_with_openai.sql               --pl/python으로 openai 연동
```
