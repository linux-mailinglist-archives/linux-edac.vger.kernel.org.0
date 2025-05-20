Return-Path: <linux-edac+bounces-3962-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B92FABE427
	for <lists+linux-edac@lfdr.de>; Tue, 20 May 2025 21:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F7C17C9E0
	for <lists+linux-edac@lfdr.de>; Tue, 20 May 2025 19:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FB52820C2;
	Tue, 20 May 2025 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Pl0ZN8ju"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DF322DA0D;
	Tue, 20 May 2025 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747770870; cv=none; b=i7k3hoi4E5QaJpQeN4K26pMo4KfCcyTwl2QF3YUuLvg/AV/TGe7icA3ejVA9h2iFCIE9TzSPnBNfWFELPuCPYPSI8dxLbOyW77GSqdnQiOFbHMEZqyBFrJJBTv1dR9yJ66rPKJxjz4mY6Hi6AlGpzplmnziTRVzf8Ax6GTSQS3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747770870; c=relaxed/simple;
	bh=2kMHseLqwS8J4HbVVYtlByPDNyfTBjvZLCMmS+72Qxs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ho4pU6joDIP/7024HbH3D7Q9zWWzDZ06J+pP3Xo3QFRlTqYEbGyy0nFAVJVk+STMO8RaiCHpAM0fl1db51tCTOV60xzf61bq5wFKE3crVOBmWMZx9Fkzwk7MAJATX8IeQTPaga55GH3Yz/hbAf6qKMq70RAU8TxpvEwKyIHwri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Pl0ZN8ju; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.96.49] (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4DCC220277CF;
	Tue, 20 May 2025 12:54:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4DCC220277CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747770869;
	bh=j0BQDoWqGiLewXVQq8ozCOmSu4PtttES3KhfLhlj1Ao=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Pl0ZN8juCYNxhwBtIxyghdq/X7f3qGkfdroHpLvx4+msNdkVVFSbTE+UVSfwGjUTm
	 KhjAfXnfGTU/7irEkhYtLUS1ShePfCTZLrr9M2Fm14sqhmG/slCChzzrKuFB238VFF
	 HLHMUZVwZjtSOzQHEjtJF0i7CWtTE0E3Ngi+Ak2g=
Message-ID: <4630a9fc-0980-485f-9b70-01558ab418db@linux.microsoft.com>
Date: Tue, 20 May 2025 12:54:32 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drivers/edac: Add L1 and L2 error detection for A72
From: Vijay Balakrishna <vijayb@linux.microsoft.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tyler Hicks <code@tyhicks.com>, Marc Zyngier <maz@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, devicetree@vger.kernel.org
References: <1747353973-4749-1-git-send-email-vijayb@linux.microsoft.com>
 <1747353973-4749-2-git-send-email-vijayb@linux.microsoft.com>
 <20250519085130.GFaCrxEnZvaoETKrao@fat_crate.local>
 <ea19ad06-142c-4d7e-83ba-00b9b7e3cdaf@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <ea19ad06-142c-4d7e-83ba-00b9b7e3cdaf@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/20/2025 9:09 AM, Vijay Balakrishna wrote:
> On 5/19/2025 1:51 AM, Borislav Petkov wrote:
>> I'd venture a guess you need to protect here against CPU hotplug...
>>
>>> +    for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
>>> +        smp_call_function_single(cpu, read_errors, &merrsr, true);
>>> +        report_errors(edac_ctl, cpu, &merrsr);
>>> +    }
>>> +}
>>> +
> 
> Hi Boris,
> 
> I appreciate you highlighting the CPU hotplug issue. Upon further review 
> of surrounding code, I realized we must ensure that the data passed to 
> read_errors() is per-CPU.

Actually, per-CPU data not needed as we are passing true -- wait until 
function has completed on other CPUs.

