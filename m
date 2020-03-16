Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7DF1186AD9
	for <lists+linux-edac@lfdr.de>; Mon, 16 Mar 2020 13:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbgCPM3E (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Mar 2020 08:29:04 -0400
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:19590
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730896AbgCPM3E (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Mar 2020 08:29:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpPjr8SXAvGeGEo3/7XUIqncW6t7mof8vj2XUF6cL0TGsrSgISAB0UhnqM9yNkc5qjximIgIk6o/GlIOf8bb4582D/ZixRzop4KqZ4m9BYCcVH9qDXvOCQIXmP3M9HB8s1GwrJ2kxIQr+31EvrUpi54EIARzvqdjfNPK7XUnmn5wI33mQcyiS9R+V+l0YJ9qCjRLeky11wG/BLICnAxYDSKfiyVW4hjNg6zxCT5PuLa0/DaQIhMF/VTTgAATftb2Oigl5uk+8XWKTnoix4joMhO3AYahFHft5c980YXHFzchmz8pDpsa8NwQ4yrTxqfVfRzeODqTN6mZpo1p91yl8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rb7LsBiwaQXtOAaHSy5jQa/Za4XR0ztpv56/1lJbFBQ=;
 b=E50FvTmibehXDWE5hhombdema55y0Q6TFOi9soWR6q0DGiMh7YyuExhr/SGpo668TBzxCk2c28af7xl+ItanPjsVqERAO+9lUWpL3Lv5tWa2dSi6qqYZi4volmANWB/HuwjqvYpn3NT4iXiAeQ2bf0UgFZDGvjMPjyUWFrlhTlrCAPtOah9BLg59s+bTUxJOeSDD6vMZ1jzeTVHWw+jJSmwvNj8qwrXlHvn1Ecb+5MKweLVo+04e0zscIfPQDRK1rjkRwuhvxTVmDYltOHq+6L/fZJ8CBRXwun5A8aEjd2jdW6QG4D4CgMwHRFGNn2JrfPVuSrNGE57ERvBbbkFgVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rb7LsBiwaQXtOAaHSy5jQa/Za4XR0ztpv56/1lJbFBQ=;
 b=gnW8GzgChcBlfFIcrCGTyV4dACrgRbaPizRknfoFxr1JHdudRhU0ZPvZATafHzG/kFl7zPO5YZpo2GsCBds+JyzQ5nLlq1crdaS/Dp19iE/adJ7oWxt/Q1CCGVdNl4mt8BLUA/JpmIrqkZSusJ3sOheK4aWKGiWF/mbzaQ/tA94=
Received: from AM6PR04MB6584.eurprd04.prod.outlook.com (20.179.245.21) by
 AM6PR04MB5557.eurprd04.prod.outlook.com (20.178.93.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18; Mon, 16 Mar 2020 12:28:58 +0000
Received: from AM6PR04MB6584.eurprd04.prod.outlook.com
 ([fe80::3c28:9128:54b1:ee7c]) by AM6PR04MB6584.eurprd04.prod.outlook.com
 ([fe80::3c28:9128:54b1:ee7c%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 12:28:58 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "manish.narani@xilinx.com" <manish.narani@xilinx.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH v2] EDAC: synopsys: Fix the wrong call of pinf->col
 parameter
Thread-Topic: [PATCH v2] EDAC: synopsys: Fix the wrong call of pinf->col
 parameter
Thread-Index: AQHV7d33uILy8BVBmkGIj78HSs8mPahKKjMAgABbh2CAAJ4fAIAAHRUA
Date:   Mon, 16 Mar 2020 12:28:58 +0000
Message-ID: <AM6PR04MB6584F064D683493842EE5B4A92F90@AM6PR04MB6584.eurprd04.prod.outlook.com>
References: <1582856183-5007-1-git-send-email-sherry.sun@nxp.com>
 <20200315195024.GB10926@zn.tnic>
 <AM6PR04MB658495A13744517A6E263D2292F90@AM6PR04MB6584.eurprd04.prod.outlook.com>
 <20200316104356.GH26126@zn.tnic>
In-Reply-To: <20200316104356.GH26126@zn.tnic>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sherry.sun@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b769c13c-e6a9-4dbd-281d-08d7c9a59a0a
x-ms-traffictypediagnostic: AM6PR04MB5557:|AM6PR04MB5557:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5557B90FC630D14EE7246B7792F90@AM6PR04MB5557.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(199004)(76116006)(66946007)(66476007)(64756008)(66556008)(66446008)(8676002)(6506007)(53546011)(2906002)(52536014)(5660300002)(86362001)(45080400002)(966005)(478600001)(316002)(54906003)(4326008)(7696005)(81156014)(8936002)(81166006)(9686003)(55016002)(6916009)(44832011)(71200400001)(26005)(186003)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5557;H:AM6PR04MB6584.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /RKCOcGY9uz6E0okVfusXjPv5YRfrRqTER1XX2NGgYn1OebBi3KMIGOCYIyfzkp3/ceA6Nxunua5fLzLdcUghQL3E7Aw4vMG7pD7Cd3uFw2u3I8aBNjLJjOqMmAdHJfT3TB1bXt3lg6IFPI+nNxTtup3pSMe2aYUlTtmakZ0SD4a58B3clffdgLbtH5hBuVdt3FQO3M7E5n2VLv6WhKORud465WLX2StI60KGTbaMZBYSr8YTlMD9embfAlIkPaPHzDDzsN7oPmQLUR1Qhm2RwoaJCul6+IVetbP2GQs/cu9s47rIQGrKoR/nXDN0N5BLR14o6CJJR5E75+R/73HDlAdjidb+pIz4ZSBh32paByYJCDa1sMpcg4UwrF3CnvWJlhX5lzjMbjr/JFB1xDtwzhIxNWSAXVMwhVe4r2oXnQxWM14UUoXTWD6GJGV5KrynjDfvQJ9PGYn0/9tKFbmPDU3KMVUVtsAksREgBR9Ps89pXC5fUFYHKmc3JUQkTlWP54W4bChZ5O9xET1s4wKjzzYHZEEh2uS8Wu0CXhQ/CZoT/syUC5j0t3htno7GifV4zd+SmrB8Q5jWWAO7v9Fs5j9k6qztgUVgBRmsZ07I1w4qUY8ErVGHAValPgm6Vy9
x-ms-exchange-antispam-messagedata: liuzu4WmlSYZGGNHsA/7y2DOwGnyNxbo0at0vMCsJZUqlSmID/07yI2RjhPIgEg5Hu1wQDTvatBnBLKHbrp6Dr2Dnf/3kG5ALbc7UzpzjzL5LjMGbJmmVPtJjE0apK8rrch4BTN1hRZw6ahNxBrynA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b769c13c-e6a9-4dbd-281d-08d7c9a59a0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 12:28:58.6808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +4z1n9G89WW/gFK+zYnZp9q87AFrDTI+taci5jizs9/MquCHjMvO9eLMFGRgSibwoJx0he3r1v1W+TGDDIucnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5557
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgQm9yaXNsYXYsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9y
aXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IDIwMjDlubQz5pyIMTbml6UgMTg6
NDQNCj4gVG86IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gQ2M6IG1jaGVoYWJA
a2VybmVsLm9yZzsgdG9ueS5sdWNrQGludGVsLmNvbTsgamFtZXMubW9yc2VAYXJtLmNvbTsNCj4g
cnJpY2h0ZXJAbWFydmVsbC5jb207IG1pY2hhbC5zaW1la0B4aWxpbnguY29tOyBtYW5pc2gubmFy
YW5pQHhpbGlueC5jb207DQo+IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPjsg
RnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIEVE
QUM6IHN5bm9wc3lzOiBGaXggdGhlIHdyb25nIGNhbGwgb2YgcGluZi0+Y29sDQo+IHBhcmFtZXRl
cg0KPiANCj4gT24gTW9uLCBNYXIgMTYsIDIwMjAgYXQgMDE6MzA6MzlBTSArMDAwMCwgU2hlcnJ5
IFN1biB3cm90ZToNCj4gPiBNYXliZSB5b3UgbWlzdW5kZXJzdG9vZCB0aGUgaGFuZGxlX2Vycm9y
KCksIHRoaXMgZnVuY3Rpb24gaGFzIGFscmVhZHkNCj4gPiBkaXN0aW5ndWlzaGVkIGJldHdlZW4g
WnlucSBhbmQgWnlucU1QIHRocm91Z2ggcHJpdi0+cF9kYXRhLT5xdWlya3MuDQo+ID4gQW5kIHdo
YXQgSSBhbSBkb2luZyBpbiB0aGlzIHBhdGNoIGlzIHRvIHJlbW92ZSB0aGUgdXNlbGVzcyBwaW5m
LT5jb2wNCj4gPiBpbiBaeW5xTVAgcGFydCwgd2hpY2ggd29uJ3QgYnJlYWsgdGhlIFp5bnEgcGFy
dC4NCj4gDQo+IE9rLCBJIHNlZSBpdCBub3csIHRoYW5rcyBmb3IgY2xhcmlmeWluZy4NCj4gDQo+
IE5vdywgaW4geW91ciB2MiBwbHMgZml4IHRoaXMgY2hlY2sgaW4gaGFuZGxlX2Vycm9yKCk6DQo+
IA0KPiAJaWYgKCFwcml2LT5wX2RhdGEtPnF1aXJrcykgew0KPiANCj4gdG8gKmFjdHVhbGx5KiAq
ZXhwbGljaXRseSogY2hlY2sgdGhhdCB0aGUgcGxhdGZvcm0gZm9yIHdoaWNoIHRoaXMgZnVuY3Rp
b24gaXMNCj4gY2FsbGVkLCByZWFsbHkgc3VwcG9ydHMgaW50ZXJydXB0cywgaS5lLiwgRERSX0VD
Q19JTlRSX1NVUFBPUlQsIGFuZCBub3QgdGhhdA0KPiB0aGUgLT5xdWlya3MgdGhpbmcgaXMgIT0g
MC4gTGlrZSB0aGUgcmVzdCBvZiB0aGUgY29kZSBkb2VzLg0KPiANCg0KT2ssIEkgd2lsbCBmaXgg
dGhpcyBjaGVjay4NCg0KQmVzdCByZWdhcmRzDQpTaGVycnkgU3VuDQoNCj4gVGh4Lg0KPiANCj4g
LS0NCj4gUmVnYXJkcy9HcnVzcywNCj4gICAgIEJvcmlzLg0KPiANCj4gaHR0cHM6Ly9ldXIwMS5z
YWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGcGVvcGwN
Cj4gZS5rZXJuZWwub3JnJTJGdGdseCUyRm5vdGVzLWFib3V0LQ0KPiBuZXRpcXVldHRlJmFtcDtk
YXRhPTAyJTdDMDElN0NzaGVycnkuc3VuJTQwbnhwLmNvbSU3Q2NkODQzMjM5ZmZkDQo+IGQ0OGEw
NWNlNDA4ZDdjOTk2ZWJkNSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3
Qw0KPiAwJTdDNjM3MTk5NTIyMzU2OTA5ODM4JmFtcDtzZGF0YT01cDZKdVhRUUpneWpsYU1PVUgx
Y0xMU0RGYlV6TQ0KPiBSJTJGanpzNUhDJTJGZVUxWmMlM0QmYW1wO3Jlc2VydmVkPTANCg==
