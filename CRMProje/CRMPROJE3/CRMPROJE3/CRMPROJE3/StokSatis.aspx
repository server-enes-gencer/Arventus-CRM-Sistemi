﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Satis.Master" AutoEventWireup="true" CodeBehind="StokSatis.aspx.cs" Inherits="CRMPROJE3.StokSatis" %>

<%@ Register Assembly="DevExpress.Web.v22.2, Version=22.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.XtraCharts.v22.2.Web, Version=22.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dx" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Register assembly="DevExpress.XtraCharts.v22.2, Version=22.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraCharts" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="CSS\style.css" />
    <link rel="stylesheet" href="CSS\responsive.css" />
    <style>
        ::-webkit-scrollbar {
            width: 1.50vh; /* Yatay scrollbar genişliği */
            height: 2vh; /* Dikey scrollbar genişliği */
        }

        /* Track */
        ::-webkit-scrollbar-track {
            background: #0094ff; /* Arka plan rengi */
        }

        /* Handle */
        ::-webkit-scrollbar-thumb {
            background: #4e73df; /* Scrollbar rengi */
            border-radius: 10px; /* Oval şeklini sağlamak için */
        }

        /* Sağ taraftaki scrollbar'ı oval yapmak için */
        ::-webkit-scrollbar-thumb:vertical {
            border-radius: 10px;
        }

        /* İçindeki scrollbar track'ı dikdörtgen şeklinde bırakmak için */
        ::-webkit-scrollbar-track-piece {
            background: #ccc; /* Track arka plan rengi */
        }

        .grid-container {
            overflow-x: auto; /* Yatay kaydırma çubuğunu göster */
            width: 100%;
        }
        .grid-container .dxgv {
            width: 1500px; /* ASPxGridView'in genişliği */
        }
          /* Butonlar arasındaki boşluğu ayarla */
    .excelbutonstok {
        margin-right: 10px; /* İstenilen boşluk miktarı */
    }

        .pdfbutonstok {
            margin-right: 10px; /* İstenilen boşluk miktarı */
        }
                  /* Özel genişlik sınıfı */
.modal-lg-custom
    {
    max-width: 800px; /* Burada istediğiniz genişliği ayarlayabilirsiniz */
    
}

