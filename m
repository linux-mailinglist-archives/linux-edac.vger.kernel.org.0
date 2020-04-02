Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68B2719C1CD
	for <lists+linux-edac@lfdr.de>; Thu,  2 Apr 2020 15:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbgDBNKE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Apr 2020 09:10:04 -0400
Received: from mail-eopbgr40064.outbound.protection.outlook.com ([40.107.4.64]:64575
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733234AbgDBNKE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 2 Apr 2020 09:10:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrBFehfoLicAj+H00s4dVpOo4aYih3VbHh358To+onOw6qvNrW6ysF8fpwkbtI3zxKviABRH94Oc4rXl5AuyafYoUQt8YCn4geTlegyV3rg9McylPq6nDtBuvlD1cnUQmhbEzduhsvZjH6pfufuQYTNg+qmlzuYvgAYjPuC+gLqaqBmGymnSdCmxtWmMUv4RuKFLm2cni+WuS9sWxOjo9KTFcOULvvinoErjjaF+BmR4Rk6+FDWEnetYYmmkG4OWnKPnGprk1sJEStk5gbxkXPg33qNgtia1SA6lAp//qpjT2uww0dFz3l/+P8Lt3DL+z61dy7DcNvHLNo+axfiwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptz5sDfiA5DNWZiCBQCNXejr7GEkZF6Zh0Gt25XSyqY=;
 b=TI9VF9odO3DNXPSCNZ9vHjyAjQl+Fsv5GO6Zpyh0keTvnCs6OOYmPTRvjZRGuCRnwGybFvoIgGvVN3rc2+9m02kZbN3kok6ihozoWzUcscG2jchE9KjAjsJHlhVk00i/nFjPkGeoPwnIT81V5cmyW4u3e9SFImJnbKcF+rCQGI5ZKAB7VGhXmeQKJgz3/MpqzWiVyNIt3OUTawMOJGOqD96PUg/SmImPoewxKFMwQlk6i+w2M1sT9asD3F2La34RtCO40YhBx1MkDr44CtlVICmfMujRsWkxR3X2N/hBt7kdjBWJXl+D+QzwK/K13H/fdgcGutl1Z2EwW+DwRB6/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptz5sDfiA5DNWZiCBQCNXejr7GEkZF6Zh0Gt25XSyqY=;
 b=Ns+c2YAbSd77Q72x99Ec1DVAodObPjRQLWzdjG0PMi+LmxmErSEC36+0JUzRCdwRTqjYZFZLh1M9EC63JCOsaZVQx58mQMUDlJqNyU/fUjSEu87kN3Qwm6aiTupfSpNJmgsFbjCbWdZdoClsiJMQlcAj5DN4LfHpRKWKb7NpJdU=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (20.177.49.213) by
 VI1PR04MB5392.eurprd04.prod.outlook.com (20.178.120.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Thu, 2 Apr 2020 13:09:57 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b105:1422:4bfa:338e]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b105:1422:4bfa:338e%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 13:09:57 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Robert Richter <rrichter@marvell.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "manish.narani@xilinx.com" <manish.narani@xilinx.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Frank Li <frank.li@nxp.com>
Subject: RE: [patch v3 3/4] EDAC: synopsys: Add edac driver support for
 i.MX8MP
Thread-Topic: [patch v3 3/4] EDAC: synopsys: Add edac driver support for
 i.MX8MP
Thread-Index: AQHWCI4FcS/WeLicyEGazLJqeHwA4ahlbbGAgAAX+iCAACm4gIAAFIjQ
Date:   Thu, 2 Apr 2020 13:09:57 +0000
Message-ID: <VI1PR04MB4960DF2EF1961DCF74655BF592C60@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <1585790433-31465-1-git-send-email-sherry.sun@nxp.com>
 <1585790433-31465-4-git-send-email-sherry.sun@nxp.com>
 <20200402072200.o6c6u3uim6jwopo6@rric.localdomain>
 <VI1PR04MB4960985DD2A4F0CA68063D9592C60@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20200402111709.qr7zpo5o5vrwh5kb@rric.localdomain>
In-Reply-To: <20200402111709.qr7zpo5o5vrwh5kb@rric.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sherry.sun@nxp.com; 
x-originating-ip: [121.228.205.159]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0f75deea-14d2-4650-51f9-08d7d70724a4
x-ms-traffictypediagnostic: VI1PR04MB5392:|VI1PR04MB5392:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5392A69E7DEA55877E0DCA7B92C60@VI1PR04MB5392.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(55016002)(186003)(6916009)(316002)(6506007)(4326008)(86362001)(8676002)(478600001)(81156014)(33656002)(54906003)(66946007)(66446008)(5660300002)(2906002)(52536014)(71200400001)(81166006)(26005)(64756008)(66476007)(44832011)(66556008)(53546011)(7696005)(8936002)(76116006)(9686003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ahjDlklHkIv4AY9EYvj8P/nFJPrbyGT/3J6/tYFvOl1UwOqtScyjPH3f+SkXaVwvk+HdmB2IU0lpxzKEuNq/tr5gENv8C5GBdHYMvcF315RypBm5CAAM9rAicAhN3lVVmrCgOyECd63RzHuiwoqB8wswLmCOaXaWbrf4Nhme3SVN5coiUfmP082Ck3sh0XUU8TZxpQlJqE+plvZW0zFV1y/pqTrCncXjH33U8dXJDuvlUKhiIs0eXwZDoX0LJdl52NzbEabk1SUqo9LB5eYTQb0WXBKe+8/ZGpUi3r3bmoZYCV1WZuq/c28zS31o/+ReK40jHvZFW9V9/+HJjKAoYIVbBXxpmVdT0kMFIi1lEm3PRXWgVoodQ7g0OYEm/E23/+GOZsei9u/z+508e0sZBFN5LyL9MLR/75WGCVWEUZ1tIr3pRSOvBUOmQ8kPALG5
x-ms-exchange-antispam-messagedata: XZOxOqbICwApEWkhkYEl5oMoRq5xu0/iqgK7Xhoutpi+2ZFXakm3ei/S+vd9RLgeQYfLeJMxglYR2LWcDYh/HEPO3uQEZl1p9MibD3ncWTSS/6s/Z0z3py2doOTSUdB9CmvtZpiZWphkrl3buA7tFQ==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f75deea-14d2-4650-51f9-08d7d70724a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 13:09:57.4037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QqEziAnEXgtgaNQCU1GxnG21nGv5s/LzPkXfZfuKe21XcZP57GPBWJ7xVzuALC7i9Np4hm0E2fyEdE3gVNEc0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5392
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgUm9iZXJ0LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYmVy
dCBSaWNodGVyIDxycmljaHRlckBtYXJ2ZWxsLmNvbT4NCj4gU2VudDogMjAyMMTqNNTCMsjVIDE5
OjE3DQo+IFRvOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+IENjOiBicEBhbGll
bjguZGU7IG1jaGVoYWJAa2VybmVsLm9yZzsgdG9ueS5sdWNrQGludGVsLmNvbTsNCj4gamFtZXMu
bW9yc2VAYXJtLmNvbTsgbWljaGFsLnNpbWVrQHhpbGlueC5jb207DQo+IG1hbmlzaC5uYXJhbmlA
eGlsaW54LmNvbTsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgRnJhbmsg
TGkNCj4gPGZyYW5rLmxpQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbcGF0Y2ggdjMgMy80XSBF
REFDOiBzeW5vcHN5czogQWRkIGVkYWMgZHJpdmVyIHN1cHBvcnQgZm9yDQo+IGkuTVg4TVANCj4g
DQo+IE9uIDAyLjA0LjIwIDA5OjA2OjI3LCBTaGVycnkgU3VuIHdyb3RlOg0KPiA+ID4gRnJvbTog
Um9iZXJ0IFJpY2h0ZXIgPHJyaWNodGVyQG1hcnZlbGwuY29tPiBPbiAwMi4wNC4yMCAwOToyMDoz
MiwNCj4gPiA+IFNoZXJyeSBTdW4gd3JvdGU6DQo+IA0KPiA+ID4gPiArc3RhdGljIHZvaWQgZW5h
YmxlX2ludHJfaW14OG1wKHN0cnVjdCBzeW5wc19lZGFjX3ByaXYgKnByaXYpIHsNCj4gPiA+ID4g
KwlpbnQgcmVndmFsOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJcmVndmFsID0gcmVhZGwocHJpdi0+
YmFzZWFkZHIgKyBFQ0NfQ0xSX09GU1QpOw0KPiA+ID4gPiArCXJlZ3ZhbCB8PSAoRERSX0NFX0lO
VFJfRU5fTUFTSyB8IEREUl9VRV9JTlRSX0VOX01BU0spOw0KPiA+ID4gPiArCXdyaXRlbChyZWd2
YWwsIHByaXYtPmJhc2VhZGRyICsgRUNDX0NMUl9PRlNUKTsgfQ0KPiA+ID4gPiArDQo+ID4gPiA+
ICtzdGF0aWMgdm9pZCBkaXNhYmxlX2ludHJfaW14OG1wKHN0cnVjdCBzeW5wc19lZGFjX3ByaXYg
KnByaXYpIHsNCj4gPiA+ID4gKwlpbnQgcmVndmFsOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJcmVn
dmFsID0gcmVhZGwocHJpdi0+YmFzZWFkZHIgKyBFQ0NfQ0xSX09GU1QpOw0KPiA+ID4gPiArCXJl
Z3ZhbCAmPSB+KEREUl9DRV9JTlRSX0VOX01BU0sgfCBERFJfVUVfSU5UUl9FTl9NQVNLKTsNCj4g
PiA+ID4gKwl3cml0ZWwocmVndmFsLCBwcml2LT5iYXNlYWRkciArIEVDQ19DTFJfT0ZTVCk7IH0N
Cj4gPiA+ID4gKw0KPiA+ID4gPiArLyogSW50ZXJydXB0IEhhbmRsZXIgZm9yIEVDQyBpbnRlcnJ1
cHRzIG9uIGlteDhtcCBwbGF0Zm9ybS4gKi8NCj4gPiA+ID4gK3N0YXRpYyBpcnFyZXR1cm5fdCBp
bnRyX2hhbmRsZXJfaW14OG1wKGludCBpcnEsIHZvaWQgKmRldl9pZCkgew0KPiA+ID4gPiArCWNv
bnN0IHN0cnVjdCBzeW5wc19wbGF0Zm9ybV9kYXRhICpwX2RhdGE7DQo+ID4gPiA+ICsJc3RydWN0
IG1lbV9jdGxfaW5mbyAqbWNpID0gZGV2X2lkOw0KPiA+ID4gPiArCXN0cnVjdCBzeW5wc19lZGFj
X3ByaXYgKnByaXY7DQo+ID4gPiA+ICsJaW50IHN0YXR1cywgcmVndmFsOw0KPiA+ID4gPiArDQo+
ID4gPiA+ICsJcHJpdiA9IG1jaS0+cHZ0X2luZm87DQo+ID4gPiA+ICsJcF9kYXRhID0gcHJpdi0+
cF9kYXRhOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJcmVndmFsID0gcmVhZGwocHJpdi0+YmFzZWFk
ZHIgKyBFQ0NfU1RBVF9PRlNUKTsNCj4gPiA+ID4gKwlpZiAoIShyZWd2YWwgJiBFQ0NfSU5UUl9N
QVNLKSkNCj4gPiA+ID4gKwkJcmV0dXJuIElSUV9OT05FOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJ
c3RhdHVzID0gcF9kYXRhLT5nZXRfZXJyb3JfaW5mbyhwcml2KTsNCj4gPiA+ID4gKwlpZiAoc3Rh
dHVzKQ0KPiA+ID4gPiArCQlyZXR1cm4gSVJRX05PTkU7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlw
cml2LT5jZV9jbnQgKz0gcHJpdi0+c3RhdC5jZV9jbnQ7DQo+ID4gPiA+ICsJcHJpdi0+dWVfY250
ICs9IHByaXYtPnN0YXQudWVfY250Ow0KPiA+ID4gPiArCWhhbmRsZV9lcnJvcihtY2ksICZwcml2
LT5zdGF0KTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWVkYWNfZGJnKDMsICJUb3RhbCBlcnJvciBj
b3VudCBDRSAlZCBVRSAlZFxuIiwNCj4gPiA+ID4gKwkJIHByaXYtPmNlX2NudCwgcHJpdi0+dWVf
Y250KTsNCj4gPiA+ID4gKwllbmFibGVfaW50cl9pbXg4bXAocHJpdik7DQo+ID4gPg0KPiA+ID4g
V2h5IGRvIHlvdSBlbmFibGUgaW50ZXJydXB0cyBoZXJlPw0KPiA+DQo+ID4gQmVjYXVzZSB6eW5x
bXBfZ2V0X2Vycm9yX2luZm8oKSB3cm90ZSAwIHRvIEVDQ19DTFJfT0ZTVCwgc28gaGVyZSBoYXZl
DQo+IHRvIHJlLWVuYWJsZSB0aGUgaW50ZXJydXB0cy4NCj4gDQo+IFRoaXMgZG9lcyBub3Qgc2Vl
bSB0byBiZSB0aGUgcmlnaHQgcGxhY2UgZm9yIGl0Lg0KPiANCj4gPiBBcyBzYWlkIGluIHRoZSBj
b21taXQsIHRoZSBtYWluIGRpZmZlcmVuY2UgYmV0d2VlbiBaeW5xTVAgYW5kIGkuTVg4TVANCj4g
ZGRyIGNvbnRyb2xsZXIgaXMgdGhlIGludGVycnVwdCByZWdpc3RlcnMuDQo+ID4gWnlucU1QIHVz
ZSBERFIgUU9TIEludGVycnVwdCByZWdpc3RlcnMsICBidXQgaS5NWDhNUCB1c2UgRUNDX0NMUl9P
RlNUDQo+IFJlZ2lzdGVyKGJpdDggYW5kIGJpdDkpIHRvIGVuYWJsZS9kaXNhYmxlIHRoZSBjZS91
ZSBpbnRlcnJ1cHRzLg0KPiA+DQo+ID4gSW4genlucW1wX2dldF9lcnJvcl9pbmZvKCksIFp5bnFt
cCB3cm90ZSAwIHRvIEVDQ19DTFJfT0ZTVCByZWdpc3RlciB0bw0KPiBjbGVhciBDRS9VRSBlcnJv
ciBmbGFncyBhbmQgY291bnRzLCBpdCBoYXMgbm8gZWZmZWN0IG9uIFp5bnFtcCBpbnRlcnJ1cHRz
Lg0KPiA+IEJ1dCBmb3IgaS5NWDhNUCwgd2lydGUgMCB0byBFQ0NfQ0xSX09GU1Qgd2lsbCBkaXNh
YmxlIGkuTVg4TVAgQ0UvVUUNCj4gaW50ZXJydXB0LCBzbyBuZWVkIHJlLWVuYWJsZSB0aGUgaW50
ZXJydXB0cy4NCj4gDQo+IEFsbCB0aGlzIHNob3dzIG9uZSBtb3JlIHRpbWUgdGhlcmUgc2hvdWxk
IGJlIHNlcGFyYXRlIGhhbmRsZXJzLiBZb3Ugc2hvdWxkDQo+IGdldCByaWQgbW9zdCBjYWxsYmFj
a3MgaW4gc3RydWN0IHN5bnBzX3BsYXRmb3JtX2RhdGEgYW5kIGluc3RlYWQgaGF2ZQ0KPiBzZXBh
cmF0ZSBwcm9iZSBmdW5jdGlvbnMgZm9yIGJvdGggZmxhdm9ycyB0aGF0IHNoYXJlIGNvbW1vbiBj
b2RlLg0KDQpEbyB5b3UgbWVhbiB0aGF0IEkgc2hvdWxkIGNyZWF0ZSBzcGVjaWZpYyBjYWxsYmFj
a3MgaW4gc3RydWN0IHN5bnBzX3BsYXRmb3JtX2RhdGEgZm9yIGkuTVg4TVAgaW5zdGVhZCByZXVz
ZSB0aGUgWnlucU1QIGZ1bmN0aW9ucz8NCkJ1dCBleGNlcHQgdGhpcyBvcGVyYXRpb24gb2Ygd3Jp
dGUgMCB0byBFQ0NfQ0xSX09GU1QgaW4genlucW1wX2dldF9lcnJvcl9pbmZvKCksIA0KdGhlIG90
aGVyIGNhbGxiYWNrcyBpbiBzdHJ1Y3Qgc3lucHNfcGxhdGZvcm1fZGF0YSBhcmUgYWxsIHRoZSBz
YW1lIGJldHdlZW4gWnlucU1QIGFuZCBpLk1YOE1QLg0KDQpCZXN0IHJlZ2FyZHMNClNoZXJyeSBT
dW4NCg0KDQo=
