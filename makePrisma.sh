
#if [ -d "hello-prisma2" ]
#then 
#	rm -r 'hello-prisma2'
#fi
#read -p 'qual é o nome da pasta do teu projecto: ' pasta;
#mkdir $pasta;
#cd $pasta;
#pwd
pasta="Agenda_projecto"
mkdir $pasta
move -r ./* $pasta
cd $pasta


mkdir APP;
mkdir APP/Back_end;
mkdir APP/Front_end;

copy makePrisma.sh $pasta/makePrisma.sh

sleep 1;

yarn init;

npm install prisma typescript ts-node express express-validator express-session @types/node --save-dev;
yarn add  tslib @types/node -D;

echo '{'>tsconfig.json
echo '  "compilerOptions": { '>>tsconfig.json
echo '   "sourceMap": true,'>>tsconfig.json
echo '   "outDir": "dist",'>>tsconfig.json
echo '   "strict": true,'>>tsconfig.json
echo '   "lib": ["esnext"],'>>tsconfig.json
echo '   "esModuleInterop": true'>>tsconfig.json
echo '  }'>>tsconfig.json
echo '}'>>tsconfig.json

#npm install prisma --save-dev;
yarn prisma init --datasource-provider postgresql;

yarn prisma;

yarn prisma init;

#dados para o postgresql
user="postgres";
password="postgres123";
localhost="127.0.0.1";
port="5432"
database="Agendamento_Reuniao";

echo "DATABASE_URL=\"postgresql://$user:$password@$localhost:$port/$database?schema=public\" "> .env;

sleep 1
echo '
model User {
  id String @id @default(uuid())
  email String @unique
  name String
  password String
  created_at DateTime @default(now())
  updated_at DateTime @updatedAt
  participante Participante [] @relation("user")
  funcao  Funcao? @relation(fields: [userId], references: [id])
  userId String 
  Contacto Contacto[]
  perfil  Perfil             @default(USER)
  perfilId String

@@map("users")
}
model Reuniao{
  id String @id @default(uuid())
  title     String 
  duration Int
  release_date DateTime 
  tempo_inicio DateTime 
   tempo_fim  DateTime
  @@map("reuniao")
  participante Participante [] @relation("reuniao")
  estado_reuniao Estado_reuniao? @relation(fields: [estadoId], references: [id])
  estadoId String
  prioridade_reuniao Prioridade_reuniao? @relation(fields: [prioridadeId], references: [id])
  prioridadeId String
}
model Participante{
  user User @relation("user", fields:[userId],references: [id])
  userId String
  reuniao Reuniao @relation("reuniao", fields:[reuniaoId],references: [id])
  reuniaoId String
  
   @@id([userId,reuniaoId])
   @@map("participante")
}

model Sala2 {
  id  String   @id @default(uuid())
  edificio2Id Int?
  piso String
  nome String
  Edificio2  Edificio2? @relation(fields: [salaId], references: [id])
  salaId String

@@map("sala2")

}

model Edificio2 {
  id    String    @id @default(uuid())
  salas2 Sala2[]
  nome String
  
  @@map("edificio")
}

//Relacao dos Usuarios

model Funcao {
id   String    @id @default(uuid())
nome String
user User[]
Departamento  Departamento? @relation(fields: [departamentoId], references: [id])
departamentoId String
 @@map("funcao")
}
model Departamento{
  id   String    @id @default(uuid())
  nome String
  funcao Funcao[]

  @@map("departamento")
}

model Contacto{
id   String    @id @default(uuid())
numero String
@@map("contacto")
user  User? @relation(fields: [contactoId], references: [id])
contactoId String
}


enum Perfil {
  USER
  ADMIN
}

/*model Perfil{
 id   String    @id @default(uuid())
  descricao String
 user User[]
}*/

//Relacao Reuniao 

model Estado_reuniao{
  id String  @id @default(uuid())
  descricao String
  Reuniao Reuniao[]

  @@map("estado_reuniao")

}
model Prioridade_reuniao{
  id String  @id @default(uuid())
  descricao String
  Reuniao Reuniao[]

  @@map("prioridade_reuniao")

}


' >> prisma/schema.prisma;

#sleep 1;
#echo 'continuar??? npx prisma migrate dev --name init digita ( Y / N )';
#read cont;
yarn add @prisma/client;
sleep 2;

#if [ $cont == 'Y'] || [ $cont == 'y' ]
#then
	yarn prisma migrate dev --name init
#else
 #	exit;
#fi

sleep 2;



echo '
import { PrismaClient } from "@prisma/client"

const prisma = new PrismaClient()

' > APP/index.ts;




