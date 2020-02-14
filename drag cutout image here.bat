@echo off

set base_name=%~nx1

set output_directory=%~dp1

set obj_name=image plane.obj
set obj_file=%output_directory%%obj_name%
set nl2sco_file=%output_directory%%base_name%.nl2sco
set nl2mat_file=%output_directory%%base_name%.nl2mat

if exist "%obj_file%" goto create_nl2sco
:create_obj
(
	echo o Plane
	echo v -0.5 0.0 0.5
	echo v 0.5 0.0 0.5
	echo v 0.5 0.0 -0.5
	echo v -0.5 0.0 -0.5
	echo vt 1.0 0.0
	echo vt 1.0 1.0
	echo vt 0.0 1.0
	echo vt 0.0 0.0
	echo usemtl Material
	echo f 1/1 2/2 3/3 4/4
) > "%obj_file%"

:create_nl2sco
(
	echo ^<?xml version="1.0" encoding="UTF-8"?^>
	echo ^<root^>
	echo   ^<sceneobject^>
	echo     ^<model path="%obj_name%"/^>
	echo     ^<preview^>%base_name%^</preview^>		
	echo     ^<materialpath name="Material"^>%base_name%.nl2mat^</materialpath^>
	echo   ^</sceneobject^>
	echo ^</root^>
) > "%nl2sco_file%"

:create_nl2mat
(
	echo ^<?xml version="1.0" encoding="UTF-8"?^>
	echo ^<root^>
	echo   ^<material^>
	echo     ^<renderpass^>
	echo     ^<transparency mode="cutout"/^>
	echo     ^<alphatest function="ge128"/^>
	echo       ^<linearshading/^>
	echo       ^<custommaterial^>
	echo         ^<diffuse r="1" g="1" b="1"/^>
	echo         ^<ambient r="1" g="1" b="1"/^>
	echo         ^<specular r="1" g="1" b="1"/^>
	echo         ^<shininess exponent="128"/^>
	echo       ^</custommaterial^>
	echo       ^<rgbgen mode="lighting"/^>
	echo       ^<texunit^>
	echo         ^<map^>%base_name%^</map^>
	echo         ^<wrap mode="clamp"/^>
	echo         ^<fixzeroalpha/^>
	echo         ^<fixalphatestedmipmaps/^>
	echo         ^<tcgen mode="base"/^>
	echo       ^</texunit^>
	echo     ^</renderpass^>
	echo   ^</material^>
	echo ^</root^>
) > "%nl2mat_file%"