function [] = importASL(mainLoc,bidsdir,subnum,srcfilename,aslfile,xASLdir)
    addpath(mainLoc)
    %% Need a section to rename folder without spaces, then rename with spaces
    oldasl=strcat(bidsdir,'\sourcedata\',srcfilename,'\',aslfile);
    chunks = split(aslfile,' ');
    newaslfilename='';
    for i=1:length(chunks)
        newaslfilename=strcat(newaslfilename,chunks{i});
    end
    newasl=strcat(bidsdir,'\sourcedata\',srcfilename,'\',newaslfilename);
    movefile(oldasl,newasl)
    %% Full unpack including making the directories and removing them after
    %Write in the xASL import files
    cd(bidsdir)
    writeStudyPar(srcfilename)
    writeSourceStructure(srcfilename,newaslfilename)
    % Delete previous log and lock files
    % Delete log and lock files from xASL which may have logged that unpacking
    % has already been done
    try 
        rmdir(fullfile(bidsdir,'derivatives\ExploreASL\lock'), 's')
        rmdir(fullfile(bidsdir,'derivatives\ExploreASL\log'), 's')
    end
    % run xASL
    cd(xASLdir)
    ExploreASL(bidsdir,[1 1 0],0)
    % Move unpacked ASL into the proper subject folder then remove temp folder
    match = ["_","-"];
    unpckfoldname = erase(srcfilename,match); %Get compressed xASL name
    filename1=strcat(bidsdir,'\rawdata\sub-',unpckfoldname,'\perf\sub-',unpckfoldname,'_asl.json');
    filename2=strcat(bidsdir,'\rawdata\sub-',unpckfoldname,'\perf\sub-',unpckfoldname,'_asl.nii.gz');
    filename3=strcat(bidsdir,'\rawdata\sub-',unpckfoldname,'\perf\sub-',unpckfoldname,'_aslcontext.tsv');
    newfilename1=strcat(bidsdir,'\rawdata\sub-',num2str(subnum),'\perf\sub-',num2str(subnum),'_asl.json');
    newfilename2=strcat(bidsdir,'\rawdata\sub-',num2str(subnum),'\perf\sub-',num2str(subnum),'_asl.nii.gz');
    newfilename3=strcat(bidsdir,'\rawdata\sub-',num2str(subnum),'\perf\sub-',num2str(subnum),'_aslcontext.tsv');
    fileloc=strcat(bidsdir,'\rawdata\sub-',unpckfoldname,'\perf\');
    newfileloc=strcat(bidsdir,'\rawdata\sub-',num2str(subnum),'\perf\');
    try mkdir(newfileloc)
    end
    cd(fileloc)
    movefile(filename1,newfilename1)
    movefile(filename2,newfilename2)
    movefile(filename3,newfilename3)
    % remove directory, delete dataset description
    loc=strcat(bidsdir,'\rawdata\sub-',unpckfoldname);
    cd(bidsdir)
    rmdir(loc, 's')
    delete(strcat(bidsdir,'\rawdata\dataset_description.json'))
    delete(strcat(bidsdir,'\studyPar.json'))
    delete(strcat(bidsdir,'\sourceStructure.json'))
    %% rename folder
    movefile(newasl,oldasl)
end