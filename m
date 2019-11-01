Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05F64EC586
	for <lists+linux-edac@lfdr.de>; Fri,  1 Nov 2019 16:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfKAPTl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 1 Nov 2019 11:19:41 -0400
Received: from mail-eopbgr750073.outbound.protection.outlook.com ([40.107.75.73]:32130
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728158AbfKAPTl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 1 Nov 2019 11:19:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baUMc950KxAPVvyhov3TlAit7dxU0MemniPlC5X4fxDbOA9YOxq2KQ8hJlUjDFdTmpvNKynXi2kP63tgHvUhdpjYGUTp7lcZW/AmnlTe/6V8/fVFcWTV0uXKV7aoH4+7C8pwCTWHYE/QNN+UHbTSPVuvPo9IrcmTHpbgn/VHSyzrN4SO6dLW2hsm/u2KZuWjzTpAp8uEBbUXEMns+LW4XY9Lir4IXsaRoXHspcovxghw2b7Fd9/QWtNeLjb7kNnTimZF1kFxhm2T4sRulO+wY/f5b3fe2pULvpBKzT9OqPKBEbdqTx7VtlllHn0szszDjBEKdvnr+CKsHlWzpAj0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riBqu5tBfeg4ljwUTxKYlkThNkFKiuJAcvkMXFy7yM4=;
 b=DKNDrd5aC6cEfWL5iLT0oSCSfVdw4nWGypLa0erejgj7H2iT+US1qapNOCSoXRjMj8xhy+5+dvZC+zII0JCYBTsyRlEugDlYqUxrhSRO2YwdNFqxuRXXgpCEdPLJrMryg8DamEuTqUzCDmHOV4BpqxyQxooxESYFSOvsPPrgZAM0CxSLpvod//jF4qTDjxkfr/1PR5iOup5Z4wPLWxy+8nX4I9M//GSyRog6cYX8BzjlCodhz9stmbN8/tYF0Hj3h2kAX9iE0EkjkPMOvD7hLfCw4hbNmyGkYETbhwgm3GvTLemU57bgb4TGH0PISYoUxYOFB687+C2wCSogFl1L0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riBqu5tBfeg4ljwUTxKYlkThNkFKiuJAcvkMXFy7yM4=;
 b=yz20WR9MWh/eGUKjV857amc3uCU/80FxumjVR2/UNwqsRCQloiZkYdh7D7lepbBtZhesFcKH91dOoSGmTpcS/aIRPJP/h8RTRv/kZa8YUFjIuowfSPXeIgPAp1dOQFEOrsOe3Sem1RW3uq3bdTaaFLn8ZyJB6NiF0aY8fHKCkRU=
Received: from BYAPR12MB2630.namprd12.prod.outlook.com (20.177.124.91) by
 BYAPR12MB2693.namprd12.prod.outlook.com (20.176.255.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Fri, 1 Nov 2019 15:19:36 +0000
Received: from BYAPR12MB2630.namprd12.prod.outlook.com
 ([fe80::70f9:320:f40f:9528]) by BYAPR12MB2630.namprd12.prod.outlook.com
 ([fe80::70f9:320:f40f:9528%6]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 15:19:36 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/6] AMD64 EDAC: Check for nodes without memory, etc.
Thread-Topic: [PATCH v2 0/6] AMD64 EDAC: Check for nodes without memory, etc.
Thread-Index: AQHViRgxcQiEBlwrekGL67NfTPIxZqdrX8oAgAsY5vA=
Date:   Fri, 1 Nov 2019 15:19:36 +0000
Message-ID: <BYAPR12MB2630ED1425A3F01727E1C45BF8620@BYAPR12MB2630.namprd12.prod.outlook.com>
References: <20191022203448.13962-1-Yazen.Ghannam@amd.com>
 <20191025133456.GA6483@zn.tnic>
In-Reply-To: <20191025133456.GA6483@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.25.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15084a9f-e431-41f3-7fe0-08d75edee7dd
x-ms-traffictypediagnostic: BYAPR12MB2693:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR12MB2693B634C1C811A88E5FDF12F8620@BYAPR12MB2693.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(13464003)(199004)(189003)(26005)(14444005)(14454004)(6306002)(256004)(7696005)(102836004)(52536014)(76176011)(33656002)(55016002)(76116006)(66946007)(6506007)(66556008)(6916009)(66476007)(53546011)(99286004)(54906003)(9686003)(86362001)(2906002)(71190400001)(5660300002)(478600001)(966005)(25786009)(66066001)(4326008)(6246003)(66446008)(6436002)(64756008)(71200400001)(229853002)(8936002)(6116002)(316002)(8676002)(446003)(305945005)(7736002)(74316002)(476003)(81166006)(81156014)(486006)(3846002)(186003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2693;H:BYAPR12MB2630.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xovxh1zA33YcD+Ufm2W1OEHPF5/qZ6bWBcNXlkHdsNTfm0mw6q2ZTEBMyooqc18ZZqum0B1r8v7fWXHaXFMK+Ld7CCWaz3Y7bJ4r55Az0fymDICGI91SSQ8FZu+h2IIiQQuWoJgHTfsIsJCkEQQ4I8oA74/wMbfj5DtFN4T4UDVvKMdRBlqJaJZ/atx6rw5xUYMPhucrs6tXpn6//B1K2rJt9MawaG0JBhSlA1zgCdYmPG9l2QBglxeQe+/njs8fTNqC+rTyKL4S9M/u8n9vNubQz+QVtsfeGwV+3guzjYx/IaOljo6JF5ZHh1DPpisc5GesMs+7fp1VyY9yrvGJdDggFCeCtWYLT3b/mGXkX4yM+QT377L7deF0+sNGVjoPdxWhkp2Y8l8Gne5B8bW02dt3LKbEAB1DWK8Q6e1ZXDuu9whBQoQpNqGqMHK5sfhQM9qofmy14Zr1CEpYlErBvbW20VQgiT2aGiPgBwNZgAk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15084a9f-e431-41f3-7fe0-08d75edee7dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 15:19:36.0748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZyMMgMW3xE+Fr5oqZGydFv7nV+Be77qdDAsnrp+wWmV3666rwZtIKWA/owleefbcoYCRNWYRdSD3Zda8XeIQrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2693
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDI1LCAyMDE5IDk6MzUgQU0NCj4g
VG86IEdoYW5uYW0sIFlhemVuIDxZYXplbi5HaGFubmFtQGFtZC5jb20+DQo+IENjOiBsaW51eC1l
ZGFjQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYyIDAvNl0gQU1ENjQgRURBQzogQ2hlY2sgZm9yIG5vZGVzIHdpdGhv
dXQgbWVtb3J5LCBldGMuDQo+IA0KPiBPbiBUdWUsIE9jdCAyMiwgMjAxOSBhdCAwODozNTowOFBN
ICswMDAwLCBHaGFubmFtLCBZYXplbiB3cm90ZToNCj4gPiBGcm9tOiBZYXplbiBHaGFubmFtIDx5
YXplbi5naGFubmFtQGFtZC5jb20+DQo+ID4NCj4gPiBIaSBCb3JpcywNCj4gPg0KPiA+IE1vc3Qg
b2YgdGhlc2UgcGF0Y2hlcyBhZGRyZXNzIHRoZSBpc3N1ZSB3aGVyZSB0aGUgbW9kdWxlIGNoZWNr
cyBhbmQNCj4gPiBjb21wbGFpbnMgYWJvdXQgRFJBTSBFQ0Mgb24gbm9kZXMgd2l0aG91dCBtZW1v
cnkuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gWWF6ZW4NCj4gPg0KPiA+IExpbms6DQo+ID4gaHR0
cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDE5MTAxODE1MzExNC4zOTM3OC0xLVlhemVuLkdoYW5u
YW1AYW1kLmNvbQ0KPiA+DQo+ID4gWWF6ZW4gR2hhbm5hbSAoNik6DQo+ID4gICBFREFDL2FtZDY0
OiBNYWtlIHN0cnVjdCBhbWQ2NF9mYW1pbHlfdHlwZSBnbG9iYWwNCj4gPiAgIEVEQUMvYW1kNjQ6
IEdhdGhlciBoYXJkd2FyZSBpbmZvcm1hdGlvbiBlYXJseQ0KPiA+ICAgRURBQy9hbWQ2NDogU2F2
ZSBtYXggbnVtYmVyIG9mIGNvbnRyb2xsZXJzIHRvIGZhbWlseSB0eXBlDQo+ID4gICBFREFDL2Ft
ZDY0OiBVc2UgY2FjaGVkIGRhdGEgd2hlbiBjaGVja2luZyBmb3IgRUNDDQo+ID4gICBFREFDL2Ft
ZDY0OiBDaGVjayBmb3IgbWVtb3J5IGJlZm9yZSBmdWxseSBpbml0aWFsaXppbmcgYW4gaW5zdGFu
Y2UNCj4gPiAgIEVEQUMvYW1kNjQ6IFNldCBncmFpbiBwZXIgRElNTQ0KPiA+DQo+ID4gIGRyaXZl
cnMvZWRhYy9hbWQ2NF9lZGFjLmMgfCAxOTYgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gPiAgZHJpdmVycy9lZGFjL2FtZDY0X2VkYWMuaCB8ICAgMiArDQo+ID4gIDIg
ZmlsZXMgY2hhbmdlZCwgMTAwIGluc2VydGlvbnMoKyksIDk4IGRlbGV0aW9ucygtKQ0KPiANCj4g
QWxtb3N0IHRoZXJlOiBub3cgaXQgZHVtcHMgdGhlIHdob2xlIHNoZWJhbmcgdHdpY2UuIFRoaXMg
aXMgb24gYW4gb2xkDQo+IEYxMGggYm94IHdoaWNoIGRvZXNuJ3QgaGF2ZSBFQ0MgRElNTXM6DQo+
IA0KPiBbICAgIDIuMjIyODUzXSBFREFDIE1DOiBWZXI6IDMuMC4wDQo+IFsgICAgMi4yMjY4ODFd
IEVEQUMgREVCVUc6IGVkYWNfbWNfc3lzZnNfaW5pdDogZGV2aWNlIG1jIGNyZWF0ZWQNCj4gWyAg
ICA1LjcyNjkxMl0gRURBQyBhbWQ2NDogRjEwaCBkZXRlY3RlZCAobm9kZSAwKS4NCi4uLg0KPiBb
ICAgIDYuMjA4MDg3XSBFREFDIGFtZDY0OiBGMTBoIGRldGVjdGVkIChub2RlIDApLg0KDQpJcyB0
aGUgbW9kdWxlIGJlaW5nIHByb2JlZCB0d2ljZT8gV2UgaGF2ZSB0aGlzIHByb2JsZW0gaW4gZ2Vu
ZXJhbCwgZS5nLiB0aGUNCm1vZHVsZSBnZXRzIGxvYWRlZCBtdWx0aXBsZSB0aW1lcyBvbiBmYWls
dXJlLg0KDQpUaGUgY2x1ZSBmb3IgbWUgaXMgdGhhdCBub2RlIDAgZ2V0cyBkZXRlY3RlZCB0d2lj
ZS4gVGhpcyBpcyBkb25lIGluDQpwZXJfZmFtaWx5X2luaXQoKSBlYXJseSBpbiBwcm9iZV9vbmVf
aW5zdGFuY2UoKS4NCg0KSW4gYW55IGNhc2UsIEkgdGhpbmsgd2UgY2FuIG1ha2UgIWVjY19lbmFi
bGVkKHB2dCkgaW4gcHJvYmVfb25lX2luc3RhbmNlKCkgYQ0KZmFpbHVyZSBub3cgdGhhdCB3ZSBo
YXZlIGFuIGV4cGxpY2l0IGNoZWNrIGZvciBtZW1vcnkgb24gYSBub2RlLiBJbiBvdGhlcg0Kd29y
ZHMsIGlmIHdlIGhhdmUgbWVtb3J5IGFuZCBFQ0MgaXMgZGlzYWJsZWQgdGhlbiB0aGlzIGlzIGEg
ZmFpbHVyZSBmb3IgdGhlDQptb2R1bGUuDQoNClRoYW5rcywNCllhemVuDQo=
