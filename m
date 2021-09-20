Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0ABE4119A5
	for <lists+linux-edac@lfdr.de>; Mon, 20 Sep 2021 18:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242657AbhITQUr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 20 Sep 2021 12:20:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:31107 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243502AbhITQUh (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 20 Sep 2021 12:20:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="286846742"
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="286846742"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 09:18:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="483870902"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga008.jf.intel.com with ESMTP; 20 Sep 2021 09:18:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 20 Sep 2021 09:18:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 20 Sep 2021 09:18:58 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.012;
 Mon, 20 Sep 2021 09:18:58 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Jue Wang <juew@google.com>, Ding Hui <dinghui@sangfor.com.cn>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "Song, Youquan" <youquan.song@intel.com>,
        "huangcun@sangfor.com.cn" <huangcun@sangfor.com.cn>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] x86/mce: Drop copyin special case for #MC
Thread-Topic: [PATCH v2 3/3] x86/mce: Drop copyin special case for #MC
Thread-Index: AQHXk8gq8Qe1g5tesEOw6jGkHsNov6utTUoAgAAAgWA=
Date:   Mon, 20 Sep 2021 16:18:58 +0000
Message-ID: <9d4690a2f3f143f882f63bd88c355004@intel.com>
References: <20210706190620.1290391-1-tony.luck@intel.com>
 <20210818002942.1607544-1-tony.luck@intel.com>
 <20210818002942.1607544-4-tony.luck@intel.com> <YUhQsOKLeY/QV6ag@zn.tnic>
