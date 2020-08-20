Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9ED24C523
	for <lists+linux-edac@lfdr.de>; Thu, 20 Aug 2020 20:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgHTSPS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Thu, 20 Aug 2020 14:15:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:44367 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgHTSPS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 20 Aug 2020 14:15:18 -0400
IronPort-SDR: DrFNCJcmLMEC+n/pCDHCGtLctmaoW0YqYGB1nK7vXaUCpJZ4VKExf2OXzO+m3kXMpGCZgfwAWY
 bui9zyH130eA==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="135440282"
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="135440282"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 11:15:16 -0700
IronPort-SDR: a28MDPoGhY3ZbwPZkRwnx4UXMCZSupMHkurC+C6FkeY/JDGHUBmNp/SCnIeaPn/P4aVkUYLRrM
 guQdsxgdmWMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="278702644"
Received: from fmsmsx603-2.cps.intel.com (HELO fmsmsx603.amr.corp.intel.com) ([10.18.84.213])
  by fmsmga007.fm.intel.com with ESMTP; 20 Aug 2020 11:15:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Aug 2020 11:15:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Aug 2020 11:15:15 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Thu, 20 Aug 2020 11:15:15 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH] x86/mce: Increase maximum number of banks to 64
Thread-Topic: [PATCH] x86/mce: Increase maximum number of banks to 64
Thread-Index: AQHWdxRMOUugzLYNmEqR71NB1yUYSKlBsiQAgAAMvQD//43q0A==
Date:   Thu, 20 Aug 2020 18:15:15 +0000
Message-ID: <6ecac9c40d7b4491b9a87c8927a4aca6@intel.com>
References: <20200820170624.1855825-1-Yazen.Ghannam@amd.com>
 <20200820171518.GB17271@zn.tnic> <20200820180054.GA2033274@yaz-nikka.amd.com>
In-Reply-To: <20200820180054.GA2033274@yaz-nikka.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

>> How much does vmlinux size grow with your change?
>>
>
> It seems to get smaller.
>
> -rwxrwxr-x   1 yghannam yghannam 807634088 Aug 20 17:51 vmlinux-32banks
> -rwxrwxr-x   1 yghannam yghannam 807634072 Aug 20 17:50 vmlinux-64banks

You need to run:

$ size vmlinux
   text    data     bss     dec     hex filename
20334755        12569682        14798924        47703361        2d7e541 vmlinux

Likely the extra space is added to the third element ("bss"). That doesn't show
up in the vmlinux file, but does add to memory footprint while running.

-Tony
