Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069AE2920D5
	for <lists+linux-edac@lfdr.de>; Mon, 19 Oct 2020 03:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgJSBIb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 18 Oct 2020 21:08:31 -0400
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]:14246
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728329AbgJSBIa (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 18 Oct 2020 21:08:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWUHcb/rIOdd0r+UZmzoZltE2MpzYu3ksA3C8Qu1UiKokadYwxjPkLjtYiv0GtbgNiwAJtYNPyHscdEziYYnEsQYBfMUM/kCno/RAoC66NT4PkPLcprzSYJupubQ8ioR/vAAtAwFBS4ev7mj0cHGJEbVULP5Jrix79KXFh3G3ojiWSxWqTIq6E3ok/lCRM8rCAcc1GJxoYAWydKFuF/yalI52m7VUUO/S/VlgTmSOZGHDPQVOgo3R8/uMp0nhzpYWQ9wzyuJOatLpVMNoqyaQ3rjXnAVnBW09cMU1sqkaPrFZPbIWCWHgJkzd8yzzZRFol/RSq4r9Qx42mORf0sJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shHDoCdd+JNHm2Zhor7znShLcaXttXSn3X24ltUA3Fc=;
 b=Hd6ToGsSiLcySArTgFP+DRNY6vlp4KIXBfdtNwpYXJDack629xyIakrngYS8l5TB0qXAVWHcjkV1YSSZuU0coNztoCOR/22k7/+X4bV6KZcDLEX71WvLEH+rNwJvJLPGISQELl6KiU/8R/oXokAj44gx75EliUhuvvFYrE75SIbLxaMF7p6CppmUaqRXX+o3/mtcc1PbYb0PeyOQQb6r2WnQABVFEI3XXsfFcQNdWNujXKvzyw08N3QWUSd63mRkZP2Ew+frfo0edmwz61t/ANVMeKP1Gz3U7m42XuHxnp2UUjkCyWUYbP6E+T4j5hTIWHjTpiEQyr+hd4WmHkFgug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shHDoCdd+JNHm2Zhor7znShLcaXttXSn3X24ltUA3Fc=;
 b=bAOYUoS9/F/Jgm7Rs7pgJPzb/rzZo0klyNCqm1xIyo2SdAFnVqOUxLReyEN29Q07GdrNU+4Yqf22Whi0ZJTtOUxIRJYONqIF6/qIvgPelOveiabM+gchXmNSHNaKMDSCKgjOTMVkv3vhqNzeLS60zhJRCi7YBPHRQItEJOyyFZo=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6716.eurprd04.prod.outlook.com (2603:10a6:10:109::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Mon, 19 Oct
 2020 01:08:25 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 01:08:25 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Borislav Petkov <bp@alien8.de>, Aisheng Dong <aisheng.dong@nxp.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        "Franck Lenormand (OSS)" <franck.lenormand@oss.nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Subject: RE: [PATCH v2 5/5] soc: imx8: Add the SC SECVIO driver
Thread-Topic: [PATCH v2 5/5] soc: imx8: Add the SC SECVIO driver
Thread-Index: AQHWX3KAH044pDDlDUSK2nAKZvz1uak/mzuAgF3C7wCAAEXigIABBXkA
Date:   Mon, 19 Oct 2020 01:08:25 +0000
Message-ID: <DB6PR0402MB276045F41304FE3DB53540B6881E0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1595344835-67746-1-git-send-email-franck.lenormand@oss.nxp.com>
 <1595344835-67746-6-git-send-email-franck.lenormand@oss.nxp.com>
 <20200819133136.GB7114@dragon>
 <AM6PR04MB496668D6EE3D07C78C5FE77E80010@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201018093135.GA8364@zn.tnic>
In-Reply-To: <20201018093135.GA8364@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47b3c1e3-7aa7-4753-a03a-08d873cb7b2c
x-ms-traffictypediagnostic: DB8PR04MB6716:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB671603654672135314E533B1881E0@DB8PR04MB6716.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mkvm3wFi574Mh4bDyixqGZya1Mmi0LoxbCRCQMvkkT0kt1fCm0TSOeMjsWIEqmCjZDdzbMARP8mUH+jjM+S3WYFir3v9i/l41SK9gs2EoWS5hQXvhpBhUace2pouzNNI68EtPGSuq5EA7jqqb9PuDEUiPy+3CqlpTaQugGRlxo/qp5HOkA8voDsiLJdQiejgw1c8oAEh7zWqeZWsbbhNXsuYwwSqweX/dY9SBPq6nWJ4DFk/461PzFS68PLdRAGJQT3+cxW27jeh2cE8OsAshvhlw0Er0aeM9Nk6XpRsvakJlEFWLpeKxjhwqaQs8CnDolBLr4PwMqiIciY7ljDfkJqZwmp6SHSC6QH3s/gZUE4ah+lAh9nwMs1Sk5xcQXAxzuMwYJZYg7Zg4LAL+ObLOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(7696005)(9686003)(55016002)(2906002)(26005)(5660300002)(186003)(44832011)(6506007)(33656002)(4744005)(8676002)(478600001)(66476007)(66556008)(64756008)(66446008)(66946007)(4326008)(76116006)(86362001)(45080400002)(110136005)(54906003)(966005)(8936002)(316002)(71200400001)(6636002)(7416002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KK6HpzFVxCu6WaWlHYceRWHI1277MB637W9xu+dpe+d2rhrKzLd1EHcilkjJmi+K7ik/V/+jX1ns/R/u7zBstjzjRbnW+AoZVu3UoqdcZT9t3iWlk49rRmxhLTIg16549KtkThSgtRyOIZ0YGt0ynBwsDWByj207R7L9pScblBQAjfZG6qbIkXWzG+rAZ71Sxh2a+PJ7nTJWgSW5FfmMVvxrmN7TVjd8piGtSkJ/lzCNNdljZjggNudJbY2ITfqwZTdeTYYxKuYrYf/fw4waLC2GgJ/3KmhDJKhsb/OvG8khl+XQiNXjENyC9rSIaKm+cjlgjhkPJdCSxWfXsHj1pOwCbmMkJdGk761QRGhjR9p28b/rNzAnc5OGFteaa3anq00WQq/fHmzyjNxF3Bo6bBip9xBeeinSA60r1yrO9LBw8DAEHE0iD3PvJOSIVpr95Sbax48lnWS44p09xs/OpHngaqdhKIHAdhWjhX1SlZhrZjtbr0P541LEWxaBmtPrcsfXLQ8TwFPgk/zQo5rUi/LVZxlKeLbY22MWUrTCL16emnbCPoYNkYfM50WJPkqAWUFhCsltkLQA0o3AvIWFfsl12j+tX5mlAl9xm9vCALRgYmwxrkTdrQBXHlFx9L/VIIB2K+iqkp5jIZXSsa/P5Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b3c1e3-7aa7-4753-a03a-08d873cb7b2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 01:08:25.2533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5injSwP02CpPZlGjnkEvXCsuOYsv2OO0QcSUrCahzkICvE7d6N1lxMYNqU/B+tnKhikDPlPN1VNjtnjoafUUIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6716
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDUvNV0gc29jOiBpbXg4OiBBZGQgdGhlIFNDIFNFQ1ZJ
TyBkcml2ZXINCj4gDQo+IE9uIFN1biwgT2N0IDE4LCAyMDIwIGF0IDA1OjIxOjI4QU0gKzAwMDAs
IEFpc2hlbmcgRG9uZyB3cm90ZToNCj4gPiBOb3Qgc3VyZSBpZiBFREFDIGNvdWxkIGJlIGEgYmV0
dGVyIHBsYWNlLg0KPiA+IGUuZy4NCj4gPiBkcml2ZXJzL2VkYWMvc2lmaXZlX2VkYWMuYw0KPiAN
Cj4gSSBkb24ndCBzZWUgaG93IHRoaXMgZnVuY3Rpb25hbGl0eSBoYXMgYW55dGhpbmcgdG8gZG8g
d2l0aCBFREFDLg0KDQpZZXMsIHRoaXMgaGFzIG5vdGhpbmcgcmVsYXRlZCB3aXRoIEVEQUMNCg0K
PiANCj4gPiBJZiBub3QsIG1heWJlIHdlIGNhbiBwdXQgaW4gJ3NvYycgZmlyc3QuDQo+IA0KPiBP
ciBkcml2ZXJzL21pc2MvDQoNCkkgdGhpbmsgZHJpdmVycy9zb2MvaW14IHNob3VsZCBiZSBvay4N
Cg0KUmVnYXJkcywNClBlbmcuDQoNCj4gDQo+IC0tDQo+IFJlZ2FyZHMvR3J1c3MsDQo+ICAgICBC
b3Jpcy4NCj4gDQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRnBlb3BsZQ0KPiAua2VybmVsLm9yZyUyRnRnbHglMkZub3Rl
cy1hYm91dC1uZXRpcXVldHRlJmFtcDtkYXRhPTA0JTdDMDElN0NwZW5nDQo+IC5mYW4lNDBueHAu
Y29tJTdDOGQyN2MzMjVjZWI4NDRlZjA5YTYwOGQ4NzM0OGEyZDElN0M2ODZlYTFkM2JjDQo+IDJi
NGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNzM4NjEwMzEwNTYyODE5MyU3Q1Vua25v
dw0KPiBuJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklp
TENKQlRpSTZJazFoYQ0KPiBXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPXE0bSUy
RjY1dHlmSmpmNm5ZcndnQ0thdzVNDQo+IE5HTm4zVyUyQmxZbjNLa2Exd3B5RSUzRCZhbXA7cmVz
ZXJ2ZWQ9MA0K
