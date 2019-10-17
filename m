Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70DAEDBA53
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2019 01:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391061AbfJQXxV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Oct 2019 19:53:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:50947 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729190AbfJQXxU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 17 Oct 2019 19:53:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 16:53:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,309,1566889200"; 
   d="scan'208";a="200547487"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga006.jf.intel.com with ESMTP; 17 Oct 2019 16:53:20 -0700
Received: from orsmsx121.amr.corp.intel.com (10.22.225.226) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 17 Oct 2019 16:53:19 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.146]) by
 ORSMSX121.amr.corp.intel.com ([169.254.10.88]) with mapi id 14.03.0439.000;
 Thu, 17 Oct 2019 16:53:19 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
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
Thread-Index: AQHVgtVLxuJrYmx6hUyzyzJQOp33Lqdb2lSAgABPIQCAATmTgIAAYKeAgAGZqlCAAHqDgP//rfgg
Date:   Thu, 17 Oct 2019 23:53:18 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F4A6045@ORSMSX115.amr.corp.intel.com>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
 <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
 <20191015084833.GD2311@hirez.programming.kicks-ass.net>
 <f481b4ab6dfebbc0637c843e5f1cd4ddfd4bd60b.camel@linux.intel.com>
 <20191016081405.GO2328@hirez.programming.kicks-ass.net>
 <20191016140001.GF1138@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F4A57D0@ORSMSX115.amr.corp.intel.com>
 <20191017214445.GG14441@zn.tnic>
In-Reply-To: <20191017214445.GG14441@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGYzOWExNTUtM2Q3Ny00Y2Y4LTkyZjQtMjc1ODlkMDQwNDQzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiczZkajBFc09rN0pkd1dWYWNXYkxYVlpxOWhkWW9qSHRCNTBtYlAyN1B3akpvK1RXYlVrSmVTNHdhY0ttR2w4TCJ9
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

PiAqIHdlIHRocm90dGxlIHRoZSBtYWNoaW5lIGZyb20gd2l0aGluIHRoZSBrZXJuZWwgLSB3aGF0
ZXZlciB0aGF0IG1heSBtZWFuDQo+ICogaWYgdGhhdCBkb2Vzbid0IGhlbHAsIHdlIHN0b3Agc2No
ZWR1bGluZyAhcm9vdCB0YXNrcw0KPiAqIGlmIHRoYXQgZG9lc24ndCBoZWxwLCB3ZSBoYWx0DQoN
ClRoZSBzaWxpY29uIHdpbGwgZG8gdGhhdCAiaGFsdCIgc3RlcCBhbGwgYnkgaXRzZWxmIGlmIHRo
ZSB0ZW1wZXJhdHVyZQ0KY29udGludWVzIHRvIHJpc2UgYW5kIGhpdHMgdGhlIGhpZ2hlc3Qgb2Yg
dGhlIHRlbXBlcmF0dXJlIHRocmVzaG9sZHMuDQoNCi1Ub255DQo=
