Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F071A1A21
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2019 14:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfH2Mcl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Aug 2019 08:32:41 -0400
Received: from mail-eopbgr50047.outbound.protection.outlook.com ([40.107.5.47]:64641
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727101AbfH2Mcl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 29 Aug 2019 08:32:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAbu7tUkrw7RYs0nl5tRc0x9LtZJa7bxvu7agoFjNG6G7UGUcoHrla6d4w2KJJqAZuLXoqEE2/ivuDjKMLPGHEF+d3g3vpjBZRTrqsALKLi+hGX1upIFvpbEA6keWOW+nsjTQfHE94lxgYtzH8fy9sk/wnpr2eU6jKspPd9SPZih84cs/1Jon5HAlrhZGHrY9zLxbOvoj3Mj9KZ7OqplNSg1qUDTyKrJjJsqRKygYwxOjEQZ7Y2P3HJgAtOL6fVpcSsn/RXVggXMAyBcTeGU8kC4Dt+44iU7noJPTTAbl1lyfD8AD4UruB69CiHHHSt3C3V2oUuJi7IlsKeuVBm/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nco5YH7IEO1lYjh9k6pVGk4OBp1hts8K8iAdIXeeZzU=;
 b=i4SEBFrGLhk544H1Dg3UVCS7C5S3Hlq2lhuqFaAGyjRa2gNRiK5cG/s/jyMaOVm/Jf6tdV60qWkmb6VrKPJhcomfbXCpsk/TXBFqw9NqKhii4Frh0tdJSG6d3hSF23u5uUceQKqclub9CA1NlQ5HnGe55UM2KGy3rObb20oUXz3Q+xU5Bk6g1B4dEELPMvEsK5Ne/OupK8uwPxXJ0m/jje6T4COtybZYDg7jYFObn14r5SJATZs57expK/3fvFWeYalsry+2CByIkZFdG3pdYzJanw9mUesKD6SahAN3RMPondot0oQYnndY+B+FJrHDGlBtspDE4ldUCRPxli0XEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nco5YH7IEO1lYjh9k6pVGk4OBp1hts8K8iAdIXeeZzU=;
 b=KV4D2LysFPgitYfkT/X+TvdHUcyvBwazRKXVhmVpn66fH390U8CeAUvpgsIPehsio++MbbR+OR8Svg6L4vz1kbHEWAI4vJHVmwlA1w2xGMZKbWcu/SQJ685Wi9MamoybqWQ62+ilYkxIo5TgHH8kpSCxHg3psi1ki7aSqDy5olI=
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com (52.134.90.16) by
 AM0PR04MB4001.eurprd04.prod.outlook.com (52.134.93.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Thu, 29 Aug 2019 12:32:37 +0000
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::ccf4:a1f3:f062:7620]) by AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::ccf4:a1f3:f062:7620%6]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 12:32:37 +0000
From:   York Sun <york.sun@nxp.com>
To:     "jocke@infinera.com" <joakim.tjernlund@infinera.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>
Subject: RE: [EXT] mpc85xx_edac PCI broken for P2010 and T1042, possibly more
Thread-Topic: [EXT] mpc85xx_edac PCI broken for P2010 and T1042, possibly more
Thread-Index: AQHVXlYNMVx90vL3H0+OYJ1BrAUe56cSDo0A
Date:   Thu, 29 Aug 2019 12:32:37 +0000
Message-ID: <AM0PR04MB39719E7D451AA7DFD109A5139AA20@AM0PR04MB3971.eurprd04.prod.outlook.com>
References: <1b86d79d26eafe50731e0664e7b7bc05aab12b47.camel@infinera.com>
In-Reply-To: <1b86d79d26eafe50731e0664e7b7bc05aab12b47.camel@infinera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=york.sun@nxp.com; 
x-originating-ip: [192.88.158.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29e3c553-3776-4fb4-83ab-08d72c7cf9ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4001;
x-ms-traffictypediagnostic: AM0PR04MB4001:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB40010A052B7F842E1087DC789AA20@AM0PR04MB4001.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(13464003)(199004)(189003)(99286004)(66946007)(5660300002)(9686003)(74316002)(66476007)(66556008)(64756008)(66446008)(8936002)(53936002)(52536014)(6436002)(486006)(86362001)(66066001)(446003)(11346002)(55016002)(476003)(110136005)(6116002)(478600001)(71200400001)(316002)(76116006)(14454004)(229853002)(2906002)(26005)(186003)(6636002)(53546011)(81156014)(305945005)(76176011)(6506007)(256004)(7736002)(81166006)(44832011)(3846002)(7696005)(2501003)(71190400001)(8676002)(6246003)(25786009)(33656002)(14444005)(102836004)(491001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4001;H:AM0PR04MB3971.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kq+oAfLFI6NrTnHm2jlQXqA2yt21Uv3VGH7gaKETAG25YwKxhDqf5rFKqPiF5CTsMF8Qb6MReQPWSMGNnC5yl+1dwyJUJ8ccVgUTecPRAK/1D5SQ9X2VKOG32WRPtZBrOTNpoPMrQbmy0bUdrrVg++mCXFGwr6v0xsJqQW3q2vaVD4UujsPWxj8pEG+0viZ1SfAi3JvucDILNhyZmlM0pAgsChMbAYrCHHSVokk5d3AbnWsPGGBj0he7RTFOfDomIt7Tgs/QLuwffNNTpnMEegJR3zrYGNTQHt+I0UsSVoIevZtwGO4vcy/uB587BMIQoWZ4NjPOD79PCOcueQB8ziaajCkrWv9yLyCSITtERgtapEOYC6UElt/SXsNP7s+oTukfJ9N/dbkK3WgUobHX6AqLcn3Y/jslRG8i5bYwGaE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e3c553-3776-4fb4-83ab-08d72c7cf9ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 12:32:37.1050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i32llAbtcXfKohH6jztqEzLnsjM00Gxfm1D2OUrgBlMdwiVyowJ7mHbDuz8OX+CvAz0XOiHdiu1uAzGxRDeyGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4001
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Sm9ha2ltLA0KDQpZb3UgYXJlIHByb2JhYmx5IHJpZ2h0IGFib3V0IFBDSS4gSXQgaGFzIGxlZ2Fj
eSBjb2RlIGFuZCBub3QgcmVndWxhcmx5IHVzZWQuIFBsZWFzZSBmb2xsb3cgdXAgd2l0aCBMZW8g
YXMgSSBoYXZlIGxlZnQgc29mdHdhcmUgZGVwYXJ0bWVudC4NCg0KWW9yaw0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvYWtpbSBUamVybmx1bmQgPEpvYWtpbS5UamVy
bmx1bmRAaW5maW5lcmEuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDI5LCAyMDE5IDM6
NDAgQU0NCj4gVG86IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBZb3JrIFN1biA8eW9yay5z
dW5AbnhwLmNvbT4NCj4gU3ViamVjdDogW0VYVF0gbXBjODV4eF9lZGFjIFBDSSBicm9rZW4gZm9y
IFAyMDEwIGFuZCBUMTA0MiwgcG9zc2libHkgbW9yZQ0KPg0KPiBDYXV0aW9uOiBFWFQgRW1haWwN
Cj4NCj4gUENJZSBlcnJvcnMsIGRvbid0IGtub3cgd2hpY2gsIGNhdXNlcyBlbmRsZXNzIElSUXMg
Zm9yIEVEQUMncyBQQ0llIHJvdXRpbmU6DQo+DQo+IFsgICAxNy42OTA3MTZdIGlycSAyNjogbm9i
b2R5IGNhcmVkICh0cnkgYm9vdGluZyB3aXRoIHRoZSAiaXJxcG9sbCIgb3B0aW9uKQ0KPiBbICAg
MTcuNjk3NDE3XSBDUFU6IDAgUElEOiAwIENvbW06IHN3YXBwZXIgTm90IHRhaW50ZWQgNC4xNC45
MisgIzI0DQo+IFsgICAxNy43MDMzMzRdIENhbGwgVHJhY2U6DQo+IFsgICAxNy43MDU3ODBdIFtk
ZjllZGYxMF0gW2MwMDU2OTkwXSBfX3JlcG9ydF9iYWRfaXJxLmlzcmEuNysweDM0LzB4ZGMNCj4g
KHVucmVsaWFibGUpDQo+IFsgICAxNy43MTMxODFdIFtkZjllZGYzMF0gW2MwMDU2ZDIwXSBub3Rl
X2ludGVycnVwdCsweDI3NC8weDJjMA0KPiBbICAgMTcuNzE4ODQwXSBbZGY5ZWRmNjBdIFtjMDA1
NDllMF0gaGFuZGxlX2lycV9ldmVudF9wZXJjcHUrMHgxYTAvMHgyMDgNCj4gWyAgIDE3LjcyNTI4
MV0gW2RmOWVkZmEwXSBbYzAwNTRhODBdIGhhbmRsZV9pcnFfZXZlbnQrMHgzOC8weDVjDQo+IFsg
ICAxNy43MzA5NDBdIFtkZjllZGZiMF0gW2MwMDU3NjY4XSBoYW5kbGVfZmFzdGVvaV9pcnErMHhi
MC8weDFlMA0KPiBbICAgMTcuNzM2ODY3XSBbZGY5ZWRmYzBdIFtjMDA1NDA0Y10gZ2VuZXJpY19o
YW5kbGVfaXJxKzB4M2MvMHg1Yw0KPiBbICAgMTcuNzQyNzAzXSBbZGY5ZWRmZDBdIFtjMDAwNGJl
MF0gX19kb19pcnErMHg0OC8weDEwYw0KPiBbICAgMTcuNzQ3NzUyXSBbZGY5ZWRmZjBdIFtjMDAw
YzM5OF0gY2FsbF9kb19pcnErMHgyNC8weDNjDQo+IFsgICAxNy43NTI5NzddIFtjMDQ1M2U4MF0g
W2MwMDA0ZDA4XSBkb19JUlErMHg2NC8weGM0DQo+IFsgICAxNy43NTc3NjhdIFtjMDQ1M2VhMF0g
W2MwMDBkYTNjXSByZXRfZnJvbV9leGNlcHQrMHgwLzB4MTgNCj4gWyAgIDE3Ljc2MzI1N10gLS0t
IGludGVycnVwdDogNTAxIGF0IGFyY2hfY3B1X2lkbGUrMHg0Yy8weDVjDQo+IFsgICAxNy43NjMy
NTddICAgICBMUiA9IGNwdV9zdGFydHVwX2VudHJ5KzB4MTdjLzB4MjBjDQo+IFsgICAxNy43NzM0
MzddIFtjMDQ1M2Y2MF0gW2MwMDRkZTFjXSBjcHVfc3RhcnR1cF9lbnRyeSsweDc0LzB4MjBjDQo+
ICh1bnJlbGlhYmxlKQ0KPiBbICAgMTcuNzgwNDA1XSBbYzA0NTNmYjBdIFtjMDNmYzk4OF0gc3Rh
cnRfa2VybmVsKzB4MzRjLzB4MzYwDQo+IFsgICAxNy43ODU4ODldIFtjMDQ1M2ZmMF0gW2MwMDAw
MzgwXSBzZXRfaXZvcisweDEwYy8weDE0OA0KPiBbICAgMTcuNzkxMDI0XSBoYW5kbGVyczoNCj4g
WyAgIDE3Ljc5MzI5Nl0gWzxjMDIzOGU3ND5dIG1wYzg1eHhfcGNpX2lzcg0KPiBbICAgMTcuNzk3
MjEzXSBEaXNhYmxpbmcgSVJRICMyNg0KPg0KPiBUaGlzIGlzIGJlY2F1c2UNCj4gc3RhdGljIGly
cXJldHVybl90IG1wYzg1eHhfcGNpX2lzcihpbnQgaXJxLCB2b2lkICpkZXZfaWQpIHsNCj4gICAg
ICAgICBzdHJ1Y3QgZWRhY19wY2lfY3RsX2luZm8gKnBjaSA9IGRldl9pZDsNCj4gICAgICAgICBz
dHJ1Y3QgbXBjODV4eF9wY2lfcGRhdGEgKnBkYXRhID0gcGNpLT5wdnRfaW5mbzsNCj4gICAgICAg
ICB1MzIgZXJyX2RldGVjdDsNCj4NCj4gICAgICAgICBlcnJfZGV0ZWN0ID0gaW5fYmUzMihwZGF0
YS0+cGNpX3ZiYXNlICsgTVBDODVYWF9QQ0lfRVJSX0RSKTsNCj4NCj4gICAgICAgICBpZiAoIWVy
cl9kZXRlY3QpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gSVJRX05PTkU7DQo+IGFsd2F5cyBl
bmQgd2l0aCBJUlFfTk9ORS4NCj4NCj4NCj4gTWFraW5nIEVEQUMgcG9sbGVkIGp1c3QgbG9ncyBl
bmRsZXNzIGdhcmJhZ2U6DQo+IEF1ZyAyOSAxMDo0NDoyMiB4aGF1bC1iMDIga2VybmVsOiBQQ0ll
IGVycm9yKHMpIGRldGVjdGVkIEF1ZyAyOSAxMDo0NDoyMg0KPiB4aGF1bC1iMDIga2VybmVsOiBQ
Q0llIEVSUl9EUiByZWdpc3RlcjogMHgwMDAwMDAwMCBBdWcgMjkgMTA6NDQ6MjIgeGhhdWwtDQo+
IGIwMiBrZXJuZWw6IFBDSWUgRVJSX0NBUF9TVEFUIHJlZ2lzdGVyOiAweDAwMDAwMDAwIEF1ZyAy
OSAxMDo0NDoyMiB4aGF1bC0NCj4gYjAyIGtlcm5lbDogUENJZSBFUlJfQ0FQX1IwIHJlZ2lzdGVy
OiAweDAwMDAwMDAwIEF1ZyAyOSAxMDo0NDoyMiB4aGF1bC1iMDINCj4ga2VybmVsOiBQQ0llIEVS
Ul9DQVBfUjEgcmVnaXN0ZXI6IDB4MDAwMDAwMDAgQXVnIDI5IDEwOjQ0OjIyIHhoYXVsLWIwMg0K
PiBrZXJuZWw6IFBDSWUgRVJSX0NBUF9SMiByZWdpc3RlcjogMHgwMDAwMDAwMCBBdWcgMjkgMTA6
NDQ6MjIgeGhhdWwtYjAyDQo+IGtlcm5lbDogUENJZSBFUlJfQ0FQX1IzIHJlZ2lzdGVyOiAweDAw
MDAwMDAwDQo+DQo+IEl0IHNlZW1zIHRvIHRoYXQgUENJIGVkYWMgaGFzIG5ldmVyIHdvcmtlZCBh
bmQgbmVlZHMgc29tZSBsb3ZlIGZyb20gTlhQDQo+IG5vdCBzdXJlIHdobyBpcyB0aGUgTlhQIG1h
aW50YWluZXIgdGhvdWdoLCBZb3JrPw0KPg0KPiAgIEpvY2tlDQo=
