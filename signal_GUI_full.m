function signal_GUI_full ()
    % Create the figure for the GUI
    f = figure('Name','Signal Generator & Modifier','Position',[300 100 800 550]);

    % Time variable
    t = linspace(0, 1, 1000);
    
    uicontrol('Style','text','Position',[20 510 100 20],'String','start:');
    Box = uicontrol('Style','edit','Position',[120 510 80 25],'String','0');
       uicontrol('Style','text','Position',[20 510 100 20],'String','end:');
    ampBox = uicontrol('Style','edit','Position',[120 510 80 25],'String','0');
     uicontrol('Style','text','Position',[20 510 100 20],'String','samplingfreq:');
    ampBox = uicontrol('Style','edit','Position',[120 510 80 25],'String','0');
    t = linspace(start, end, samplingfreq);
    y = [];

    % Amplitude input
    uicontrol('Style','text','Position',[20 510 100 20],'String','Amplitude:');
    ampBox = uicontrol('Style','edit','Position',[120 510 80 25],'String','1');

    % Frequency input
    uicontrol('Style','text','Position',[20 480 100 20],'String','Frequency:');
    freqBox = uicontrol('Style','edit','Position',[120 480 80 25],'String','1');

    % Phase input
    uicontrol('Style','text','Position',[20 450 100 20],'String','Phase:');
    phaseBox = uicontrol('Style','edit','Position',[120 450 80 25],'String','0');

    % Signal type selection
    uicontrol('Style','text','Position',[220 510 100 20],'String','Signal Type:');
    typeMenu = uicontrol('Style','popupmenu','Position',[320 510 150 25],...
        'String',{'Sine','Cosine','Square','Triangle','Sawtooth','DC','Ramp'});

    % Operation selection
    uicontrol('Style','text','Position',[500 510 100 20],'String','Operation:');
    opMenu = uicontrol('Style','popupmenu','Position',[600 510 160 25],...
        'String',{'None','Amplitude Scaling','Time Reversal','Time Shift','Expanding','Compressing'});

    % Generate signal button
    uicontrol('Style','pushbutton','Position',[120 400 120 30],'String','Generate Signal',...
        'Callback',@generateSignal);

    % Apply operation button
    uicontrol('Style','pushbutton','Position',[280 400 120 30],'String','Apply Operation',...
        'Callback',@applyOperation);

    % Plot area
    ax = axes('Units','pixels','Position',[80 80 640 300]);

    % Variables to store signal
    original_t = t;
    original_y = y;

    % Signal generation callback
    function generateSignal(~,~)
        amplitude = str2double(ampBox.String);
        frequency = str2double(freqBox.String);
        phase = str2double(phaseBox.String);
        signalType = typeMenu.Value;

        switch signalType
            case 1 % Sine
                y = amplitude * sin(2 * pi * frequency * t + phase);
            case 2 % Cosine
                y = amplitude * cos(2 * pi * frequency * t + phase);
            case 3 % Square
                y = amplitude * square(2 * pi * frequency * t + phase);
            case 4 % Triangle
                y = amplitude * sawtooth(2 * pi * frequency * t + phase, 0.5);
            case 5 % Sawtooth
                y = amplitude * sawtooth(2 * pi * frequency * t + phase);
            case 6 % DC
                y = amplitude * ones(size(t));
            case 7 % Ramp
                y = amplitude * t;
            otherwise
                errordlg('Invalid signal type selected');
                return;
        end

        original_y = y;
        original_t = t;

        plot(ax, t, y);
        title(ax, 'Original Signal');
        grid(ax, 'on');
    end

    % Apply operation callback
    function applyOperation(~,~)
        if isempty(y)
            errordlg('Please generate a signal first');
            return;
        end

        operation = opMenu.Value;
        switch operation
            case 1 % None
                plot(ax, t, y);
                title(ax, 'Original Signal');
            case 2 % Amplitude Scaling
                factor = str2double(inputdlg('Enter amplification value:','',1,{'1'}));
                plot(ax, t, factor * y);
                title(ax, 'Amplified Signal');
            case 3 % Time Reversal
                plot(ax, -t, y);
                title(ax, 'Time Reversed Signal');
            case 4 % Time Shift
                shift = str2double(inputdlg('Enter shift value:','',1,{'0'}));
                plot(ax, t + shift, y);
                title(ax, 'Time Shifted Signal');
           case 5 % Expanding
                exp = str2double(inputdlg('Enter expansion factor:','',1,{'1'}));
                plot(ax, t * exp, y);
                title(ax, 'Expanded Signal');
            case 6 % Compressing
                comp = str2double(inputdlg('Enter compression factor:','',1,{'1'}));
                if comp == 0
                    errordlg('Compression factor cannot be zero');
                    return;
                end
                plot(ax, t / comp, y);
                title(ax, 'Compressed Signal');
        end
        grid(ax, 'on');
    end
end     