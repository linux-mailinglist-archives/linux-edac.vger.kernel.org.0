Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AE133DE34
	for <lists+linux-edac@lfdr.de>; Tue, 16 Mar 2021 20:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbhCPTwc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Mar 2021 15:52:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:30364 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240708AbhCPTwA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 16 Mar 2021 15:52:00 -0400
IronPort-SDR: bkTQu5z30hYNhVg9MmzZ36d4PSoUXmmdEyRQeDzSDjbEgBOxKyygQrsPIoe3gswMeMVJztGNtm
 bKnhsyZQnzvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="250687781"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="250687781"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 12:51:57 -0700
IronPort-SDR: o6KQgJNCj7RnteGUONcD0qhADDacuyrodiAQFmy02/xvckeBhSqs4KerJhtmcCjYs2PQ1r4YAa
 4mtXp0UzcIEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="373896902"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2021 12:51:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Mar 2021 12:51:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Mar 2021 12:51:56 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Tue, 16 Mar 2021 12:51:56 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Hermann Ruckerbauer <Hermann.Ruckerbauer@EyeKnowHow.de>,
        Borislav Petkov <bp@alien8.de>
CC:     He Zhe <zhe.he@windriver.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: EDAC list as Trojan Horse distribution ??
Thread-Topic: EDAC list as Trojan Horse distribution ??
Thread-Index: AQHXGo0W9hx3/FPQI0m2mXfwu/dM1qqHW0yAgAACaoCAABVaAP//kk+g
Date:   Tue, 16 Mar 2021 19:51:56 +0000
Message-ID: <4347e4ad4d544e778631ddd15eb88d28@intel.com>
References: <20210316180357.GG18003@zn.tnic>
 <3a2cbcf1-388c-4524-907d-0592438320fc@email.android.com>
In-Reply-To: <3a2cbcf1-388c-4524-907d-0592438320fc@email.android.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Pj4gTm90aGluZyBuZXcgLSBqdXN0IHRoZSBuZXh0IHNwYW1tZXIgYXR0ZW1wdC4gDQoNCj4gQnV0
IHRoaXMgd2FzIGEgbmV3IGNsYXNzIG9mIFNwYW0uIFNvIGZhciBpIGdvdCBvbmx5IG1hc3MgbWFp
bGluZy4uLiBUaGlzIHdhcyBwZXJzb25hbGl6ZWQgYmFzZWQgb24gbXkgcHJldmlvdXMgZS1NYWls
IChkaWQgbm90IGluY2x1ZGUgdGhpcyBwYXJ0IGluIG15IG1haWwpDQoNClNvbWV3aGF0IG5ldyAt
IGNvbWJpbmluZyB0cmF3bGluZyBvZiBwdWJsaWMgbWFpbGluZyBsaXN0cyBmb3IgYWRkcmVzc2Vz
IHdpdGgNCmEgcGhpc2hpbmcgYXR0YWNrIHRyeWluZyB0byBnZXQgeW91IHRvIG9wZW4gYSAocHJl
c3VtYWJseSkgbWFsaWNpb3VzIHBheWxvYWQuDQoNCkkgaGF2ZW4ndCBwZXJzb25hbGx5IHNlZW4g
dGhhdCAuLi4gcHJvYmFibHkgbXkgY29tcGFueSdzIGUtbWFpbCBmaWx0ZXJzIGJsb2NrZWQgaXQu
DQoNCi1Ub255DQo=
