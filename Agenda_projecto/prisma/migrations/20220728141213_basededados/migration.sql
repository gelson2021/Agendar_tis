-- CreateEnum
CREATE TYPE "Perfil" AS ENUM ('USER', 'ADMIN');

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "userId" TEXT NOT NULL,
    "perfil" "Perfil" NOT NULL DEFAULT 'USER',
    "perfilId" TEXT NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "reuniao" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "duration" INTEGER NOT NULL,
    "release_date" TIMESTAMP(3) NOT NULL,
    "tempo_inicio" TIMESTAMP(3) NOT NULL,
    "tempo_fim" TIMESTAMP(3) NOT NULL,
    "estadoId" TEXT NOT NULL,
    "prioridadeId" TEXT NOT NULL,

    CONSTRAINT "reuniao_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "participante" (
    "userId" TEXT NOT NULL,
    "reuniaoId" TEXT NOT NULL,

    CONSTRAINT "participante_pkey" PRIMARY KEY ("userId","reuniaoId")
);

-- CreateTable
CREATE TABLE "sala2" (
    "id" TEXT NOT NULL,
    "edificio2Id" INTEGER,
    "piso" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "salaId" TEXT NOT NULL,

    CONSTRAINT "sala2_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "edificio" (
    "id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,

    CONSTRAINT "edificio_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "funcao" (
    "id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "departamentoId" TEXT NOT NULL,

    CONSTRAINT "funcao_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "departamento" (
    "id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,

    CONSTRAINT "departamento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contacto" (
    "id" TEXT NOT NULL,
    "numero" TEXT NOT NULL,
    "contactoId" TEXT NOT NULL,

    CONSTRAINT "contacto_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "estado_reuniao" (
    "id" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,

    CONSTRAINT "estado_reuniao_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "prioridade_reuniao" (
    "id" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,

    CONSTRAINT "prioridade_reuniao_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_userId_fkey" FOREIGN KEY ("userId") REFERENCES "funcao"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reuniao" ADD CONSTRAINT "reuniao_estadoId_fkey" FOREIGN KEY ("estadoId") REFERENCES "estado_reuniao"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reuniao" ADD CONSTRAINT "reuniao_prioridadeId_fkey" FOREIGN KEY ("prioridadeId") REFERENCES "prioridade_reuniao"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "participante" ADD CONSTRAINT "participante_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "participante" ADD CONSTRAINT "participante_reuniaoId_fkey" FOREIGN KEY ("reuniaoId") REFERENCES "reuniao"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sala2" ADD CONSTRAINT "sala2_salaId_fkey" FOREIGN KEY ("salaId") REFERENCES "edificio"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "funcao" ADD CONSTRAINT "funcao_departamentoId_fkey" FOREIGN KEY ("departamentoId") REFERENCES "departamento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contacto" ADD CONSTRAINT "contacto_contactoId_fkey" FOREIGN KEY ("contactoId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
