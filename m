Return-Path: <linux-edac+bounces-1556-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68902937406
	for <lists+linux-edac@lfdr.de>; Fri, 19 Jul 2024 08:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA2F281680
	for <lists+linux-edac@lfdr.de>; Fri, 19 Jul 2024 06:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ECF37703;
	Fri, 19 Jul 2024 06:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="mnOBR2l2"
X-Original-To: linux-edac@vger.kernel.org
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A41229CE6;
	Fri, 19 Jul 2024 06:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721370335; cv=none; b=fDcsi1EkQhRO6hsEGklBgYHyX5f5VXMlT2ToqJqsg5iHW2oLMgTL6TLvN88um9ZuSXFV8K3cI5KtThxebT4wr927ozWw74H0v9qL2dnMsVwsd/JZXNwZVjaEr5qDEnRg03BwedZcTqmwfL2Sn3pDICPfHT2SvQxswOMxGuHtfGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721370335; c=relaxed/simple;
	bh=j2S2BiTnFjnMDCqHjpzb2VhUaNfciznSi4vJjRSF6QU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sWnKIx5YUOviOeaEVTS3hytjNvmYYkXBZaeNPuMd2QP4ZFroCSyQEhR4xuoSlbkP6TeeB+0RU4UwWW8H9cJcDtOhAQ8siGDz640B6qnw2HYrcLth2/G+gqoBcSPpkP3PDGKs1Pl/FOuxCGcbKMURpjQnpOnT+lbTJI7Q1cdrAD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=mnOBR2l2; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1721370333; x=1752906333;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=j2S2BiTnFjnMDCqHjpzb2VhUaNfciznSi4vJjRSF6QU=;
  b=mnOBR2l2otRCYjWfSu8Gbicm/DDvDBuDVucFy/TFWFM7mRIy9RaLDT5m
   TrtUcFdViW5sv0/Gu7At9t7c5OZyY/V5WpiZP9Psg4KiSZ9vc+5rPelKf
   9Xj5dZG7td1AVrdpbDGWX0Xkfra1IFrCvHA6GlnFTIsRYrwxKATplt20A
   FrRQus8HKYT3pKvWwB+xQoLyr00cQ+jmTMauG4HUtO+QXxsVrUpcbQDjQ
   i4H/ggOLYlOB7IRte78NZpwnog3lWQl4WpDHVjPJXG/kaMZJPm26nRN2r
   0vefodNrelTWLq/9E5Q5HiBz7TRnyLMhGLIgC0JjsLKVOgfo/Q8Z8EVEZ
   g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="167905339"
X-IronPort-AV: E=Sophos;i="6.09,220,1716217200"; 
   d="scan'208";a="167905339"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 15:24:19 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 702C8E8521;
	Fri, 19 Jul 2024 15:24:16 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id A2560E67B1;
	Fri, 19 Jul 2024 15:24:15 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3078620086312;
	Fri, 19 Jul 2024 15:24:15 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 6343B1A000A;
	Fri, 19 Jul 2024 14:24:13 +0800 (CST)
Message-ID: <1d98c0a9-3981-4a01-890a-00eb763a140c@fujitsu.com>
Date: Fri, 19 Jul 2024 14:24:13 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
 linux-edac@vger.kernel.org
Cc: dan.j.williams@intel.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 dave@stgolabs.net, ira.weiny@intel.com, alison.schofield@intel.com,
 dave.jiang@intel.com, vishal.l.verma@intel.com,
 Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
