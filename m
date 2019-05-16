Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B718D20F3E
	for <lists+linux-edac@lfdr.de>; Thu, 16 May 2019 21:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfEPTgK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 May 2019 15:36:10 -0400
Received: from mail-eopbgr730117.outbound.protection.outlook.com ([40.107.73.117]:21770
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726586AbfEPTgJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 May 2019 15:36:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=vyqS8CLUiU6FrKS6OANtygZM38S/ActRoVwr71umvDb1DfHwsvJYXHjTt3OMB8iFvl67yx/REA/TmwG0o1ejzh/gHUa+521svkgyAK0m+QasD5xTj6BihwU2DYD2fUWi0aVQ2GBolP1eq7TlZo2JNLFIncQFnHjW9h9bsMltJ5w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBseKympQtgKPpR6ckm/j+Hq14h0qsVuCxgAh3W1aUc=;
 b=sXvhdYougSZLjWj0dSMlzOVORqcfKIyJTER5OauM8/YlDtJliiTw2V2j+ZdCfQL1GZrvg63vy9KbTkwuSFQ6skq/WFCvd2tq7W4V+Saaq6aciEBcg8uaptu93+1huXnoK/RZEEBk5ktxqVfRc0jmf0R6hBijVYu6Fx3FcJt8l7A=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBseKympQtgKPpR6ckm/j+Hq14h0qsVuCxgAh3W1aUc=;
 b=R9zCOeql8iGEnAHx1gdpFEpQwke3UcxtJ0EvVamGuhkBgfLG+Tnse1t6jhHZO95luwSqsYz1AQoXt0N5Wi0QYtn0U2VtyZe5W9EzcbZFJdwD3bTRPlrgGty72fG4mg29jd7XWBTqU6/InEGdOuNJQYpon4gMy0fTzHtkKLm25Sg=
Received: from DM6PR21MB1324.namprd21.prod.outlook.com (2603:10b6:5:175::11)
 by DM6PR21MB1211.namprd21.prod.outlook.com (2603:10b6:5:166::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.4; Thu, 16 May
 2019 19:36:05 +0000
Received: from DM6PR21MB1324.namprd21.prod.outlook.com
 ([fe80::c439:40a:2a9e:e211]) by DM6PR21MB1324.namprd21.prod.outlook.com
 ([fe80::c439:40a:2a9e:e211%7]) with mapi id 15.20.1922.002; Thu, 16 May 2019
 19:36:05 +0000
From:   "Lei Wang (BSP)" <Wang.Lei@microsoft.com>
To:     James Morse <james.morse@arm.com>, Rui Zhao <ruizhao@outlook.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Hang Li <hangl@microsoft.com>, Rui Zhao <ruizhao@microsoft.com>
Subject: RE: [PATCH v2 2/2] dt-bindings: edac: arm-dmc520.txt
Thread-Topic: [PATCH v2 2/2] dt-bindings: edac: arm-dmc520.txt
Thread-Index: AQHU1IR05Uxdw3NZh0y2dQGi+EwxJKYcyIoAgFCwt8A=
Date:   Thu, 16 May 2019 19:36:05 +0000
Message-ID: <DM6PR21MB13245182E07A6276E9BB5B18900A0@DM6PR21MB1324.namprd21.prod.outlook.com>
References: <1551921818-2825-1-git-send-email-ruizhao@outlook.com>
 <BN7PR08MB5572B3388B2D7DC8F6C7F285AE4C0@BN7PR08MB5572.namprd08.prod.outlook.com>
 <3b740d3a-ba0d-d186-e8f8-6fdf75a36056@arm.com>
In-Reply-To: <3b740d3a-ba0d-d186-e8f8-6fdf75a36056@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=lewan@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-05-16T19:36:03.1278729Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7b4a8393-38f7-4897-9737-2fffc09b9fb6;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Wang.Lei@microsoft.com; 
x-originating-ip: [2001:4898:80e8:a:488f:8888:7969:e786]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d36f349e-cc02-4e26-884b-08d6da35bcec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR21MB1211;
x-ms-traffictypediagnostic: DM6PR21MB1211:
x-microsoft-antispam-prvs: <DM6PR21MB121107DC2FBF3AD571506164900A0@DM6PR21MB1211.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(13464003)(72206003)(53936002)(478600001)(11346002)(4326008)(33656002)(446003)(14454004)(25786009)(6436002)(10090500001)(10290500003)(486006)(46003)(55016002)(6246003)(476003)(68736007)(107886003)(229853002)(7696005)(8990500004)(9686003)(76176011)(86362001)(71190400001)(52396003)(71200400001)(256004)(14444005)(316002)(8676002)(6506007)(53546011)(99286004)(74316002)(22452003)(5660300002)(7736002)(7416002)(6116002)(2906002)(186003)(305945005)(86612001)(81166006)(8936002)(52536014)(66556008)(76116006)(73956011)(66446008)(66476007)(102836004)(64756008)(54906003)(110136005)(81156014)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1211;H:DM6PR21MB1324.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1IG2/JAhEmAmywSX/Z8rth4D69Uxmp5v84TLgldTSixKvzckVJeglLWGREXtt/nRaPWloC9WJH9W/ueyDq6G+l6ZjgCiinFkxhM2uZ06RoJia/cgKZwQ/rsp8d1vyqP8I2F5ADdPNKGwEH2ENjCcTa+/2N4sNZdMaYyz9Z6rMRimDtRsu++PZLF6eoi1C810bNHQUDKBd5pgKpuuPZ848win/jVqPkHKWpZg8A0JSmj1XQGW93Y5IOqaE8dYwyBEy1G0t23Z2h4j3skwOoBXilF+GOzsMzsktBumU5GdEfj2CsTNBbwvU+5gUuMZBNhKSppcZgAmbfpeqmOmW62vtRTwMYwqL4VZ2gJfCcaGLXJTtGSOM7eTnS9U7+1ekO9n8kToh1lRf18gA5VSONYd5wjMLlqhCQqrsNJk6LxO4hw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36f349e-cc02-4e26-884b-08d6da35bcec
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 19:36:05.5630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lewan@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1211
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgSmFtZXMvQm9yaXNsYXYsDQoNCkkgYWRkcmVzc2VkIHlvdXIgY29tbWVudHMgYW5kIHNlbnQg
b3V0ICJbUEFUQ0ggdjMgMS8yXSBkdC1iaW5kaW5nczogZWRhYzogYXJtLWRtYzUyMC50eHQiIGZv
ciByZXZpZXcuIFRoYW5rcyENCg0KLUxlaQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogSmFtZXMgTW9yc2UgPGphbWVzLm1vcnNlQGFybS5jb20+IA0KU2VudDogTW9uZGF5LCBN
YXJjaCAyNSwgMjAxOSAxMTozMCBBTQ0KVG86IFJ1aSBaaGFvIDxydWl6aGFvQG91dGxvb2suY29t
Pg0KQ2M6IGJwQGFsaWVuOC5kZTsgcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJt
LmNvbTsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBva2F5YUBrZXJuZWwub3JnOyBtY2hl
aGFiQGtlcm5lbC5vcmc7IHdpbGwuZGVhY29uQGFybS5jb207IHNhc2hhbEBrZXJuZWwub3JnOyBI
YW5nIExpIDxoYW5nbEBtaWNyb3NvZnQuY29tPjsgTGVpIFdhbmcgKEJTUCkgPFdhbmcuTGVpQG1p
Y3Jvc29mdC5jb20+OyBSdWkgWmhhbyA8cnVpemhhb0BtaWNyb3NvZnQuY29tPg0KU3ViamVjdDog
UmU6IFtQQVRDSCB2MiAyLzJdIGR0LWJpbmRpbmdzOiBlZGFjOiBhcm0tZG1jNTIwLnR4dA0KDQpI
aSBSdWksDQoNCk9uIDA3LzAzLzIwMTkgMDE6MjQsIFJ1aSBaaGFvIHdyb3RlOg0KPiBGcm9tOiBS
dWkgWmhhbyA8cnVpemhhb0BtaWNyb3NvZnQuY29tPiBkdC1iaW5kaW5ncyBmb3IgbmV3IEVEQUMg
ZHJpdmVyIA0KPiBkbWM1MjBfZWRhYy5jLg0KDQoobWlub3Igbml0LCB0aGUgRFQgZm9sayBwcmVm
ZXIgdGhlIGJpbmRpbmcgdG8gY29tZSBmaXJzdCBpbiB0aGUgc2VyaWVzLCB0aGlzIG1ha2VzIGl0
IGVhc2llciB0byByZXZpZXcpDQoNCg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2VkYWMvYXJtLWRtYzUyMC50eHQgDQo+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2VkYWMvYXJtLWRtYzUyMC50eHQNCj4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gaW5kZXggMDAwMDAwMC4uN2JlYTdkZA0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9lZGFjL2FybS1kbWM1MjAudHh0DQo+
IEBAIC0wLDAgKzEsMjEgQEANCj4gKyogQVJNIERNQy01MjAgRURBQyBub2RlDQo+ICsNCj4gK1Jl
cXVpcmVkIHByb3BlcnRpZXM6DQo+ICstIGNvbXBhdGlibGUJCTogImFybSxkbWMtNTIwIi4NCj4g
Ky0gcmVnCQkJOiBBZGRyZXNzIHJhbmdlIG9mIHRoZSBETUMtNTIwIHJlZ2lzdGVycy4NCj4gKy0g
aW50ZXJydXB0cwkJOiBETUMtNTIwIGludGVycnVwdCBudW1iZXJzLg0KDQpZb3VyIGV4YW1wbGUg
aGFzIHR3byBpbnRlcnJ1cHRzLCB3aGF0IGRvIHRoZXkgY29ycmVzcG9uZCB0bz8gKEl0IG5lZWRz
IHRvIGJlIGNsZWFyIGZyb20gdGhlIGJpbmRpbmcpDQoNCkJlY2F1c2UgdGhpcyB0aGluZyBoYXMg
cXVpdGUgYSBmZXcsIGl0IG1heSBiZSB3b3J0aCBuYW1pbmcgdGhlIG9uZXMgeW91IHVzZS4gSWYg
c29tZW9uZSBlbHNlJ3MgcGxhdGZvcm0gdXNlcyBvbmUgb2YgdGhlIG90aGVycywgdGhleSBjYW4g
YWRkIGl0IHdpdGhvdXQgY29uZmxpY3Rpbmcgd2l0aCBEVHMgZm9yIHlvdXJzLg0KDQpMb29raW5n
IHRocm91Z2ggdGhlIFRSTSBmb3IgdGhpbmdzIGVuZGluZyBpbiBfaW50LCB0aGV5IHNlZW0gdG8g
YmU6DQoqIHJhbV9lY2NfZXJjDQoqIHJhbV9lY2NfZXJkDQoqIGRyYW1fZWNjX2VyYw0KKiBkcmFt
X2VjY19lcmQNCiogZmFpbGVkX2FjY2Vzcw0KKiBmYWlsZWRfcHJvZw0KKiBsaW5rX2Vycg0KKiBh
cmNoX2ZzbQ0KKiB0ZW1wZXJhdHVyZV9ldmVudA0KKiBwaHlfcmVxdWVzdA0KKiBjb21iaW5lZF9p
bnQNCg0KSSB0aGluayB0aGlzIGlzIGZhciB0b28gbWFueSB0byBlbnVtZXJhdGUgZnJvbSBkYXkg
b25lLCBlc3BlY2lhbGx5IGFzIHlvdXIgcGxhdGZvcm0gb25seSBuZWVkcyB0d28uIENvdWxkIHdl
IG5hbWUgdGhlIHR3byB5b3UgbmVlZCBzbyB0aGF0IGl0cyBjbGVhciB3aGljaCBvbmVzIHRoZXkg
YXJlLCBhbmQgb3RoZXJzIGNhbiBiZSBhZGRlZCB3aGVuIHNvbWVvbmUgbmVlZHMgdGhlbS4NCg0K
DQo+ICstIGludGVycnVwdC1tYXNrCTogSW50ZXJydXB0cyB0byBiZSBlbmFibGVkLCByZWZlciB0
byBpbnRlcnJ1cHRfY29udHJvbA0KPiArCQkJICByZWdpc3RlciBpbiBETUMtNTIwIFRSTSBmb3Ig
aW50ZXJydXB0IG1hcHBpbmcuDQoNClRoaXMgc291bmRzIGxpa2UgcG9saWN5LiBJdCB3b3VsZCBi
ZSBnb29kIHRvIG9taXQgdGhlIGludGVycnVwdHMgdGhhdCBhcmVuJ3Qgd2lyZWQgdXAuIElmIHRo
ZXJlIGlzIGEgcG9saWN5IGxpa2UgJ3VzZSByYW0gbm90IGRyYW0gb24gcGxhdGZvcm0gWScgd2Ug
Y2FuIGdldCB0aGUgZWRhYyBkcml2ZXIgdG8gZG8gdGhhdCBiYXNlZCBvbiBvZl9tYWNoaW5lX2lz
X2NvbXBhdGlibGUoKSAoYXMgdGhlIGFsdGVyYSBlZGFjIGRyaXZlciBhbHJlYWR5IGRvZXMpLg0K
DQoNCj4gK09wdGlvbmFsIHByb3BlcnRpZXM6DQo+ICstIGludGVycnVwdC1zaGFyZWQJOiBzZXQg
dGhpcyBwcm9wZXJ0eSBpZiBhbmQgb25seSBpZiBhbGwgRE1DLTUyMA0KPiArCQkJICBpbnRlcnJ1
cHRzIHNoYXJlIHRoZSBpbnRlcnJ1cHQgbnVtYmVyLg0KDQpXaGF0IGlmIHNvbWUgb2YgdGhlbSBh
cmUgY29tYmluZWQsIGFuZCBzb21lIGFyZW4ndD8NCg0KKHRoaXMgc2hhcmVkLWludGVycnVwdHMg
d2FzIG15IGV4YW1wbGUgb2Ygd2h5IHdlIG5lZWQgYSBkb2N1bWVudGVkIGJpbmRpbmcgdG8gd29y
ayBvdXQgd2hhdCBpcyBzcGVjaWZpYyB0byB5b3VyIHBsYXRvZnJtKQ0KDQpJJ20gbm90IHN1cmUg
aG93IHRoaXMgdXN1YWxseSBnZXRzIGRlc2NyaWJlZCBpbiBhIERUIGJpbmRpbmcgLi4uIGNvdWxk
bid0IHdlIHNwb3QgdGhpcyBmcm9tIGR1cGxpY2F0ZSBlbnRyaWVzIGluIHRoZSBpbnRlcnJ1cHRz
IHByb3BlcnR5PyBJZiB3ZSByZWdpc3RlciB0aGVtIHdpdGggSVJRRl9TSEFSRUQsIHdvdWxkIGl0
IG1hdHRlcj8NCg0KKFdlIGNhbiBhbHdheXMgdGVsbCBpdHMgb3VyIGRldmljZSBmcm9tIHRoZSBz
dGF0dXMgcmVnaXN0ZXIsIHNvIEkgdGhpbmsgd2Ugc2hvdWxkIHVzZSBJUlFGX1NIQVJFRCByZWdh
cmRsZXNzLikNCg0KDQpUaGFua3MsDQoNCkphbWVzDQo=
