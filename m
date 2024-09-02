Return-Path: <linux-edac+bounces-1761-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8CE9689CB
	for <lists+linux-edac@lfdr.de>; Mon,  2 Sep 2024 16:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4B1280EF3
	for <lists+linux-edac@lfdr.de>; Mon,  2 Sep 2024 14:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1AD19C55D;
	Mon,  2 Sep 2024 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="RBwoIacM"
X-Original-To: linux-edac@vger.kernel.org
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19BF179AA;
	Mon,  2 Sep 2024 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286844; cv=none; b=UU24O6p1C9GLTXQ/FER/2/YXmBcBQ6Jpdp7Sz8fYWyihyoIfvMO5nIzPabCfiTV/3GD9K+rWuted9GcFhxLfNNXN5rmT4aArkw3TXrxhpfLw32dXF4w/W2caoq0tQdnkrzHHj7IyBYSChKqi7NXPNgD7h5+Gbh+701csjhaYSTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286844; c=relaxed/simple;
	bh=ZkWv2QJf7NlJ00mCSywvA3GddH6obDZjGitEq5QIKtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYbRNEk8k4M73MlE8KRgh4Cu/tcsKtH2CtJ2XxmXuiobMXWujyqS+a7JXNcoitJSLr3W0KSA0CDS4vTXG/rNbb4qRr/c+BxKQpHftqkbSG6jNrcbT1ZjGu/lIFIcmSnGj4FPbmMDssurNAtYUophd0PAt8y1C8DdPbWlpdzkcb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=RBwoIacM; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1725286842; x=1756822842;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZkWv2QJf7NlJ00mCSywvA3GddH6obDZjGitEq5QIKtQ=;
  b=RBwoIacM0XeQuWZBtk8B9cTLsGZNltwyFKP7+e2a9hbZylpFJNmtQmzf
   9kPtix7Ou7maSQlyEEN28NtiU4v3De5q3tUPynYWkkEXhf6ULVT7bLCFe
   xpdnQn4xqy6FCMlJXnFEtyHNUeZlNG1Um8GsFRfZNKP6v0DMewtDiDk7d
   w36+OA7BKsIKPP82ZXwQUnWk9zNBohx/QZedbrlIHVFtieLLVLezFwGMp
   /8bnQ1kwdujg97vTlHxi+sLaGcLloTPWWgvq3Xnnof0jWbTOfi/RRx6OA
   BhIyH2KFclkyX7H23UB0YgZjMc0ya42eh00zFnTz19ELrqDvJq4ZZM3/p
   Q==;
X-CSE-ConnectionGUID: 7mXtf9pXT66heOu5aJX5NQ==
X-CSE-MsgGUID: ++GJYVH4TuqlC6cHkJGiMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="151869290"
X-IronPort-AV: E=Sophos;i="6.10,195,1719846000"; 
   d="scan'208";a="151869290"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 23:19:30 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1F29AD800F;
	Mon,  2 Sep 2024 23:19:28 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5F185D4F51;
	Mon,  2 Sep 2024 23:19:27 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id BA7946BD5B;
	Mon,  2 Sep 2024 23:19:26 +0900 (JST)
Received: from [10.193.128.195] (unknown [10.193.128.195])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 889C41A000A;
	Mon,  2 Sep 2024 22:19:25 +0800 (CST)
Message-ID: <c7e48e89-88fb-4810-8bdb-9307203a0091@fujitsu.com>
Date: Mon, 2 Sep 2024 22:19:25 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] cxl: avoid duplicated report from MCE & device
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-mm@kvack.org, dan.j.williams@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, bp@alien8.de, dave.jiang@intel.com,
 dave@stgolabs.net, ira.weiny@intel.com, james.morse@arm.com,
 linmiaohe@huawei.com, mchehab@kernel.org, nao.horiguchi@gmail.com,
 rric@kernel.org, tony.luck@intel.com
References: <20240808151328.707869-1-ruansy.fnst@fujitsu.com>
 <20240808151328.707869-3-ruansy.fnst@fujitsu.com>
 <20240827165255.00003184@Huawei.com>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20240827165255.00003184@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28638.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28638.000
