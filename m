Return-Path: <linux-edac+bounces-4430-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D73B1108A
	for <lists+linux-edac@lfdr.de>; Thu, 24 Jul 2025 19:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD76F3B869B
	for <lists+linux-edac@lfdr.de>; Thu, 24 Jul 2025 17:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E47A2EB5C9;
	Thu, 24 Jul 2025 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reox.at header.i=@reox.at header.b="Owkl0oG0"
X-Original-To: linux-edac@vger.kernel.org
Received: from midgard.reox.at (midgard.reox.at [176.9.78.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209B42192F4
	for <linux-edac@vger.kernel.org>; Thu, 24 Jul 2025 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.78.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753379772; cv=none; b=MpoGDOfJCM2NYXAZoSGxgCuXHCn93W8GM+Yf3wiTsLBkijdkb2gdAgQINh1joam+1WDT7nyfKf4lEeb1qZxM0XzGEOJ+KgVczice6cAFB6dVaciPSu47e4FrpfKkzRcXpYihp4G/dKCCGP9Z2dpxlgqRfzW/IIDt2vLuEptOiHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753379772; c=relaxed/simple;
	bh=E3N4qCmn8dgMMOW31tj9k3RchnTSbWs2a2F9+vntHX8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=u0x9DKyZwpNRGoO3frJBEUWdFiLcYbzWxd0VNopdzED7lyY00QsONe/3w7osBqWvG0szZuKMlv0gEQlCdF2XMpIeLYN8sj/hcIiNV1yNeEHTP4sU1gEP89Yv7zH+9Vwb5xrv3i2Nvn1+QRYaMkHNfynd4J/7wn+3gYbeAk7+w0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=reox.at; spf=pass smtp.mailfrom=reox.at; dkim=pass (2048-bit key) header.d=reox.at header.i=@reox.at header.b=Owkl0oG0; arc=none smtp.client-ip=176.9.78.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=reox.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reox.at
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by midgard.reox.at (Postfix) with ESMTPSA id 8CDEF100200;
	Thu, 24 Jul 2025 19:47:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=reox.at; s=dkim2502;
	t=1753379228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6wYp94+XwfTnuxKEmQZVp1RGTKHoND8FWbikhGiXHc=;
	b=Owkl0oG0vva2JFfec2X0LBV1cqwObqtxnmG2KBGXvMH4TJeXrYST1gt1pTsW9ezImwLrWp
	uYZ9HHGNKlRg7C3UG0U5rEy8bpSCiwHqqf8mNMdXgvgBDbHuxmqfpvbdUD4SPVJun0jP9D
	fpBFLprBaoaZjSMYKYiECuN90Qyz8FEVvRzW2OiE+G4C0+0MQ8XkInA5D6OATFkGCwjDnt
	TKvbVF2YWYqd6fYyhmBgLSR50rbvIYZJKA6f5QvxBLq5itVbkspcDsBCh5yeTCUZznzgTN
	svrcsMvXC2IYZqigQnChSMQ7POh7plu95j3gu8iV9Y1cIeHXXzdPwhgT5zlu4Q==
Message-ID: <745587f6-80f8-4ecf-a7e3-a85c891a6cd5@reox.at>
Date: Thu, 24 Jul 2025 19:47:07 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: mailinglist@reox.at
Subject: Re: Memory controller not showing half of the memory?
To: "Naik, Avadhut" <avadnaik@amd.com>, =?UTF-8?B?xb1pbHZpbmFzIMW9YWx0aWVu?=
 =?UTF-8?Q?a?= <zilvinas@natrix.lt>
Cc: yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>
References: <20250317120702.GA7066@yaz-khff2.amd.com>
 <dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt>
 <20250328152415.GCZ-a_HzI0zpcaLNWD@fat_crate.local>
 <a1ed1aa7-96df-4c95-b818-4dd8f9da7c56@reox.at>
 <3d9b82ed-a5ce-4d15-afb7-bce1dd40649b@amd.com>
Content-Language: en-GB
In-Reply-To: <3d9b82ed-a5ce-4d15-afb7-bce1dd40649b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi everyone,

I installed 6.12.38 now and - as announced in the 6.12.35 changelog - it 
is indeed fixed!

Thanks a lot!

Best,
Sebastian

Am 01.04.2025 um 20:00 schrieb Naik, Avadhut:
> On 4/1/2025 06:44, mailinglist@reox.at wrote:
>>
>>
>> Am 28.03.2025 um 16:24 schrieb Borislav Petkov:
>>> On Thu, Mar 20, 2025 at 11:38:58AM +0200, Žilvinas Žaltiena wrote:
>>>> Hello,
>>>>
>>>> I am also having this "half" memory problem - EDAC is showing 48GB instead
>>>> of 96GB, however otherwise whole 96GB are usable by OS.
>>>
>>> Both of y'all folks encountering this issue, care to run the below patch?
>>>
>>> https://lore.kernel.org/all/20250327210718.1640762-1-avadhut.naik@amd.com/
>>>
>>> Thx.
>>>
>>
>> I tried to apply it on the current Bookworm Backports kernel (6.12.12) - which seemed to work but I still get the same output, i.e., 32GB out of 64GB of RAM.
>>
> 
> Think we are mixing up issues here. So, to clarify, there are two issues currently being worked on in the
> amd64_edac module.
> 
> 1. For Family 19h Models 70h-7Fh all UMCs are not enumerated by the module. 4 are present but only 2 are
> enumerated. Currently, required approvals are being sought to upstream the fix. I think this is the issue
> being encountered by Sebastian from the dmesg logs and lshw output provided in this thread.
> 
> 2. For calculating DIMM sizes, the module does not consider both Address Mask and Address Mask Secondary
> registers. Consequently, for non-power-of-2 DIMMs, the memory size logged by the module is inaccurate. I
> think this is the issue being encountered by Žilvinas.
> 
> The patch that Boris asked you folks to try out fixes the second issue. Fix for the first issue has not
> yet been submitted.
> 
>> I may not have built the kernel correct though... I did not had an environment to do that and just set one up. Or do I need a newer kernel version to apply the patch to? Sorry for the noob questions...
>>
>> Best,
>> Sebastian
> 


