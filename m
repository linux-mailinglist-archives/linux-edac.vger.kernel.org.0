Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A134816B16E
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2020 22:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBXVFK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Feb 2020 16:05:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:40405 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgBXVFK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Feb 2020 16:05:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 13:05:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; 
   d="scan'208";a="226113254"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga007.jf.intel.com with ESMTP; 24 Feb 2020 13:05:09 -0800
Received: from orsmsx125.amr.corp.intel.com (10.22.240.125) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 24 Feb 2020 13:05:09 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.107]) by
 ORSMSX125.amr.corp.intel.com ([169.254.3.208]) with mapi id 14.03.0439.000;
 Mon, 24 Feb 2020 13:05:08 -0800
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "hpa@zytor.com" <hpa@zytor.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/mce/therm_throt: Handle case where
 throttle_active_work() is called on behalf of an offline CPU
Thread-Topic: [PATCH] x86/mce/therm_throt: Handle case where
 throttle_active_work() is called on behalf of an offline CPU
Thread-Index: AQHV61YYXKHnouzZ302AwVkmqxKOXg==
Date:   Mon, 24 Feb 2020 21:05:08 +0000
Message-ID: <093f3f8665f72937548665099b7eb9b805fc5ac7.camel@intel.com>
References: <20200222162432.497201-1-srinivas.pandruvada@linux.intel.com>
         <20200222175151.GD11284@zn.tnic>
         <40989625ca5496a986ca3e595957da83723777f4.camel@linux.intel.com>
         <20200224125525.GA29318@zn.tnic> <87y2ssm0sz.fsf@nanos.tec.linutronix.de>
         <87lforn5xr.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87lforn5xr.fsf@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.2 (3.34.2-1.fc31) 
x-originating-ip: [10.54.75.21]
Content-Type: text/plain; charset="utf-8"
Content-ID: <55200E206ACD1648AB90B8896125ED20@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTI0IGF0IDIwOjI1ICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPiB3cml0ZXM6DQo+ID4gV2hp
Y2ggaXMgd3JvbmcgYXMgd2VsbC4gVHJ5aW5nIHRvICJmaXgiIGl0IGluIHRoZSB3b3JrIHF1ZXVl
DQo+ID4gY2FsbGJhY2sgaXMNCj4gPiBwYXBlcmluZyBvdmVyIHRoZSByb290IGNhdXNlLg0KPiA+
IA0KPiA+IFdoeSBpcyBhbnkgd29yayBzY2hlZHVsZWQgb24gYW4gb3V0Z29pbmcgQ1BVIGFmdGVy
IHRoaXMgQ1BVDQo+ID4gZXhlY3V0ZWQNCj4gPiB0aGVybWFsX3Rocm90dGxlX29mZmxpbmUoKT8N
Cj4gPiANCj4gPiBXaGVuIHRoZXJtYWxfdGhyb3R0bGVfb2ZmbGluZSgpIGlzIGludm9rZWQgdGhl
IGNwdSBib3VuZCB3b3JrDQo+ID4gcXVldWVzIGFyZQ0KPiA+IHN0aWxsIGZ1bmN0aW9uYWwgYW5k
IHRoZXJtYWxfdGhyb3R0bGVfb2ZmbGluZSgpIGNhbmNlbHMgb3V0c3RhbmRpbmcNCj4gPiB3b3Jr
Lg0KPiA+IA0KPiA+IFNvIG5vLCBwbGVhc2UgZml4IHRoZSByb290IGNhdXNlIG5vdCB0aGUgc3lt
cHRvbS4NCj4gDQo+IEFuZCBpZiB5b3UgbG9vayBhdCB0aGVybWFsX3Rocm90dGxlX29ubGluZSgp
IHRoZW4geW91J2xsIG5vdGljZSB0aGF0DQo+IGl0DQo+IGlzIGFzeW1ldHJpYyB2cy4gdGhlcm1h
bF90aHJvdHRsZV9vZmZsaW5lKCkuDQo+IA0KPiBBbHNvIHlvdSB3YW50IHRvIGRvIGNhbmNlbF9k
ZWxheWVkX3dvcmtfc3luYygpIGFuZCBub3QganVzdA0KPiBjYW5jZWxfZGVsYXllZF93b3JrKCkg
YmVjYXVzZSBvbmx5IHRoZSBsYXR0ZXIgZ3VhcmFudGVlcyB0aGF0IHRoZQ0KPiB3b3JrDQo+IGlz
IG5vdCBlbnF1ZXVlZCBhbnltb3JlIHdoaWxlIHRoZSBmb3JtZXIgZG9lcyBub3QgdGFrZSBydW5u
aW5nIG9yDQo+IHNlbGYNCj4gcmVxdWV1ZWluZyB3b3JrIGludG8gYWNjb3VudC4NCj4gDQo+IFNv
bWV0aGluZyBsaWtlIHRoZSB1bnRlc3RlZCBwYXRjaCBiZWxvdy4NClRoYW5rcyBUaG9tYXMuIEkg
YW0gdGVzdGluZyB0aGlzIHBhdGNoLg0KDQotU3Jpbml2YXMNCg0KPiANCj4gVGhhbmtzLA0KPiAN
Cj4gICAgICAgICB0Z2x4DQo+IC0tLQ0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS90
aGVybV90aHJvdC5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL3RoZXJtX3Rocm90
LmMNCj4gQEAgLTQ4Nyw4ICs0ODcsMTIgQEAgc3RhdGljIGludCB0aGVybWFsX3Rocm90dGxlX29m
ZmxpbmUodW5zaQ0KPiAgCXN0cnVjdCB0aGVybWFsX3N0YXRlICpzdGF0ZSA9ICZwZXJfY3B1KHRo
ZXJtYWxfc3RhdGUsIGNwdSk7DQo+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gZ2V0X2NwdV9kZXZp
Y2UoY3B1KTsNCj4gIA0KPiAtCWNhbmNlbF9kZWxheWVkX3dvcmsoJnN0YXRlLT5wYWNrYWdlX3Ro
cm90dGxlLnRoZXJtX3dvcmspOw0KPiAtCWNhbmNlbF9kZWxheWVkX3dvcmsoJnN0YXRlLT5jb3Jl
X3Rocm90dGxlLnRoZXJtX3dvcmspOw0KPiArCS8qIE1hc2sgdGhlIHRoZXJtYWwgdmVjdG9yIGJl
Zm9yZSBkcmFpbmluZyBldnRsLiBwZW5kaW5nIHdvcmsNCj4gKi8NCj4gKwlsID0gYXBpY19yZWFk
KEFQSUNfTFZUVEhNUik7DQo+ICsJYXBpY193cml0ZShBUElDX0xWVFRITVIsIGwgfCBBUElDX0xW
VF9NQVNLRUQpOw0KPiArDQo+ICsJY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZzdGF0ZS0+cGFj
a2FnZV90aHJvdHRsZS50aGVybV93b3JrKTsNCj4gKwljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMo
JnN0YXRlLT5jb3JlX3Rocm90dGxlLnRoZXJtX3dvcmspOw0KPiAgDQo+ICAJc3RhdGUtPnBhY2th
Z2VfdGhyb3R0bGUucmF0ZV9jb250cm9sX2FjdGl2ZSA9IGZhbHNlOw0KPiAgCXN0YXRlLT5jb3Jl
X3Rocm90dGxlLnJhdGVfY29udHJvbF9hY3RpdmUgPSBmYWxzZTsNCg==
