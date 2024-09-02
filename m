Return-Path: <linux-edac+bounces-1760-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803F2968957
	for <lists+linux-edac@lfdr.de>; Mon,  2 Sep 2024 16:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC221C219C2
	for <lists+linux-edac@lfdr.de>; Mon,  2 Sep 2024 14:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F88C20FA87;
	Mon,  2 Sep 2024 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FOK62MW9"
X-Original-To: linux-edac@vger.kernel.org
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30A19E98B;
	Mon,  2 Sep 2024 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725285801; cv=none; b=tqI1e2U9WL0EkZQZ6UaDXFWcTcclW0EC1bx/GsaI3PV9ospqFQNUlaL68n8oXIe/Dd+jgt5Ml23VchKEmgRpYx4l+9rYvDakw4x05jTb+bBgr/bSGyfL6niJp9DU7/Rln7C3WdzW4vlK5JeXe1svA84+jxiATawtW1EkQQ7kPlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725285801; c=relaxed/simple;
	bh=GX/6obQSv/WJf/FAn9TAasDUp/DJhqEtQ4ON1iidy0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYEu+0MdoT8Wg8WqwfpeBKzUYrH1y9Bsg7J2zwZc4OoYSqBfI6nIeSjBUX44cWqv31njy5fpk/DEgqnJMf1PxjgV2vevpD/UuqgRQOOAModMFGLs/Km9e/MjlhlF86Qg4FuwhNhG+/S8aYlSTvOUYFTQSlR9SeY0b21chSGRYn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FOK62MW9; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1725285799; x=1756821799;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GX/6obQSv/WJf/FAn9TAasDUp/DJhqEtQ4ON1iidy0E=;
  b=FOK62MW9oPVpjZOW3Y8L3FKQG8rVI2/n5txWW9SIyg/M+BHlyE12iXDg
   seRkB9A0FJ/jWjQRR3hVWc8C/U0iYcZx+db2t1ZvlwRJXz+mCyK/9J+FH
   KAKf4bBb5ph5EXOy1cjEdRlWqeRuqZkQaW4mDJ8I3paBv/q3GaUR/3vtj
   duea9fPNimwAlj0BywFJz/tniVlDanALtrsC0l8wmzO2aFMrlfWWyYLM5
   uC+71rWq1r6KBgDOcXcGwqAceHGsPbhuO0JzpHZV34ACT8RAKxWmctUNM
   NwhvcHa/sV7is5swES82/DDv05lMzH7D+21xI/qqLPkjcYXVtAU/QJ4r8
   Q==;
X-CSE-ConnectionGUID: QZZPBUTPTX2pgT9HNVnijA==
X-CSE-MsgGUID: tCYDIVg1SISKzv75HClY5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="172391208"
X-IronPort-AV: E=Sophos;i="6.10,195,1719846000"; 
   d="scan'208";a="172391208"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 23:03:10 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 9A433D6EEE;
	Mon,  2 Sep 2024 23:03:07 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id DB922CFB76;
	Mon,  2 Sep 2024 23:03:06 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 602CC6BD5B;
	Mon,  2 Sep 2024 23:03:06 +0900 (JST)
Received: from [10.193.128.195] (unknown [10.193.128.195])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 79DEE1A000A;
	Mon,  2 Sep 2024 22:03:04 +0800 (CST)
Message-ID: <05811930-8fa9-42f8-8034-6f0945b103fc@fujitsu.com>
Date: Mon, 2 Sep 2024 22:03:03 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cxl/core: introduce device reporting poison
 hanlding
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-mm@kvack.org, dan.j.williams@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, bp@alien8.de, dave.jiang@intel.com,
 dave@stgolabs.net, ira.weiny@intel.com, james.morse@arm.com,
 linmiaohe@huawei.com, mchehab@kernel.org, nao.horiguchi@gmail.com,
 rric@kernel.org, tony.luck@intel.com, shiju.jose@huawei.com
References: <20240808151328.707869-1-ruansy.fnst@fujitsu.com>
 <20240808151328.707869-2-ruansy.fnst@fujitsu.com>
 <20240827164610.00002f4d@Huawei.com>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20240827164610.00002f4d@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28636.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28636.007
