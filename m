Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569BE3AE08D
	for <lists+linux-edac@lfdr.de>; Sun, 20 Jun 2021 23:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFTVKh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Sun, 20 Jun 2021 17:10:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:49973 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230211AbhFTVKg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 20 Jun 2021 17:10:36 -0400
IronPort-SDR: cVmc/qwAv0SENsiG5xf84sDK3g3RWIWZLCTgoyF5+S45ukYRXhsYECykNqGtbPuTHLRlnJv0Oy
 lzaUf2cG1qWw==
X-IronPort-AV: E=McAfee;i="6200,9189,10021"; a="193881080"
X-IronPort-AV: E=Sophos;i="5.83,288,1616482800"; 
   d="scan'208";a="193881080"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2021 14:08:23 -0700
IronPort-SDR: LoETC79phESlLsHLXENMdPX+o3OVdAnbaw1KZvlfwip+5kqIjQ/NVTOgdEvp/pk8peT8m1dvPT
 zDSJOj6lHzaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,288,1616482800"; 
   d="scan'208";a="453686096"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jun 2021 14:08:23 -0700
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sun, 20 Jun 2021 14:08:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 SHSMSX606.ccr.corp.intel.com (10.109.6.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 21 Jun 2021 05:08:19 +0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.008;
 Sun, 20 Jun 2021 14:08:17 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH] EDAC/igen6: fix core dependency
Thread-Topic: [PATCH] EDAC/igen6: fix core dependency
Thread-Index: AQHXZSR20xaNNpx7sU2QBycvvxKAS6sdZfpA
Date:   Sun, 20 Jun 2021 21:08:17 +0000
Message-ID: <7b21e5405e4b4838b2b469fcf67eb40e@intel.com>
References: <20210619160203.2026-1-rdunlap@infradead.org>
In-Reply-To: <20210619160203.2026-1-rdunlap@infradead.org>
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

> igen6_edac needs mce_register()/unregister() functions,
> so it should depend on X86_MCE (or X86_MCE_INTEL).

Thanks Randy

Also reported by the lkp robot (e-mail from the robot got to
me about six hours after your fix).

Applied.

-Tony