In-Reply-To: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28538.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28538.003
X-TMASE-Result: 10--24.299000-10.000000
X-TMASE-MatchedRID: Ef5f9TJi2wePvrMjLFD6eKn9fPsu8s0a2q80vLACqaeqvcIF1TcLYCxz
	RYsJiUavTn58gKg8la7m3gC+nXarcZcLewwAa76fs/Hes76OTZCNTfm/w05jw56fSoF3Lt+MnRw
	gpbfXKvNRzAfF54kYaWowq23ynEFcWHT+0u4LwuT+xRIVoKNMvH5Lmbb/xUua13kaiNHAkIBlWG
	AuNI6Sxsz9lPfBq+1F7abh56CWkbN/s7IOpKdgtxFbgtHjUWLyutt2Dch6FcotferJ/d7Ab5/1F
	vKGn+lPEEqtRysSflO46UHmTVPkFB63VPG+eA2DrMZ+BqQt2NpDVmiiHQSFeAtLaYWP8cGHuua+
	F17fpzj7EH8CyiIGBt6nuB9VOJmrWrN4/58ppmLTCZHfjFFBz7JOtZXi/DJf1xSe1t5SKeM7ETv
	uQ225CXsDbTFoPmjmf+pDHdeWxgz4eXMWsO1RDPUDwTduLUkchCDQXoQcDah9ZDXSzHFFNzd7cd
	HHAIr1Wb1EFD5Yly4kAchtY7c9mnzh4vqEo4GEtT4jIeGRd/Vcsgu/IQFPzk8XS5YwROOZRtUL4
	XifTntJN5dsWcjr6TpA5K9m1Jp8/bu+3CdDf0BZNYSHk3Zr0eOaAxDXuHnryPRAwD/3abYYrur/
	gtBkqOHJnvo8jZJC7wQR4QooTK5VmyN0+mvk2EXBhxFdFgcQrECF/8Y+iZ+PaLJ/Ca3ST28GLH2
	U1HrNpFedpgCFxaXJVWLjSiZxbnAA9eFj9SfYngIgpj8eDcBZDL1gLmoa/CGj6i653v+C7nY51l
	wLq0+8QIu4z6HhEH7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0


在 2024/6/19 0:53, Shiyang Ruan 写道:
> 
> This patch adds a new notifier_block and MCE_PRIO_CXL, for CXL memdev
> to check whether the current poison page has been reported (if yes,
> stop the notifier chain, won't call the following memory_failure()
> to report), into `x86_mce_decoder_chain`.  In this way, if the poison
> page already handled(recorded and reported) in (1) or (2), the other one
> won't duplicate the report.  The record could be clear when
> cxl_clear_poison() is called.

Hi guys,

I'd like to sort out the work I am currently carrying forward, to make 
sure I'm not going in the wrong direction. Please correct me if anything 
is wrong.

As is known to us, CXL spec defines POISON feature to notify its status 
when CXL memory device got a broken page.  Basically, there are two 
major paths for the notification.

1. CPU handling error
   When a process is accessing this broken page, CXL device returns data
   with POISON.  When CPU consumes the POISON, it raises a kind of error
   notification.
   To be precise, "how CPU should behave when it consumes POISON" is
   architecture dependent.  In my understanding, x86-64 raises Machine
   Check Exception(MCE) via interrupt #18 in this case.
2. CXL device reporting error
   When CXL device detects the broken page by itself and sends memory
   error signal to kernel in two optional paths.
   2.a. FW-First
     CXL device sends error via VDM to CXL Host, then CXL Host sends it
     to System Firmware via interrupt, finally kernel handles the error.
   2.b. OS-First
     CXL device directly sends error via MSI/MSI-X to kernel.

Note: Since I'm now focusing on x86_64, basically I'll describe about 
x86-64 only.

The following diagram should describe the 2 major paths and 2 optional 
sub-paths above.
```
1.  MCE (interrupt #18, while CPU consuming POISON)
     -> do_machine_check()
       -> mce_log()
         -> notify chain (x86_mce_decoder_chain)
           -> memory_failure()
2.a FW-First (optional, CXL device proactively find&report)
     -> CXL device -> Firmware
       -> OS: ACPI->APEI->GHES->CPER -> CXL driver -> trace
2.b OS-First (optional, CXL device proactively find&report)
     -> CXL device -> MSI
       -> OS: CXL driver -> trace
```

For "1. CPU handling error" path, the current code seems to work fine. 
When I used error injection feature on QEMU emulation, the code path is 
executed certainly.  Then, if the CPU certainly raises a MCE when it 
consumes the POISON, this path has no problem.

So, I'm working on making for 2.a and 2.b path, which is CXL device 
reported POISON error could be handled by kernel.  This path has two 
advantages.

- Proactively find&report memory problems

   Even if a process does not read data yet, kernel/drivers can prevent
   the process from using corrupted data proactively.  AFAIK, the current
   kernel only traces POISON error event from FW-First/OS-First path, but
   it doesn't handle them, neither notify processes who are using the
   POISON page like MCE does.  User space tools like rasdaemon reads the
   trace and log it, but as well, it doesn't handle the POISON page.  As
   a result, user has to read the error log from rasdaemon, distinguish
   whether the POISON error is from CXL memory or DDR memory, find out
   which applications are effected.  That is not an easy work and cannot
   be handled in time.  Thus, I'd like to add a feature to make the work
   done automatically and quickly. Once CXL device reports the POISON
   error (via FW-First/OS-First), kernel handles it immediately, similar
   to the flow when a MCE is triggered.  This is my first motivation.

