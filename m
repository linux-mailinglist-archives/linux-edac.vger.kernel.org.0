Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE4419BDBB
	for <lists+linux-edac@lfdr.de>; Thu,  2 Apr 2020 10:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgDBIpB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Apr 2020 04:45:01 -0400
Received: from mail-vi1eur05on2059.outbound.protection.outlook.com ([40.107.21.59]:13364
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728480AbgDBIpB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 2 Apr 2020 04:45:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9OcomyCsDgaWiDcNIMluZPLiX4Km42oB0km8CAAlaKZIhvOEY2w/MQLfmHZ/uLa9N6qXRio53UpN4hoW1ve6Nbk/HJW6jDW5oiQ7fcNiTW+6rvA3Z1uH7d8+e7WBa/yYui+VOHOuyIci2Wv+QFMA3Ply9AXSoetLNTyDVZ5HApu21WVZFugsK7/Qgo1VLu4AZhI8b0wBes6Oskqh7qrGEUIKQxNFUSiFNK2LV6bK9fLzIH+jOuX1c07oBVrNXp/gawBY5qOM/qdsRXKqqqG59dxtFUyiYYxmvGIrU0Bu65WH4knWPzAaiur0f+/Zzl6O2OMCIy/zuZlpMiVljoeZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R57MySnZS/T1jD6T8P3/hAeVkGdsjldADsuOqcCaOKg=;
 b=dQncTybbMEal5vwH7/kivZzvOM3bYZGcs9lzfpRis0psuXalFMGRTy682uEQeyKAaquPMWIwuPsQFVGCfux6E2AfKcTaSdyrVlR6a1KvfTHE/ChpdA70qG+dPCHTeDyNvhA/DUw6VHI1uDIvuzewg/3ephbbpKukmReCfvDVWncsaSY5KZ9/6gnrk9WINQZsTkka05UPA+D4LVtX0Dg2KKNhFR/dVkrKpgUHSKkxK3XLIsF8A4u7bkdhYN/e0fRJ0DsFca4kKhNM9olrmFZ5BxZ1G8WmmDbGkSLDkzNBwSkvgIzn4HYokPxTp+iUu+Jal6Lhob6G3HbAiektIY5QoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R57MySnZS/T1jD6T8P3/hAeVkGdsjldADsuOqcCaOKg=;
 b=rjU0o9Bykhpl6wpLcxznRhcXOpwSyLes5WUkYvK69dbgzOAG8cuNu2TXn/POi+dUMHru9dWIb1TQyevYvLJ71PJzas2tvAno4G8DOqsmn1Yqb/5VGcNVgGJQ1P937WsO06c9iB86TS+VhjF+0aNoQspulyal4CHG9kEzHBtgoR0=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (20.177.49.213) by
 VI1PR04MB6943.eurprd04.prod.outlook.com (52.133.247.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Thu, 2 Apr 2020 08:44:57 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b105:1422:4bfa:338e]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b105:1422:4bfa:338e%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 08:44:57 +0000
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
        Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH v2 4/4] EDAC: synopsys: Add useful debug and output
 information for 64bit systems
Thread-Topic: [PATCH v2 4/4] EDAC: synopsys: Add useful debug and output
 information for 64bit systems
Thread-Index: AQHWB/nL9ePNYAIn50WVBCwbMM/nTqhkGIaAgAA4qYCAAR0hAIAADLkw
Date:   Thu, 2 Apr 2020 08:44:57 +0000
Message-ID: <VI1PR04MB49608E4D6AAB50FA550380EC92C60@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <1585726749-13039-1-git-send-email-sherry.sun@nxp.com>
 <1585726749-13039-5-git-send-email-sherry.sun@nxp.com>
 <20200401105647.hszgxzt2uedqofth@rric.localdomain>
 <VI1PR04MB4960BEC8A60876A543A92ED692C90@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20200402072005.ma6etmns2pdzuqaw@rric.localdomain>
