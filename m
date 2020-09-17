Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB90126D8B9
	for <lists+linux-edac@lfdr.de>; Thu, 17 Sep 2020 12:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgIQKUZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Sep 2020 06:20:25 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:55056 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726672AbgIQKUW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 17 Sep 2020 06:20:22 -0400
X-Greylist: delayed 1387 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 06:20:15 EDT
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08H9snG4024039;
        Thu, 17 Sep 2020 02:56:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=cjm8ZLzWUwIcUGRqBEbxjQcYTCzuW9hDAs+uEQg5LTk=;
 b=kyvZpQecZINWn/6LP4lx5aKDLUtBAdyK/M5RthEIsjz7u5BqDdk8uIiVWmLx1FhL2QF4
 MLkPzjdxuHzJOV9H000EEcMCt8Ppc7cGFEz3MmCTu/A93pr5ixcvlgxi8xtml2oFu116
 nxWG4xm663eI1cfuJbnOrdhXmsdoUYiK8QFEfEhzYQOiBKxTzC0WfVQJaHmh2EqUbvnK
 5pWzBOmOTI+3Z3vurNY5r7dcVcrBbJBbMW8HXX6wsdUiBTV29p5rmTlC7SRUAqz83BFD
 9aPTMWsBZ6z+W/dmLCMun6/33sQNYfbjGl9eZsIkVLDQSHsxRdT7bMwsEDJyENrQb15O gg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33k5njy1jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 02:56:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNBGNy4QFHWVW9ksvcDSk2LSCRpg/ctzfZKBNImECNO0NM4GDKZnsvOxwPMmBrOZxs5eUm128qUO+Gb5RG6eZ4iyb4dz3dPrLYXL5YaiiGHFLo9yYNos/grYGXxnDc4vNf3GfH+0bvOhQGbJkCR6aNwtxewLV9kZMrYH0jbfTf6DPC3nxnH6fAKvxixmup4aXPomK9F5ntwnkMfFXhdgPP1ElBeLcEvqQ6/UeoW3EagaTNwcG136RAag7INgK2Kjpo586eVKd/FfHD20vqe+uHq+o2jd80ygnBqwreFJSkg2ADhVsUY3Vw6O94Kaz5tDmKMA920F1PyFIZKjlYg1CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjm8ZLzWUwIcUGRqBEbxjQcYTCzuW9hDAs+uEQg5LTk=;
 b=HSXZ8GkgK75FAUoFs4H/idjJRRiqWQjcvPGpe82uehxvfQUJoa+Ig/T5o52oLOcLNBrX0dgpITFqwaC9KdrIPU+Bef9qPPMqarYc3vYJ8yENc+4xQcfWCbHYJQH/ovDRHMHndLOOzQ0ulSxAfQj/cgg2rD15K9Dv+Kv1RuFSE5rudm7q4tC0zB6hi+Ppxy/pN5p7ODyb5m0kO89jAS8ZvRDXlqKAp+cJ+4F5jUt1YXz+dQemQV9YqPTNO4yY4FRob+yqT34KT6A15BfV7q69Pk4Tk3DIc6DYva566aGtuTzogAHD/3Ev2VlaLlYDkyG3OCQZzcQyluMkn8Ug2nawAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjm8ZLzWUwIcUGRqBEbxjQcYTCzuW9hDAs+uEQg5LTk=;
 b=JUAFNFH4Zf+sHm48hzCvx7Se+bW0YuNacawirmOk5iBiw/P1tnvCfGMc+ZGzo3/zmof2grXU83vOVhpM2kB2iAAkQ44ouRKz/eqZDJ5nzRdekUFPdzDdd+7eDFdHuWZ5G/+B8HUtvjYZDayiMZAA2w6vVOw5VAdMBQpbUrRpmgc=
