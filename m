Return-Path: <linux-edac+bounces-3360-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31467A5FE86
	for <lists+linux-edac@lfdr.de>; Thu, 13 Mar 2025 18:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724921760DF
	for <lists+linux-edac@lfdr.de>; Thu, 13 Mar 2025 17:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4F51DC985;
	Thu, 13 Mar 2025 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reox.at header.i=@reox.at header.b="XrqG/uRb"
X-Original-To: linux-edac@vger.kernel.org
Received: from midgard.reox.at (midgard.reox.at [176.9.78.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530668635C
	for <linux-edac@vger.kernel.org>; Thu, 13 Mar 2025 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.78.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888129; cv=none; b=E9I3fMSLH+dFjQlDxsgBkwKW+kPCY/xGjAttGw8ZGGFfRZTcysDTVeh1s4NTlQW1HGW8Mgpqf3cYuf70FU1S4HKaac/3Jstbh/8fe+QVVEwDs7GWUTlQswithzOmnF/kp7ON2j6YEz3cCjbf5z6IhipLIeqp2r1P0xuCUL8qcAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888129; c=relaxed/simple;
	bh=1hNC9gDvM0O8h8o47kG/2ZQx6iO/1gENHr7Tb9Asqms=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=itkTdZbQB2zKDMNdrxC1sLFgj4wdStT/fpAm05KV4e2BDKDxRXGPmq0SdPJeX4EO6ZL/sUoyxlVjw24viafVo+VU4vyDC6Ft5nuwZ+VMoAD1gU80YzQqayXotqy1DpuzQO3q4mVPjOSjyLsn3qz481+8lvUnJeD/YvKXovD7ul8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=reox.at; spf=pass smtp.mailfrom=reox.at; dkim=pass (2048-bit key) header.d=reox.at header.i=@reox.at header.b=XrqG/uRb; arc=none smtp.client-ip=176.9.78.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=reox.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reox.at
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by midgard.reox.at (Postfix) with ESMTPSA id 0B1971031DE;
	Thu, 13 Mar 2025 18:48:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=reox.at; s=dkim2502;
	t=1741888124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RFjhNwJkcJB5qMpiebW7pW6nLk5h118tJcQcqjgSvWk=;
	b=XrqG/uRbWAO3Tl0n+3x6NwSKfQq6UhlOn/d5Hnh+PMrFL3XePCYS0UywO073hHnL83X7rM
	ctb/bmBRhUT9nEvMH7VA9LD7ZKIUgJAAIJGr9ifAKHUzZio4/qmo6691wIvpgtTzZQWX2b
	I+00dPOseDBdWI7E0bwAc7eSe6euYtjSkTgM2lVD4Ysd3T9G9g3g8VmZ6eqaoiladCzY0k
	mM+IPCah2NH2eeCODI947t99WX0CT1f37ZSO3JW1xH8VWuMK5mmd5xlWr9kSDx9vdyTmbX
	FQSKG4EKuZY2tmw2VmI78cFGl1SMJpjicFs4PtMYn0ktqNxmr0DGTuHyDX+67g==
Message-ID: <84f97663-2bf2-484d-a6f4-22f6efdbc1de@reox.at>
Date: Thu, 13 Mar 2025 18:48:42 +0100
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: reox <mailinglist@reox.at>
Subject: Re: Memory controller not showing half of the memory?
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, Yazen Ghannam <yazen.ghannam@amd.com>
References: <27dc093f-ce27-4c71-9e81-786150a040b6@reox.at>
 <20250313173109.GDZ9MWXTRUHbFh4UJ3@fat_crate.local>
Content-Language: en-GB
In-Reply-To: <20250313173109.GDZ9MWXTRUHbFh4UJ3@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Am 13.03.2025 um 18:31 schrieb Borislav Petkov:
> On Thu, Mar 13, 2025 at 06:21:28PM +0100, reox wrote:
>> Hello,
>>
>> I hope it is okay to ask such a question on this mailinglist, however there
>> is surprisingly little information on this topic (or I'm not deep enough in
>> the matter to understand everything correctly...).
>>
>> I have a server with a ASRockRack B665D4U-1L board. I'm running Debian with
>> bookworm-backports kernel 6.12.9-1~bpo12+1.
>> In the syslog I see the following output of EDAC:
>> # dmesg | grep -i EDAC
>> [    1.340448] EDAC MC: Ver: 3.0.0
>> [    4.705255] EDAC MC0: Giving out device to module amd64_edac controller
>> F19h_M70h: DEV 0000:00:18.3 (INTERRUPT)
>> [    4.705262] EDAC amd64: F19h_M70h detected (node 0).
>> [    4.705266] EDAC MC: UMC0 chip selects:
>> [    4.705267] EDAC amd64: MC: 0:     0MB 1:     0MB
>> [    4.705270] EDAC amd64: MC: 2:  8192MB 3:  8192MB
>> [    4.705273] EDAC MC: UMC1 chip selects:
>> [    4.705274] EDAC amd64: MC: 0:     0MB 1:     0MB
>> [    4.705277] EDAC amd64: MC: 2:  8192MB 3:  8192MB
>>
>> However, compare this to the real amount of memory (2×32GB):
>> # lshw -c memory  # shorted
>>    *-memory
>>         size: 64GiB
>>         capabilities: ecc
>>         configuration: errordetection=multi-bit-ecc
>>       *-bank:0
>>            description: [empty]
>>       *-bank:1
>>            description: DIMM Synchronous Unbuffered (Unregistered) 4800 MHz
>> (0.2 ns)
>>            product: HMCG88MEBEA081N
>>            vendor: SK Hynix
>>            size: 32GiB
>>       *-bank:2
>>            description: [empty]
>>       *-bank:3
>>            description: DIMM Synchronous Unbuffered (Unregistered) 4800 MHz
>> (0.2 ns)
>>            product: HMCG88MEBEA081N
>>            vendor: SK Hynix
>>            size: 32GiB
>>
>> I'm a bit confused here... Does EDAC simply miss half of the memory? Is this
>> output correct? Or the memory controller not fully implemented / bugged in
>> that kernel version (with the bookworm kernel it does not load EDAC at all)?
> 						^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> What does that mean, exactly?
> 
> Are you force-loading the module?

Sorry, that was formulated a bit sloppy... I meant that with the current 
bookworm kernel (6.1.128) there was no memory controller detected. The 
module was loaded fine but reported nothing. As far as I can tell, 
support was added only with 6.5 with commit 6c79e42 (would the expected 
outcome in my case also be 4×16GB?).

by the way, if it helps, the CPU is a "AMD Ryzen 7 PRO 8700GE w/ Radeon 
780M Graphics".

> 
> You could send a full dmesg...

from 6.1.128 or 6.12.9?

> 
>> Unfortunately I cannot easily run a dev version of the kernel on that
>> machine - otherwise I would have probably already done that.
>>
>> Thanks in advance!
>> Best,
>> Sebastian
>>
> 