- Architecture independent

   As the mentioned above, "1. CPU handling error" path is architecture
   dependent.  On the other hand, this route can be architecture
   independent code.  If there is a CPU which does not have similar
   feature like MCE of x86-64, my work will be essential.  (To be honest,
   I did not notice this advantage at first as mentioned later, but I
   think this is also important.)


Here is the timeline of my development of it.

Two series of patches have been sent so far:
- PATCH: cxl/core: add poison creation event handler [1]
- PATCH: cxl: avoid duplicating report from MCE & device [2]
[1] 
https://lore.kernel.org/linux-cxl/20240417075053.3273543-1-ruansy.fnst@fujitsu.com/
[2] 
https://lore.kernel.org/linux-cxl/20240618165310.877974-1-ruansy.fnst@fujitsu.com/


The 1st patch[1] added POISON error handler in "2. CXL device reporting 
error" path.

My first version was constructing a MCE data from POISON address and 
calling mce_log() to handle the POISON.  But I was told that 
constructing MCE data is architecture dependent while CXL is not.  So, 
in later version, just call memory_failure_queue() in CXL to handle the 
POISON error to avoid the arch-dependent problem.

After many discussions, a new problem was found: as Dan said[3], added 
POISON handling will cause the "duplicate report" problem:
 > So, I think all CXL poison notification events should trigger an
 > action optional memory_failure(). I expect this needs to make sure
 > that duplicates re not a problem. I.e. in the case of CPU consumption
 > of CXL poison, that causes a synchronous MF_ACTION_REQUIRED event via
 > the MCE path *and* it may trigger the device to send an error record
 > for the same page. As far as I can see, duplicate reports (MCE + CXL
 > device) are unavoidable.

[3] 
https://lore.kernel.org/linux-cxl/664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch/


To solve this problem, I made the 2nd patch[2].  Allow me to describe 
the background again:

Since CXL device is a memory device, while CPU is consuming a poison 
page of CXL device, it always triggers a MCE (via interrupt #18) and 
calls memory_failure() to handle POISON page, no matter which-First path 
is configured.

My patch added memory_failure() in FW-First/OS-First path: if device 
finds and reports the POISON, kernel not only traces but also calls 
memory_failure() to handle it, marked as "ADD" in the figure blow.
```
1.  MCE (interrupt #18, while CPU consuming POISON)
     -> do_machine_check()
       -> mce_log()
         -> notify chain (x86_mce_decoder_chain)
           -> memory_failure() <---------------------------- EXISTS
2.a FW-First (optional, CXL device proactively find&report)
     -> CXL device -> Firmware
       -> OS: ACPI->APEI->GHES->CPER -> CXL driver -> trace
                                                  \-> memory_failure()
                                                      ^----- ADD
2.b OS-First (optional, CXL device proactively find&report)
     -> CXL device -> MSI
       -> OS: CXL driver -> trace
                        \-> memory_failure()
                            ^------------------------------- ADD
```

But in this way, the memory_failure() could be called twice or even at 
same time, as is shown in the figure above: (1.) and (2.a or 2.b), 
before the POISON page is cleared.  memory_failure() has it own mutex 
lock so it actually won't be called at same time and the later call 
could be avoided because HWPoison bit has been set.  However, assume 
such a scenario, "CXL device reports POISON error" triggers 1st call, 
user see it from log and want to clear the poison by executing `cxl 
clear-poison` command, and at the same time, a process tries to access 
this POISON page, which triggers MCE (it's the 2nd call).  Since there 
is no lock between the 2nd call with clearing poison operation, race 
condition may happen, which may cause HWPoison bit of the page in an 
unknown state.

Thus, we have to avoid the 2nd call. This patch[2] introduces a new 
notifier_block into `x86_mce_decoder_chain` and a POISON cache list, to 
stop the 2nd call of memory_failure(). It checks whether the current 
poison page has been reported (if yes, stop the notifier chain, don't 
call the following memory_failure() to report again).

Looking forward to your comments!


--
Thanks,
Ruan.

