Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551CE374BC0
	for <lists+linux-edac@lfdr.de>; Thu,  6 May 2021 01:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhEEXOa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Wed, 5 May 2021 19:14:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:28412 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhEEXO2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 5 May 2021 19:14:28 -0400
IronPort-SDR: R0eynmIc6B9nFbPKMwSuUl7ubeoTiiRbLeGqT5RR2AxucKweGS01Sz+3sbMqIcnjXu0CcVkFZb
 lvkSIEDrWZQg==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="185790812"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="185790812"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 16:13:31 -0700
IronPort-SDR: JtNRit5eVng05dldqvlehV+SyrHwPbQrRBdsXvYUZ/yqu1FmmcQyh+R0VcnnDthakjpKfW4hle
 MRsCVRfBRPJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="428324716"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 05 May 2021 16:13:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 5 May 2021 16:13:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 5 May 2021 16:13:30 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Wed, 5 May 2021 16:13:30 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Borislav Petkov <bp@alien8.de>
CC:     wangglei <wangglei@gmail.com>,
        "Lei Wang (DPLAT)" <Wang.Lei@microsoft.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hang Li <hangl@microsoft.com>,
        Brandon Waller <bwaller@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH] EDAC: update edac printk wrappers to use
 printk_ratelimited.
Thread-Topic: [EXTERNAL] Re: [PATCH] EDAC: update edac printk wrappers to use
 printk_ratelimited.
Thread-Index: AQHXQdRdJYHRX8nk2Ei54dInHCnYRqrVou8AgAAREgCAAAv0gIAACuGAgAALZQCAAAxOAIAAA+cAgAADu4CAAAfJgIAAAxYAgAAB6wD//40xMA==
Date:   Wed, 5 May 2021 23:13:30 +0000
Message-ID: <d727342c294b4d40b411dc25cbd3266f@intel.com>
References: <YJLdZCcsgWG6TrKz@zn.tnic>
 <SJ0PR21MB199984A8B47FBEECEC5D11CE90599@SJ0PR21MB1999.namprd21.prod.outlook.com>
 <YJL1vU6HNBWPKy8g@zn.tnic> <20210505202357.GC4967@sequoia>
 <YJMIbB31oEDaXm0C@zn.tnic> <20210505214846.GE4967@sequoia>
 <YJMWBBBlQ6TwFad9@zn.tnic> <20210505221605.GF4967@sequoia>
 <20210505224357.GG4967@sequoia> <YJMiRF8D3EG28d2V@zn.tnic>
 <20210505230152.GH4967@sequoia>
In-Reply-To: <20210505230152.GH4967@sequoia>
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

>> What is your situation? ARM?
>
> Yes, though I'm not sure if those additional features are
> important/useful enough for us to generalize that driver. The main
> motivation here was just to prevent storage/network from being flooded
> by obviously-bad nodes that haven't been offlined yet. :) 
>
> Lei and others on cc will need to evaluate porting cec.c and what it
> will gain them. Thanks again.

Tyler,

You might also look at the x86 "storm" detection code (tl;dr version
"If error interrupts are coming too fast, turn off the interrupts and poll").

-Tony 
