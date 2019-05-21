Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9B025950
	for <lists+linux-edac@lfdr.de>; Tue, 21 May 2019 22:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfEUUmk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 21 May 2019 16:42:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:18009 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfEUUmk (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 21 May 2019 16:42:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 13:42:40 -0700
X-ExtLoop1: 1
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by FMSMGA003.fm.intel.com with ESMTP; 21 May 2019 13:42:40 -0700
Date:   Tue, 21 May 2019 13:42:40 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 4/6] x86/MCE: Make number of MCA banks per_cpu
Message-ID: <20190521204239.GA11029@agluck-desk>
References: <20190430203206.104163-1-Yazen.Ghannam@amd.com>
 <20190430203206.104163-5-Yazen.Ghannam@amd.com>
 <20190518112530.GA26276@zn.tnic>
 <SN6PR12MB2639571E33EBC7342A0607F8F8070@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190521202902.GC7793@cz.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521202902.GC7793@cz.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 21, 2019 at 10:29:02PM +0200, Borislav Petkov wrote:
> 
> Can we do instead:
> 
> -static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank *, mce_banks_array);
> +static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank, mce_banks_array[MAX_NR_BANKS]);
> 
> which should be something like 9*32 = 288 bytes per CPU.
> 

Where did you get the "9" from?  struct mce_bank looks to
be over 50 bytes.

Still only 1.5K per cpu though.

-Tony
