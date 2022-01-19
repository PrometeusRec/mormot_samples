type
  TTestType   = (C_GREEN,C_RED);
  TBarsJSON   = packed record
    t            : TDateTime;
    o            : Double;
    h            : Double;
    l            : Double;
    c            : Double;
    v            : Int64;
    n            : Int64;
    vw           : Double;
//    test_type  : TTestType;
  end;
  TBarsHubs   = array of TBarsJSON;

var   JSONOrigin  : TStringList;
      Bars        : TBarsJSON;
      BarsHubs    : TBarsHubs;
      tmp         : RawUtf8;
      array_size  : Integer;	

const __TBarsHub = 't: TDateTime; o: Double; h: Double; l: Double; c: Double; v: Int64; n: Int64; vw: Double';

begin
  MemoTrab.Clear;

  JSONOrigin := TStringList.Create;
  JSONOrigin.LoadFromFile('20220117222332_HTTPRESPONSE.TXT');
  tmp := JSONOrigin.Text;
//  TRttiJson.RegisterFromText(TypeInfo(TBarsHubs),__TBarsHub,[jpoIgnoreUnknownProperty],[]);
  DynArrayLoadJson(BarsHubs,@tmp,TypeInfo(TBarsHubs));
  array_size := SizeOf(BarsHubs);
  MemoResult.Lines.Add((BarsHubs[0].o).ToString);
  JSONOrigin.Free;