In-Reply-To: <20200402072005.ma6etmns2pdzuqaw@rric.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sherry.sun@nxp.com; 
x-originating-ip: [121.228.205.159]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7ce388e-ca4c-435e-1932-08d7d6e21f50
x-ms-traffictypediagnostic: VI1PR04MB6943:|VI1PR04MB6943:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB69432E27F90E95BB4DE136B792C60@VI1PR04MB6943.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(2906002)(8676002)(478600001)(66476007)(316002)(76116006)(86362001)(66556008)(52536014)(6916009)(186003)(5660300002)(66946007)(44832011)(64756008)(66446008)(26005)(55016002)(33656002)(54906003)(81156014)(53546011)(6506007)(9686003)(7696005)(71200400001)(81166006)(8936002)(4326008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FzzlvXTmNvvVI63Bs6eO8sf2ix41acod3pzICC7Q8FMXUBAJm940LfLJKYcCFIldzJGy1nB09Y2ImXmYeGiN5Im1Re2U0bIrkURonacFhGHBOVzt/BntBnjMwJeUx0wkHFlWlfXCtloPNUmZxQ8veiVgD6E218YHW9I5cQ7JRk3wagSfWAZs3sxbg2beohKqzSQPtIpM7rw1NNKrqw68qpHOFctyCU4OHgHmBgatm+DoklWf9woa/6TaeIxcPEUg8n560TOu2bypKu0sK5JQl0X7HKCtSder7hUuK4N3sa1VLztrLAZ1CxkQ1LsMBxHBP+G/KNnTKegKwV2gAjvOERZFMCq3spRCsQbbK+JO2Kg/nx+iHBi6FFIkEgl1kQ5/OQyT9DzNVS/FwvoXc4bYVcRAG/UFrKMYOsJgQwzb2okQoFsh8j6pUqo0dldjKy0S
x-ms-exchange-antispam-messagedata: YNBR4AjlLGa7x8lVBe10dSTIiAlHLKh7gXsbNSXtmVf7tCudZOf8txiK4zr/afHtiSqjFJtj/lN+bi+4yJkT0HBD75jeluGiUwQm7SEdc8PiIF8rz9kmzjJ2akqQOZU7E7Q5jsXJw+L6nZA86q+TlA==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ce388e-ca4c-435e-1932-08d7d6e21f50
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 08:44:57.1631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IjGu+5Ut8sMxwK/HE3zzdFFd2rRsOZmHZACXTzS0Fw9R77rZu7l55PdcJV9jyNXXFXM7ot6CR5iak0gJDEjIuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6943
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgUm9iZXJ0LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYmVy
dCBSaWNodGVyIDxycmljaHRlckBtYXJ2ZWxsLmNvbT4NCj4gU2VudDogMjAyMMTqNNTCMsjVIDE1
OjIwDQo+IFRvOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+IENjOiBicEBhbGll
bjguZGU7IG1jaGVoYWJAa2VybmVsLm9yZzsgdG9ueS5sdWNrQGludGVsLmNvbTsNCj4gamFtZXMu
bW9yc2VAYXJtLmNvbTsgbWljaGFsLnNpbWVrQHhpbGlueC5jb207DQo+IG1hbmlzaC5uYXJhbmlA
eGlsaW54LmNvbTsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MiA0LzRdIEVEQUM6IHN5bm9wc3lzOiBBZGQgdXNlZnVsIGRlYnVnIGFuZCBv
dXRwdXQNCj4gaW5mb3JtYXRpb24gZm9yIDY0Yml0IHN5c3RlbXMNCj4gDQo+IE9uIDAxLjA0LjIw
IDE0OjMyOjU4LCBTaGVycnkgU3VuIHdyb3RlOg0KPiA+ID4gRnJvbTogUm9iZXJ0IFJpY2h0ZXIg
PHJyaWNodGVyQG1hcnZlbGwuY29tPiBPbiAwMS4wNC4yMCAxNTozOTowOSwNCj4gPiA+IFNoZXJy
eSBTdW4gd3JvdGU6DQo+IA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2VkYWMvc3lub3BzeXNfZWRh
Yy5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvZWRhYy9zeW5vcHN5c19lZGFjLmMNCj4gPiA+ID4g
QEAgLTI3OCwxOCArMjc4LDIyIEBADQo+ID4gPiA+ICAgKiBAY29sOglDb2x1bW4gbnVtYmVyLg0K
PiA+ID4gPiAgICogQGJhbms6CUJhbmsgbnVtYmVyLg0KPiA+ID4gPiAgICogQGJpdHBvczoJQml0
IHBvc2l0aW9uLg0KPiA+ID4gPiAtICogQGRhdGE6CURhdGEgY2F1c2luZyB0aGUgZXJyb3IuDQo+
ID4gPiA+ICsgKiBAZGF0YV9sb3c6CUxvdyBiaXQgZGF0YSBjYXVzaW5nIHRoZSBlcnJvci4NCj4g
PiA+ID4gKyAqIEBkYXRhX2hpZ2g6CUhpZ2ggYml0IGRhdGEgY2F1c2luZyB0aGUgZXJyb3IodXNl
ZCBmb3IgNjQgYml0DQo+ID4gPiBzeXN0ZW1zKS4NCj4gPiA+ID4gICAqIEBiYW5rZ3JwbnI6CUJh
bmsgZ3JvdXAgbnVtYmVyLg0KPiA+ID4gPiAgICogQGJsa25yOglCbG9jayBudW1iZXIuDQo+ID4g
PiA+ICsgKiBAc3luZHJvbWU6CVN5bmRyb21lIG9mIHRoZSBlcnJvci4NCj4gPiA+ID4gICAqLw0K
PiA+ID4gPiAgc3RydWN0IGVjY19lcnJvcl9pbmZvIHsNCj4gPiA+ID4gIAl1MzIgcm93Ow0KPiA+
ID4gPiAgCXUzMiBjb2w7DQo+ID4gPiA+ICAJdTMyIGJhbms7DQo+ID4gPiA+ICAJdTMyIGJpdHBv
czsNCj4gPiA+ID4gLQl1MzIgZGF0YTsNCj4gPiA+ID4gKwl1MzIgZGF0YV9sb3c7DQo+ID4gPiA+
ICsJdTMyIGRhdGFfaGlnaDsNCj4gPiA+DQo+ID4gPiBXaGVyZSBhcmUgMTYsIDMyIGFuZCA2NCBi
aXQgd2lkdGhzLiBZb3UgY291bGQgaGFuZGxlIHRoZW0gYWxsIHRoZQ0KPiA+ID4gc2FtZSBpbiBh
IHU2NC4NCj4gPiA+DQo+ID4gPiBJZiBJIGFtIG5vdCB3cm9uZywgdGhlIHdpZHRoIGlzIGZpeCBm
b3IgdGhlIHdob2xlIG1jaS4gU28geW91IGNvdWxkDQo+ID4gPiBjcmVhdGUgdmFyaW91cyAuZ2V0
X2Vycm9yX2luZm8oKSBmdW5jdGlvbnMgZGVwZW5kaW5nIG9uIHRoZSBkYXRhDQo+ID4gPiB3aWR0
aCB3aXRob3V0IHJ1biB0aW1lIHdpZHRoIGNoZWNrcy4NCj4gPiA+DQo+ID4NCj4gPiBZZXMsIGhl
cmUgd2UgY2FuIHVzZSB1NjQuIFdpbGwgY29ycmVjdCBpdCBpbiB2My4NCj4gPiBGb3IgdGhlIHp5
bnEsIGl0J3MgMTYtYml0IGJ1cyB3aWR0aCwgZm9yIGlteDhtcCwgaXQncyA2NC1iaXQgYnVzIHdp
ZHRoLg0KPiA+IEJ1dCBmb3IgenlucW1wLCBpdCdzIG9wdGlvbmFsIGJldHdlZW4gMzItYml0IGFu
ZCA2NC1iaXQgYnVzIHdpZHRoLCBTbw0KPiA+IHdlIGhhZCBiZXR0ZXIgcnVuIHRpbWUgY2hlY2sg
dGhlIGJ1cyB3aWR0aCwgd2hhdCBkbyB5b3UgdGhpbms/DQo+IA0KPiBJIGFtIHdvbmRlcmluZyBh
IGJpdCBoZXJlLiAqZ2V0X2R0eXBlKCkgaXMgdXNlZCBvbmx5IGluIGluaXRfY3Nyb3dzKCkgd2hp
Y2gNCj4gc2V0cyB1cCB0aGUgbWNpLiBTbyBpdCB3aWxsIGJlIGEgZml4IHZhbHVlIGFsbCB0aGUg
dGltZSBhZnRlciBpbml0LiBXaXRoIHRoYXQgeW91DQo+IGVhc2lseSBjYW4gc2V0dXAgZnVuY3Rp
b25zIGRlcGVuZGluZyBvbiB0aGUgd2lkdGgsIGFsdGVybmF0aXZlbHkgdGhlIHdpZHRoDQo+IGNv
dWxkIGJlIHN0b3JlZCBpbiBzdHJ1Y3Qgc3lucHNfcGxhdGZvcm1fZGF0YSBvciBzdHJ1Y3Qgc3lu
cHNfZWRhY19wcml2Lg0KPiANCg0KWWVzLCBJIHRoaW5rIHlvdXIgc3VnZ2VzdGlvbiBpcyByZWFz
b25hYmxlLCBJIHdpbGwgaGF2ZSBhIHRyeSBsYXRlci4NCg0KPiA+DQo+ID4gPiA+ICAJdTMyIGJh
bmtncnBucjsNCj4gPiA+ID4gIAl1MzIgYmxrbnI7DQo+ID4gPiA+ICsJdTMyIHN5bmRyb21lOw0K
PiA+ID4gPiAgfTsNCj4gDQo+ID4gPiBAQCAtNDgwLDIwDQo+ID4gPiA+ICs1NTksMjcgQEAgc3Rh
dGljIHZvaWQgaGFuZGxlX2Vycm9yKHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSwNCj4gPiA+ID4g
K3N0cnVjdA0KPiA+ID4gPiBzeW5wc19lY2Nfc3RhdHVzICpwKSAgew0KPiA+ID4gPiAgCXN0cnVj
dCBzeW5wc19lZGFjX3ByaXYgKnByaXYgPSBtY2ktPnB2dF9pbmZvOw0KPiA+ID4gPiAgCXN0cnVj
dCBlY2NfZXJyb3JfaW5mbyAqcGluZjsNCj4gPiA+ID4gKwlpbnQgbjsNCj4gPiA+ID4NCj4gPiA+
ID4gIAlpZiAocC0+Y2VfY250KSB7DQo+ID4gPiA+ICAJCXBpbmYgPSAmcC0+Y2VpbmZvOw0KPiA+
ID4gPiAgCQlpZiAocHJpdi0+cF9kYXRhLT5xdWlya3MgJiBERFJfRUNDX0lOVFJfU1VQUE9SVCkg
ew0KPiA+ID4gPiAtCQkJc25wcmludGYocHJpdi0+bWVzc2FnZSwgU1lOUFNfRURBQ19NU0dfU0la
RSwNCj4gPiA+ID4gLQkJCQkgIkREUiBFQ0MgZXJyb3IgdHlwZTolcyBSb3cgJWQgQmFuayAlZA0K
PiA+ID4gQmFua0dyb3VwIE51bWJlciAlZCBCbG9jayBOdW1iZXIgJWQgQml0IFBvc2l0aW9uOiAl
ZCBEYXRhOiAweCUwOHgiLA0KPiA+ID4gPiAtCQkJCSAiQ0UiLCBwaW5mLT5yb3csIHBpbmYtPmJh
bmssDQo+ID4gPiA+IC0JCQkJIHBpbmYtPmJhbmtncnBuciwgcGluZi0+YmxrbnIsDQo+ID4gPiA+
IC0JCQkJIHBpbmYtPmJpdHBvcywgcGluZi0+ZGF0YSk7DQo+ID4gPiA+ICsJCQluID0gc25wcmlu
dGYocHJpdi0+bWVzc2FnZSwgU1lOUFNfRURBQ19NU0dfU0laRSwNCj4gPiA+ID4gKwkJCQkgICAg
ICJERFIgRUNDIGVycm9yIHR5cGU6JXMgUm93ICVkIEJhbmsgJWQNCj4gPiA+IEJhbmtHcm91cCBO
dW1iZXIgJWQgQmxvY2sgTnVtYmVyICVkIEJpdCBQb3NpdGlvbjogJWQgRGF0YTogMHglMDh4IiwN
Cj4gPiA+ID4gKwkJCQkgICAgICJDRSIsIHBpbmYtPnJvdywgcGluZi0+YmFuaywNCj4gPiA+ID4g
KwkJCQkgICAgIHBpbmYtPmJhbmtncnBuciwgcGluZi0+YmxrbnIsDQo+ID4gPiA+ICsJCQkJICAg
ICBwaW5mLT5iaXRwb3MsIHBpbmYtPmRhdGFfbG93KTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCQkJ
aWYgKHp5bnFtcF9nZXRfZHR5cGUocHJpdi0+YmFzZWFkZHIpID09IERFVl9YOCkNCj4gPiA+DQo+
ID4gPiBUaGlzIGlzIHp5bnFtcCBzcGVjaWZpYywgcmlnaHQ/IGJ1dCB5b3UgY2FsbCBpdCBpbiB0
aGUgZ2VuZXJpYw0KPiA+ID4gZnVuY3Rpb24gaGFuZGxlX2Vycm9yKCkuDQo+ID4NCj4gPiBZZXMs
IGFsdGhvdWdoIGhhbmRsZV9lcnJvcigpIGlzIGEgZ2VuZXJpYyBmdW5jdGlvbiwgYnV0IHRoaXMg
b3BlcmF0aW9uDQo+ID4gaXMgY2hlY2tlZCBieSBwcml2LT5wX2RhdGEtPnF1aXJrcywgc28gaGVy
ZSBpcyB6eW5xbXAgYW5kIGlteDhtcA0KPiA+IHNwZWNpZmljLg0KPiANCj4gTmFhaCwgdGhpcyBp
cyBhIGJpdCBoYWNreSwganVzdCBtYWtlIDIgdmFyaWFudHMgb2YgaGFuZGxlcnMgYW5kIHNldCB0
aGVtIHVwDQo+IGR1cmluZyBpbml0LiBTdG9yaW5nIHRoZSB3aWR0aCBpbiBzb21lIHByaXZhdGUg
ZGF0YSB3b3VsZCBiZSBhbiBhbHRlcm5hdGl2ZS4NCj4gDQoNCk9rYXksIEkgd2lsbCB0cnkgdG8g
c3RvcmUgdGhlIGJ1cyB3aWR0aCBpbiBwcml2YXRlIGRhdGEuVGhhbmtzLg0KDQpCZXN0IHJlZ2Fy
ZHMNClNoZXJyeSBTdW4NCg0KPiBUaGFua3MsDQo+IA0KPiAtUm9iZXJ0DQo+IA0KPiA+DQo+ID4g
QmVzdCByZWdhcmRzDQo+ID4gU2hlcnJ5IFN1bg0KPiA+DQo+ID4gPg0KPiA+ID4gLVJvYmVydA0K
PiA+ID4NCj4gPiA+ID4gKwkJCQlzbnByaW50Zihwcml2LT5tZXNzYWdlICsgbiwNCj4gPiA+ID4g
KwkJCQkJIFNZTlBTX0VEQUNfTVNHX1NJWkUgLSBuLA0KPiA+ID4gPiArCQkJCQkgIiBEYXRhX2hp
Z2g6IDB4JTA4eCBTeW5kcm9tZToNCj4gPiA+IDB4JTA4eCIsDQo+ID4gPiA+ICsJCQkJCSBwaW5m
LT5kYXRhX2hpZ2gsIHBpbmYtPnN5bmRyb21lKTsNCj4gPiA+ID4gIAkJfSBlbHNlIHsNCj4gPiA+
ID4gIAkJCXNucHJpbnRmKHByaXYtPm1lc3NhZ2UsIFNZTlBTX0VEQUNfTVNHX1NJWkUsDQo+ID4g
PiA+ICAJCQkJICJERFIgRUNDIGVycm9yIHR5cGU6JXMgUm93ICVkIEJhbmsgJWQNCj4gPiA+IENv
bCAlZCBCaXQgUG9zaXRpb246ICVkIERhdGE6IDB4JTA4eCIsDQo+ID4gPiA+ICAJCQkJICJDRSIs
IHBpbmYtPnJvdywgcGluZi0+YmFuaywgcGluZi0+Y29sLA0KPiA+ID4gPiAtCQkJCSBwaW5mLT5i
aXRwb3MsIHBpbmYtPmRhdGEpOw0KPiA+ID4gPiArCQkJCSBwaW5mLT5iaXRwb3MsIHBpbmYtPmRh
dGFfbG93KTsNCj4gPiA+ID4gIAkJfQ0KPiA+ID4gPg0KPiA+ID4gPiAgCQllZGFjX21jX2hhbmRs
ZV9lcnJvcihIV19FVkVOVF9FUlJfQ09SUkVDVEVELCBtY2ksDQo=
