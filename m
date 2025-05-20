Return-Path: <linux-edac+bounces-3961-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B64FABE011
	for <lists+linux-edac@lfdr.de>; Tue, 20 May 2025 18:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BA98C05E9
	for <lists+linux-edac@lfdr.de>; Tue, 20 May 2025 16:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05C4275103;
	Tue, 20 May 2025 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WvXZr0vv"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4418F26C396;
	Tue, 20 May 2025 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757373; cv=none; b=KI+qBmuXKeVwufMUVmD0w+sfUOKl1ovAMfJ0630o3TQXdHWN8DoXxFmrC+cCUTZriS7St9SbvnnQR9CeYSNSvnwUIBMAPmeRY/RuwU4EHoOtq7rqFTZPqW+QFf4QnEv44H02MLFdKWE6Pj6MDpharLSwEv9c/Npcx34benUR7p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757373; c=relaxed/simple;
	bh=QsPbWopl90NhAfbzIQZhkUpuoKh3760rkfO147eFZUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJPMb8yla60YvUFlz2EouLA1Q4vS+JtPP0jwxJbevcWtFAJw1W9ooRpP5nXIfoJevySe2jhqf2zjgFYyusqmF9qlOUu8L4gvIVlL92+ovHTP5Izq5demP0+Hh2IkjA9zw3eaOP+CwyocZu9SYwih5zbvz52Kelx3neQpqXP1/Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WvXZr0vv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.200.68] (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id 95B10206789F;
	Tue, 20 May 2025 09:09:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 95B10206789F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747757366;
	bh=ewI1krelm1qHOVbYJgxVRWGxDfpNjtQIIAfnmWISbuM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WvXZr0vvtz8VjYgCmTlUlFt0zB6b6L5oO/lWgBpCa7aKiQbOyph8ckTJmMIM34Muo
	 nlu+d1v+9/oxzCpGbV4v87kfmPZR5kVRT3f5ezkMBTw1Yfb4HRGb6QkCQyhg/BsGfk
	 GOqN3w2nD7pLgwRzIzf6BVD+qkrQFflI/v/C+s8w=
Message-ID: <ea19ad06-142c-4d7e-83ba-00b9b7e3cdaf@linux.microsoft.com>
Date: Tue, 20 May 2025 09:09:29 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drivers/edac: Add L1 and L2 error detection for A72
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
Content-Language: en-US
From: Vijay Balakrishna <vijayb@linux.microsoft.com>
In-Reply-To: <20250519085130.GFaCrxEnZvaoETKrao@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/19/2025 1:51 AM, Borislav Petkov wrote:
> I'd venture a guess you need to protect here against CPU hotplug...
> 
>> +	for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
>> +		smp_call_function_single(cpu, read_errors, &merrsr, true);
>> +		report_errors(edac_ctl, cpu, &merrsr);
>> +	}
>> +}
>> +

Hi Boris,

I appreciate you highlighting the CPU hotplug issue. Upon further review 
of surrounding code, I realized we must ensure that the data passed to 
read_errors() is per-CPU.

Thank you for your review. I will address the remainder of your comments 
promptly.

Vijay

