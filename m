Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 583DD19BE58
	for <lists+linux-edac@lfdr.de>; Thu,  2 Apr 2020 11:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgDBJGg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Apr 2020 05:06:36 -0400
Received: from mail-db8eur05on2075.outbound.protection.outlook.com ([40.107.20.75]:31600
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728612AbgDBJGg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 2 Apr 2020 05:06:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoWCYDyFcz3zrdthPod4qhl61r97maBFtI9Cqn4/sm5qXHcB4oGe34ZvQdUdd24MTZgbq0mrp8G6KDZ00rVBqsdyyViRT+u5hX3pKhTf8tjOIPIn9eQG8kklWRGSspJDvpYd2xCSJyXxS/0Vr4TukZOLC9NuzIV8I+621aJ68Icj4SvwcYSZdxeUw0LJDaRyZDsiweBRWElTQsysUV+RfC3arkliV3nH31z09btO+sMN+h0xpAhACvNzLvyqNcQO4+uuxPISkEjcNTqO9uKMZGVb3AvZnGIQ2sK64ecFm9nbj9JPZ9ZDYqA37gQyB6TLieHgjOvSi584db+4QbQaNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAJUG10sgIb04nE7PESdy6WhS5mJ6j5Ftt6691s9jIY=;
 b=MGlVrVAtouXEFKMghx62CvOeUejXEv2xRfFqFs6LjvHSRtWr+LhWnhb8Ynt2W/aMazEazyVYKRuL5rfBm7BI614Kg2kryQQ/whDumLdZ+y17WlEDfLMt1vkUUSzKo8R+V6wHHxautbDk2dORWgj/AKSu9BcnrMWELn1ZUwgg63Cgb2I2shm8oTPQzymtnqZW1hhefkyVSfjGWoTFhBkp19J7Cwbl8+Mm2W+rr7YSyU8r3CHKzhzOaXXAnkZ80eP8UXBO0v446yvKtmw3ltLe5rLNKeLsx4EPS7IJ/kXE4n02ipWKX73c2oZRXqCk1/niE7NjyKncH6+Tg06RzvAPNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAJUG10sgIb04nE7PESdy6WhS5mJ6j5Ftt6691s9jIY=;
 b=Q1Q5rFhiCWPPJoBV/7mUuljOy4k0kw/dBuOJlDb8qy2oUoJyx/++9bPhtWkN2YhIr7cbL96J/BynZGxrA6uV7vczTtFV3RQBE8jvYxByMKK4g1ulobR3TwJ1AloDDPiCS62C9uUHZAlWPCVphY7FCedzgeYfixlw9JFaeC8A9z8=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (20.177.49.213) by
 VI1PR04MB4013.eurprd04.prod.outlook.com (52.134.31.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Thu, 2 Apr 2020 09:06:30 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b105:1422:4bfa:338e]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b105:1422:4bfa:338e%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 09:06:27 +0000
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
Thread-Index: AQHWCI4FcS/WeLicyEGazLJqeHwA4ahlbbGAgAAX+iA=
Date:   Thu, 2 Apr 2020 09:06:27 +0000
Message-ID: <VI1PR04MB4960985DD2A4F0CA68063D9592C60@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <1585790433-31465-1-git-send-email-sherry.sun@nxp.com>
 <1585790433-31465-4-git-send-email-sherry.sun@nxp.com>
 <20200402072200.o6c6u3uim6jwopo6@rric.localdomain>
In-Reply-To: <20200402072200.o6c6u3uim6jwopo6@rric.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sherry.sun@nxp.com; 
x-originating-ip: [121.228.205.159]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c3e4db6-7019-4ea0-9bc6-08d7d6e52037
x-ms-traffictypediagnostic: VI1PR04MB4013:|VI1PR04MB4013:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4013E337EDC7DF7333979A3692C60@VI1PR04MB4013.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(44832011)(7696005)(6506007)(52536014)(71200400001)(2906002)(8676002)(8936002)(81166006)(6916009)(53546011)(5660300002)(33656002)(86362001)(316002)(4326008)(54906003)(76116006)(66946007)(66446008)(64756008)(66476007)(66556008)(9686003)(81156014)(478600001)(55016002)(26005)(186003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qBmMknfkfFTsktVrjN7VMeiV25QD99Metf6zMC4DkytC0BcM4RPhDEnTrfXRm7o50HBNIM+j52cHnk9gVq6OIlxmECpCdAit1cTbmGl8yjN5ioEsvlfTLqstlrMQ2H9G8Sdwi3bLWsEaSE/w8WD9VMWWLRdKm3Jyu3HVXUdWJcVa+xp3fxjT6me6K0BWDEjUiq62BW4jojBDbx3lCC8NPN7z0sws7alksxC8w1bYVw5XROHmXxFst3G15fpOHc5z6IRR9rb4Zt7SKLef/u5izMu3VPdAm0jLZ0XNmQMjs7dAwmvZ5hloWrCfS4kU4X0wxGci+789zczkRNXoDxdALBE6vYTr0waKft8GKhDWKGen0TgH/UmGYi24fcefS4A+EuUxYk3hAaBqtJJGNya9TIj1n5Ls0XDX3CcHtO5XLuxy4tWCwQYW0okQjArD3IuX
x-ms-exchange-antispam-messagedata: oGNDZn9DKYtTmxnIx3d1LIImyIz4zA2niqR2yacSQ+3RyWnMVoRMCGrb+RuLJh+3Q8Wp2TIdGy+Mv1dTtFpStXrHVPCkmFa+0izamETzxcPZLsJTRQ4pdcOGg0Hw7qs19CtwcbZOGq0BnfmsDA88rw==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3e4db6-7019-4ea0-9bc6-08d7d6e52037
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 09:06:27.1825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ex6rHWirvoT0HbbKoUkB1wiA5Z7pQCFZyxfYlqxu/mWdmH8HLelPPjh1WKU5BZcAN4zUs0ov9GVcgVOZKxGQEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4013
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgUm9iZXJ0LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYmVy
dCBSaWNodGVyIDxycmljaHRlckBtYXJ2ZWxsLmNvbT4NCj4gU2VudDogMjAyMMTqNNTCMsjVIDE1
OjIyDQo+IFRvOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+IENjOiBicEBhbGll
bjguZGU7IG1jaGVoYWJAa2VybmVsLm9yZzsgdG9ueS5sdWNrQGludGVsLmNvbTsNCj4gamFtZXMu
bW9yc2VAYXJtLmNvbTsgbWljaGFsLnNpbWVrQHhpbGlueC5jb207DQo+IG1hbmlzaC5uYXJhbmlA
eGlsaW54LmNvbTsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgRnJhbmsg
TGkNCj4gPGZyYW5rLmxpQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbcGF0Y2ggdjMgMy80XSBF
REFDOiBzeW5vcHN5czogQWRkIGVkYWMgZHJpdmVyIHN1cHBvcnQgZm9yDQo+IGkuTVg4TVANCj4g
DQo+IE9uIDAyLjA0LjIwIDA5OjIwOjMyLCBTaGVycnkgU3VuIHdyb3RlOg0KPiA+IFNpbmNlIGku
TVg4TVAgdXNlIHN5bm9wc3lzIGRkciBjb250cm9sbGVyIElQLCBzbyBhZGQgZWRhYyBzdXBwb3J0
IGZvcg0KPiA+IGkuTVg4TVAgYmFzZWQgb24gc3lub3BzeXMgZWRhYyBkcml2ZXIuIGkuTVg4TVAg
dXNlIExQRERSNCBhbmQgc3VwcG9ydA0KPiA+IGludGVycnVwdHMgZm9yIGNvcnJlY3RlZCBhbmQg
dW5jb3JyZWN0ZWQgZXJyb3JzLiBUaGUgbWFpbiBkaWZmZXJlbmNlDQo+ID4gYmV0d2VlbiBaeW5x
TVAgYW5kIGkuTVg4TVAgZGRyIGNvbnRyb2xsZXIgaXMgdGhlIGludGVycnVwdCByZWdpc3RlcnMu
DQo+ID4gU28gYWRkIGFub3RoZXIgaW50ZXJydXB0IGhhbmRsZXIgZnVuY3Rpb24sIGVuYWJsZS9k
aXNhYmxlIGludGVycnVwdA0KPiA+IGZ1bmN0aW9uIHRvIGRpc3Rpbmd1aXNoIHdpdGggWnlucU1Q
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2VkYWMvc3lub3BzeXNfZWRhYy5jIHwgNzcNCj4gPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDc2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+ID4gK3N0YXRpYyB2b2lkIGVu
YWJsZV9pbnRyX2lteDhtcChzdHJ1Y3Qgc3lucHNfZWRhY19wcml2ICpwcml2KSB7DQo+ID4gKwlp
bnQgcmVndmFsOw0KPiA+ICsNCj4gPiArCXJlZ3ZhbCA9IHJlYWRsKHByaXYtPmJhc2VhZGRyICsg
RUNDX0NMUl9PRlNUKTsNCj4gPiArCXJlZ3ZhbCB8PSAoRERSX0NFX0lOVFJfRU5fTUFTSyB8IERE
Ul9VRV9JTlRSX0VOX01BU0spOw0KPiA+ICsJd3JpdGVsKHJlZ3ZhbCwgcHJpdi0+YmFzZWFkZHIg
KyBFQ0NfQ0xSX09GU1QpOyB9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBkaXNhYmxlX2ludHJf
aW14OG1wKHN0cnVjdCBzeW5wc19lZGFjX3ByaXYgKnByaXYpIHsNCj4gPiArCWludCByZWd2YWw7
DQo+ID4gKw0KPiA+ICsJcmVndmFsID0gcmVhZGwocHJpdi0+YmFzZWFkZHIgKyBFQ0NfQ0xSX09G
U1QpOw0KPiA+ICsJcmVndmFsICY9IH4oRERSX0NFX0lOVFJfRU5fTUFTSyB8IEREUl9VRV9JTlRS
X0VOX01BU0spOw0KPiA+ICsJd3JpdGVsKHJlZ3ZhbCwgcHJpdi0+YmFzZWFkZHIgKyBFQ0NfQ0xS
X09GU1QpOyB9DQo+ID4gKw0KPiA+ICsvKiBJbnRlcnJ1cHQgSGFuZGxlciBmb3IgRUNDIGludGVy
cnVwdHMgb24gaW14OG1wIHBsYXRmb3JtLiAqLyBzdGF0aWMNCj4gPiAraXJxcmV0dXJuX3QgaW50
cl9oYW5kbGVyX2lteDhtcChpbnQgaXJxLCB2b2lkICpkZXZfaWQpIHsNCj4gPiArCWNvbnN0IHN0
cnVjdCBzeW5wc19wbGF0Zm9ybV9kYXRhICpwX2RhdGE7DQo+ID4gKwlzdHJ1Y3QgbWVtX2N0bF9p
bmZvICptY2kgPSBkZXZfaWQ7DQo+ID4gKwlzdHJ1Y3Qgc3lucHNfZWRhY19wcml2ICpwcml2Ow0K
PiA+ICsJaW50IHN0YXR1cywgcmVndmFsOw0KPiA+ICsNCj4gPiArCXByaXYgPSBtY2ktPnB2dF9p
bmZvOw0KPiA+ICsJcF9kYXRhID0gcHJpdi0+cF9kYXRhOw0KPiA+ICsNCj4gPiArCXJlZ3ZhbCA9
IHJlYWRsKHByaXYtPmJhc2VhZGRyICsgRUNDX1NUQVRfT0ZTVCk7DQo+ID4gKwlpZiAoIShyZWd2
YWwgJiBFQ0NfSU5UUl9NQVNLKSkNCj4gPiArCQlyZXR1cm4gSVJRX05PTkU7DQo+ID4gKw0KPiA+
ICsJc3RhdHVzID0gcF9kYXRhLT5nZXRfZXJyb3JfaW5mbyhwcml2KTsNCj4gPiArCWlmIChzdGF0
dXMpDQo+ID4gKwkJcmV0dXJuIElSUV9OT05FOw0KPiA+ICsNCj4gPiArCXByaXYtPmNlX2NudCAr
PSBwcml2LT5zdGF0LmNlX2NudDsNCj4gPiArCXByaXYtPnVlX2NudCArPSBwcml2LT5zdGF0LnVl
X2NudDsNCj4gPiArCWhhbmRsZV9lcnJvcihtY2ksICZwcml2LT5zdGF0KTsNCj4gPiArDQo+ID4g
KwllZGFjX2RiZygzLCAiVG90YWwgZXJyb3IgY291bnQgQ0UgJWQgVUUgJWRcbiIsDQo+ID4gKwkJ
IHByaXYtPmNlX2NudCwgcHJpdi0+dWVfY250KTsNCj4gPiArCWVuYWJsZV9pbnRyX2lteDhtcChw
cml2KTsNCj4gDQo+IFdoeSBkbyB5b3UgZW5hYmxlIGludGVycnVwdHMgaGVyZT8NCg0KQmVjYXVz
ZSB6eW5xbXBfZ2V0X2Vycm9yX2luZm8oKSB3cm90ZSAwIHRvIEVDQ19DTFJfT0ZTVCwgc28gaGVy
ZSBoYXZlIHRvIHJlLWVuYWJsZSB0aGUgaW50ZXJydXB0cy4NCg0KQXMgc2FpZCBpbiB0aGUgY29t
bWl0LCB0aGUgbWFpbiBkaWZmZXJlbmNlIGJldHdlZW4gWnlucU1QIGFuZCBpLk1YOE1QIGRkciBj
b250cm9sbGVyIGlzIHRoZSBpbnRlcnJ1cHQgcmVnaXN0ZXJzLg0KWnlucU1QIHVzZSBERFIgUU9T
IEludGVycnVwdCByZWdpc3RlcnMsICBidXQgaS5NWDhNUCB1c2UgRUNDX0NMUl9PRlNUIFJlZ2lz
dGVyKGJpdDggYW5kIGJpdDkpIHRvIGVuYWJsZS9kaXNhYmxlIHRoZSBjZS91ZSBpbnRlcnJ1cHRz
LiANCg0KSW4genlucW1wX2dldF9lcnJvcl9pbmZvKCksIFp5bnFtcCB3cm90ZSAwIHRvIEVDQ19D
TFJfT0ZTVCByZWdpc3RlciB0byBjbGVhciBDRS9VRSBlcnJvciBmbGFncyBhbmQgY291bnRzLCBp
dCBoYXMgbm8gZWZmZWN0IG9uIFp5bnFtcCBpbnRlcnJ1cHRzLiANCkJ1dCBmb3IgaS5NWDhNUCwg
d2lydGUgMCB0byBFQ0NfQ0xSX09GU1Qgd2lsbCBkaXNhYmxlIGkuTVg4TVAgQ0UvVUUgaW50ZXJy
dXB0LCBzbyBuZWVkIHJlLWVuYWJsZSB0aGUgaW50ZXJydXB0cy4NCg0KQmVzdCByZWdhcmRzDQpT
aGVycnkgU3VuDQoNCj4gDQo+IC1Sb2JlcnQNCj4gDQo+ID4gKw0KPiA+ICsJcmV0dXJuIElSUV9I
QU5ETEVEOw0KPiA+ICt9DQo=
