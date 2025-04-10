Return-Path: <linux-edac+bounces-3512-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D56A84FA4
	for <lists+linux-edac@lfdr.de>; Fri, 11 Apr 2025 00:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB5D87B4DDD
	for <lists+linux-edac@lfdr.de>; Thu, 10 Apr 2025 22:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EFE1FC10E;
	Thu, 10 Apr 2025 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fudX9cfv"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C752EAD5E;
	Thu, 10 Apr 2025 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744324041; cv=none; b=BEeQj2qM6ncnnmoDGVWGU0lbZz1RgGtWctthjGGLgth1H8PFs/EvcKLc4mYpyYjmwKvLZEYu+WRHjwesfCLxb5JIeAl8YU/0ONJFo6cQxl0gmsRFqmPWNBRl+GUPOl9w3oQ+1nYMmwqR2V21ZQgwVQsr/FtIJDt9twZQ2XWQl44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744324041; c=relaxed/simple;
	bh=DrB08N5vJpBO00PaLi2EQwkYUnMtu3OKx4Wnr7y5pss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmtuILHefS+O6c+pzC4wb5oOLfZCz980gjFPXOSL+Fzvtkrnr3hPnd1ktf8JNDlEdGYnwHgn6yJMWznWQ2G+O0Gq1otcuRwlCfSZBsMsWQU0sIas6fwZolt7uQpYsZZmZBYgljc+DNBellU5SZkbw4Cgqe5TugCY/ry9RQVoB1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fudX9cfv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.32.16] (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id C68FA2114DA7;
	Thu, 10 Apr 2025 15:27:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C68FA2114DA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744324039;
	bh=pkMs5AJBhRZ0JMEFeYZdqR+F93uPTPCtkVAJXcycSu8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fudX9cfvxHLuQG5pnqmRTGCroHhiRkFrqQU/k2C1P+vq7cggMGSbkCx1h0Dj6jwrM
	 dSfgZnql2xypQcjJhOgTtTseytEHr2Hi3praLAKOqzMVK2zRrZUFQ8CyMFdRljgIGR
	 6mgiTrwj+YQM0MJ6P502NhijYQEPK1CWsk8JH648=
Message-ID: <eff8d726-d25e-4424-846f-fd3cfa249315@linux.microsoft.com>
Date: Thu, 10 Apr 2025 15:27:18 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drivers/edac: Add L1 and L2 error detection for A53,
 A57 and A72
To: "Tyler Hicks (Microsoft)" <code@tyhicks.com>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
References: <1744241785-20256-1-git-send-email-vijayb@linux.microsoft.com>
 <1744241785-20256-2-git-send-email-vijayb@linux.microsoft.com>
 <Z/gkWCiveESbvdxS@redbud>
Content-Language: en-US
From: Vijay Balakrishna <vijayb@linux.microsoft.com>
In-Reply-To: <Z/gkWCiveESbvdxS@redbud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/2025 1:04 PM, Tyler Hicks (Microsoft) wrote:
>> +		snprintf(msg, MESSAGE_SIZE, "%s %s error(s) on CPU %d",
>> +			 str, fatal ? "fatal" : "correctable", cpu);
>> +
>> +		if (fatal)
>> +			edac_device_handle_ue(edac_ctl, cpu, 0, msg);
>> +		else
>> +			edac_device_handle_ce(edac_ctl, cpu, 0, msg);
>> +
>> +		write_sysreg_s(0, SYS_CPUMERRSR_EL1);
>> +		isb();
> I think the register writes and barriers should happen much closer to the
> register reads, in read_errors(). Looking back at Marc's feedback on v5, I
> think his most important piece of feedback was to only clear the register when
> the valid bit is set to avoid accidentally clobbering an error that came in
> between the register read and write.
> 
> By moving the register writes into report_errors() in this v6 series, there's
> now a much larger window where new errors could occur between the register
> read and the register write. Those new errors would be silently lost/ignored.
> Reducing the window to the least number of cycles seems important for accurate
> reporting.

Moving clear to report_errors() is wrong actually, it has be cleared 
from the CPU, from read_errors() which is a SMP call. Let me share new 
version with changes.

Thanks,
Vijay