.modal-body-custom {
    max-height: 800px; /* Modalın yüksekliğini de ayarlayabilirsiniz */
    overflow-y: auto; /* İçeriğin taşması durumunda kaydırma çubuğu eklemek için */
}

              
    
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <div class="grid-container">
        <dx:ASPxGridView ID="gvStok" runat="server" AutoGenerateColumns="False" DataSourceID="dsStok" KeyFieldName="Id" EnableTheming="True" Theme="IOS" Width="100%" CssClass="dxgv">
            <SettingsEditing Mode="Batch"></SettingsEditing>
            <Settings ShowHeaderFilterButton="True" ShowGroupPanel="True" />
            <SettingsPopup>
                <FilterControl AutoUpdatePosition="False"></FilterControl>
            </SettingsPopup>
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowDeleteButton="True" ShowInCustomizationForm="True" ShowNewButtonInHeader="True" VisibleIndex="0"></dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Id" ReadOnly="True" VisibleIndex="1" Visible="False">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="stok_kodu" VisibleIndex="2" Caption="Stok Kodu"></dx:GridViewDataTextColumn>
                <dx:GridViewDataComboBoxColumn FieldName="kategori_no" VisibleIndex="3" Caption="Kategori">
                    <PropertiesComboBox DataSourceID="dsKategori" TextField="kategori_adi" ValueField="kategori_no"></PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataComboBoxColumn FieldName="depo_kod" VisibleIndex="4" Caption="Depo">
                    <PropertiesComboBox DataSourceID="dsDepo" TextField="depo_ad" ValueField="depo_kod"></PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataTextColumn FieldName="stok_adi" VisibleIndex="5" Caption="Stok Adı"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="depodaki_miktar" VisibleIndex="6" Caption="Depodaki Miktar"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="tane_ucreti" VisibleIndex="7" Caption="Birim Fiyat"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="satis_ucreti" VisibleIndex="8" Caption="Satış Fiyatı"></dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
    </div>

    <asp:SqlDataSource ID="dsStok" runat="server" ConnectionString="<%$ ConnectionStrings:ARVENTUSConnectionString %>" DeleteCommand="DELETE FROM [Stok] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Stok] ([stok_kodu], [kategori_no], [depo_kod], [stok_adi], [depodaki_miktar], [tane_ucreti], [satis_ucreti]) VALUES (@stok_kodu, @kategori_no, @depo_kod, @stok_adi, @depodaki_miktar, @tane_ucreti, @satis_ucreti)" SelectCommand="SELECT * FROM [Stok]" UpdateCommand="UPDATE [Stok] SET [stok_kodu] = @stok_kodu, [kategori_no] = @kategori_no, [depo_kod] = @depo_kod, [stok_adi] = @stok_adi, [depodaki_miktar] = @depodaki_miktar, [tane_ucreti] = @tane_ucreti, [satis_ucreti] = @satis_ucreti WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="stok_kodu" Type="Int32" />
            <asp:Parameter Name="kategori_no" Type="Int32" />
            <asp:Parameter Name="depo_kod" Type="Int32" />
            <asp:Parameter Name="stok_adi" Type="String" />
            <asp:Parameter Name="depodaki_miktar" Type="Int32" />
            <asp:Parameter Name="tane_ucreti" Type="Int64" />
            <asp:Parameter Name="satis_ucreti" Type="Int64" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="stok_kodu" Type="Int32" />
            <asp:Parameter Name="kategori_no" Type="Int32" />
            <asp:Parameter Name="depo_kod" Type="Int32" />
            <asp:Parameter Name="stok_adi" Type="String" />
            <asp:Parameter Name="depodaki_miktar" Type="Int32" />
            <asp:Parameter Name="tane_ucreti" Type="Int64" />
            <asp:Parameter Name="satis_ucreti" Type="Int64" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dsKategori" runat="server" ConnectionString="<%$ ConnectionStrings:ARVENTUSConnectionString %>" SelectCommand="SELECT * FROM [Stok_Kategori]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsDepo" runat="server" ConnectionString="<%$ ConnectionStrings:ARVENTUSConnectionString %>" SelectCommand="SELECT * FROM [Depo]"></asp:SqlDataSource>

    <div class="container mt-3" style="display:flex; align-items:flex-end;">

        <div style="margin-right: 10px;">
          
      <asp:ImageButton ID="excelbutonstok" runat="server" ImageUrl="İmage/excelicon.png" Width="30" Height="30" Class="excelbutonstok"  OnClick="excelbutonstok_Click"/>
          </div>
        <div>
    <asp:ImageButton ID="pdfbutonstok" runat="server" ImageUrl="İmage/pdf.png" Width="30" Height="30" Class="pdfbutonstok" OnClick="pdfbutonstok_Click"/>
             </div>
        <div class="col-auto" style="margin-right: 130vh;">
            <dx:ASPxGridViewExporter ID="Exporter" runat="server" GridViewID="ASPxGridView1" />
        </div>
       

          
        
        </div>
     
   
        </div>

    <style>
        .modal-lg-custom {
    max-width: 80%; /* Burada istediğiniz genişliği ayarlayabilirsiniz */
    
}

.modal-body-custom {
    max-height: 500px; /* Modalın yüksekliğini de ayarlayabilirsiniz */
    overflow-y: auto; /* İçeriğin taşması durumunda kaydırma çubuğu eklemek için */
}
    </style>
    <!-- Stok Grafiği Modalı -->
    
               <div class="modal fade" id="StokGrafikModal" tabindex="-1"  role="dialog" aria-labelledby="StokGrafikModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg-custom" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="StokGrafikModalLabel">Stok Grafiği</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body modal-body-custom d-flex flex-column align-items-center">
                <dx:WebChartControl ID="StokChart" runat="server" CrosshairEnabled="True" DataSourceID="dsStokChart" Height="500px" Width="1150px" >
    <DiagramSerializable>
        <dx:SimpleDiagram3D RotationMatrixSerializable="1;0;0;0;0;0.5;-0.866025403784439;0;0;0.866025403784439;0.5;0;0;0;0;1">
        </dx:SimpleDiagram3D>
    </DiagramSerializable>
    <SeriesSerializable>
        <dx:Series ArgumentDataMember="stok_adi" LabelsVisibility="True" Name="Series 1" ValueDataMembersSerializable="depodaki_miktar" LegendTextPattern="{A}">
            <ViewSerializable>
                <dx:Pie3DSeriesView>
                </dx:Pie3DSeriesView>
            </ViewSerializable>
        </dx:Series>
    </SeriesSerializable>
    <SeriesTemplate LegendTextPattern="{A}">
    </SeriesTemplate>
      <Titles>
          <dx:ChartTitle Text="STOK GRAFİĞİ" />
      </Titles>
</dx:WebChartControl>

<asp:SqlDataSource ID="dsStokChart" runat="server" ConnectionString="<%$ ConnectionStrings:ARVENTUSConnectionString %>" SelectCommand="SELECT * FROM [Stok]" ValidateRequestMode="Disabled"></asp:SqlDataSource>


            </div>
            <div class="modal-footer d-flex justify-content-center">
                <button class="btn btn-primary" type="button" data-dismiss="modal">Kapat</button>
            </div>
        </div>
    </div>
</div>
</asp:Content>
