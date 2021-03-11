Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC31337A69
	for <lists+linux-edac@lfdr.de>; Thu, 11 Mar 2021 18:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhCKRGY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Thu, 11 Mar 2021 12:06:24 -0500
Received: from mga03.intel.com ([134.134.136.65]:17589 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230046AbhCKRF4 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 11 Mar 2021 12:05:56 -0500
IronPort-SDR: sxolkFIWZJZtgDX2iitjkpbdMW3EwlRVC5T3c9Q+ZUaOtfmZwsAWTLaaJzfJdKGjlDHeuQfShi
 3utg7r/YMeyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="188739272"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="188739272"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 09:05:55 -0800
IronPort-SDR: UnBMPMNAmjlV2lOgE13+gfTJozcsEO11D+J/l9JEvw33mJDqzC0k9EivlWoaoCOoaNpc9n0Wfa
 PAmHtPuL316g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="372391140"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 11 Mar 2021 09:05:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Mar 2021 09:05:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Mar 2021 09:05:54 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Thu, 11 Mar 2021 09:05:54 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>, Aili Yao <yaoaili@kingsoft.com>
CC:     Oscar Salvador <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
Subject: RE: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Topic: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Index: AQHXCnz5ja9ELypBUEatGW66U99st6pnoa2AgAEgN4CAAIHfAIAAAyEAgAAQXwD//9g7gIABDSmAgAALNoCAB2DqAIAAiu0AgABOzQD//+3L0IABObiAgAAiT4CAACi3AIAAmjmAgACgEACAAGnOwIAHwDQAgAHAYACAAADA4A==
Date:   Thu, 11 Mar 2021 17:05:53 +0000
Message-ID: <db80e98d2b264e988596d0d7d7c8a776@intel.com>
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
In-Reply-To: <20210311085529.GA22268@hori.linux.bs1.fc.nec.co.jp>
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

> I guess that p->mce_vaddr stores the virtual address of the error here.
> If so, sending SIGBUS with the address looks enough as we do now, so why
> do you walk page table to find the error virtual address?

p->mce_vaddr only has the virtual address for the COPYIN case. In that code
path we decode the kernel instruction that hit the fault in order to find the virtual
address. That's easy because:

1) The kernel RIP is known to be good (can't page fault etc. on kernel address).
2) There are only a half dozen instructions used by the kernel for get_user() or
     copy_from_user().

When the machine check happens during user execution accessing poison data
we only have the physical address (from MCi_ADDR).

-Tony
