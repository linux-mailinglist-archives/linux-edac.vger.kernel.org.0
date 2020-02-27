Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D26C171141
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2020 08:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgB0HJf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Feb 2020 02:09:35 -0500
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:29235
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727336AbgB0HJe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Feb 2020 02:09:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJ3q7pIvhEKXjQJyuo/aNbuW45AnQ6R2kAg3fhe8UmB22gzSrnzo5qSlvYS/AUgruPFkL0KdximC3m80Fsj03CgPDIovcqqhJiisk2N0t/2l4Lav7dzFZ0JPWSQQKZXKS7PsLMJ+KdVY6fW+1tHH1w0K5WYUFYwtokVja4vnXeFF8gryR5rIWeFqN4RTqwO+jMHprwnyMfrSPG7yjvA9YBP1kw2CiTSFapK3yNP8ZCdgrTyvQam40bW5fAYQ+Nv/taiyd2u2RYkp8EANW+4cyHBmHQrGC9AeCO/D9+7iARoi0DPxbDx+0eSDdLAkgvOBK8IsQ9CsOtvxq0M9wcc3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SZXW0hkkGXDiK3zofsZyIy92isG8K2umQZNWogzrdc=;
 b=bwQmW97CAFPAcvW9/gRAPser6f6pvTJq3XP7gI34/ZapNlX+7sNSR2sYP+CxP0wdkRNoIPQURcf7GoGrCSvwnmw++0xAW6t9lWBOagATA2ttzLuf+qoj2ZV0ytFGngaZa+DyCdLodSliuwA9SQJSE6H53lQL7BBThivyWYOZkBJsicrWCtScp6IldaVxvDzjyEByOwMYFMZnWiDtlGV0l77Vvn0heJYINFgQqGLiyDHnmhgvSP6rhiqBk+dXW6Y087FX+dqZ85Vn/65jFw9Krckq+jzevB+NayviQHHT66ZyVmsVYUG9J1AkC2h8kQ81LYKX55i1QWCuMaVjqZ6Dbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SZXW0hkkGXDiK3zofsZyIy92isG8K2umQZNWogzrdc=;
 b=aojHNrLh4PvXtBeCrcfKatwtr9uFWEsPajmMcEsFVD0LWJZQ25IlTT0hp5tRIBGHeRFS/4Sf3MkSaQVKG9IO6A+wgG7Ixm9Fjzcrs+7USlJXVvlC9vohsiaAyEcFxLBa1BJ1Qozyy946q4yabWYhscpQE3AL7E/QPSi58IzLqU4=
