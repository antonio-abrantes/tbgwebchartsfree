unit Charts.Bar;

interface

uses
  Interfaces;

Type
  TModelHTMLChartsBar = class(TInterfacedObject, iModelHTMLChartsBar)
    private
      FHTML : String;
      FParent : iModelHTMLCharts;
      FConfig : iModelHTMLChartsConfig<iModelHTMLChartsBar>;
    public
      constructor Create(Parent : iModelHTMLCharts);
      destructor Destroy; override;
      class function New(Parent : iModelHTMLCharts) : iModelHTMLChartsBar;
      function Attributes : iModelHTMLChartsConfig<iModelHTMLChartsBar>;
      function HTML(Value : String) : iModelHTMLChartsBar; overload;
      function HTML : String; overload;
      function &End : iModelHTMLCharts;
  end;

implementation

uses
  Charts.Config, SysUtils, Injection;

{ TModelHTMLChartsBar }

function TModelHTMLChartsBar.&End: iModelHTMLCharts;
begin
  Result := FParent;
  FParent.HTML('<div class="col-'+IntToStr(FConfig.ColSpan)+'">  ');
  FParent.HTML('<canvas id="'+FConfig.Name+'" ');
  if FConfig.Width > 0 then
    FParent.HTML('width="'+IntToStr(FConfig.Width)+'px" ');
  if FConfig.Heigth > 0 then
    FParent.HTML('height="'+IntToStr(FConfig.Heigth)+'px" ');
  FParent.HTML('></canvas>  ');
  FParent.HTML('<script>  ');

  FParent.HTML('var ctx = document.getElementById('''+FConfig.Name+''').getContext(''2d''); ');
  FParent.HTML('var myChart = new Chart(ctx, { ');
  FParent.HTML('type: ''bar'', ');
  FParent.HTML('data: { ');
  FParent.HTML('labels: '+FConfig.ResultLabels+',  ');
  FParent.HTML('datasets: [  ');
  FParent.HTML(FConfig.ResultDataSet);
  FParent.HTML(']  ');
  FParent.HTML('}, ');
  FParent.HTML('options: { responsive: true, legend: { position: ''top'', }, title: { display: true, text: '''+FConfig.Title+''' } }, ');
  FParent.HTML('}); ');
  FParent.HTML('</script>  ');
  FParent.HTML('</div>  ');
end;

function TModelHTMLChartsBar.HTML: String;
begin
  Result := FHTML;
end;

function TModelHTMLChartsBar.HTML(Value: String): iModelHTMLChartsBar;
begin
  Result := Self;
  FHTML := Value;
end;

function TModelHTMLChartsBar.Attributes: iModelHTMLChartsConfig<iModelHTMLChartsBar>;
begin
  Result := FConfig
end;

constructor TModelHTMLChartsBar.Create(Parent : iModelHTMLCharts);
begin
  TInjection.Weak(@FParent, Parent);
  FConfig := TModelHTMLChartsConfig<iModelHTMLChartsBar>.New(Self);
end;

destructor TModelHTMLChartsBar.Destroy;
begin

  inherited;
end;

class function TModelHTMLChartsBar.New(Parent : iModelHTMLCharts) : iModelHTMLChartsBar;
begin
  Result := Self.Create(Parent);
end;

end.
