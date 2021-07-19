Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099D63CEF7D
	for <lists+linux-edac@lfdr.de>; Tue, 20 Jul 2021 00:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbhGSWQE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Mon, 19 Jul 2021 18:16:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:29438 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1387923AbhGSUih (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 19 Jul 2021 16:38:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="272247948"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="272247948"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 14:16:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="500060605"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2021 14:16:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 19 Jul 2021 14:16:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 19 Jul 2021 14:16:58 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.010;
 Mon, 19 Jul 2021 14:16:58 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>
Subject: RE: [PATCH 3/7] EDAC/mc: Add new HBM2 memory type
Thread-Topic: [PATCH 3/7] EDAC/mc: Add new HBM2 memory type
Thread-Index: AQHXfN9g3bq+MffDR0eiB1M8/p7+KatKyi7w
Date:   Mon, 19 Jul 2021 21:16:58 +0000
Message-ID: <df4b694601a947d5b6f3d87c5d776807@intel.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210630152828.162659-4-nchatrad@amd.com>
 <20210719204758.GC19451@aus-x-yghannam.amd.com>
In-Reply-To: <20210719204758.GC19451@aus-x-yghannam.amd.com>
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
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> The following commit added HBM support to some Intel EDAC code.
>
>  c945088384d0 EDAC/i10nm: Add support for high bandwidth memory
>
> But it didn't include a new mem_type for HBM. Should it have?
>
> I only see some edac_mem_types use in sysfs and some debug messages. So
> I'm curious if users find this information useful.

Yazen,

That commit makes the normal vs. HBM error visible in the DIMM label (by
prefixing the "MC" for memory controller with "HB".

+       if (imc->hbm_mc)
+               snprintf(dimm->label, sizeof(dimm->label), "CPU_SrcID#%u_HBMC#%u_Chan#%u",
+                        imc->src_id, imc->lmc, chan);
+       else
+               snprintf(dimm->label, sizeof(dimm->label), "CPU_SrcID#%u_MC#%u_Chan#%u_DIMM#%u",
+                        imc->src_id, imc->lmc, chan, dimmno);

Perhaps we should also set the "type" of the DIMMs.  Qiuxu: opinion?

-Tony
