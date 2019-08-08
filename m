Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEB2486C0B
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2019 23:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfHHVFN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Thu, 8 Aug 2019 17:05:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:59112 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbfHHVFN (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 8 Aug 2019 17:05:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 14:05:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,362,1559545200"; 
   d="scan'208";a="186471669"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga002.jf.intel.com with ESMTP; 08 Aug 2019 14:05:12 -0700
Received: from orsmsx124.amr.corp.intel.com (10.22.240.120) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 8 Aug 2019 14:05:12 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.6]) by
 ORSMSX124.amr.corp.intel.com ([169.254.2.63]) with mapi id 14.03.0439.000;
 Thu, 8 Aug 2019 14:05:11 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Stephen Douthit <stephend@silicom-usa.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC, pnd2: Fix ioremap() size in dnv_rd_reg() from 64K
 -> 32K
Thread-Topic: [PATCH] EDAC, pnd2: Fix ioremap() size in dnv_rd_reg() from
 64K -> 32K
Thread-Index: AQHVTiskHjYyDh8ZF0eccCUFKX9IfabxvLZQ
Date:   Thu, 8 Aug 2019 21:05:10 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F416946@ORSMSX115.amr.corp.intel.com>
References: <20190808205147.25547-1-stephend@silicom-usa.com>
In-Reply-To: <20190808205147.25547-1-stephend@silicom-usa.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmFmMTkyZWUtOWQ1Ni00MTQzLWEwMTktOWVlNjcwN2FkMzg2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoid3BpUlBHTUpGQkFieDViZnpZOE9sYmlQbGVjNVZDWmtLT3RHUU1OUTBSKzE5VzhUK1FleHpZSE1JTGdTTlphaSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

-		base = ioremap((resource_size_t)addr, 0x10000);
+		base = ioremap((resource_size_t)addr, 0x8000);

Changing one magic value for another.  :-(

Do different BIOS do different things?  I don't recall seeing this error
(but perhaps I missed it, or perhaps the kernel has added better checks).

If this number is at the whim of the BIOS, is there some way to
figure out what is the right value on a specific implementation?

-Tony
