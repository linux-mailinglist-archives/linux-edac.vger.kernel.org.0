Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BA22C9EBE
	for <lists+linux-edac@lfdr.de>; Tue,  1 Dec 2020 11:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgLAKG1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Dec 2020 05:06:27 -0500
Received: from mail-eopbgr1300109.outbound.protection.outlook.com ([40.107.130.109]:36896
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbgLAKG1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 1 Dec 2020 05:06:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFmC1yxidqbDR5gcQoyz9YApa/qH+GVVSks4tqTiybMj1LArOkdhiHPLbkrxQoxWCvRfucvFzbQl/lfbdS6Xz0cAdcY9bqON4H0jcYzZE5MJUVOfSJvjUQNFxNBkQAYo60GL3JHyFQJ4msUrwaswJVpVRxwdxQ0+wtkfx827+Pycn7zGP8gB1wkK4eAdZI1j4AKJBfQ64lDYqolaT3Zhxxq3HAOf6Dd20cE5JDiZlgNE1/UjaiWNyFxi/pnZ0N0qshG4qsfrd34uChpl9DWTVhEYo6Zynu2B5q/k1PnM/vL4ubrHFKByUCi7NjDWm/oyXi20Rl+cnHzVHBtBcITF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUajGHWSqg28Fnlgx7L+wkGredWaO6LdDg0aDG62Ljg=;
 b=Fee7BgR7e4nV0QYJf7KvCY/XOtZ6k71cLQrZDtFja+U4WRrCNqvn+2dZoBGe2a6RZz3FCWPKaWWGaFxzNBIppMDxH/7cjUsAIAIRGuP9tKBm/x6IVDA8D2rECGB29NQvOyTxDVHWBED4+O8fdZMj3XPkHcoLJlNUvLgrl1zUyJcE5/lbOlttfuCvwMRJWvJTtdeg99h+VsYDZW5zKrm28At1Yl8GSWg3r4iDLL4gnqJCmaoQZkE4hM98cLi8DcrWlOoqAm56cGX91fOdwQqCEr2ztLhOnl9qNeGd7B/IqnCIagHoAjd0or+NfY4Ta5624nrYWYPT+xt7tub4reUanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from PS1PR06MB2600.apcprd06.prod.outlook.com (2603:1096:803:4d::19)
 by PU1PR06MB2374.apcprd06.prod.outlook.com (2603:1096:803:3b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Tue, 1 Dec
 2020 10:04:51 +0000
Received: from PS1PR06MB2600.apcprd06.prod.outlook.com
 ([fe80::7d57:cb3c:146c:36e3]) by PS1PR06MB2600.apcprd06.prod.outlook.com
 ([fe80::7d57:cb3c:146c:36e3%4]) with mapi id 15.20.3611.031; Tue, 1 Dec 2020
 10:04:51 +0000
From:   Troy Lee <troy_lee@aspeedtech.com>
To:     "Stefan Schaeckeler (sschaeck)" <sschaeck@cisco.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>
CC:     "leetroy@gmail.com" <leetroy@gmail.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Stefan Schaeckeler <schaecsn@gmx.net>
Subject: RE: [PATCH 3/3] edac: Supporting AST2400 and AST2600 edac driver
Thread-Topic: [PATCH 3/3] edac: Supporting AST2400 and AST2600 edac driver
Thread-Index: AQHWxvOZHTlrFWqSykaazJ8oPL0cyKngZN4AgAGYsUA=
Date:   Tue, 1 Dec 2020 10:04:51 +0000
Message-ID: <PS1PR06MB26008D10C46C5DF0B47F81368AF40@PS1PR06MB2600.apcprd06.prod.outlook.com>
References: <20201130083345.4814-1-troy_lee@aspeedtech.com>
 <20201130083345.4814-3-troy_lee@aspeedtech.com>
 <4AD4AB7A-54E7-4922-9547-7E26D61F7C77@cisco.com>
In-Reply-To: <4AD4AB7A-54E7-4922-9547-7E26D61F7C77@cisco.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cisco.com; dkim=none (message not signed)
 header.d=none;cisco.com; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [118.99.190.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f003460d-216c-4a56-a5df-08d895e08b17
x-ms-traffictypediagnostic: PU1PR06MB2374:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1PR06MB23742213C74F3FBE6912D4D78AF40@PU1PR06MB2374.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tQHYB+CZLQPYKJTnaYn/XKj9sxkjfSinqWK2RsDeDZcjaU1S0K5jpxXerJG7elw/Io1oJwyLI29Gq7V/zVSQdFjtdoTJPPDNhWd3ZAuPmdCa3+QfyQV28MJiBmR2w4F/MvQYo+hcHnwVjY0Tpfhbc1+2+1jis2iltbL/pt2hTGRZBfuWNYPeBLw+y3XwmEi2vJdKSBb3ZOlG8jfJQsahbfz/Ej2VMRnroq3hPYK4G/rgKkSK6ljHNv4MQHzjM7Mnm7HFYTjGloE9d2jZjVIYTi7R4Xg3ENIrjVY6/kEvqqYo9zmp1TuB6686zZjpJ2j9BAwBTppPVSFGxbYbIneDSAyFHvB6n9W56AaeAQj+iHeppVn06BxyRBaxtMPPyDWAOSwex7CC2Qh64o/+IcVUVWk5dtKAMpGP+g2aeaLb6eHdtz2h9HesJPRftg/Dntp2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR06MB2600.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(366004)(39840400004)(376002)(53546011)(52536014)(966005)(66476007)(478600001)(8676002)(6506007)(66556008)(66446008)(71200400001)(26005)(66946007)(76116006)(8936002)(86362001)(186003)(921005)(7696005)(5660300002)(2906002)(4326008)(64756008)(316002)(110136005)(9686003)(54906003)(33656002)(7416002)(83380400001)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aFBtOGRmK1V4WUJlZTlWZ2RCY1ZCRFZjdHZIR2lIT2sxUW5ObWhBSW84ella?=
 =?utf-8?B?N2tnTW1pcGZFOXpnTE9IUzcxL0RmeVNlU0tGQ2lhdXN0ME5LYUxhS2MyTjdr?=
 =?utf-8?B?aW5vN3d2TnNWenVNVHE1eExRam9vUVhPMEErcS84MzJPK3hZM2ZITzBpa0V0?=
 =?utf-8?B?ZkVVZWlLeU1oai9QTk16WGI0SjVmSHVXd0hiZmZDUXpqczcvb295V1J1Tld3?=
 =?utf-8?B?WGs3NVl1RzBKTG43VThFK1RtR2JZbW9haEw4cXNGS2wvQU5DczNrbG9JVUlN?=
 =?utf-8?B?YlFhbWZKMTc0YXEyQ2wrVXk0L3VTcjZSZzZkaHhjRmVlWEhqVldMODhSQmtD?=
 =?utf-8?B?RFZ4QXZuV2lFZjN6M3FhcWhlMHVPcVhpaXBIVWN0TkgrblFQOXF5NE1EM294?=
 =?utf-8?B?b2xsKzNwaG1pSGVFN1psM3VXR2k5OTR1Y3VLekxUL09JcDZTSUozTm9DQUh3?=
 =?utf-8?B?emNCMFdmbVN2WnNzQ0dxYVA1bUc5T2RJdlZOQU5SNGJieGc3YW00Y3hVOHoy?=
 =?utf-8?B?U1N2M29iTlpLbDYwM3hJS1lic0kreEVGZHJLaVV6aFNYcEVyUE1XclZzalI2?=
 =?utf-8?B?ZDFkcXhGL1BFb2FIelVTSHVUUUdQTVFkWmZ1SFJYRFNNKzNneEs3NGs0b0FQ?=
 =?utf-8?B?aGJsS1BKc2cwUkpRbmY5MlhkN1o3SFNLMVRRUXNmc1B2WVFWU20ySmZ4MkIw?=
 =?utf-8?B?UFVYVXAvUytiNjQvMDRNU25oZnNjVFJoNlk1Y1h5dUV3M0RHcExvY2FMU1V5?=
 =?utf-8?B?cGtHcDFId05NcnZid2ZhcVdKUEVtS1ZEUWdsS1lUK2JVQ0NZanBhdGh1WXFL?=
 =?utf-8?B?MjZzLy9sT3YxaHQ5S296b2RMUThzbGJXOS8yWnQrM3VXbXNIVHdnUUtQQ3hV?=
 =?utf-8?B?N1R4Z092Qjg2NmNmK21adGRLeThZYUtQWUtaSjVxeWZSN2JSUU96UTF2elVq?=
 =?utf-8?B?TnJrclpGbnhtemcrbWlvTzc0b1dzQnVQZ0Fab1ZUNVpIWVZoa0hkdjgxRjEv?=
 =?utf-8?B?MlJzN2oyV3JGa0E1SGJ1bm5yTnVNVjd2T2xFWUF0VmwzM3BpM0xXZ0JxR3RR?=
 =?utf-8?B?THA4bkl1aFBvTTV5cldBN014YVJrU1E0aXZ1TUN6OElpMzd2U0xaU2Y5ZFdH?=
 =?utf-8?B?YnJaVkdPUUFLQnlwWVR5ZjdWeHNDcGFIVXpPN3pkWTNpUlczdHRZR2duMU1t?=
 =?utf-8?B?N0MzVit5R3VHbU1pRGN5UTNBQ1NvQ0Q1dHVMUnJ2czlDNnorME1aQkg3ZVZt?=
 =?utf-8?B?UzNOLzZRZVJFMGp3cmRWN1ZIV3VSajVkdGRDT3QrZEo3cWtXd2JMdmNPdHY3?=
 =?utf-8?Q?JMFs2vDkweE+s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR06MB2600.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f003460d-216c-4a56-a5df-08d895e08b17
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 10:04:51.0851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4T234sx1RjaC6JApDBCYmpKQiTu1fTip4u+hyUTQeXGmHnwT4Cxhqws3ETdx7YkIy8qms+XvL/zwa6HaiNH9jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1PR06MB2374
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgU3RlZmFuLA0KDQpUaGUgZHJpdmVyIHdhcyBwb3J0ZWQgZnJvbSBsYXRlc3QgQVNQRUVEIEJT
UCwgc28gSSBvbmx5IHRlc3Qgd2l0aCBFQ0Mtb24vb2ZmIA0KZnJvbSB1LWJvb3QgYW5kIGNoZWNr
IGlmIGRyaXZlciBydW5zIGNvcnJlY3RseS4NCg0KVGhlIHRlc3QgZG9jIHlvdSBwcm92aWRlZCBp
cyB2ZXJ5IG5pY2UgYW5kIGRldGFpbGVkLCBJJ2xsIHRyeSB0byByZXByb2R1Y2UgdGhlIA0KaW5q
ZWN0aW9uIHRlc3QgaW4gdjIgcGF0Y2guDQoNClRoYW5rcywNClRyb3kgTGVlDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlZmFuIFNjaGFlY2tlbGVyIChzc2NoYWVj
aykgPHNzY2hhZWNrQGNpc2NvLmNvbT4NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAzMCwgMjAy
MCA1OjE2IFBNDQo+IFRvOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyBSb2Ig
SGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsNCj4gSm9lbCBTdGFubGV5IDxqb2VsQGptcy5p
ZC5hdT47IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAYWouaWQuYXU+OyBCb3Jpc2xhdg0KPiBQZXRr
b3YgPGJwQGFsaWVuOC5kZT47IE1hdXJvIENhcnZhbGhvIENoZWhhYiA8bWNoZWhhYkBrZXJuZWwu
b3JnPjsNCj4gVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPjsgSmFtZXMgTW9yc2UgPGph
bWVzLm1vcnNlQGFybS5jb20+Ow0KPiBSb2JlcnQgUmljaHRlciA8cnJpY2h0ZXJAbWFydmVsbC5j
b20+OyBvcGVuIGxpc3Q6T1BFTiBGSVJNV0FSRSBBTkQNCj4gRkxBVFRFTkVEIERFVklDRSBUUkVF
IEJJTkRJTkdTIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47IG1vZGVyYXRlZA0KPiBsaXN0
OkFSTS9BU1BFRUQgTUFDSElORSBTVVBQT1JUIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc+Ow0KPiBtb2RlcmF0ZWQgbGlzdDpBUk0vQVNQRUVEIE1BQ0hJTkUgU1VQUE9SVA0K
PiA8bGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmc+OyBvcGVuIGxpc3QgPGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBvcGVuIGxpc3Q6RURBQy1DT1JFIDxsaW51eC1lZGFjQHZn
ZXIua2VybmVsLm9yZz4NCj4gQ2M6IGxlZXRyb3lAZ21haWwuY29tOyBSeWFuIENoZW4gPHJ5YW5f
Y2hlbkBhc3BlZWR0ZWNoLmNvbT47IFN0ZWZhbg0KPiBTY2hhZWNrZWxlciA8c2NoYWVjc25AZ214
Lm5ldD4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIGVkYWM6IFN1cHBvcnRpbmcgQVNUMjQw
MCBhbmQgQVNUMjYwMCBlZGFjIGRyaXZlcg0KPiANCj4gSGVsbG8gVHJveSwNCj4gDQo+ID4gQWRk
aW5nIEFTVDI0MDAgYW5kIEFTVDI2MDAgZWRhYyBkcml2ZXIgc3VwcG9ydC4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0N
Cj4gPiBkcml2ZXJzL2VkYWMvS2NvbmZpZyAgICAgICB8ICAgNiArLQ0KPiA+IGRyaXZlcnMvZWRh
Yy9hc3BlZWRfZWRhYy5jIHwgMTE0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0NCj4gPiAyIGZpbGVzIGNoYW5nZWQsIDk0IGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygt
KQ0KPiANCj4gVWgsIHRoZXJlIGFyZSBxdWl0ZSBzb21lIG5vbi10cml2aWFsIGNoYW5nZXMuIEkn
bGwgaGF2ZSBhIGxvb2sgb3ZlciB0aGUgY29taW5nDQo+IHdlZWtlbmQuDQo+IA0KPiBUZXN0aW5n
IGFuIGVkYWMgZHJpdmVyIGNvbWVzIHdpdGggY2hhbGxlbmdlcy4gRGlkIHlvdSB0ZXN0IHlvdXIg
Y29kZT8gSWYgc28sDQo+IGhvdz8NCj4gDQo+IFRoYXQncyBob3cgSSB3YXMgdGVzdGluZyBteSBv
cmlnaW5hbCBlZGFjIDI1MDAgZHJpdmVyDQo+IGh0dHA6Ly9zdHVkZW50cy5lbmdyLnNjdS5lZHUv
fnNzY2hhZWNrL21pc2MvYXNwZWVkLWVkYWMuaHRtbA0KPiANCj4gIFN0ZWZhbg0KDQo=
