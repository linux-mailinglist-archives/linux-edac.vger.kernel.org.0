Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A551B2525B0
	for <lists+linux-edac@lfdr.de>; Wed, 26 Aug 2020 05:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgHZDDV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Aug 2020 23:03:21 -0400
Received: from mail-eopbgr60089.outbound.protection.outlook.com ([40.107.6.89]:2694
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726672AbgHZDDT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 25 Aug 2020 23:03:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYQrxduZWWSloFD+R/kyoZYoTxAxnU3X+Atvq4Hw6RqfdSLELOplGHAnFU7rCcjfoB24RaZjUoEiyGx4CoLGIbGsYARjLmeZHge1ct2qg4hdm67zme9Ho2eZCuZsH3PW47KdQSKWDhnPK0OPlwaVqrFHRh0rk23h24FBUa2M/W4dc/KrsZqg6sODbm+/588v0TvzWkJly07cVfad++keltvztOpnDvtZi46DcX1q0tJTJRWSG/JJr8d4raeMtqqA0D2+NVnp2T07dGESRpQpsWS/4NwjQ2iskj/9hFIBL42e+HsWgP7IU9Rj9A9WCtjQJRtKOt3FM3wXGyQml0yIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/c5jQb7dTnUiguQwBXCdz2gA35gHqGA7XqCpH9HjYdQ=;
 b=jskYhjOfSjEpX9skChkMmzMw0rr0GMKSJyXL9PF+8+7+JP6t+wuivt2zKAFt/F0huRDn9nDtnQErtHK16WGN1VptIWbJZTLDI/5NF4746AaQb1El1gNl500EIGRlVHoltSPA+IScm5T67sJtkfVzMc/a2Wd08/kY3G3i2VFNxGXW+sDN9d3dhBDYL4Rkz8eVFw4H29Bg+WD9KoSWCerzlZt7aw01gVyfTUEZbD1LNQkinDSsOwF+zsnKIaYjGpW2niZw0YvLulQyUBhhvEbOdATU4tUZvI4xLWbnRG0+MX0PxEI4QVRuDMHfmm9nCFyarFBxthjosDu9MLps5mZZ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/c5jQb7dTnUiguQwBXCdz2gA35gHqGA7XqCpH9HjYdQ=;
 b=Fpwkvc6M/cudx+m/NBw7A6ECTEMxIt8kUKoeuNZnRiFmFKri8OBug52s/BM5QLTVzebsM4KFysmayYUq2mMxSIBQQYezANqMqr60F78Ij0QalqNK0PrCwlEOtOXrwkWrJQCwOlphm94xjaL6m43Ui059V/j0Ar/MBSLyfHX/SlI=
Received: from VI1PR04MB4062.eurprd04.prod.outlook.com (2603:10a6:803:40::32)
 by VI1PR0402MB2845.eurprd04.prod.outlook.com (2603:10a6:800:b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Wed, 26 Aug
 2020 03:03:15 +0000
Received: from VI1PR04MB4062.eurprd04.prod.outlook.com
 ([fe80::c64:3b0c:b102:b2df]) by VI1PR04MB4062.eurprd04.prod.outlook.com
 ([fe80::c64:3b0c:b102:b2df%6]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 03:03:15 +0000
From:   Alison Wang <alison.wang@nxp.com>
To:     James Morse <james.morse@arm.com>, "bp@alien8.de" <bp@alien8.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] edac: nxp: Add L1 and L2 error detection for
 A53 and A72 cores
Thread-Topic: [EXT] Re: [PATCH] edac: nxp: Add L1 and L2 error detection for
 A53 and A72 cores
Thread-Index: AQHWVcrvq+aORnEdQEueBFx0LvqOUKlCs7KAgASNEGCAAdgCgIAA30Bg
Date:   Wed, 26 Aug 2020 03:03:15 +0000
Message-ID: <VI1PR04MB4062B4701339466752BFDDE9F4540@VI1PR04MB4062.eurprd04.prod.outlook.com>
References: <20200709082215.12829-1-alison.wang@nxp.com>
 <92811e33-2f57-244b-4b50-c2831b09b835@arm.com>
 <VI1PR04MB4062A3BF31A7002AD45E5200F4570@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <f962eb83-da13-a5de-9f06-b1b987f1e621@arm.com>
In-Reply-To: <f962eb83-da13-a5de-9f06-b1b987f1e621@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5bc0e30a-dfd3-4902-d7b3-08d8496c93ad
x-ms-traffictypediagnostic: VI1PR0402MB2845:
x-microsoft-antispam-prvs: <VI1PR0402MB28452E98F5BCEA22AD9A41ACF4540@VI1PR0402MB2845.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YPWe1dNsfeCr1sgkGWuVJLVt1+TL9QRJy3HkW7RZoTKgbFqdS4RKYgK2htKmZhF8aMXv1PMZq2uLajJxYaSPT2OhnWz61pLTz2TEdEzfdUnRMks/jGntif3y8L0uGHyw1awmzuNwkuHnUd3N1O3akR5yrxaZJoyy9k6L5m33+bvqcGJ1dP0/PNBkOPUZZw0iuuUlxa/bjoRUkLg5PKEU8Hept93guiP/qJM7Ye0Tz6IIvGyMmTmG9c9oRzeJlHa7yNa4LCO4JMrjLtD4VFaZVwPppITevWKb5TplsJ969SyXhls9gQboeiRWOWxRaFNEz2t7+0biHrXQ7AUd/NKDBd1rLi1ilZv9O6I20/9RpmBoXk4MA630UjGcnHbj+y8FVUarE8qFYoU5PyZ2fBsTtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4062.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(186003)(478600001)(26005)(53546011)(316002)(6506007)(71200400001)(44832011)(4326008)(5660300002)(110136005)(52536014)(54906003)(966005)(45080400002)(55016002)(33656002)(86362001)(66446008)(66476007)(83380400001)(66946007)(64756008)(66556008)(8936002)(76116006)(8676002)(9686003)(2906002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KaeVz6Ks8HjlyutGsYN7zWWp8Iypo6iiXV5kBKoOkj754c0CTMFo9LWYwmsQFVpUbjU98nAzc2WJby0iRjJzG09XBb6DCSJVqiDrNCGR8yZ4SQnOZrUZ5VH7j9odJy7eUlesU/hrivOaWt0QHnWyR6h8lycMrLz7NImcbLLX1BwiAtiXlwYF/F8AIXQJZqQxCQDcFDhbvbhgf5ElLnt8jeX/sZoob/ajWrgsRmcXzY/6go+2PZl5fxS1EblmxCuOEoq5z8CJyHdXCJJaL1S1BRLMg5A+p+nQQM2t99XsFayCU5lZ9Mbdu0fF9+5HBUJZlIR/QPy+C2OkfVrlalybFc5qabsd5E96FZi1uPx6Dj5GiBEiilxYU7dr0Acv8TS8lJyiSlhuEE3xgHrUiGYM6yMAROGb89SZoW9TyB2l7gITFMqZgYjvJv1sKYseco2B4gGl0NmtAlN4887XI2cH/WjiVFB79KiFg3sDrGNVO9V+gY+JCciTszLMfmfZ+hnaAWtp+3+qtHP32xvfUqEkbr+9az6eKlbiUt5v+zOxdiDcrym+IDkYn4+6QesUxn8FbNfFa9VGKlPR2qV1h4Q8GjAnOAlyeN3OD4MTRZtZqludV3ufe9fhIvogAsnDGD2G+ffklRMT9AHMR0JQzYsu9w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4062.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc0e30a-dfd3-4902-d7b3-08d8496c93ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 03:03:15.4295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dW4fnPlGLyk7X2koQF9WurYeMgDA/mCyghOZ1dw/lJhm5UOpJh1bqdfYvm8OVei2KtnTtD5270tL5oHvWIQ97g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2845
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGksIEphbWVzLA0KDQo+IE9uIDI1LzA4LzIwMjAgMDM6MzEsIEFsaXNvbiBXYW5nIHdyb3RlOg0K
PiA+PiBPbiAwOS8wNy8yMDIwIDA5OjIyLCBBbGlzb24gV2FuZyB3cm90ZToNCj4gPj4+IEFkZCBl
cnJvciBkZXRlY3Rpb24gZm9yIEE1MyBhbmQgQTcyIGNvcmVzLiBIYXJkd2FyZSBlcnJvciBpbmpl
Y3Rpb24NCj4gPj4+IGlzIHN1cHBvcnRlZCBvbiBBNTMuIFNvZnR3YXJlIGVycm9yIGluamVjdGlv
biBpcyBzdXBwb3J0ZWQgb24gYm90aC4NCj4gPj4NCj4gPiA8c25pcD4NCj4gPj4NCj4gPj4gQXMg
d2UgY2FuJ3Qgc2FmZWx5IHdyaXRlIHRvIHRoZXNlIHJlZ2lzdGVycyBmcm9tIGxpbnV4LCBzbyBJ
IHRoaW5rDQo+ID4+IHRoaXMgbWVhbnMgYWxsIHRoZSBlcnJvciBpbmplY3Rpb24gYW5kIG1heWJl
IFNNQyBzdHVmZiBjYW4gZGlzYXBwZWFyLg0KPiANCj4gPiBJIGFncmVlZCB3aXRoIHlvdXIgb3Bp
bmlvbiB0aGF0IENQVUFDVExSX0VMMSBhbmQgTDJBQ1RMUiBjYW4ndCBiZSB3cml0dGVuDQo+IGlu
IExpbnV4Lg0KPiANCj4gV2VsbCwgd2UgY2FuJ3QgZG8gd2hhdCB0aGUgVFJNIHRlbGxzIHVzIHdl
IG11c3QgYmVmb3JlIHdyaXRpbmcgdG8gdGhhdA0KPiByZWdpc3Rlci4NCltBbGlzb25dIFJpZ2h0
Lg0KPiANCj4gDQo+ID4gU28gdGhlIGVycm9yIGluamVjdGlvbiBjYW4ndCBiZSBkb25lIGluIExp
bnV4LiBEbyB5b3UgbWVhbiB0aGUgZXJyb3INCj4gPiBpbmplY3Rpb24gY2FuIG9ubHkgYmUgZG9u
ZSBpbiBmaXJtd2FyZSBiZWZvcmUgTGludXggYm9vdHMgdXA/IElmIHNvLA0KPiA+IHRoZSBzeXN0
ZW0gaXMgcnVubmluZyB3aXRoIGVycm9yIGluamVjdGlvbiBlbmFibGVkIGFsbCB0aGUgdGltZSwg
aXQgbWF5IGJlIG5vdA0KPiBhIGdvb2QgaWRlYSB0b28uIEFueSBzdWdnZXN0aW9uPw0KPiANCj4g
VGhlc2UgcmVnaXN0ZXJzIGFyZSBleHBlY3RlZCB0byBoYXZlIG9uZSB2YWx1ZSwgZm9yZXZlci4g
VGhlIGVycmF0YSBkb2N1bWVudA0KPiBzb21ldGltZXMgdGVsbHMgdXMgdG8gdG8gc2V0IG9yIGNs
ZWFyIG9uZSBvZiB0aGVzZSBiaXRzIHRvIHdvcmthcm91bmQgYW4gaXNzdWUuDQo+IEJlY2F1c2Ug
dGhleSBjYW4gb25seSBiZSB3cml0dGVuIHRvIHdoZW4gdGhlIHN5c3RlbSBpcyBpZGxlLCB0eXBp
Y2FsbHkgZHVyaW5nDQo+IGJvb3QsIHRoaXMgaXMgZmlybXdhcmUncyByZXNwb25zaWJpbGl0eS4N
Cj4gDQo+IEkgZXhwZWN0IGZpcm13YXJlIHRvIHNldCB0aGUgYml0cyBpbiBBQ1RMUl9FTDMsIHRv
IHByZXZlbnQgbG93ZXIgZXhjZXB0aW9uDQo+IGxldmVscyBmcm9tIHRvdWNoaW5nIGFueSBvZiB0
aGVzZSByZWdpc3RlcnMuDQo+IA0KPiANCj4gSSBkb24ndCBrbm93IGhvdyB0aGUgZXJyb3IgaW5q
ZWN0aW9uIG9uIEE1MyBvciBBNzIgd29ya3MsIHNvIEkgZG9uJ3Qga25vdyBpZg0KPiB5b3UgY2Fu
IGxlYXZlIGl0IGVuYWJsZWQgYWxsIHRoZSB0aW1lLiBUaGUgYml0IHlvdSBhcmUgc2V0dGluZyBp
cyBkZXNjcmliZWQgYXMNCj4gUkVTMCBieSB0aGUgQTUzIGFuZCBBNzIgVFJNcy4gSSBzdXNwZWN0
IEkgaGFkIHRoZSB3cm9uZyBUUk0gb3BlbiwgYXMgbXkNCj4gJ0wxREVJRU4nIGNvbW1lbnQgc2Vl
bXMgdG8gYmUgd2hhdCB5b3VyIENQVUFDVExSX0VMMVs2XSBpcyBjYWxsZWQgb24gQTM1Lg0KPiAo
MzUsIDUzPyBHdWVzcyBob3cgdGhhdCBoYXBwZW5lZCEpDQpbQWxpc29uXSBQbGVhc2UgY2hlY2sg
QTUzIFRSTSByMHA0IGZyb20gaHR0cHM6Ly9kZXZlbG9wZXIuYXJtLmNvbS9kb2N1bWVudGF0aW9u
L2RkaTA1MDAvai9TeXN0ZW0tQ29udHJvbC9BQXJjaDY0LXJlZ2lzdGVyLWRlc2NyaXB0aW9ucy9D
UFUtQXV4aWxpYXJ5LUNvbnRyb2wtUmVnaXN0ZXItLUVMMT9sYW5nPWVuIC4gDQpJbiB0aGUgQ1BV
QUNUTFJfRUwxIGJpdCBhc3NpZ25tZW50cywgeW91IHdpbGwgZmluZCB0aGUgZm9sbG93aW5nIGRl
c2NyaXB0aW9uLg0KWzZdCUwxREVJRU4JDQpMMSBELWNhY2hlIGRhdGEgUkFNIGVycm9yIGluamVj
dGlvbiBlbmFibGUuDQowDQpOb3JtYWwgYmVoYXZpb3IsIGVycm9ycyBhcmUgbm90IGluamVjdGVk
LiBUaGlzIGlzIHRoZSByZXNldCB2YWx1ZS4NCjENCkRvdWJsZS1iaXQgZXJyb3JzIGFyZSBpbmpl
Y3RlZCBvbiBhbGwgd3JpdGVzIHRvIHRoZSBMMSBELWNhY2hlIGRhdGEgUkFNcyBmb3IgdGhlIGZp
cnN0IHdvcmQgb2YgZWFjaCAzMi1ieXRlIHJlZ2lvbi4NCj4gDQo+IEEzNSdzIGVycm9yIGluamVj
dGlvbiBzYXlzOg0KPiB8IFdoaWxlIHRoaXMgYml0IGlzIHNldCwgZG91YmxlLWJpdCBlcnJvcnMg
YXJlIGluamVjdGVkIG9uIGFsbCB3cml0ZXMgdG8NCj4gfCB0aGUgTDEgRC1jYWNoZSBkYXRhIFJB
TXMgZm9yIHRoZSBmaXJzdCB3b3JkIG9mIGVhY2ggMzItYnl0ZSByZWdpb24uDQo+IA0KPiBZb3Ug
Y2VydGFpbmx5IGNhbid0IGxlYXZlIHRoaXMgc29ydCBvZiB0aGluZyBlbmFibGVkISBBbmQgeW91
IGNhbid0IGNoYW5nZSBpdCBhdA0KPiBydW50aW1lLCBzbyB3ZSBjYW4ndCB1c2UgaXQuDQpbQWxp
c29uXSBPay4NCj4gDQo+IA0KPiBJIHRoaW5rIGZlYXR1cmVzIGxpa2UgdGhpcyBhcmUgaW50ZW5k
ZWQgdG8gYmUgdXNlZCB0byBjaGVjayB0aGUgaW50ZWdyYXRpb24sIG5vdA0KPiB0byB0ZXN0IHRo
ZSBzb2Z0d2FyZS4NCj4gDQo+IA0KPiBBZnRlciBJIHNlbnQgdGhlIG9yaWdpbmFsIGNvbW1lbnRz
IG9uIHRoaXMsIEkgZm91bmQgU2FzY2hhJ3MgdmVyc2lvbiwgd2hpY2ggaGFzDQo+IHRoZXNlIGlz
c3VlcyByZXNvbHZlZDoNCj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRs
b29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9yZS5rZXINCj4gbmVsLm9yZyUyRmxpbnV4LWFy
bS1rZXJuZWwlMkYyMDIwMDgxMzA3NTcyMS4yNzk4MS0xLXMuaGF1ZXIlNDBwZW5ndXQNCj4gcm9u
aXguZGUlMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q2FsaXNvbi53YW5nJTQwbnhwLmNvbSU3QzNkYzYx
NjAyDQo+IDI1YjI0ZmNlMDY4NzA4ZDg0OGY5NTU3ZSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5
YzVjMzAxNjM1JTdDMA0KPiAlN0MwJTdDNjM3MzM5NTgzMDAyMDY0ODQ5JmFtcDtzZGF0YT10TGY2
TUhoNUlNU0JYdkFTa2VhSUFOTEdYDQo+IEEwSjZGMjZocG4yNTRhNkk2YyUzRCZhbXA7cmVzZXJ2
ZWQ9MA0KPiANCj4gSSB0aGluayB0aGlzIHZlcnNpb24gc2hvdWxkIHdvcmsgb24geW91ciBwbGF0
Zm9ybSB0b28uDQpbQWxpc29uXSBJIGhhdmUgYSBsb29rIGF0IHRoaXMgcGF0Y2guIFRoaXMgcGF0
Y2ggZG9lc24ndCBjb21wbGV0ZSBhbGwgdGhlIGZ1bmN0aW9ucyBpbiBteSBwYXRjaC4gSXQNCmlz
IGp1c3QgdG8gcmVwb3J0IGVycm9ycywgYnV0IGVycm9yIGluamVjdGlvbiBmdW5jdGlvbiBpcyBh
bGwgcmVtb3ZlZC4NCg0KDQpCZXN0IFJlZ2FyZHMsDQpBbGlzb24gV2FuZw0K