X-TMASE-Result: 10--18.722600-10.000000
X-TMASE-MatchedRID: qA30kLX4rkePvrMjLFD6eKn9fPsu8s0a2q80vLACqaeqvcIF1TcLYLBk
	jjdoOP1bW9EH4+AJvKPWEKq3/x+jsOZusStRKBV2lOneJcroAxQEa8g1x8eqFzKIerHAhfYxh4A
	8/yPGZNapvxnoY+yIonXOnTupNIIg0ULUiMMnBpvEOJqSsn5KmZQ7eT0DII9NfnzRct83gQIJfS
	FgccfpAR+fvjkvoc3Be52pOBC+4eHTVE410k90AWQFd4bOnrT64XnbArnSCLHkMnUVL5d0Ezje3
	avJWBBRdOlApyjqZMKIT8eUrs+4RRs7n0Ur0F2YRN+FMKVZBhEQOcMSo0926lcZNuxCoduS7bVh
	2RA8dMz3SzCPT5sXYys9U4Zn7lQDVOc6pZRHw9cmZusHWPhfCk3yuY9BGW8rsqiKlYBJQxg0Oxd
	vWc671FozlTt1FeqbX7bicKxRIU23sNbcHjySQdigzzbKqYUy+gtHj7OwNO0YzpbdT4uedzdKAe
	VgKQLGIiCPMSPC78UIet2iW5cw1yy8MXciL+hj
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/8/27 23:52, Jonathan Cameron 写道:
> On Thu,  8 Aug 2024 23:13:28 +0800
> Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
> 
>> Since CXL device is a memory device, while CPU is consuming a poison
>> page of CXL device, it always triggers a MCE (via interrupt #18) and
>> calls memory_failure() to handle POISON page, no matter which-First path
>> is configured.  CXL device could also find and report the POISON, kernel
>> now not only traces but also calls memory_failure() to handle it, which
>> is marked as "NEW" in the figure blow.
>> ```
>> 1.  MCE (interrupt #18, while CPU consuming POISON)
>>       -> do_machine_check()
>>         -> mce_log()
>>           -> notify chain (x86_mce_decoder_chain)
>>             -> memory_failure() <---------------------------- EXISTS
>> 2.a FW-First (optional, CXL device proactively find&report)
>>       -> CXL device -> Firmware
>>         -> OS: ACPI->APEI->GHES->CPER -> CXL driver -> trace
>>                                                    \-> memory_failure()
>>                                                        ^----- NEW
>> 2.b OS-First (optional, CXL device proactively find&report)
>>       -> CXL device -> MSI
>>         -> OS: CXL driver -> trace
>>                          \-> memory_failure()
>>                              ^------------------------------- NEW
>> ```
>>
>> But in this way, the memory_failure() could be called twice or even at
>> same time, as is shown in the figure above: (1.) and (2.a or 2.b),
>> before the POISON page is cleared.  memory_failure() has it own mutex
>> lock so it actually won't be called at same time and the later call
>> could be avoided because HWPoison bit has been set.  However, assume
>> such a scenario, "CXL device reports POISON error" triggers 1st call,
>> user see it from log and want to clear the poison by executing `cxl
>> clear-poison` command, and at the same time, a process tries to access
>> this POISON page, which triggers MCE (it's the 2nd call).
> 
> Attempting to clear poison in a page that is online seems unwise.
> Does that ever make sense today?

To be honest, I am not sure about this.  Even if the error from CXL 
device is recoverable, we don't reuse it again?

> 
>>   Since there
>> is no lock between the 2nd call with clearing poison operation, race
>> condition may happen, which may cause HWPoison bit of the page in an
>> unknown state.
> 
> As long as that state is always wrong in the sense we think it's poisoned
> when it isn't we don't care.

The 2nd memory_failure() need this state to determine whether to 
continue its process or return.

>>
>> Thus, we have to avoid the 2nd call. This patch[2] introduces a new
>> notifier_block into `x86_mce_decoder_chain` and a POISON cache list, to
>> stop the 2nd call of memory_failure(). It checks whether the current
>> poison page has been reported (if yes, stop the notifier chain, don't
>> call the following memory_failure() to report again).
>>
> 
> If we do want to do this, it belongs in the generic code, not arch specific
> part. Can we do similar in memory failure?

Yes, I saw the build error.  Will fix this.

> 
> To RAS reviewers, this isn't a new problem unique to CXL. Does a solution
> like this make sense in practice, or are we fine to always let two reports
> for the same error get handled?
> 
> 
> Jonathan
> 
> 


--
Thanks,
Ruan.

