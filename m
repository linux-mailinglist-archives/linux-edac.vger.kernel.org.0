Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885B634D494
	for <lists+linux-edac@lfdr.de>; Mon, 29 Mar 2021 18:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhC2QMq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Mon, 29 Mar 2021 12:12:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:52406 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230362AbhC2QMV (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 29 Mar 2021 12:12:21 -0400
IronPort-SDR: BDhejDPbmdXwwlp3p2IQOWnQR69O2wwfhPzF/W4NojeH7cNnWsRXN5f7CT1LCT0Qb77Uhwney0
 xqxZxyhnDdKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="188311718"
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="188311718"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 09:12:19 -0700
IronPort-SDR: Ywc2bagZ1nzzoME6LaH3jnzZ1I16yUvRE+5CK+GulRa/bf8ymgaHUvA4Kie3og30AEuRfYQOSc
 StATGDkHWnAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="454618452"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 29 Mar 2021 09:12:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 29 Mar 2021 09:12:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 29 Mar 2021 09:12:16 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Mon, 29 Mar 2021 09:12:16 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/mce/dev-mcelog: Fix potential memory access error
Thread-Topic: [PATCH] x86/mce/dev-mcelog: Fix potential memory access error
Thread-Index: AQHXJIDSM+kFcRvHZ0aVR9xYGcvpeqqbIiLg
Date:   Mon, 29 Mar 2021 16:12:16 +0000
Message-ID: <745eaeb668bc43deb8eb7db7a3342691@intel.com>
References: <1617011360-102531-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1617011360-102531-1-git-send-email-yang.lee@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

-		set_bit(MCE_OVERFLOW, (unsigned long *)&mcelog->flags);
+		mcelog->flags |= BIT(MCE_OVERFLOW);

set_bit() is an atomic operation because it might race with the code to
get and clear this bit:

                do {
                        flags = mcelog->flags;
                } while (cmpxchg(&mcelog->flags, flags, 0) != flags);

Originally this was needed because mcelog could be called from #MC
context.

That's all changed now and the machine check notifier chain routines are
called in a kernel thread. So some other locking (mutex?) could be used
to protect access to mcelog->flags.

-Tony

