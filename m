Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B78D3115
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 21:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfJJTAW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 15:00:22 -0400
Received: from mail-eopbgr690052.outbound.protection.outlook.com ([40.107.69.52]:59118
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726387AbfJJTAV (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 15:00:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+ifiBjspcMWHVJyea2+m/YOBXCocpzWg+eC6+X4DpoGd9PK+hqFPrObimGOBBENOPaDLsIYiY86D5+iZozOGdXgO6vbLiVNOon70n2o0HZSjcaV4GC7gtk5BL2L9kGTmNYeau5boE3eo50NeydU+EHppoo/7fIDkvNPAxj6+K/JKtzAbpHBpP/r5bMZ0b1nN+tLkIyBe0bsZ7zLDAFou3elMOeMEnOqssin/IuALS2XO56nCbPTeA3vNK2mYEhZjGuafUJk7pfJwNmf2m5GA3IZvftF7vQqXBkyAX9LADEsuH7UmLgCjSBRA+L+278NXOWSn3f5kLFyy9yaibkPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWNIGEe2u892NnhBOUI+zSMdn9Y4ZpO/cOjRcQMdMTI=;
 b=RJwQa6OAEOlSJVWpvmGKF7LuvP3dq2qqbjj6sBHkEBRXz0vC8RL28lBYpnfqipuNuNY6GkG3CpqfzPi6BvzELRuP7maY/mqSX3CUPNZgVF+djMaABNPXtKqoLJEvw2b9cPi30HOqLvLtK+qk5iY2KwTEjtYSpi0jgWKaZzmvJAzb/cmO3KX/d1JeuWz/JVWVkZ1ZHqkhxvtAXvD9KCjXWCh26R5H4Hkspach+zSUDwvzsq9j6ftMU0OpqEZ/DTQI/DavrllqWCa8V+d/h3ZM2fEPYkTA33ULUDFIwADPPXpDCqlz9IGjdiSQpwtbf1d94uRJ2LBhHtiRg0X8ZU8djw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWNIGEe2u892NnhBOUI+zSMdn9Y4ZpO/cOjRcQMdMTI=;
 b=TqTRT2tTS+V29pbHdvGeD9qcYGyC7kCQ1FOYw8XQhK2cWtWl2azjMNwg/ys1XhFMGBBvoeF1bnHRNhOl866MRqbc0dwVQBTWH3NHahUVh1slSBg9yCdQdNTFNTHwBQvQtbpRFczuIEhfr4iiq7mPC5kjkCX4jfCzx0M2pc9jUtE=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2750.namprd12.prod.outlook.com (52.135.107.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 19:00:18 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8%7]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 19:00:18 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        Jean-Frederic <jfgaudreault@gmail.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h support
Thread-Topic: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h
 support
Thread-Index: AQHVe51JKTDxmyKbykahkp73y8AC1qdOxx+AgABffACAAX9igIAAg6EAgAA5tACAAL6mgIAAp9WAgAA40oCAAKg4AIAAL+sAgAAO2ACAAFkOAA==
Date:   Thu, 10 Oct 2019 19:00:18 +0000
Message-ID: <60b68d6c-5aff-3e7c-9461-c26a5f28cd87@amd.com>
References: <20191007071502.GA24289@zn.tnic>
 <CAEVokG51DtL1g+9YFK6RE=3m-wtjV1VN=vV56b5-3=K21=Jmrw@mail.gmail.com>
 <20191008115041.GD14765@zn.tnic>
 <678ba7d1-cf3d-4101-1819-29b291cf236d@amd.com>
 <CAEVokG4SSkgWS2N8eqr+h7AJg9CF26OW7vtXwOurCGU-4dsLbw@mail.gmail.com>
 <20191009103041.GC10395@zn.tnic>
 <724d6f97-61f2-94bd-3f4b-793a55b6ac15@amd.com>
 <CAEVokG4T5q8PBmf4=vLjPWQjzL_Xwu6yF81=mLjkpoJSoCggkw@mail.gmail.com>
 <20191010095650.GC7658@zn.tnic>
 <9f3ce002-7380-0e93-7bd5-20bb944d0b77@gmail.com>
 <20191010134128.GF7658@zn.tnic>
In-Reply-To: <20191010134128.GF7658@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR18CA0006.namprd18.prod.outlook.com
 (2603:10b6:404:121::16) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.25.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ade2e7b8-a89c-46f6-c3d8-08d74db417a4
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2750:
x-microsoft-antispam-prvs: <SN6PR12MB275016134B09DE0A220B6477F8940@SN6PR12MB2750.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(199004)(189003)(7736002)(53546011)(36756003)(486006)(14454004)(6116002)(476003)(2616005)(31686004)(11346002)(6506007)(478600001)(25786009)(446003)(3846002)(26005)(64756008)(66556008)(102836004)(66946007)(76176011)(99286004)(52116002)(66476007)(66446008)(2906002)(186003)(305945005)(386003)(316002)(6512007)(31696002)(110136005)(229853002)(6436002)(8676002)(8936002)(81166006)(81156014)(256004)(71190400001)(71200400001)(6246003)(86362001)(4326008)(66066001)(5660300002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2750;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DTfeR2gFU8WNbtvHNarhZOKL4cNqiSERnpj65tX50DBdybJqRvTR3HedRFAnyh3Iy9LKBGfaC6BCBfkasM4HRzGUH+ryRoyHqOFge2ObzWokfrBiUvq+4SgT3/qoEMSRxYZ+LQCozinF7syEUdP+ZLrQt0Bzq9Xe8YklxR8netzixbboIarOHKO7adXWuMXj+PLZEdQV4bLFHfSRu+520s1yCQH3McunhH4/svSTvDHo5IaqEr+kmGjk5cpgE7KdRjK9aayvD5uN4OwqY/XCkr/bjuREz6httVYsTqWQ7Bt0HHEtqrZWw8ItoXsToUOoysfSvijnWnEtmnYmhhH2EsdcrjM1BYbzyh0wFUrUGNDdW3UT6P8TnYFRlza2V5EaZimAw2ybeECI55vjkqdDo/6bXoLGoaiiu0O9n5JHJs4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <29CAEFEEE4F3C8449673DAE8CCC766DC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade2e7b8-a89c-46f6-c3d8-08d74db417a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 19:00:18.4299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: teQIIm0Ozk3mvY7rmgbv0bRDAU73JRq1Sq83gtaQGkul3Uj5ffefK+tlbLt4JchCxRC7hGzikQaqqa+48T9rCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2750
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gMTAvMTAvMjAxOSA5OjQxIEFNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+IE9uIFRodSwg
T2N0IDEwLCAyMDE5IGF0IDA4OjQ4OjIwQU0gLTA0MDAsIEplYW4tRnJlZGVyaWMgd3JvdGU6DQo+
PiBJIGRpZCByZWNoZWNrIGFsbCBtZW51cyBpbiBhZHZhbmNlZCBtb2RlIHNldmVyYWwgdGltZXMu
IEkgdXNlZCBteSBiaW9zDQo+PiBmYWlybHkgb2Z0ZW4gd2hlbiBJIGdvdCB0aGlzIG5ldyBzeXN0
ZW0sIEkgd291bGQgYWxzbyBoYXZlIHNlZW4gaXQNCj4+IGJlZm9yZSBJIHdvdWxkIHRoaW5rLg0K
PiANCj4gSSBoYXZlIHRoZSBmYWludCBzdXNwaWNpb24gdGhhdCBvdXIgcGVyZmVjdGx5IGNhcGFi
bGUgQklPUyB3cml0ZXJzDQo+IGZvcmdvdCB0byBhZGQgYSBkaXNhYmxlIGZ1bmN0aW9uYWxpdHku
IExldCdzIHNlZSB3aGF0IFlhemVuIGZpbmRzIG91dA0KPiBmaXJzdCwgdGhvdWdoLg0KPiANCg0K
SSBiZWxpZXZlIFBGRUggaXMgZ2VuZXJhbGx5IGdlYXJlZCB0b3dhcmRzIGVudGVycHJpc2UgdXNl
cnMgd2hpY2ggaXMgd2h5IEkNCnJlbWVtYmVyZWQgaXQgb25jZSB5b3UgbWVudGlvbmVkIHlvdXIg
c3lzdGVtIGlzIEVQWUMuIEkgZG9uJ3QgcmVhbGx5IGtub3cgaWYNCml0J3MgYmVpbmcgdXNlZCBm
b3IgZGVza3RvcC9jbGllbnQgc3lzdGVtcy4gT2YgY291cnNlLCBpdCdzIHVwIHRvIHRoZSB2ZW5k
b3INCndoaWNoIGZlYXR1cmVzIHRoZXkgY2hvb3NlIHRvIGltcGxlbWVudC4gSSBoYXZlbid0IHNl
ZW4gaXQgaW4gdGhlIGNsaWVudA0KZG9jdW1lbnRhdGlvbiB0aG91Z2guDQoNClRoZXJlJ3Mgbm8g
ZXhwbGljaXQgd2F5IHRvIGNoZWNrIGlmIFBGRUggaXMgZW5hYmxlZCBmcm9tIHRoZSBrZXJuZWwu
IFRoZQ0KZmVhdHVyZSBpcyBtZWFudCB0byBiZSB0cmFuc3BhcmVudCB0byB0aGUgT1MuDQoNCkhv
d2V2ZXIsIE1DQV9NSVNDMCB3aWxsIGJlIFJlYWQtYXMtWmVyby9Xcml0ZXMtSWdub3JlZCBmb3Ig
YWxsIE1DQSBiYW5rcyB3aGVuDQpQRkVIIGlzIGVuYWJsZWQuIFNvIHlvdSBjYW4gdXNlIHRoaXMg
YXMgYW4gaW1wbGljaXQgY2hlY2suIFRoaXMgaXMganVzdCBhbg0KaW1wbGVtZW50YXRpb24gZGV0
YWlsIHRob3VnaCBmb3IgY3VycmVudCBzeXN0ZW1zLiBJdCdzIG5vdCBhbiBhcmNoaXRlY3R1cmFs
DQpyZXF1aXJlbWVudC4NCg0KSmVhbi1GcmVkZXJpYywNClBsZWFzZSBkbyB0aGUgZm9sbG93aW5n
IGlmIHlvdSdkIGxpa2UgdG8gdHJ5IHRoaXMgY2hlY2s6DQoxKSByZG1zciAweEMwMDAyMDAzDQoN
ClRoaXMgY29tbWFuZCB3aWxsIHJlYWQgdGhlIE1DQV9NSVNDMCByZWdpc3RlciBmcm9tIE1DQSBi
YW5rIDAuIElmIGl0IGlzDQpub24temVybywgdGhlbiB3ZSdsbCBrbm93IHRoYXQgUEZFSCBpcyBu
b3QgZW5hYmxlZC4NCg0KVGhlICJyZG1zciIgY29tbWFuZCBpcyB1c3VhbGx5IGZvdW5kIGluIHRo
ZSBtc3ItdG9vbHMgcGFja2FnZSBpbiBtYW55IGRpc3Ryb3MuDQpZb3Ugd2lsbCBuZWVkIHRvIHJ1
biBpdCBhcyByb290LCBhbmQgeW91IG1heSBuZWVkIHRvIGxvYWQgdGhlICJtc3IiIG1vZHVsZQ0K
YmVmb3JlIHVzaW5nIHRoZSBjb21tYW5kLg0KDQpUaGFua3MsDQpZYXplbg0K
