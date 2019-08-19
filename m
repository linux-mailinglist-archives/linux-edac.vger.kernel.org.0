Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 171D394ECC
	for <lists+linux-edac@lfdr.de>; Mon, 19 Aug 2019 22:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfHSUUB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Aug 2019 16:20:01 -0400
Received: from mail-eopbgr800075.outbound.protection.outlook.com ([40.107.80.75]:39072
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727769AbfHSUUB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 19 Aug 2019 16:20:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TA8LI+tIOoAbHzJbopHcb+/fzNxgnwqIFxs3vhLuhredojCo2A8iKwFqwFPzZFWUQeZ1lgn7P96QuBMF1XRVFEqqyKH5WaDyf595r+IvyCX07dp7ojtcyStfxm//azQP+OfSV56RTpiiwZwmK7IhE0VcGbk72yQF5SGCEg/EPirsSX1CuQlNLcCftDVplXXQ/5A+IoOn6SZs+ZLbaIjUQ3DAiCIC2Ygj9ftTuyohnMm686edYk9emMXcr9RrGABoKN8psKO0WOnYEPBaBL3Wc93a/l5Gpcj8bZ/wmmRhYXStPg323+zZr4kl4Gslz7jSCigE0nRMIm60992gxHfbFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bkMgzICxv60XiEkSQCkKGtql2IvspGDw/PQxymqzsQ=;
 b=b46YFH/LIW99ncjzitbLc6dILSNG8oGPeSYkrUZrIySgkaDDu/FST10M+yXNQQ+RakdI0BdAqTgBM+6AG5Jd4ux6b4GLbZef+8AWK2I7sG/oqN9gP2ZgGQczbWqerggXVyhyITDwHjxldxezB27VjdifvxEtMIdJgO92Dg18CjhbMcHl0y/iTBwHl13fdDLg+jfAlooK3XDViLsp2vqg6W/v7P6nrU8aDOtpE7tRqx8lgf4yryuLQlDj5tK0C5NX7W7fV59e6mEYS2g/z1x6kmrSGdIfTLGyi2NjCDsLPLY52N6KHeukb+XEaEl/fB1e2pZRhDVwCQGgPqlASZxeDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bkMgzICxv60XiEkSQCkKGtql2IvspGDw/PQxymqzsQ=;
 b=sZkOv5PBXR5gUNVK86MPuY1xKGEtbUuWHPcflCQt6U8g6AA75DP0qOEUiJ/r0LGwmZXXCNjUU6f/Y5xIvDRzq+ONFz+VBna4/UsoSy3NlCggy3qVw0duHmYg29jABMprqE/AuBwoKnjAod63IvZCU/dXLARdeim+JBf0cAJphmA=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2640.namprd12.prod.outlook.com (52.135.103.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 20:19:16 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53%2]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 20:19:16 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/7] EDAC/amd64: Recognize DRAM device type with
 EDAC_CTL_CAP
Thread-Topic: [PATCH v2 2/7] EDAC/amd64: Recognize DRAM device type with
 EDAC_CTL_CAP
Thread-Index: AQHVNqE5pOXYz88VFEqxtA4lZ5p0QabnnmMAgBuAj4A=
Date:   Mon, 19 Aug 2019 20:19:16 +0000
Message-ID: <SN6PR12MB26397171F6D504EE1F6F09FBF8A80@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190709215643.171078-1-Yazen.Ghannam@amd.com>
 <20190709215643.171078-3-Yazen.Ghannam@amd.com>
 <20190802074224.GB30661@zn.tnic>
