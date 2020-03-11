Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F15CB181D25
	for <lists+linux-edac@lfdr.de>; Wed, 11 Mar 2020 17:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgCKQFJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Wed, 11 Mar 2020 12:05:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:2894 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729956AbgCKQFJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 11 Mar 2020 12:05:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 09:05:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="441729684"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga005.fm.intel.com with ESMTP; 11 Mar 2020 09:05:07 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 11 Mar 2020 09:05:07 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.100]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.148]) with mapi id 14.03.0439.000;
 Wed, 11 Mar 2020 09:05:07 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Wei Huang <wei.huang2@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "bp@suse.de" <bp@suse.de>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "smita.koralahallichannabasappa@amd.com" 
        <smita.koralahallichannabasappa@amd.com>
Subject: RE: [PATCH 1/1] x86/mce/amd: Add PPIN support for AMD MCE
Thread-Topic: [PATCH 1/1] x86/mce/amd: Add PPIN support for AMD MCE
Thread-Index: AQHV91/AwhhvsPm2/U2ZVZmNlYO+oqhDjQBg
Date:   Wed, 11 Mar 2020 16:05:07 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F59AA85@ORSMSX115.amr.corp.intel.com>
References: <20200311044409.2717587-1-wei.huang2@amd.com>
In-Reply-To: <20200311044409.2717587-1-wei.huang2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

+		if ((val & 3UL) == 2UL)
+			set_cpu_cap(c, X86_FEATURE_PPIN);

You may have copied a bug of mine from upstream. We recently found
a system where the BIOS enabled PPIN and set the lock bit.

If that is possible on AMD, then you should just check for enabled at this
point. "if (val & 2UL)"

See this commit in TIP tree:

59b5809655bd ("x86/mce: Fix logic and comments around MSR_PPIN_CTL")

Otherwise looks fine:

Acked-by: Tony Luck <tony.luck@intel.com>

-Tony
