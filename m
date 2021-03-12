Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18E4339365
	for <lists+linux-edac@lfdr.de>; Fri, 12 Mar 2021 17:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhCLQ3s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Fri, 12 Mar 2021 11:29:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:59180 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232005AbhCLQ3r (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 12 Mar 2021 11:29:47 -0500
IronPort-SDR: HbCqPIK8EYH03sr8G7Tq7VHevrTUnXZNLYXcmb2GfGwisTAB4fUL2+DZha0hH0yGprrGoHIJEj
 DAjXCdoClRQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="185497514"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="185497514"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 08:29:39 -0800
IronPort-SDR: xfqavqvf/Q0gVTpWY4GxfHOXj9kaFU8+WFvbVgS8pgLZG1ix1w4s9a3BS98RLT7M+ItzKo7tSo
 qEGAsaM36rYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="387388874"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 12 Mar 2021 08:29:39 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Mar 2021 08:29:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Mar 2021 08:29:38 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Fri, 12 Mar 2021 08:29:38 -0800
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
Thread-Index: AQHXCnz5ja9ELypBUEatGW66U99st6pnoa2AgAEgN4CAAIHfAIAAAyEAgAAQXwD//9g7gIABDSmAgAALNoCAB2DqAIAAiu0AgABOzQD//+3L0IABObiAgAAiT4CAACi3AIAAmjmAgACgEACAAGnOwIAHwDQAgAHAYACAAADA4IABX0yAgAAnh8A=
Date:   Fri, 12 Mar 2021 16:29:37 +0000
Message-ID: <3900f518d1324c388be52cf81f5220e4@intel.com>
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
In-Reply-To: <20210312135531.72e33b35@alex-virtual-machine>
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

> Sorry to interrupt as I am really confused here:
> If it's a copyin case, has the page been mapped for the current process?

Yes. The kernel has the current process mapped to the low address range
and code like get_user(), put_user() "simply" reaches down to those addresses
(maybe not so simply, as the access needs to be within a STAC/CLAC section
of code on modern CPUs, and the access instruction needs an entry in EXTABLE
so that the page fault handler can fix it if there isn't a page mapped at the user
address).

> will memory_failure() find it and unmap it? if succeed, then the current will be
> signaled with correct vaddr and shift?

That's a very good question.  I didn't see a SIGBUS when I first wrote this code,
hence all the p->mce_vaddr.  But now I'm
a) not sure why there wasn't a signal
b) if we are to fix the problems noted by AndyL, need to make sure that there isn't a SIGBUS

> Maybe the mce_vaddr is set correctly, but we may lost the correct page shift?
Yes. There is a hard-coded PAGE_SHIFT for this case - which may not match the actual page size.

> And for copyin case, we don't need to call set_mce_nospec()?
Yes. We should.

Thanks for your good questions.

-Tony