X-TMASE-Result: 10--17.417900-10.000000
X-TMASE-MatchedRID: xnGAJ48IopiPvrMjLFD6eKn9fPsu8s0a2q80vLACqaeqvcIF1TcLYLBk
	jjdoOP1bW9EH4+AJvKPMrGM6h+7YUICoSWHZmQrDKiJEqUFWRghZDdHiTk9OcJDHQ2MaZXz4jK1
	xN9jQWTnOpS+AHyEE2hcHv+b01YKmYY3ozW+EngffqVBdB7I8UaPhbuuLYFOYc/T3GfQUvxlxtF
	6KhREXKa2fCRhYzsoC+5kmiwJAxT+hxhqB2G57XTe9MF4SNA1+ocSvEPKGO+fAu8ilngS2RRRcq
	LOELivDxSb5KmzgaAwv1d8yhDAVO4xxTMlLewfdh1CxlJlk5RpJ0h0KLwFrgJm3OIVSf4P5slCg
	QfGYOCnzgfRAkJS4G6EfeQTpODV8uybvDkIalGAdZEkR8Y/meYQg0F6EHA2oS1jK4vkKprF5GDv
	/ZOF4Nm5/m6vlvI+l0CcTQ1zeUMSPfh1s1LkJMFlGa4Om1d9neF6MevMVZUBncSzHLoRambTLcN
	rcH2Gr585VzGMOFzDYh0PvnvUH8EY41YX/o/8KDZX99HwFDsIqtq5d3cxkNUB2W41yROPGyZQsj
	JwjJMsteacMfEd8nWcmUNFBCcvs6v+KAQNhbdM=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/8/27 23:46, Jonathan Cameron 写道:
> On Thu,  8 Aug 2024 23:13:27 +0800
> Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
> 
>> CXL device can find&report memory problems, even before MCE is detected
>> by CPU.  AFAIK, the current kernel only traces POISON error event
>> from FW-First/OS-First path, but it doesn't handle them, neither
>> notify processes who are using the POISON page like MCE does.
>>
>> Thus, user have to read logs from trace and find out which device
>> reported the error and which applications are affected.  That is not
>> an easy work and cannot be handled in time.
> 
> These are async reports, so I'm not sure what 'in time' really means here.

'in time' may not be appropriate.  I think 'ASAP' is better.  I just 
want to say: comparing with users finding out the errors from trace logs 
and notifying apps manually, kernel handler can do that automatically 
and ASAP.

> If we get synchronous poison from a processor access it will be handled
> via traditional means (MCE, ARM SEA etc)

Yes.  For FW-First path, MCE mechanism can cover this.  But for OS-First 
path, errors can only be traced, then logged by userspace tool like 
rasdaemon.  We hope in OS-First path, kernel can handle it like MCE does 
too.

> 
> Whether to handle async error reports (typically from scrub or because
> the memory device received poison from someone else) the same way
> should perhaps be a policy decision.  It should match what we do
> for firmware first async reports though (any policy controls make sense
> for both).

Yes.  In OS-First path, I think it should always be turned on.

> 
> An example of this would be that an host OS might attempt a polite close
> of an application might attempt a polite if we know there is poison
> somewhere in a dataset it has access to. If that poison is never seen
> synchronously (because that data is not read) then it my close
> successfully rather than being killed.

According to kernel docs for 'early kill' of memory-failure, I think 
it's suitable for this case.

> 
> If it's injected poison and we didn't see it synchronously we might
> well not want to kill anything.

Agree.  Injection APIs are used for debugging, not a really HW poison.

> 
>> Thus, it is needed to add
>> the feature to make the work done automatically and quickly.  Once CXL
>> device reports the POISON error (via FW-First/OS-First), kernel
>> handles it immediately, similar to the flow when a MCE is triggered.
>>
>> The current call trace of error reporting&handling looks like this:
>> ```
>> 1.  MCE (interrupt #18, while CPU consuming POISON)
>>       -> do_machine_check()
>>         -> mce_log()
>>           -> notify chain (x86_mce_decoder_chain)
>>             -> memory_failure()
>>
>> 2.a FW-First (optional, CXL device proactively find&report)
>>       -> CXL device -> Firmware
>>         -> OS: ACPI->APEI->GHES->CPER -> CXL driver -> trace
>>                                                    \-> memory_failure()
>>                                                        ^----- ADD
>> 2.b OS-First (optional, CXL device proactively find&report)
>>       -> CXL device -> MSI
>>         -> OS: CXL driver -> trace
>>                          \-> memory_failure()
>>                              ^------------------------------- ADD
>> ```
>> This patch adds calling memory_failure() while CXL device reporting
>> error is received, marked as "ADD" in figure above.
> 
> Typo in patch title.  handling

Thanks.

> I've also dropped qemu-devel as this doesn't have anything to do with qemu.
> 

OK.

>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> 
> Experienced RAS folk in the CC, how do you want this to work for
> asynchoronous memory errors on CXL devices?
> 
> 

