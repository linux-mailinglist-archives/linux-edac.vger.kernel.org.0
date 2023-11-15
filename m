Return-Path: <linux-edac+bounces-24-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688BB7EB927
	for <lists+linux-edac@lfdr.de>; Tue, 14 Nov 2023 23:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B93FEB20A50
	for <lists+linux-edac@lfdr.de>; Tue, 14 Nov 2023 22:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2852E82B;
	Tue, 14 Nov 2023 22:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SgnO5N3g"
X-Original-To: linux-edac@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1E2E82A
	for <linux-edac@vger.kernel.org>; Tue, 14 Nov 2023 22:04:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6329CD3;
	Tue, 14 Nov 2023 14:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699999489; x=1731535489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bO2MaK8085CtqTUh+1DTNmOM9z7MqhltlidbwclV2dY=;
  b=SgnO5N3gwDIXtoxuyj8mmxZSEjzRDk/hjrAaa3R62wpjg8waqsK1MdIp
   gGUUKVH+R8DW1S8GwlETSs2jqy9M/f5yYnqFwleGR/OAycj7FyjF/nb/9
   /eXZgFb3/WH31mp/kdlHz1Kh9LZCmh7dp9ule+bSWp0m8uq7lfYVMt1px
   fVfe3O0tJWgX6AQK0y+upJ2GLimodGmSspU/2o4F0iXRGTBs/JB+mordF
   zBG7LX9xb5o36jdEtePn4mdd3xKvLCIvs3Zh0vQ+vEQonu30e6sTBj+ql
   Ju1kLCj25BfjMb49Xx82Esnzf1+ZnFDAUWpf3MK7uPGOkvthhx7nD0p6D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="370950897"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="370950897"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 14:04:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="888392403"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="888392403"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 14:04:48 -0800
Date: Tue, 14 Nov 2023 14:04:46 -0800
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Smita.KoralahalliChannabasappa@amd.com, dave.hansen@linux.intel.com,
	x86@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
Message-ID: <ZVPu/hX9b7lUkrBY@agluck-desk3>
References: <20230929181626.210782-1-tony.luck@intel.com>
 <20231004183623.17067-1-tony.luck@intel.com>
 <20231004183623.17067-3-tony.luck@intel.com>
 <20231019151211.GHZTFHS3osBIL1IJbF@fat_crate.local>
 <ZTa37L2nlnbok8dz@agluck-desk3>
 <20231114192324.GAZVPJLGZmfJBS181/@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114192324.GAZVPJLGZmfJBS181/@fat_crate.local>

On Tue, Nov 14, 2023 at 08:23:24PM +0100, Borislav Petkov wrote:
> On Mon, Oct 23, 2023 at 11:14:04AM -0700, Tony Luck wrote:
> > I want to track whether each bank is in storm mode, or not. But there's
> > no indication when a CMCI is delivered which bank was the source. Code
> > just has to scan all the banks, and might find more than one with an
> > error. While no bank is in polling mode, there isn't a set time interval
> > between scanning banks.
> 
> Well, if no bank is in *storm* polling mode - I presume you mean that
> when you say "polling mode" - then we have the default polling interval
> of machine_check_poll() of INITIAL_CHECK_INTERVAL, i.e., 5 mins, I'd
> say.

Initial state is that no banks are in storm mode. Errors logged in any
bank are signaled with a CMCI to all logical CPUs that share that bank.
But the "mce_banks_owned" per-cpu bitmask means that only one of those
CPUs will get past the test_bit() check at the top of the loop in
machine_check_poll():

        for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
                if (!mce_banks[i].ctl || !test_bit(i, *b))
                        continue;

Before any storm happens, machine_check_poll() may only be called once
a month, or less, when errors occur.

When a storm is detected for a bank, that bank (and any others in storm
mode) will be checked once per second.

> > A scan is just triggered when a CMCI happens. So it's non-trivial to
> > compute a rate. Would require saving a timestamp for every logged
> > error.
> 
> So what I'm trying to establish first is, what our entry vectors into
> the storm code are.
> 
> 1. You can enter storm tracking when you poll normally. I.e.,
>    machine_check_poll() each 5 mins once.

For a bank that doesn't support CMCI, then polling is the only way
to find errors. You are right, these will feed into the history
tracker, but while at 5-minute interval will not be able to trigger
a storm. Since that 5-minute interval is halved every time error is
found consecutively, it is possible at the 1-second poll interval to
fill out enough bits to indicate a storm. I think I need to add some
code to handle that case as it makes no sense to mess with the CMCI
threshold in IA32_MCi_CTL2 for a bank that doesn't support CMCI.
Probably will just skip tracking for any such banks.

>    mce_track_storm() tracks history only for MCI_STATUS_VAL=1b CEs, which
>    is what I was wondering. It is hidden a bit down in that function.
> 
> 2. As a result of a CMCI interrupt. That will call machine_check_poll()
>    too and go down the same path.
> 
> So that flow should be called out in the commit message so that the big
> picture is clear - how we're doing that storm tracking.

Yes. Those are both inputs to the storm tracker. I'll update the commit
message to describe that.

> Now, what is protecting this against concurrent runs of
> machine_check_poll()? Imagine the timer fires and a CMCI happens at the
> same time and on the same core.

Aren't interrupts disabled while running the code after the timer fires?
Whichever of the timer and the CMCI happens first will run. Second to
arrive will pend the interrupt and be handled when interrupts are
enabled as the first completes.

... rest of message trimmed, no open discussion items there.

-Tony

