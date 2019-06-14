Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0F64605B
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2019 16:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfFNOOl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Jun 2019 10:14:41 -0400
Received: from mail-eopbgr740053.outbound.protection.outlook.com ([40.107.74.53]:12334
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728913AbfFNOOl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Jun 2019 10:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0wu9xDXyDtT7EogLA/yer6QhrmNMafCIf9keEIa8jE=;
 b=oE82JbZX9l52a+zGaCbhvyCA715cFFC4P9zHQUNIgboNSUbtpDJrtZxQeIYPmQlgeYtzVsz+o4TX1LhJnZIKI+eXucDF88Bl5OTAoeORoaD+9O+Az1+FMAxVOC7mF/V+pHo9csXzACKyoqd1kbVkZXmXUIwgnGxqY46FZJDQ/pk=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2784.namprd12.prod.outlook.com (52.135.107.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.17; Fri, 14 Jun 2019 14:14:39 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1965.019; Fri, 14 Jun 2019
 14:14:39 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/8] EDAC/amd64: Support more than two controllers for
 chip selects handling
Thread-Topic: [PATCH 2/8] EDAC/amd64: Support more than two controllers for
 chip selects handling
Thread-Index: AQHVGArjP8ASCZySEUyWj7FP348Ui6aZtVCAgABvqsCAABgIgIABCSOg
Date:   Fri, 14 Jun 2019 14:14:39 +0000
Message-ID: <SN6PR12MB263902F373B6184FEB563B89F8EE0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190531234501.32826-1-Yazen.Ghannam@amd.com>
 <20190531234501.32826-3-Yazen.Ghannam@amd.com>
 <20190613141715.GD11598@zn.tnic>
 <SN6PR12MB263987AAB225A09527C4D736F8EF0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190613222255.GH11598@zn.tnic>
In-Reply-To: <20190613222255.GH11598@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.25.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfc3c572-9bd9-42b9-a289-08d6f0d2a36a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2784;
x-ms-traffictypediagnostic: SN6PR12MB2784:
x-microsoft-antispam-prvs: <SN6PR12MB2784F61BB411EBED2A8CE6A0F8EE0@SN6PR12MB2784.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(366004)(39860400002)(13464003)(189003)(199004)(86362001)(4326008)(25786009)(2906002)(4744005)(6246003)(53936002)(71190400001)(54906003)(33656002)(256004)(102836004)(71200400001)(316002)(76176011)(66556008)(99286004)(7696005)(3846002)(66946007)(66476007)(73956011)(66066001)(66446008)(64756008)(6116002)(76116006)(6506007)(53546011)(9686003)(8936002)(81166006)(81156014)(8676002)(186003)(26005)(55016002)(6916009)(74316002)(5660300002)(229853002)(11346002)(446003)(305945005)(52536014)(7736002)(6436002)(486006)(68736007)(476003)(478600001)(14454004)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2784;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jg3hQzlxM+GjyKztjWZVhOY7RJZEGrPmtuwAFMvCBRpeGNAjtKJfRvmSoQEvH2AOxfcP5GFQ+EUwhQ5Q8lxHjPvlo4je7/R0c72x6iWpfoVQkhUZ/rs+3OLSpmhN+RBDyW6SVTkte9GlTAl7Lh+Th2GeOk6sIpX7+ZgihtiWatytZtr41a8BLSQYVk+fZivApQtlj1usxwEDwlG62yJ6VfCz+K1zqByC44P3n8HQGIHJWC25nNU/0dYLdEWrNuXtmHOAohqmvKv53OKTyfqlVEcFstANpA/wE1wJV3ptLE3gc0GKVYK3onUHyOjQWmOoaBk5Ua4/wK3hWzkFRsUR6EYmmBxbydznXAKMmMrf0p3fzKloxciD95X/lq+71jR9NgQkBikwVZf1StI/JSLx+JvjA2n0kQBy/nYXN41fqPA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc3c572-9bd9-42b9-a289-08d6f0d2a36a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 14:14:39.2938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2784
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1rZXJuZWwtb3duZXJA
dmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWwtb3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBC
ZWhhbGYgT2YgQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDEzLCAyMDE5
IDU6MjMgUE0NCj4gVG86IEdoYW5uYW0sIFlhemVuIDxZYXplbi5HaGFubmFtQGFtZC5jb20+DQo+
IENjOiBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvOF0gRURBQy9hbWQ2NDogU3VwcG9ydCBtb3Jl
IHRoYW4gdHdvIGNvbnRyb2xsZXJzIGZvciBjaGlwIHNlbGVjdHMgaGFuZGxpbmcNCj4gDQo+IE9u
IFRodSwgSnVuIDEzLCAyMDE5IGF0IDA4OjU4OjE2UE0gKzAwMDAsIEdoYW5uYW0sIFlhemVuIHdy
b3RlOg0KPiA+IFRoZSBmaXJzdCBwYXRjaCBpcyBtZWFudCBhcyBhIGZpeCBmb3IgZXhpc3Rpbmcg
c3lzdGVtcywgYW5kIHRoaXMgcGF0Y2gNCj4gPiBpcyB0byBhZGQgbmV3IGZ1bmN0aW9uYWxpdHku
DQo+ID4NCj4gPiBJIGNhbiBtZXJnZSB0aGVtIHRvZ2V0aGVyIGlmIHlvdSB0aGluayB0aGF0J3Mg
bW9yZSBhcHByb3ByaWF0ZS4NCj4gDQo+IElzIGl0IGZpeGluZyBzdWNoIGEgY3JpdGljYWwgaXNz
dWUgdGhhdCBpdCBuZWVkcyB0byBiZSBhIHNlcGFyYXRlIHBhdGNoPw0KPiBJZiBzbywgaXQgc2hv
dWxkIGJlIENDOnN0YWJsZS4NCj4gDQo+IEJ1dCBJIHRoaW5rIHdlJ3ZlIHN1cnZpdmVkIHdpdGhv
dXQgaXQganVzdCBmaW5lIHNvIHdoeSBib3RoZXIuIEJ1dCBtYXliZQ0KPiB0aGVyZSdzIGFuIGFz
cGVjdCBJJ20gbWlzc2luZy4uLg0KPiANCg0KTm8sIHlvdSdyZSByaWdodC4gSXQncyBub3Qgc29t
ZXRoaW5nIGNyaXRpY2FsLg0KDQpJIGNhbiBzcXVhc2ggdGhlc2UgdHdvIHBhdGNoZXMgdG9nZXRo
ZXIgaWYgeW91J2QgbGlrZS4NCg0KVGhhbmtzLA0KWWF6ZW4NCg==