Received: from AM6PR04MB6584.eurprd04.prod.outlook.com (20.179.245.21) by
 AM6PR04MB4757.eurprd04.prod.outlook.com (20.177.33.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 27 Feb 2020 07:09:29 +0000
Received: from AM6PR04MB6584.eurprd04.prod.outlook.com
 ([fe80::3c28:9128:54b1:ee7c]) by AM6PR04MB6584.eurprd04.prod.outlook.com
 ([fe80::3c28:9128:54b1:ee7c%6]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 07:09:29 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     James Morse <james.morse@arm.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH 2/3] EDAC: synopsys: Reorganizing the output message for
 CE/UE
Thread-Topic: [PATCH 2/3] EDAC: synopsys: Reorganizing the output message for
 CE/UE
Thread-Index: AQHV6veyWBAMxaid1EefvGNJmOAaEqgtxD8AgADdsFA=
Date:   Thu, 27 Feb 2020 07:09:29 +0000
Message-ID: <AM6PR04MB6584F58899197516F60C892292EB0@AM6PR04MB6584.eurprd04.prod.outlook.com>
References: <1582537357-10339-1-git-send-email-sherry.sun@nxp.com>
 <1582537357-10339-3-git-send-email-sherry.sun@nxp.com>
 <39c63f4c-2e39-4478-1de1-b0b564a7f4e1@arm.com>
In-Reply-To: <39c63f4c-2e39-4478-1de1-b0b564a7f4e1@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sherry.sun@nxp.com; 
x-originating-ip: [180.106.106.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a65b046-0818-4fe4-34b0-08d7bb53fd07
x-ms-traffictypediagnostic: AM6PR04MB4757:|AM6PR04MB4757:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4757B16746EBB9E3AF873B6C92EB0@AM6PR04MB4757.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(189003)(199004)(186003)(26005)(71200400001)(4326008)(6916009)(53546011)(9686003)(478600001)(5660300002)(33656002)(2906002)(55016002)(316002)(54906003)(15650500001)(7696005)(66476007)(66946007)(66446008)(76116006)(64756008)(52536014)(66556008)(8936002)(44832011)(8676002)(81156014)(81166006)(6506007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4757;H:AM6PR04MB6584.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GdaKNdwdMmNcm3pyLxYkqLHXTkgil8Zc8LWVWaSFrIShgA+D32x2h9hLiHlnVbRQbopnIptGvs0YkO0hCK2qlS1WkrBGPIHGiDavRov/eXdSa79UwqaiXaDNHxYBhn8YE00g5ebhNQP+tD7E1oy43u685Ds9SYiDBQ36qPl1dyHTni/w810LBdfRVNgZL1sa58HxGxKimx/1cxcnIa0S+Pg782m00UbhWsL8yCb4EhyRYucNjPDhdjn1/+f6r0Q2w5LOlweThwM6/FPuRoEolboJqH6SuKMvbv1dr8oYAugAgQh4KH8YyPq2ijc+sqq1PI1pZLTNSB59txXb2ArmTty8yJA0Zdlnd5pQG05LCLgMOiq3J0pbUDpjieTukhQ/quWbLaX+dfGg0bW19rHjddnvyVrXOwCPBHY0J3EE2rRQk2BvDOviESny7BoR+XtA
x-ms-exchange-antispam-messagedata: DJ9cEljTxREjiYilAUe+3atqTphXj3i0SYr1DUMrGucYFpXXICFyiAm87YBi3F6J1Ccn3MuEg6Iw3DW3ARsAC6CaetWhbV9oUV7QA/qKWZWE56peA9z776WY6YhYYHbqZeHOEWlEdgGahRxYYuHRsg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a65b046-0818-4fe4-34b0-08d7bb53fd07
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 07:09:29.7132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pSklqIKptjc3nYXWkwsLEEgzpC7+/PfkKskZ4o7BTV/ZRcc3LNemDtzoDleeeEtxKiWdDwm1LKddaWfa7cqeug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4757
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgSmFtZXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgt
ZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWVkYWMtDQo+IG93bmVyQHZnZXIua2Vy
bmVsLm9yZz4gT24gQmVoYWxmIE9mIEphbWVzIE1vcnNlDQo+IFNlbnQ6IDIwMjDlubQy5pyIMjfm
l6UgMTo0OQ0KPiBUbzogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiBDYzogYnBA
YWxpZW44LmRlOyBtY2hlaGFiQGtlcm5lbC5vcmc7IHRvbnkubHVja0BpbnRlbC5jb207DQo+IHJy
aWNodGVyQG1hcnZlbGwuY29tOyBtaWNoYWwuc2ltZWtAeGlsaW54LmNvbTsgbGludXgtDQo+IGVk
YWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlt
eEBueHAuY29tPjsgRnJhbmsgTGkNCj4gPGZyYW5rLmxpQG54cC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggMi8zXSBFREFDOiBzeW5vcHN5czogUmVvcmdhbml6aW5nIHRoZSBvdXRwdXQgbWVz
c2FnZQ0KPiBmb3IgQ0UvVUUNCj4gDQo+IEhpIFNoZXJyeSwNCj4gDQo+IE9uIDI0LzAyLzIwMjAg
MDk6NDIsIFNoZXJyeSBTdW4gd3JvdGU6DQo+ID4gVGhlIG9yaWdpbiB3YXkgd2hpY2ggY2FsbCBz
cHJpbnRmKCkgZnVuY3Rpb24gdHdvIG9yIHRocmVlIHRpbWVzIHRvDQo+IA0KPiAob3JpZ2luYWw/
ICdUaGUgY3VycmVudCB3YXknIG1heSBiZSBiZXR0ZXIpDQo+IA0KDQpTb3JyeSBmb3IgdGhhdCwg
SSB3aWxsIGNvcnJlY3QgaXQgdG8gJ1RoZSBjdXJyZW50IHdheScuDQoNCj4gDQo+ID4gb3V0cHV0
IG1lc3NhZ2UgZm9yIENFL1VFIGlzIGluY29ycmVjdCwgYmVjYXVzZSBpdCB3b24ndCBvdXRwdXQg
YWxsIHRoZQ0KPiA+IG1lc3NhZ2UgbmVlZGVkLCBpbnN0ZWFkIGl0IHdpbGwgb25seSBvdXRwdXQg
dGhlIGxhc3QgbWVzc2FnZSBpbg0KPiA+IHNwcmludGYoKS4NCj4gDQo+IE5pY2UhDQo+IA0KPiAN
Cj4gPiBTbyB0aGUgc2ltcGxlc3QgYW5kIG1vc3QgZWZmZWN0aXZlIHdheSB0byBmaXggdGhpcyBw
cm9ibGVtIGlzDQo+ID4gcmVvcmdhbml6aW5nIGFsbCB0aGUgb3V0cHV0IG1lc3NhZ2UgbmVlZGVk
IGZvciBDRS9VRSBpbnRvIG9uZQ0KPiA+IHNwcmludGYoKSBmdW5jdGlvbi4NCj4gDQo+IFRoaXMg
aXMgYSBidWcsIGJ1dCBpdHMgaW4gdGhlIG1pZGRsZSBvZiBhIHNlcmllcyBkb2luZyBzb21lIGNs
ZWFudXAsIG1lYW5pbmcNCj4gdGhlIG1haW50YWluZXIgY2FuJ3QgZWFzaWx5IHBpY2sgaXQgdXAg
aW4gaXNvbGF0aW9uLiBDb3VsZCB5b3UgcG9zdCBpdCBzZXBhcmF0ZWx5Pw0KPiANCj4gJ1Jlb3Jn
YW5pemUnIGluIHRoZSBzdWJqZWN0IG1ha2VzIHRoaXMgc291bmQgbGlrZSBjbGVhbnVwLiBXb3Vs
ZCAiRURBQzoNCj4gc3lub3BzeXM6IEZpeCBiYWNrIHRvIGJhY2sgc25wcmludGYoKSBtZXNzYWdl
cyBmb3IgQ0UvVUUiIGJlIGJldHRlcj8NCj4gDQoNClN1cmUsIEkgd2lsbCBzZW5kIHRoaXMgcGF0
Y2ggc2VwYXJhdGVseSwgYW5kIHdpbGwgY29ycmVjdCB0aGUgc3ViamVjdCBhcyB5b3Ugc3VnZ2Vz
dGVkLg0KDQo+IA0KPiBQbGVhc2UgYWRkOg0KPiBGaXhlczogYjUwMGI0YTAyOWQ1NyAoIkVEQUMs
IHN5bm9wc3lzOiBBZGQgRUNDIHN1cHBvcnQgZm9yIFp5bnFNUCBERFINCj4gY29udHJvbGxlciIp
DQo+IA0KPiBpbiB0aGUgc2lnbmVkLW9mZi1ieSBhcmVhIHNvIHRoYXQgc3RhYmxlIHRyZWVzIHBp
Y2sgdGhpcyB1cC4NCj4gDQo+IGFuZCBmb3Igd2hhdCBpdHMgd29ydGg6DQo+IFJldmlld2VkLWJ5
OiBKYW1lcyBNb3JzZSA8amFtZXMubW9yc2VAYXJtLmNvbT4NCj4gDQo+IA0KDQpUaGFua3MsIEkg
d2lsbCBhZGQgaXQuDQoNCkJlc3QgcmVnYXJkcw0KU2hlcnJ5IFN1bg0KDQo+IFRoYW5rcyENCj4g
DQo+IEphbWVzDQo+IA0KPiANCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9zeW5v
cHN5c19lZGFjLmMNCj4gPiBiL2RyaXZlcnMvZWRhYy9zeW5vcHN5c19lZGFjLmMgaW5kZXggNzA0
NmI4OTI5NTIyLi5lZjdlOTA3Yzc5NTYNCj4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9lZGFj
L3N5bm9wc3lzX2VkYWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZWRhYy9zeW5vcHN5c19lZGFjLmMN
Cj4gPiBAQCAtNDg1LDIwICs0ODUsMTQgQEAgc3RhdGljIHZvaWQgaGFuZGxlX2Vycm9yKHN0cnVj
dCBtZW1fY3RsX2luZm8NCj4gKm1jaSwgc3RydWN0IHN5bnBzX2VjY19zdGF0dXMgKnApDQo+ID4g
IAkJcGluZiA9ICZwLT5jZWluZm87DQo+ID4gIAkJaWYgKCFwcml2LT5wX2RhdGEtPnF1aXJrcykg
ew0KPiA+ICAJCQlzbnByaW50Zihwcml2LT5tZXNzYWdlLCBTWU5QU19FREFDX01TR19TSVpFLA0K
PiA+IC0JCQkJICJERFIgRUNDIGVycm9yIHR5cGU6JXMgUm93ICVkIEJhbmsgJWQNCj4gQ29sICVk
ICIsDQo+ID4gLQkJCQkgICJDRSIsIHBpbmYtPnJvdywgcGluZi0+YmFuaywgcGluZi0+Y29sKTsN
Cj4gPiAtCQkJc25wcmludGYocHJpdi0+bWVzc2FnZSwgU1lOUFNfRURBQ19NU0dfU0laRSwNCj4g
PiAtCQkJCSAiQml0IFBvc2l0aW9uOiAlZCBEYXRhOiAweCUwOHhcbiIsDQo+ID4gKwkJCQkgIkRE
UiBFQ0MgZXJyb3IgdHlwZTolcyBSb3cgJWQgQmFuayAlZA0KPiBDb2wgJWQgQml0IFBvc2l0aW9u
OiAlZCBEYXRhOiAweCUwOHgiLA0KPiA+ICsJCQkJICJDRSIsIHBpbmYtPnJvdywgcGluZi0+YmFu
aywgcGluZi0+Y29sLA0KPiA+ICAJCQkJIHBpbmYtPmJpdHBvcywgcGluZi0+ZGF0YSk7DQo+ID4g
IAkJfSBlbHNlIHsNCj4gPiAgCQkJc25wcmludGYocHJpdi0+bWVzc2FnZSwgU1lOUFNfRURBQ19N
U0dfU0laRSwNCj4gPiAtCQkJCSAiRERSIEVDQyBlcnJvciB0eXBlOiVzIFJvdyAlZCBCYW5rICVk
ICIsDQo+ID4gLQkJCQkgICJDRSIsIHBpbmYtPnJvdywgcGluZi0+YmFuayk7DQo+ID4gLQkJCXNu
cHJpbnRmKHByaXYtPm1lc3NhZ2UsIFNZTlBTX0VEQUNfTVNHX1NJWkUsDQo+ID4gLQkJCQkgIkJh
bmtHcm91cCBOdW1iZXIgJWQgQmxvY2sgTnVtYmVyICVkICIsDQo+ID4gLQkJCQkgcGluZi0+YmFu
a2dycG5yLCBwaW5mLT5ibGtucik7DQo+ID4gLQkJCXNucHJpbnRmKHByaXYtPm1lc3NhZ2UsIFNZ
TlBTX0VEQUNfTVNHX1NJWkUsDQo+ID4gLQkJCQkgIkJpdCBQb3NpdGlvbjogJWQgRGF0YTogMHgl
MDh4XG4iLA0KPiA+ICsJCQkJICJERFIgRUNDIGVycm9yIHR5cGU6JXMgUm93ICVkIEJhbmsgJWQN
Cj4gQmFua0dyb3VwIE51bWJlciAlZCBCbG9jayBOdW1iZXIgJWQgQml0IFBvc2l0aW9uOiAlZCBE
YXRhOiAweCUwOHgiLA0KPiA+ICsJCQkJICJDRSIsIHBpbmYtPnJvdywgcGluZi0+YmFuaywNCj4g
PiArCQkJCSBwaW5mLT5iYW5rZ3JwbnIsIHBpbmYtPmJsa25yLA0KPiA+ICAJCQkJIHBpbmYtPmJp
dHBvcywgcGluZi0+ZGF0YSk7DQo+ID4gIAkJfQ0KPiA+DQo+ID4gQEAgLTUxNSwxMCArNTA5LDgg
QEAgc3RhdGljIHZvaWQgaGFuZGxlX2Vycm9yKHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSwNCj4g
c3RydWN0IHN5bnBzX2VjY19zdGF0dXMgKnApDQo+ID4gIAkJCQkiVUUiLCBwaW5mLT5yb3csIHBp
bmYtPmJhbmssIHBpbmYtPmNvbCk7DQo+ID4gIAkJfSBlbHNlIHsNCj4gPiAgCQkJc25wcmludGYo
cHJpdi0+bWVzc2FnZSwgU1lOUFNfRURBQ19NU0dfU0laRSwNCj4gPiAtCQkJCSAiRERSIEVDQyBl
cnJvciB0eXBlIDolcyBSb3cgJWQgQmFuayAlZCAiLA0KPiA+IC0JCQkJICJVRSIsIHBpbmYtPnJv
dywgcGluZi0+YmFuayk7DQo+ID4gLQkJCXNucHJpbnRmKHByaXYtPm1lc3NhZ2UsIFNZTlBTX0VE
QUNfTVNHX1NJWkUsDQo+ID4gLQkJCQkgIkJhbmtHcm91cCBOdW1iZXIgJWQgQmxvY2sgTnVtYmVy
ICVkIiwNCj4gPiArCQkJCSAiRERSIEVDQyBlcnJvciB0eXBlIDolcyBSb3cgJWQgQmFuayAlZA0K
PiBCYW5rR3JvdXAgTnVtYmVyICVkIEJsb2NrIE51bWJlciAlZCIsDQo+ID4gKwkJCQkgIlVFIiwg
cGluZi0+cm93LCBwaW5mLT5iYW5rLA0KPiA+ICAJCQkJIHBpbmYtPmJhbmtncnBuciwgcGluZi0+
YmxrbnIpOw0KPiA+ICAJCX0NCj4gPg0KPiA+DQoNCg==
