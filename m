Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076B1209785
	for <lists+linux-edac@lfdr.de>; Thu, 25 Jun 2020 02:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388665AbgFYANo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 24 Jun 2020 20:13:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:26745 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388522AbgFYANo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 24 Jun 2020 20:13:44 -0400
IronPort-SDR: PjaYI25Kom+a7QYjmkIO/Nhq30/PKqtcTV8SPNERPIa60UXpbijyIOhpUGCJ5vtDTcAXTvviVQ
 4/jK6PheaeYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="162772268"
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="162772268"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 17:13:44 -0700
IronPort-SDR: PVKJm8I8Tp39bdX0zSIhvyqqds0/gehQ+YAgi/8RCik4BpqR2KgCZTav94yyNXjWjh4rcak3Hu
 N49+5WAeC3sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="310949548"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga008.jf.intel.com with ESMTP; 24 Jun 2020 17:13:43 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.56]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.232]) with mapi id 14.03.0439.000;
 Wed, 24 Jun 2020 17:13:43 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jane Chu <jane.chu@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: RE: [RFC] Make the memory failure blast radius more precise
Thread-Topic: [RFC] Make the memory failure blast radius more precise
Thread-Index: AQHWSZtiV1cAPccj5U6oivsn3si7c6jmwT6AgAB5HID//41BAIAAeRuAgAF8eAD//7g8cA==
Date:   Thu, 25 Jun 2020 00:13:43 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F67BB29@ORSMSX115.amr.corp.intel.com>
References: <20200623201745.GG21350@casper.infradead.org>
 <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com>
 <20200623221741.GH21350@casper.infradead.org>
 <20200623222658.GA21817@agluck-desk2.amr.corp.intel.com>
 <20200623224027.GI21350@casper.infradead.org>
 <24367ca1-ecb0-de96-b9e5-f94747838c74@oracle.com>
In-Reply-To: <24367ca1-ecb0-de96-b9e5-f94747838c74@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBCb3RoIHRoZSBSRkMgcGF0Y2ggYW5kIHRoZSBhYm92ZSA1LXN0ZXAgcmVjb3ZlcnkgcGxhbiBs
b29rIG5lYXQsIHN0ZXAgNCkgDQo+IGlzIG5pY2UgdG8gY2FycnkgZm9yd2FyZCBvbiBpY2VsYWtl
IHdoZW4gYSBzaW5nbGUgaW5zdHJ1Y3Rpb24gdG8gY2xlYXINCj4gcG9pc29uIGlzIGF2YWlsYWJs
ZS4NCg0KSmFuZSwNCg0KQ2xlYXJpbmcgcG9pc29uIGhhcyBzb21lIGNoYWxsZW5nZXMuDQoNCk9u
IHBlcnNpc3RlbnQgbWVtb3J5IGl0IHByb2JhYmx5IHdvcmtzIChhcyB0aGUgRElNTSBpcyBnb2lu
ZyB0byByZW1hcCB0aGF0IGFkZHJlc3MgdG8gYSBkaWZmZXJlbnQNCnBhcnQgb2YgdGhlIG1lZGlh
IHRvIGF2b2lkIHRoZSBiYWQgc3BvdCkuDQoNCk9uIEREUiBtZW1vcnkgeW91J2QgbmVlZCB0byBk
ZWNpZGUgd2hldGhlciB0aGUgcHJvYmxlbSB3YXMgdHJhbnNpZW50LCBzbyB0aGF0IGEgc2ltcGxl
DQpvdmVyd3JpdGUgZml4ZXMgdGhlIHByb2JsZW0uIE9yIHBlcnNpc3RlbnQgLi4uIGluIHdoaWNo
IGNhc2UgdGhlIHByb2JsZW0gd2lsbCBsaWtlbHkgY29tZSBiYWNrDQp3aXRoIHRoZSByaWdodCBk
YXRhIHBhdHRlcm4uICBUbyB0ZWxsIHRoYXQgeW91IG1heSBuZWVkIHRvIHJ1biBzb21lIG1lbW9y
eSB0ZXN0IG9uIHRoZSBhZmZlY3RlZA0KYXJlYS4NCg0KSWYgdGhlIGVycm9yIHdhcyBqdXN0IGlu
IGEgNEsgcGFnZSwgSSdkIGJlIGluY2xpbmVkIHRvIGNvcHkgdGhlIGdvb2QgZGF0YSB0byBhIG5l
dyBwYWdlIGFuZA0KbWFwIHRoYXQgaW4gaW5zdGVhZC4gVGhyb3dpbmcgYXdheSBvbmUgNEsgcGFn
ZSBpc24ndCBsaWtlbHkgdG8gYmUgcGFpbmZ1bC4NCg0KSWYgaXQgaXMgaW4gYSAyTS8xRyBwYWdl
IC4uLiBwZXJoYXBzIGl0IGlzIHdvcnRoIHRoZSBlZmZvcnQgYW5kIHJpc2sgb2YgdHJ5aW5nIHRv
IGNsZWFyIHRoZSBwb2lzb24NCmluIHBsYWNlIHRvIGF2b2lkIHRoZSBwYWluIG9mIGJyZWFraW5n
IHVwIGEgbGFyZ2UgcGFnZS4NCg0KLVRvbnkNCg==
