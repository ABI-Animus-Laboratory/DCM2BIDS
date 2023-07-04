function [] = writeStudyPar(regexp)
studyPar.SubjectRegExp = regexp;
studyPar.ASLContext = 'cbf';
studyPar.M0Type = 'Absent';
studyPar.M0 = false;
studyPar.Manufacturer = 'GE';
studyPar.PulseSequenceType = '3D_spiral';
studyPar.MRAcquisitionType = '3D';
studyPar.MagneticFieldStrength = 3;
studyPar.ArterialSpinLabelingType = 'PASL';
studyPar.BolusCutOffFlag = false;
studyPar.BackgroundSuppression = false;
studyPar.BackgroundSuppressionNumberPulses = 0;
studyPar.BackgroundSuppressionPulseTime = [];

encoded=jsonencode(studyPar,"PrettyPrint",true);
fid = fopen('studyPar.json','w');
fprintf(fid,'%s',encoded);
fclose(fid);