In-Reply-To: <20190802074224.GB30661@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [2601:3c2:8280:2327:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e266664-db5d-4cf1-5b2e-08d724e28294
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2640;
x-ms-traffictypediagnostic: SN6PR12MB2640:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2640DFA5E4A335B6710D1EB8F8A80@SN6PR12MB2640.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(189003)(199004)(13464003)(6116002)(446003)(71190400001)(2906002)(86362001)(74316002)(8936002)(305945005)(71200400001)(8676002)(6916009)(7736002)(6436002)(33656002)(55016002)(9686003)(256004)(6306002)(229853002)(14444005)(966005)(66946007)(76116006)(76176011)(14454004)(5660300002)(66446008)(64756008)(66556008)(66476007)(7696005)(99286004)(46003)(478600001)(25786009)(52536014)(476003)(316002)(53546011)(6506007)(81166006)(81156014)(11346002)(54906003)(102836004)(6246003)(4326008)(186003)(53936002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2640;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2n9db2gT9oGhnbIiWLoh8O3Aeznbz7Id6tawIqVEw9xUVwObAeE/+AzGFyjEykMYANQbH2TlRfv3i8soo8LGLbzKbG+GCu4v+v3F6QphxXf5GB207eDPPRC1CQ+8ae8lhVNjyo2GPjUYw1vFn1pJsQudX5Rh7t63JaZqZ7Lrj/wK1GtVXkfhlOLciyMSzRp6wxfoGwPWKE5ONeZmFeZH4HNqe/SvO3ag4VMdTANF49DOBy4Wwu6//3TNoq62AmXpSeto73by02WCbm2EOfm+xBLcOmDx4aIDjknmo/ZA0oVDN4ri69U/evwDFZHCUmz/f/gWnkcwAz+uT2uL1KvAzlW8KV1A4Bq1gsEJpql0y1CjW66WMdtLxM2Os0tIg2qRK/k3l8NNnMTe6TbHCUuiF7R9FwGMMMfSR3anq8rTTGM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e266664-db5d-4cf1-5b2e-08d724e28294
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 20:19:16.6664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWc3gnmhhdWtz4oBOqs2jlKlCliavp8ticifzn3h2tF+JrNi3I8+1H0g6JhgwpaVKdmFoWmd+DQAwiySQfidTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2640
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMiwgMjAxOSAyOjQy
IEFNDQo+IFRvOiBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0KPiBDYzog
bGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzddIEVEQUMvYW1kNjQ6IFJlY29nbml6ZSBEUkFN
IGRldmljZSB0eXBlIHdpdGggRURBQ19DVExfQ0FQDQo+IA0KPiBPbiBUdWUsIEp1bCAwOSwgMjAx
OSBhdCAwOTo1Njo1NVBNICswMDAwLCBHaGFubmFtLCBZYXplbiB3cm90ZToNCj4gPiBGcm9tOiBZ
YXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+ID4NCj4gPiBBTUQgRmFtaWx5
IDE3aCBzeXN0ZW1zIHN1cHBvcnQgeDQgYW5kIHgxNiBEUkFNIGRldmljZXMuIEhvd2V2ZXIsIHRo
ZQ0KPiA+IGRldmljZSB0eXBlIGlzIG5vdCBjaGVja2VkIHdoZW4gc2V0dGluZyBFREFDX0NUTF9D
QVAuDQo+ID4NCj4gPiBTZXQgdGhlIGFwcHJvcHJpYXRlIEVEQUNfQ1RMX0NBUCBmbGFnIGJhc2Vk
IG9uIHRoZSBkZXZpY2UgdHlwZS4NCj4gPg0KPiA+IEZpeGVzOiAyZDA5ZDhmMzAxZjUgKCJFREFD
LCBhbWQ2NDogRGV0ZXJtaW5lIEVEQUMgTUMgY2FwYWJpbGl0aWVzIG9uIEZhbTE3aCIpDQo+IA0K
PiBUaGlzIGlzIGJldHRlcjogYSBwYXRjaCB3aGljaCBmaXhlcyBhIHByZXZpb3VzIHBhdGNoIGFu
ZCBpcyBzaW1wbGUsDQo+IHNtYWxsIGFuZCBjbGVhci4gVGhhdCB5b3UgY2FuIHRhZyB3aXRoIEZp
eGVzOiBqdXN0IGZpbmUuDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFlhemVuIEdoYW5uYW0gPHlh
emVuLmdoYW5uYW1AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiBMaW5rOg0KPiA+IGh0dHBzOi8vbGtt
bC5rZXJuZWwub3JnL3IvMjAxOTA1MzEyMzQ1MDEuMzI4MjYtNC1ZYXplbi5HaGFubmFtQGFtZC5j
b20NCj4gPg0KPiA+IHYxLT52MjoNCj4gPiAqIE5vIGNoYW5nZS4NCj4gPg0KPiA+ICBkcml2ZXJz
L2VkYWMvYW1kNjRfZWRhYy5jIHwgMTMgKysrKysrKysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5jIGIvZHJpdmVycy9lZGFjL2FtZDY0X2VkYWMuYw0K
PiA+IGluZGV4IGRkNjBjZjVhM2Q5Ni4uMTI1ZDZlMmE4MjhlIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmMNCj4gPiArKysgYi9kcml2ZXJzL2VkYWMvYW1kNjRfZWRh
Yy5jDQo+ID4gQEAgLTMxNTAsMTIgKzMxNTAsMTUgQEAgc3RhdGljIGJvb2wgZWNjX2VuYWJsZWQo
c3RydWN0IHBjaV9kZXYgKkYzLCB1MTYgbmlkKQ0KPiA+ICBzdGF0aWMgaW5saW5lIHZvaWQNCj4g
PiAgZjE3aF9kZXRlcm1pbmVfZWRhY19jdGxfY2FwKHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSwg
c3RydWN0IGFtZDY0X3B2dCAqcHZ0KQ0KPiA+ICB7DQo+ID4gLQl1OCBpLCBlY2NfZW4gPSAxLCBj
cGtfZW4gPSAxOw0KPiA+ICsJdTggaSwgZWNjX2VuID0gMSwgY3BrX2VuID0gMSwgZGV2X3g0ID0g
MSwgZGV2X3gxNiA9IDE7DQo+ID4NCj4gPiAgCWZvcl9lYWNoX3VtYyhpKSB7DQo+ID4gIAkJaWYg
KHB2dC0+dW1jW2ldLnNkcF9jdHJsICYgVU1DX1NEUF9JTklUKSB7DQo+ID4gIAkJCWVjY19lbiAm
PSAhIShwdnQtPnVtY1tpXS51bWNfY2FwX2hpICYgVU1DX0VDQ19FTkFCTEVEKTsNCj4gPiAgCQkJ
Y3BrX2VuICY9ICEhKHB2dC0+dW1jW2ldLnVtY19jYXBfaGkgJiBVTUNfRUNDX0NISVBLSUxMX0NB
UCk7DQo+ID4gKw0KPiA+ICsJCQlkZXZfeDQgJj0gISEocHZ0LT51bWNbaV0uZGltbV9jZmcgJiBC
SVQoNikpOw0KPiA+ICsJCQlkZXZfeDE2ICY9ICEhKHB2dC0+dW1jW2ldLmRpbW1fY2ZnICYgQklU
KDcpKTsNCj4gDQo+IEFyZSB0aG9zZSBiaXRzIG11dHVhbGx5IGV4Y2x1c2l2ZT8NCj4gDQo+IEku
ZS4sIHNvIHRoYXQgeW91IGNhbiBkbzoNCj4gDQo+IAlpZiAoZGV2X3g0KQ0KPiAJCW1jaS0+ZWRh
Y19jdGxfY2FwIHw9IEVEQUNfRkxBR19TNEVDRDRFRDsNCj4gCWVsc2UNCj4gCQltY2ktPmVkYWNf
Y3RsX2NhcCB8PSBFREFDX0ZMQUdfUzE2RUNEMTZFRDsNCj4gDQo+ID8NCj4gDQoNCkkgZG9uJ3Qg
dGhpbmsgc28uIEkgYmVsaWV2ZSB0aGV5IGNhbiBib3RoIGJlIHplcm8uIEknbGwgdmVyaWZ5IGFu
ZCBtYWtlIHRoZSBjaGFuZ2UgaWYgdGhleSBhcmUgbXV0dWFsbHkgZXhjbHVzaXZlLg0KDQpUaGFu
a3MsDQpZYXplbg0KDQo=
