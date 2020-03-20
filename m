Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3D5E18DA03
	for <lists+linux-edac@lfdr.de>; Fri, 20 Mar 2020 22:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCTVJd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Fri, 20 Mar 2020 17:09:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:57838 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgCTVJc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 20 Mar 2020 17:09:32 -0400
IronPort-SDR: LxgOgxgznAo4msQlLblk4Wif1FgwUATYG/JulmEwSNjEyjplwoeCCBDBzdyMKfRC9IDbfrEPg9
 oYJR2DUZ4UcQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 14:09:32 -0700
IronPort-SDR: LUEt3r3KJDk1vUWMuhI4tievXJrHC+iPEvvACtJw1waq1DqF5WxC0DTorkzBmPULg1QDWb5240
 Mu6+YY8m4/kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,286,1580803200"; 
   d="scan'208";a="237327604"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga007.fm.intel.com with ESMTP; 20 Mar 2020 14:09:32 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.102]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.6]) with mapi id 14.03.0439.000;
 Fri, 20 Mar 2020 14:09:32 -0700
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
Subject: RE: [PATCH V2 1/1] x86/mce/amd: Add PPIN support for AMD MCE
Thread-Topic: [PATCH V2 1/1] x86/mce/amd: Add PPIN support for AMD MCE
Thread-Index: AQHV/u/OOpAw4hNzbky7vzrJSNSJL6hR+Ysw
Date:   Fri, 20 Mar 2020 21:09:31 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F5B7CE7@ORSMSX115.amr.corp.intel.com>
References: <20200320194305.3532606-1-wei.huang2@amd.com>
In-Reply-To: <20200320194305.3532606-1-wei.huang2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
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

Acked-by: Tony Luck <tony.luck@intel.com>

Still true for this new version.

-Tony