Received: from CH2PR07MB7190.namprd07.prod.outlook.com (2603:10b6:610:a6::9)
 by CH2PR07MB6647.namprd07.prod.outlook.com (2603:10b6:610:25::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Thu, 17 Sep
 2020 09:56:31 +0000
Received: from CH2PR07MB7190.namprd07.prod.outlook.com
 ([fe80::b4fa:137d:3c3a:801]) by CH2PR07MB7190.namprd07.prod.outlook.com
 ([fe80::b4fa:137d:3c3a:801%5]) with mapi id 15.20.3391.015; Thu, 17 Sep 2020
 09:56:30 +0000
From:   Dhananjay Vilasrao Kangude <dkangude@cadence.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     "yash.shah@sifive.com" <yash.shah@sifive.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sachin.ghadi@sifive.com" <sachin.ghadi@sifive.com>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] soc: sifive: Add SiFive specific Cadence DDR
 controller driver
Thread-Topic: [PATCH v2 2/3] soc: sifive: Add SiFive specific Cadence DDR
 controller driver
Thread-Index: AQHWhlcI+QkIqmxk0UeRRL8qfzg+Salso4lA
Date:   Thu, 17 Sep 2020 09:56:30 +0000
Message-ID: <CH2PR07MB71904C52A6BD735852151418CD3E0@CH2PR07MB7190.namprd07.prod.outlook.com>
References: <20200907061126.GA14999@infradead.org>
 <mhng-d2a95187-c772-4c5d-b30b-b053a3195177@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-d2a95187-c772-4c5d-b30b-b053a3195177@palmerdabbelt-glaptop1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZGthbmd1ZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0wZDEyMDliMS1mOGNjLTExZWEtYWU5Yy1hNDRjYzhlZDZiMTVcYW1lLXRlc3RcMGQxMjA5YjMtZjhjYy0xMWVhLWFlOWMtYTQ0Y2M4ZWQ2YjE1Ym9keS50eHQiIHN6PSIzNzk3IiB0PSIxMzI0NDgxMDE4NzQ3NDM1MjciIGg9InM1cEFtYUNhS0MySkU3d1doTEtkR1YwR0JoUT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e28cfc6-96a8-445f-650b-08d85aeff3f6
x-ms-traffictypediagnostic: CH2PR07MB6647:
x-microsoft-antispam-prvs: <CH2PR07MB6647354CF5848DFCD5769B7ECD3E0@CH2PR07MB6647.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x8CxnVywu49RN99nmYtkKNNXNUzJLMCgAb29LVOS/edLltAh7eysWZRJ6eKpQlHFBol8dqoFFqa5fFyhkaXDU2685IpyXFXL6e7cpWt/cYmUszMlKIAbQjE/zzh4yS2vkY3GJULeqeYAOfhGa+JzhpfPNT7rBNVPqeZ9cO5FLP40CYGOOEg9VAJOBc3cnUajWdydes2OEGo/CnqDJS6A1H9OsPaGxdc/a4ruKF1iImxavMlZCGgy2ftTCNZqFVne+Qu4qmGgoWnuMd5lcW6Vd4pshi+Xrkwx69w55pW6YvpbArwz3Nv3uhFPEkI4SSPEBpULssuD9iOnd6q0DN5iwMfKEmTGScBS/Q1CUmB8GVwYDYYVgRj3YELDYi9hIwkUDPN7rxr/CefRb+223yP0JnNPlzsVqJ12ONoUzz1MgBYTmrkXzUWS8DBtgMnEwRJiTk4I/SQxDzfLsNevcrhzfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR07MB7190.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(36092001)(26005)(5660300002)(478600001)(7696005)(6506007)(53546011)(52536014)(7416002)(83380400001)(86362001)(8676002)(966005)(2906002)(71200400001)(9686003)(54906003)(55016002)(33656002)(4326008)(186003)(76116006)(8936002)(110136005)(316002)(66556008)(64756008)(66946007)(66476007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ixwkO/Uvo/ZopTSpKcerH8/eRz6fHU0yfXX1Oxzg8KM66NDvOWPYndWtHq0mvpk/Lk3lwD5gT+6mCB85Ezx7BxZa9EmGdrS7dw5kjDlQggJ/sgoEkvx8jQdlRRG8E0wVlIDTMo61jnvNNzEvxJzuCOKbhulZ7H7BiHk36B1A8wo6oh0bmU3DA7MfEK7Hboa0Favtx0ZxnHD6GB9Dt+gIR0bkbIPVSRe+sU73H9+CFgk0FnphGni1Z8hk7rf8Xtcoo1jk3HAdder/1jifDWAVS9wcinMSGEl+HVYbkTPMkJlVME5FeTbWrh+tpVIaopMiwZ+mGNELOVwT5PDKjejYGBNTk0XkPdnLQa58PaDlVhKmKlubLen6r3lbNYHah17FLhu5NWTowExQqLxdkLcgx401DKGhJf47TYMmwoS1pV0zvcdCM/OM0H93SX7otqz5m2Hjy9LKlh28fFcU2c2GhIjPLlLNf1/Zw3lIniOPkw7E3l/Ah7g3B8eIdgjZNrfyziqbGcB8KrwBcamUdFERaIUW18j9ULbTWp+RNO8mmFeQKBdnQqLdA57CNPS1Tk1sppLsk4dSiYN14+M5kAXoCExwB4vJnZ45gCObKZZvAOZfyi0kaunvHArGEQriTKtwx75+L5mUM9cNP47wRk6gFA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR07MB7190.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e28cfc6-96a8-445f-650b-08d85aeff3f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 09:56:30.7837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9rZ+b37+YWH40yKUndOzg3Nb09zeAWEOjgthmL4986XAyo8Sh1wltpBjVNmXR+9EKGhWPwcyPEfl97CYtF9clpTAL0QVsToAfHUR5xfF7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB6647
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_06:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=680 phishscore=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170074
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFsbWVyIERhYmJlbHQg
PHBhbG1lckBkYWJiZWx0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgOSwgMjAy
MCA4OjQyIEFNDQo+IFRvOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+OyBE
aGFuYW5qYXkgVmlsYXNyYW8gS2FuZ3VkZQ0KPiA8ZGthbmd1ZGVAY2FkZW5jZS5jb20+DQo+IENj
OiB5YXNoLnNoYWhAc2lmaXZlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOyBQYXVsIFdhbG1zbGV5
DQo+IDxwYXVsLndhbG1zbGV5QHNpZml2ZS5jb20+OyBicEBhbGllbjguZGU7IG1jaGVoYWJAa2Vy
bmVsLm9yZzsNCj4gdG9ueS5sdWNrQGludGVsLmNvbTsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGFvdUBlZWNzLmJlcmtlbGV5LmVkdTsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zzsgc2FjaGluLmdoYWRpQHNpZml2ZS5jb207DQo+IHJyaWNodGVyQG1hcnZlbGwuY29tOyBqYW1l
cy5tb3JzZUBhcm0uY29tOyBsaW51eC0NCj4gcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGlu
dXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzNdIHNv
Yzogc2lmaXZlOiBBZGQgU2lGaXZlIHNwZWNpZmljIENhZGVuY2UgRERSDQo+IGNvbnRyb2xsZXIg
ZHJpdmVyDQo+IA0KPiBFWFRFUk5BTCBNQUlMDQo+IA0KPiANCj4gT24gU3VuLCAwNiBTZXAgMjAy
MCAyMzoxMToyNiBQRFQgKC0wNzAwKSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+ID4gT24g
TW9uLCBTZXAgMDcsIDIwMjAgYXQgMTE6MTc6NThBTSArMDUzMCwgWWFzaCBTaGFoIHdyb3RlOg0K
PiA+PiBBZGQgYSBkcml2ZXIgdG8gbWFuYWdlIHRoZSBDYWRlbmNlIEREUiBjb250cm9sbGVyIHBy
ZXNlbnQgb24gU2lGaXZlDQo+ID4+IFNvQ3MgQXQgcHJlc2VudCB0aGUgZHJpdmVyIG1hbmFnZXMg
dGhlIEVEQUMgZmVhdHVyZSBvZiB0aGUgRERSDQo+IGNvbnRyb2xsZXIuDQo+ID4+IEFkZGl0aW9u
YWwgZmVhdHVyZXMgbWF5IGJlIGFkZGVkIHRvIHRoZSBkcml2ZXIgaW4gZnV0dXJlIHRvIGNvbnRy
b2wNCj4gPj4gb3RoZXIgYXNwZWN0cyBvZiB0aGUgRERSIGNvbnRyb2xsZXIuDQo+ID4NCj4gPiBT
byBpZiB0aGlzIGlzIGEgZ2VuZXJpYyhpc2gpIENhZGVuY2UgSVAgYmxvY2sgc2hvdWxkbid0IGl0
IGJlIG5hbWVkDQo+ID4gQ2FkZW5jZSBhbmQgbWFkZSBnZW5lcmljPyAgT3IgaXMgdGhlIGZyb250
ZW5kIHNvbWVob3cgU2lGaXZlIHNwZWNpZmljPw0KPiANCj4gRm9yIHNvbWUgcmVhc29uIEkgdGhv
dWdodCB3ZSBoYWQgYSBTaUZpdmUtc3BlY2lmaWMgaW50ZXJmYWNlIHRvIHRoaXMsIGJ1dCBJIG1h
eQ0KPiBoYXZlIGdvdHRlbiB0aGF0IGNvbmZ1c2VkIHdpdGggc29tZXRoaW5nIGVsc2UgYXMgaXQn
cyBiZWVuIGEgd2hpbGUuICBTb21lb25lDQo+IGZyb20gU2lGaXZlIHdvdWxkIHByb2JhYmx5IGhh
dmUgYSBiZXR0ZXIgaWRlYSwgYnV0IGl0IGxvb2tzIGxpa2UgdGhlIHBlcnNvbiBJJ2QNCj4gYXNr
IGlzbid0IHRoZXJlYW55IG1vcmUgc28gSSdtIGFsbCBvdXQgb2Ygb3B0aW9ucyA7KQ0KPiANCj4g
SXQgbG9va3MgbGlrZSB0aGVyZSB3YXMgYSB2ZXJ5IHNpbWlsYXIgZHJpdmVyIHBvc3RlZCBieSBE
aGFuYW5qYXkgS2FuZ3VkZQ0KPiBmcm9tIENhZGVuY2UgaW4gQXByaWw6DQo+IGh0dHBzOi8vdXJs
ZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC80LzYvMzU4X187ISFF
SHNjbQ0KPiBTMXlnaVUxbEEhVWZWWVd6UXFDZ2FVTktOMTU2ZmZLTTVOa0ZvWXRQaEhhcHJ1QzN5
cW1lN252YlVCbkQyDQo+IG1FSGc4RjZpdDR5NCQgIC4gIFNvbWUgb2YgdGhlIHJlZ2lzdGVyIGRl
ZmluaXRpb25zIHNlZW0gdG8gYmUgZGlmZmVyZW50LCBidXQNCj4gdGhlIGNvZGUgSSBsb29rZWQg
YXQgaXMgdmVyeSBzaW1pbGFyIHNvIHRoZXJlJ3MgYXQgbGVhc3Qgc29tZSBiaXRzIHRoYXQgY291
bGQgYmUNCj4gc2hhcmVkLiAgSSBmb3VuZCBhIHY0IG9mIHRoYXQgcGF0Y2ggc2V0LCBidXQgdGhh
dCB3YXMgYmFjayBpbiBNYXk6DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczov
L2xrbWwub3JnL2xrbWwvMjAyMC81LzExLzkxMl9fOyEhRUhzYw0KPiBtUzF5Z2lVMWxBIVVmVllX
elFxQ2dhVU5LTjE1NmZmS001TmtGb1l0UGhIYXBydUMzeXFtZTdudmJVQm5EDQo+IDJtRUhnOERl
Q3dBcGskICAuICBJdCBhbGx1ZGVzIHRvIGEgdjUsIGJ1dCBJIGNhbid0IGZpbmQgb25lLiAgSSd2
ZSBhZGRlZA0KPiBEaGFuYW5qYXksIG1heWJlIGhlIGtub3dzIHdoYXQncyB1cD8NCj4gDQo+IEkg
ZG9uJ3Qga25vdyBlbm91Z2ggYWJvdXQgdGhlIGJsb2NrIHRvIGtub3cgaWYgdGhlIHN1YnRsZSBk
aWZmZXJlbmNlIGluDQo+IHJlZ2lzdGVyIG5hbWVzL29mZnNldHMgbWVhbnMuICBUaGV5IGxvb2sg
cHJvcGVybHkganVtYmxlZCB1cCAoaWUsIG5vdCBqdXN0IGFuDQo+IG9mZnNldCksIHNvIG1heWJl
IHRoZXJlJ3MganVzdCBkaWZmZXJlbnQgdmVyc2lvbnMgb3IgdGhhdCdzIHRoZSBTaUZpdmUtc3Bl
Y2lmaWMNCj4gcGFydCBJIGhhZCBib3VuY2luZyBhcm91bmQgbXkgaGVhZD8gIEVpdGhlciB3YXks
IGl0IHNlZW1zIGxpa2Ugb25lIGRyaXZlcg0KPiB3aXRoIHNvbWUgc2ltcGxlIGNvbmZpZ3VyYXRp
b24gY291bGQgaGFuZGxlIGJvdGggb2YgdGhlc2UgLS0gZWl0aGVyIHN0aWNraW5nDQo+IHRoZSBv
ZmZzZXRzIGluIHRoZSBEVCAoaWYgdGhleSdyZSBnb2luZyB0byBiZSBkaWZmZXJlbnQgZXZlcnl3
aGVyZSkgb3IgYnkNCj4gY29taW5nIHVwIHdpdGggc29tZSB2ZXJzaW9uIHNvcnQgb2YgdGhpbmcg
KGlmIHRoZXJlJ3MgYSBoYW5kZnVsIG9mIHRoZXNlKS4NCj4gDQo+IEknbSBub3cgYWxzbyBhIGJp
dCB3b3JyaWVkIGFib3V0IHRoZSBwcm92ZW5hY2Ugb2YgdGhpcyBjb2RlLiAgVGhlIHR3byBkcml2
ZXJzDQo+IGFyZSBlcnJpbHkgc2ltaWxhciAtLSBmb3IgZXhhbXBsZSwgdGhlIHZhcmlhYmxlIGRl
ZmluaXRpb25zIGluIGhhbmRsZV9jZSgpDQo+IA0KPiAgICAgICAgdTY0IGVycl9jX2FkZHIgPSAw
eDA7DQo+ICAgICAgICB1NjQgZXJyX2NfZGF0YSA9IDB4MDsNCj4gICAgICAgIHUzMiBlcnJfY19z
eW5kLCBlcnJfY19pZDsNCj4gICAgICAgIHUzMiBzaWdfdmFsX2wsIHNpZ192YWxfaDsNCj4gDQo+
IGFyZSBleGFjdGx5IHRoZSBzYW1lLg0KW0RoYW5hbmpheSBLYW5ndWRlXQ0KIEhpIFBhbG1lciwN
CiAgICAgICAJU29ycnkgZm9yIGRlbGF5ZWQgcmVwbHkuDQoJSSB3YXMgZXhwZWN0aW5nIG5ldyBj
aGFuZ2VzIGludG8gdGhlIGhhcmR3YXJlIElQIHNpbmNlIGxhc3QgY291cGxlIG9mDQptb250aHMg
dGh1cyBJIGhhdmVuJ3QgdXAgc3RyZWFtZWQgVjUgcGF0Y2ggdGlsbCBub3cuIFRoZSBjYWRlbmNl
IGRyaXZlciB2ZXJzaW9uIA0KaXMgb2YgbW9yZSBnZW5lcmljIGZvciBjYWRlbmNlIEREUiBjb250
cm9sbGVycyB3aGljaCBjb3VsZCBiZSBwYXJ0IG9mIG90aGVyIFNvQ3MgdG9vLg0KSSB3b3VsZCBz
dWdnZXN0IFlhc2ggdG8gcGF0Y2ggU2lmaXZlIHNwZWNpZmljIGNoYW5nZXMgb25jZSBjYWRlbmNl
IEREUiBjb250cm9sbGVyIGRyaXZlciANCmdldCB1cCBzdHJlYW1lZC4gSSB3aWxsIHNlbmQgVjUg
aW4gY29taW5nIGRheXMuDQoNClRoYW5rLA0KRGhhbmFuamF5DQo=
