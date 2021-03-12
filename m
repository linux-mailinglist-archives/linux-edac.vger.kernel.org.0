Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA12339A28
	for <lists+linux-edac@lfdr.de>; Sat, 13 Mar 2021 00:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbhCLXsy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Fri, 12 Mar 2021 18:48:54 -0500
Received: from mga17.intel.com ([192.55.52.151]:60337 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235917AbhCLXsf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 12 Mar 2021 18:48:35 -0500
IronPort-SDR: zvGsp/lYoTNcTDolUZlvQVsfiOCLUMS8A+jXMjg+uvIqQ3BSHnF9M5pBvzn5JTw1M/je1/krZm
 18+d1eYA/l/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="168822009"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="168822009"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 15:48:32 -0800
IronPort-SDR: eU82mLSqcCkLWvqZYcSZQVkkNBFocFGN+1m26nc2uVQbSnZahEsgExEJmQGe4pwUfLdTG/q96a
 RMCoALwfuXig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="604110535"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 12 Mar 2021 15:48:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Mar 2021 15:48:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Mar 2021 15:48:31 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Fri, 12 Mar 2021 15:48:31 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aili Yao <yaoaili@kingsoft.com>
CC:     =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        "sunhao2@kingsoft.com" <sunhao2@kingsoft.com>
Subject: RE: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Topic: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Index: AQHXCnz5ja9ELypBUEatGW66U99st6pnoa2AgAEgN4CAAIHfAIAAAyEAgAAQXwD//9g7gIABDSmAgAALNoCAB2DqAIAAiu0AgABOzQD//+3L0IABObiAgAAiT4CAACi3AIAAmjmAgACgEACAAGnOwIAHwDQAgAHAYACAAADA4IABX0yAgAAnh8CAAHr7MA==
Date:   Fri, 12 Mar 2021 23:48:31 +0000
Message-ID: <af80221baed940d8bcc643e3e7d40036@intel.com>
References: <20210303115710.2e9f8e23@alex-virtual-machine>
        <20210303163912.3d508e0f@alex-virtual-machine>
        <1a78e9abdc134e35a5efcbf6b2fd2263@intel.com>
        <20210304101653.546a9da1@alex-virtual-machine>
        <20210304121941.667047c3@alex-virtual-machine>
        <20210304144524.795872d7@alex-virtual-machine>
        <20210304235720.GA215567@agluck-desk2.amr.corp.intel.com>
        <20210305093016.40c87375@alex-virtual-machine>
        <aee5176eafb54c88b19a5b2671d0a1fc@intel.com>
        <20210310141042.4db9ea29@alex-virtual-machine>
        <20210311085529.GA22268@hori.linux.bs1.fc.nec.co.jp>
        <db80e98d2b264e988596d0d7d7c8a776@intel.com>
 <20210312135531.72e33b35@alex-virtual-machine>
 <3900f518d1324c388be52cf81f5220e4@intel.com>
In-Reply-To: <3900f518d1324c388be52cf81f5220e4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

>> will memory_failure() find it and unmap it? if succeed, then the current will be
>> signaled with correct vaddr and shift?
>
> That's a very good question.  I didn't see a SIGBUS when I first wrote this code,
> hence all the p->mce_vaddr.  But now I'm
> a) not sure why there wasn't a signal
> b) if we are to fix the problems noted by AndyL, need to make sure that there isn't a SIGBUS

Tests on upstream kernel today show that memory_failure() is both unmapping the page
and sending a SIGBUS.


My biggest issue with the KERNEL_COPYIN recovery path is that we don't have code
to mark the page not present while we are still in do_machine_check().  That's resulted
in recovery working for simple cases where there is a single get_user() call followed by
an error return if that failed. But more complex cases require more machine checks and
a touching faith that the kernel will eventually give up trying (spoiler: it sometimes doesn't).

Thanks to the decode of the instruction we do have the virtual address. So we just need
a safe walk of pgd->p4d->pud->pmd->pte (truncated if we hit a huge page) with a write
of a "not-present" value. Maybe a different poison type from the one we get from
memory_failure() so that the #PF code can recognize this as a special case and do any
other work that we avoided because we were in #MC context.

-Tony
