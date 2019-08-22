Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73D1F99F3B
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2019 20:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbfHVSzL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Aug 2019 14:55:11 -0400
Received: from mail-eopbgr710059.outbound.protection.outlook.com ([40.107.71.59]:35894
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726142AbfHVSzL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 22 Aug 2019 14:55:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyyTJXNheRLELqPHSlyD6h3YHE9cTts0BeF6j4NNeUeRxUSR6Gdfrf0uGCuBKGk6Y6xiDT+450ajoBs2CBVyXMy46KQ0D/MXulnnTTHdvZpGopKfe0pt+hB+aAVN4lrDWQxw+G7CCXfK/0aLQ5rJ2vcItUeu3TK4JAaibCl4NiZtugwxorXuIs07UOY9ya+tYUbWrbx7hQRrWRkn2onIN+LUkA9wx3ZN9k8GTJGl1t/yf+W3IhwEyCjIVEaVrngTeGcFfZ8IlrEfr927vBExVydj9K2lnjogU+cU0L0r5mO5y3XObXO65US28e/j6tbGXRo1nBUUKnu+xMFsTisD/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkQNkTgjmLySsWXyTkUdidmmUNrmcsWkSafTxbf8t0o=;
 b=Q+UnonQVVgZ0T7q2/umcNcWliQST9ckRlUtu+qTUDyti1Lq87uzZain7TJGB+fvgGwJtwQOS+GUT3PN+5Y+4C6UshMeuaQWH++munotP/laY97XmZmPqffOi4Dsr3tVV8hSC6BpzHzfFEf2pZlV+23csZd1/6ecBwkmBCs9lD0QYbeBiarTc7+hsAPBO9mxrj2pYzpOe4m3+1kVBmjv8h60/9B2MF7NLerRdSQqQm2qRk9Bj/b0+5wsCvD8BoTCD8AhQVLRP+1I2RbncOR0M78gVBywM9BZ+JJakkFc9+ynjmLqfuHiRbe5sS0KrPFdMAQHKMFlJoqZze65YZgEz7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkQNkTgjmLySsWXyTkUdidmmUNrmcsWkSafTxbf8t0o=;
 b=UK2aXsc4o0DPFRTii99BtrELedIhyoUDuM4ExY0cfLPXqV6mq21gk7WJ1b8DcjTqODPFL+Wa1Vj0tQEjVLUcD+4w0KzQTl1aY16Ehs8Hx9zNfvzIGRUc85AtfVaw8UrkRsD3URST0wzRbpWSq9Rtf98f+iWhVvoyb+MvW+I8Ru8=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2717.namprd12.prod.outlook.com (52.135.103.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 18:54:29 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53%2]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 18:54:29 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Adam Borowski <kilobyte@angband.pl>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: RE: [PATCH v3 0/8] AMD64 EDAC fixes
Thread-Topic: [PATCH v3 0/8] AMD64 EDAC fixes
Thread-Index: AQHVWHyGkq5ZZJpNOUKXQmjNKGyrbqcGViwAgAEuRFA=
Date:   Thu, 22 Aug 2019 18:54:29 +0000
Message-ID: <SN6PR12MB2639CD6D755B6FFCF5C4B756F8A50@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
 <20190822005020.GA403@angband.pl>
In-Reply-To: <20190822005020.GA403@angband.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53725839-ffee-49b5-e4eb-08d7273229b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR12MB2717;
x-ms-traffictypediagnostic: SN6PR12MB2717:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2717C99FCE4D9B181DA472F6F8A50@SN6PR12MB2717.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(189003)(199004)(54094003)(13464003)(7736002)(66066001)(53546011)(486006)(7696005)(6506007)(53936002)(66476007)(76176011)(8936002)(66946007)(66446008)(26005)(5660300002)(6916009)(54906003)(102836004)(14454004)(76116006)(55016002)(186003)(52536014)(316002)(966005)(478600001)(64756008)(66556008)(4326008)(6306002)(25786009)(6246003)(99286004)(6436002)(81166006)(14444005)(71190400001)(71200400001)(9686003)(229853002)(33656002)(86362001)(8676002)(446003)(11346002)(81156014)(74316002)(2906002)(3846002)(256004)(476003)(6116002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2717;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lCAvnJyj95Fv3Zi2B9rdjHic6/7dbKQun56ahrt8FA00hullzmuhLxUOV0EXyZ5sEKAEvik/ZwlbUSl0+gTy8Gbg9nIUj1xvcvlRAY3S7sis61D06T9SCQq6IQIwAederEPz2ClJrkmaA5IImjHmtAs/Ys2nViCH4O8uB/pYEKbRNu5nDurCTdn+WEF3gWu4M6CcE8aO7dD/+hWTKOecKXcCps5clNf0YCq/C48p98xN93UMHNOJYxGzLuk0KtiAJGm3O9R0X9nwG7tDJ+WIKiboiG/AzDsx38O7CHgZ+qTsWpAdZNun77lyyQLuWqOs1AATu3wXHjQUI1cn6mR5h2glv20zaRbR7u2S2pfXyw7nTuqN9LfCApo78B4bDiYlDOgfnj/Ry8/NwtWJFT8sV3FLKDUJTfLsfjeIW0WHUYU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53725839-ffee-49b5-e4eb-08d7273229b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 18:54:29.6398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GHIC0ISenVbpBD6L7O0/nKAxRmGlirUlGfCql6gF0Znz0kTJCRFuSdmoOb9UamCYF8zVAQMjPY0ZqaGoNZy9FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2717
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBBZGFtIEJvcm93c2tpDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDIxLCAyMDE5IDc6
NTAgUE0NCj4gVG86IEdoYW5uYW0sIFlhemVuIDxZYXplbi5HaGFubmFtQGFtZC5jb20+DQo+IENj
OiBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgYnBAYWxpZW44LmRlDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC84XSBBTUQ2NCBFREFD
IGZpeGVzDQo+IA0KPiBPbiBXZWQsIEF1ZyAyMSwgMjAxOSBhdCAxMTo1OTo1M1BNICswMDAwLCBH
aGFubmFtLCBZYXplbiB3cm90ZToNCj4gPiBJJ3ZlIGFsc28gYWRkZWQgUkZDIHBhdGNoZXMgdG8g
YXZvaWQgdGhlICJFQ0MgZGlzYWJsZWQiIG1lc3NhZ2UgZm9yDQo+ID4gbm9kZXMgd2l0aG91dCBt
ZW1vcnkuIEkgaGF2ZW4ndCBmdWxseSB0ZXN0ZWQgdGhlc2UsIGJ1dCBJIHdhbnRlZCB0byBnZXQN
Cj4gPiB5b3VyIHRob3VnaHRzLiBIZXJlJ3MgYW4gZWFybGllciBkaXNjdXNzaW9uOg0KPiA+IGh0
dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAxODAzMjExOTEzMzUuNzgzMi0xLVlhemVuLkdoYW5u
YW1AYW1kLmNvbQ0KPiANCj4gV2hpbGUgeW91J3JlIGVkaXRpbmcgdGhhdCBjb2RlLCBjb3VsZCB5
b3UgcGxlYXNlIGFsc28gY3V0IHRoZSBzcGFtIGlmIEVDQyBpcw0KPiBhY3R1YWxseSBkaXNhYmxl
ZD8gIEZvciBleGFtcGxlLCBhIDI5OTBXWCB3aXRoIG5vbi1FQ0MgUkFNIGdldHMgMTAyNCBsaW5l
czsNCj4gNjQgY29waWVzIG9mOg0KPiANCj4gWyAgICA4LjE4NjE2NF0gRURBQyBhbWQ2NDogTm9k
ZSAwOiBEUkFNIEVDQyBkaXNhYmxlZC4NCj4gWyAgICA4LjE4ODM2NF0gRURBQyBhbWQ2NDogRUND
IGRpc2FibGVkIGluIHRoZSBCSU9TIG9yIG5vIEVDQyBjYXBhYmlsaXR5LCBtb2R1bGUgd2lsbCBu
b3QgbG9hZC4NCj4gICAgICAgICAgICAgICAgIEVpdGhlciBlbmFibGUgRUNDIGNoZWNraW5nIG9y
IGZvcmNlIG1vZHVsZSBsb2FkaW5nIGJ5IHNldHRpbmcgJ2VjY19lbmFibGVfb3ZlcnJpZGUnLg0K
PiAgICAgICAgICAgICAgICAgKE5vdGUgdGhhdCB1c2Ugb2YgdGhlIG92ZXJyaWRlIG1heSBjYXVz
ZSB1bmtub3duIHNpZGUgZWZmZWN0cy4pDQo+IFsgICAgOC4xOTQ3NjJdIEVEQUMgYW1kNjQ6IE5v
ZGUgMTogRFJBTSBFQ0MgZGlzYWJsZWQuDQo+IFsgICAgOC4xOTYzMDddIEVEQUMgYW1kNjQ6IEVD
QyBkaXNhYmxlZCBpbiB0aGUgQklPUyBvciBubyBFQ0MgY2FwYWJpbGl0eSwgbW9kdWxlIHdpbGwg
bm90IGxvYWQuDQo+ICAgICAgICAgICAgICAgICBFaXRoZXIgZW5hYmxlIEVDQyBjaGVja2luZyBv
ciBmb3JjZSBtb2R1bGUgbG9hZGluZyBieSBzZXR0aW5nICdlY2NfZW5hYmxlX292ZXJyaWRlJy4N
Cj4gICAgICAgICAgICAgICAgIChOb3RlIHRoYXQgdXNlIG9mIHRoZSBvdmVycmlkZSBtYXkgY2F1
c2UgdW5rbm93biBzaWRlIGVmZmVjdHMuKQ0KPiBbICAgIDguMTk5ODQwXSBFREFDIGFtZDY0OiBO
b2RlIDI6IERSQU0gRUNDIGRpc2FibGVkLg0KPiBbICAgIDguMjAwOTYzXSBFREFDIGFtZDY0OiBF
Q0MgZGlzYWJsZWQgaW4gdGhlIEJJT1Mgb3Igbm8gRUNDIGNhcGFiaWxpdHksIG1vZHVsZSB3aWxs
IG5vdCBsb2FkLg0KPiAgICAgICAgICAgICAgICAgRWl0aGVyIGVuYWJsZSBFQ0MgY2hlY2tpbmcg
b3IgZm9yY2UgbW9kdWxlIGxvYWRpbmcgYnkgc2V0dGluZyAnZWNjX2VuYWJsZV9vdmVycmlkZScu
DQo+ICAgICAgICAgICAgICAgICAoTm90ZSB0aGF0IHVzZSBvZiB0aGUgb3ZlcnJpZGUgbWF5IGNh
dXNlIHVua25vd24gc2lkZSBlZmZlY3RzLikNCj4gWyAgICA4LjIwNDMyNl0gRURBQyBhbWQ2NDog
Tm9kZSAzOiBEUkFNIEVDQyBkaXNhYmxlZC4NCj4gWyAgICA4LjIwNTQzNl0gRURBQyBhbWQ2NDog
RUNDIGRpc2FibGVkIGluIHRoZSBCSU9TIG9yIG5vIEVDQyBjYXBhYmlsaXR5LCBtb2R1bGUgd2ls
bCBub3QgbG9hZC4NCj4gICAgICAgICAgICAgICAgIEVpdGhlciBlbmFibGUgRUNDIGNoZWNraW5n
IG9yIGZvcmNlIG1vZHVsZSBsb2FkaW5nIGJ5IHNldHRpbmcgJ2VjY19lbmFibGVfb3ZlcnJpZGUn
Lg0KPiAgICAgICAgICAgICAgICAgKE5vdGUgdGhhdCB1c2Ugb2YgdGhlIG92ZXJyaWRlIG1heSBj
YXVzZSB1bmtub3duIHNpZGUgZWZmZWN0cy4pDQo+IA0KDQpJIHdvbmRlciBpZiB0aGUgbW9kdWxl
IGlzIGJlaW5nIGxvYWRlZCBtdWx0aXBsZSB0aW1lcy4gSSdsbCB0cnkgdG8gcmVwcm9kdWNlIHRo
aXMgYW5kIHRyYWNrIGl0IGRvd24uDQoNClRoYW5rcyBmb3IgdGVzdGluZyBhbmQgcmVwb3J0aW5n
IHRoaXMgaXNzdWUuDQoNCi1ZYXplbg0K
