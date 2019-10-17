Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA91DB910
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2019 23:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391590AbfJQVbc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Oct 2019 17:31:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:63851 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732322AbfJQVbc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 17 Oct 2019 17:31:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 14:31:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,309,1566889200"; 
   d="scan'208";a="186628235"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga007.jf.intel.com with ESMTP; 17 Oct 2019 14:31:31 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 17 Oct 2019 14:31:31 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.146]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.228]) with mapi id 14.03.0439.000;
 Thu, 17 Oct 2019 14:31:31 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "ckellner@redhat.com" <ckellner@redhat.com>
Subject: RE: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
Thread-Topic: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
Thread-Index: AQHVgtVLxuJrYmx6hUyzyzJQOp33Lqdb2lSAgABPIQCAATmTgIAAYKeAgAGZqlA=
Date:   Thu, 17 Oct 2019 21:31:30 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F4A57D0@ORSMSX115.amr.corp.intel.com>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
 <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
 <20191015084833.GD2311@hirez.programming.kicks-ass.net>
 <f481b4ab6dfebbc0637c843e5f1cd4ddfd4bd60b.camel@linux.intel.com>
 <20191016081405.GO2328@hirez.programming.kicks-ass.net>
 <20191016140001.GF1138@zn.tnic>
In-Reply-To: <20191016140001.GF1138@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmMwOGJhZGYtMjM2My00NGFiLTkwMmUtNDg4YzY3YzM1ZTNmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiXC9Bc091SUtLUDBrWXp3RHdWRHkzMEw4TE1BWHFyRFNla0VXV3pQNytFY3BTaENmMmJzbWJiR2JGUnBJb3dUd0cifQ==
x-ctpclassification: CTP_NT
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

Pj4gVGhhdCBhbGwgc291bmRzIGxpa2UgdGhlIHByaW50ayBzaG91bGQgYmUgZG93bmdyYWRlZCB0
b28sIGl0IGlzIG5vdCBhDQo+PiBLRVJOX0NSSVQgd2FybmluZy4gSXQgaXMgbW9yZSBhIG5vdGlm
aWNhdGlvbiB0aGF0IHdlJ3JlIGdldHRpbmcgd2FybS4NCj4NCj4gUmlnaHQsIGFuZCBJIHRoaW5r
IHdlIHNob3VsZCB0YWtlIEJlbmphbWluJ3MgcGF0Y2ggYWZ0ZXIgYWxsIC0gcGVyaGFwcw0KPiBl
dmVuIHRhZyBpdCBmb3Igc3RhYmxlIGlmIHRoYXQgbWVzc2FnZSBpcyBhbm5veWluZyBwZW9wbGUg
dG9vIG11Y2ggLSBhbmQNCj4gU3Jpbml2YXMgY2FuIGRvIHRoZSBkeW5hbWljIHRoaW5nIG9udG9w
Lg0KDQpUaGF0IHNvdW5kcyBsaWtlIHRoZSByaWdodCBzaG9ydCB0ZXJtIGFjdGlvbi4NCg0KRGVw
ZW5kaW5nIG9uIHdoYXQgd2UgZW5kIHVwIHdpdGggZnJvbSBTcmluaXZhcyAuLi4gd2UgbWF5IHdh
bnQNCnRvIHJlY29uc2lkZXIgdGhlIHNldmVyaXR5LiAgVGhlIGJhc2ljIHByZW1pc2Ugb2YgU3Jp
bml2YXMnIHBhdGNoDQppcyB0byBhdm9pZCBwcmludGluZyBhbnl0aGluZyBmb3Igc2hvcnQgZXhj
dXJzaW9ucyBhYm92ZSB0ZW1wZXJhdHVyZQ0KdGhyZXNob2xkLiBCdXQgdGhlIGVmZmVjdCBvZiB0
aGF0IGlzIHRoYXQgd2hlbiB3ZSBmaW5kIHRoZSBjb3JlL3BhY2thZ2UNCnN0YXlpbmcgYWJvdmUg
dGVtcGVyYXR1cmUgZm9yIGFuIGV4dGVuZGVkIHBlcmlvZCBvZiB0aW1lLCB3ZSBhcmUNCmluIGEg
c2VyaW91cyBzaXR1YXRpb24gd2hlcmUgc29tZSBhY3Rpb24gbWF5IGJlIG5lZWRlZC4gRS5nLg0K
bW92ZSB0aGUgbGFwdG9wIG9mZiB0aGUgc29mdCBzdXJmYWNlIHRoYXQgaXMgYmxvY2tpbmcgdGhl
IGFpciB2ZW50cy4NCg0KLVRvbnkNCg==
