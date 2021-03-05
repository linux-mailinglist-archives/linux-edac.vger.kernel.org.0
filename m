Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F088D32EF6D
	for <lists+linux-edac@lfdr.de>; Fri,  5 Mar 2021 16:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhCEP4H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Fri, 5 Mar 2021 10:56:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:8779 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhCEPzj (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 5 Mar 2021 10:55:39 -0500
IronPort-SDR: iHS4aYdZNb29tq78K+skSwAdpByp8f+BcjKPWwKMdkImdesIa3cr1h+CtT6XRAOksggPIczqxG
 Wx8WJwoG9pKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9914"; a="174784783"
X-IronPort-AV: E=Sophos;i="5.81,225,1610438400"; 
   d="scan'208";a="174784783"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 07:55:38 -0800
IronPort-SDR: g2IE4/xh26TdLdJLaJusSg3SlMhFGhFxYRqpXZJ7BtZvE/ty3iHHv7fKdLHTjnZ2xTGkVqR+J6
 4qC2bhF0d6LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,225,1610438400"; 
   d="scan'208";a="384953365"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 05 Mar 2021 07:55:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 5 Mar 2021 07:55:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 5 Mar 2021 07:55:25 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Fri, 5 Mar 2021 07:55:25 -0800
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
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
Subject: RE: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Topic: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Index: AQHXCnz5ja9ELypBUEatGW66U99st6pnoa2AgAEgN4CAAIHfAIAAAyEAgAAQXwD//9g7gIABDSmAgAALNoCAB2DqAIAAiu0AgABOzQD//+3L0IABObiAgAAiT4CAACi3AIAAmjmAgACgEACAAGnOwA==
Date:   Fri, 5 Mar 2021 15:55:25 +0000
Message-ID: <aee5176eafb54c88b19a5b2671d0a1fc@intel.com>
References: <20210225181542.GA178925@agluck-desk2.amr.corp.intel.com>
        <20210226021907.GA27861@hori.linux.bs1.fc.nec.co.jp>
        <20210226105915.6cf7d2b8@alex-virtual-machine>
        <20210303033953.GA205389@agluck-desk2.amr.corp.intel.com>
        <20210303115710.2e9f8e23@alex-virtual-machine>
        <20210303163912.3d508e0f@alex-virtual-machine>
        <1a78e9abdc134e35a5efcbf6b2fd2263@intel.com>
        <20210304101653.546a9da1@alex-virtual-machine>
        <20210304121941.667047c3@alex-virtual-machine>
        <20210304144524.795872d7@alex-virtual-machine>
        <20210304235720.GA215567@agluck-desk2.amr.corp.intel.com>
 <20210305093016.40c87375@alex-virtual-machine>
In-Reply-To: <20210305093016.40c87375@alex-virtual-machine>
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

> From the walk, it seems we have got the virtual address, can we just send a SIGBUS with it?

If the walk wins the race and the pte for the poisoned page is still valid, then yes.

But we could have:

CPU1                            CPU2
memory_failure sets poison
bit for struct page


rmap finds page in task
on CPU2 and sets PTE
to not-valid-poison

                                memory_failure returns
                                early because struct page
                                already marked as poison

                                walk page tables looking
                                for mapping - don't find it

-Tony