In-Reply-To: <YUhQsOKLeY/QV6ag@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBDYW4gd2UgbmFtZSBzb21lIG9mIHRob3NlIGZpeGVzIGhlcmUgcGxzPw0KDQpTb21lL2FsbCBv
ZiB0aGlzIGJ1bmNoIGZyb20gQWwgVmlybzoNCg0KYTE4MGJkMWQ3ZTE2IGlvdl9pdGVyOiByZW1v
dmUgdWFjY2Vzc19rZXJuZWwoKSB3YXJuaW5nIGZyb20gaW92X2l0ZXJfaW5pdCgpDQo2ODUyZGYx
MjY2OTkgY3N1bV9hbmRfY29weV90b19waXBlX2l0ZXIoKTogbGVhdmUgaGFuZGxpbmcgb2YgY3N1
bV9zdGF0ZSB0byBjYWxsZXINCjJhNTEwYTc0NGJlYiBjbGVhbiB1cCBjb3B5X21jX3BpcGVfdG9f
aXRlcigpDQo4OTM4MzlmZDU3MzMgcGlwZV96ZXJvKCk6IHdlIGRvbid0IG5lZWQgbm8gc3Rpbmtp
bicga21hcF9hdG9taWMoKS4uLg0KMjQ5NWJkY2M4NmRjIGlvdl9pdGVyOiBjbGVhbiBjc3VtX2Fu
ZF9jb3B5Xy4uLigpIHByaW1pdGl2ZXMgdXAgYSBiaXQNCjU1Y2EzNzVjNWRjYyBjb3B5X3BhZ2Vf
ZnJvbV9pdGVyKCk6IGRvbid0IG5lZWQga21hcF9hdG9taWMoKSBmb3Iga3ZlYy9idmVjIGNhc2Vz
DQpjMWQ0ZDZhOWFlODggY29weV9wYWdlX3RvX2l0ZXIoKTogZG9uJ3QgYm90aGVyIHdpdGgga21h
cF9hdG9taWMoKSBmb3IgYnZlYy9rdmVjIGNhc2VzDQo0YjE3OWU5YTljN2MgaXRlcmF0ZV94YXJy
YXkoKTogb25seSBvZiB0aGUgZmlyc3QgaXRlcmF0aW9uIHdlIG1pZ2h0IGdldCBvZmZzZXQgIT0g
MA0KYTZlNGVjN2JmZDMyIHB1bGwgaGFuZGxpbmcgb2YgLT5pb3Zfb2Zmc2V0IGludG8gaXRlcmF0
ZV97aW92ZWMsYnZlYyx4YXJyYXl9DQo3YmFhNTA5OTAwMmYgaW92X2l0ZXI6IG1ha2UgaXRlcmF0
b3IgY2FsbGJhY2tzIHVzZSBiYXNlIGFuZCBsZW4gaW5zdGVhZCBvZiBpb3ZlYw0KNjIyODM4ZjNm
ZGUyIGlvdl9pdGVyOiBtYWtlIHRoZSBhbW91bnQgYWxyZWFkeSBjb3BpZWQgYXZhaWxhYmxlIHRv
IGl0ZXJhdG9yIGNhbGxiYWNrcw0KMjFiNTZjODQ3NzUzIGlvdl9pdGVyOiBnZXQgcmlkIG9mIHNl
cGFyYXRlIGJ2ZWMgYW5kIHhhcnJheSBjYWxsYmFja3MNCjFiNGZiNWZmZDc5YiBpb3ZfaXRlcjog
dGVhY2ggaXRlcmF0ZV97YnZlYyx4YXJyYXl9KCkgYWJvdXQgcG9zc2libGUgc2hvcnQgY29waWVz
DQo3NDkxYTJiZjY0ZTMgaXRlcmF0ZV9idmVjKCk6IGV4cGFuZCBidmVjLmggbWFjcm8gZm9yZXN0
LCBtYXNzYWdlIGEgYml0DQo1YzY3YWE5MGNkNWMgaW92X2l0ZXI6IHVuaWZ5IGl0ZXJhdGVfaW92
ZWMgYW5kIGl0ZXJhdGVfa3ZlYw0KN2ExYmNiNWQyNTVkIGlvdl9pdGVyOiBtYXNzYWdlIGl0ZXJh
dGVfaW92ZWMgYW5kIGl0ZXJhdGVfa3ZlYyB0byBsb2dpY3Mgc2ltaWxhciB0byBpdGVyYXRlX2J2
ZWMNCmY1ZGE4MzU0NWY0ZSBpdGVyYXRlX2FuZF9hZHZhbmNlKCk6IGdldCByaWQgb2YgbWFnaWMg
aW4gY2FzZSB3aGVuIG4gaXMgMA0KNTk0ZTQ1MGIzZjQ0IGNzdW1fYW5kX2NvcHlfdG9faXRlcigp
OiBtYXNzYWdlIGludG8gZm9ybSBjbG9zZXIgdG8gY3N1bV9hbmRfY29weV9mcm9tX2l0ZXIoKQ0K
ZjBiNjVmMzlhYzUwIGlvdl9pdGVyOiByZXBsYWNlIGlvdl9pdGVyX2NvcHlfZnJvbV91c2VyX2F0
b21pYygpIHdpdGggaXRlcmF0b3ItYWR2YW5jaW5nIHZhcmlhbnQNCmU0ZjhkZjg2Nzk4YSBbeGFy
cmF5XSBpb3ZfaXRlcl9ucGFnZXMoKToganVzdCB1c2UgRElWX1JPVU5EX1VQKCkNCjY2NTMxYzY1
YWEyNSBpb3ZfaXRlcl9ucGFnZXMoKTogZG9uJ3QgYm90aGVyIHdpdGggaXRlcmF0ZV9hbGxfa2lu
ZHMoKQ0KM2Q2NzFjYTYyYTA4IGdldCByaWQgb2YgaXRlcmF0ZV9hbGxfa2luZHMoKSBpbiBpb3Zf
aXRlcl9nZXRfcGFnZXMoKS9pb3ZfaXRlcl9nZXRfcGFnZXNfYWxsb2MoKQ0KNjEwYzdhNzE1NDNk
IGlvdl9pdGVyX2dhcF9hbGlnbm1lbnQoKTogZ2V0IHJpZCBvZiBpdGVyYXRlX2FsbF9raW5kcygp
DQo5MjIxZDJlMzdiNzIgaW92X2l0ZXJfYWxpZ25tZW50KCk6IGRvbid0IGJvdGhlciB3aXRoIGl0
ZXJhdGVfYWxsX2tpbmRzKCkNCjg0MDlhMGQyNjFlMiBzYW5pdGl6ZSBpb3ZfaXRlcl9mYXVsdF9p
bl9yZWFkYWJsZSgpDQoxODVhYzRkNDM2NjkgaW92X2l0ZXI6IG9wdGltaXplIGlvdl9pdGVyX2Fk
dmFuY2UoKSBmb3IgaW92ZWMgYW5kIGt2ZWMNCjhjZDU0YzFjODQ4MCBpb3ZfaXRlcjogc2VwYXJh
dGUgZGlyZWN0aW9uIGZyb20gZmxhdm91cg0KNTU2MzUxYzFjMDlhIGlvdl9pdGVyX2FkdmFuY2Uo
KTogZG9uJ3QgbW9kaWZ5IC0+aW92X29mZnNldCBmb3IgSVRFUl9ESVNDQVJEDQoyOGYzOGRiN2Vk
YmYgaW92X2l0ZXI6IHJlb3JkZXIgaGFuZGxpbmcgb2YgZmxhdm91cnMgaW4gcHJpbWl0aXZlcw0K
NGI2YzEzMmI3ZGE2IGlvdl9pdGVyOiBzd2l0Y2ggLi4uX2Z1bGwoKSB2YXJpYW50cyBvZiBwcmlt
aXRpdmVzIHRvIHVzZSBvZiBpb3ZfaXRlcl9yZXZlcnQoKQ0KM2IzZmMwNTFjZDJjIGlvdl9pdGVy
X2FkdmFuY2UoKTogdXNlIGNvbnNpc3RlbnQgc2VtYW50aWNzIGZvciBtb3ZlIHBhc3QgdGhlIGVu
ZA0KMGU4ZjBkNjc0MDE1IFt4YXJyYXldIGlvdl9pdGVyX2ZhdWx0X2luX3JlYWRhYmxlKCkgc2hv
dWxkIGRvIG5vdGhpbmcgaW4geGFycmF5IGNhc2UNCmE1MDZhYmM3YjY0NCBjb3B5X3BhZ2VfdG9f
aXRlcigpOiBmaXggSVRFUl9ESVNDQVJEIGNhc2UNCjA4YWE2NDc5NjAxNiB0ZWFjaCBjb3B5X3Bh
Z2VfdG9faXRlcigpIHRvIGhhbmRsZSBjb21wb3VuZCBwYWdlcw0KNjZjZDA3MWExZjgzIGlvdl9p
dGVyOiBSZW1vdmUgaW92X2l0ZXJfZm9yX2VhY2hfcmFuZ2UoKQ0KDQotVG9ueQ0K
