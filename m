Return-Path: <linux-edac+bounces-3513-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CED31A84FA7
	for <lists+linux-edac@lfdr.de>; Fri, 11 Apr 2025 00:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4C94C0B2E
	for <lists+linux-edac@lfdr.de>; Thu, 10 Apr 2025 22:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E316320E003;
	Thu, 10 Apr 2025 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LQiSJili"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89041202F7B;
	Thu, 10 Apr 2025 22:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744324163; cv=none; b=WCU998GLtQHb8gkherilKn5iP15a2Y3nYKJsV0UOntk0hEenWUA7p/VmmaXUIHyn/a9uau4vf/0cIcGOYupYda/GJZKA8SihZ5zamwq7GCHKK/wUMcMshAzgHK5lHZrM2vp5uR4KdmT5CZevpW0k7YvAwZWzkGVJrXKDwOtermM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744324163; c=relaxed/simple;
	bh=o4QeWaF1Zux9H/TMyr4q62bE+0yVW0ZNrHfLCpXWQeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLLk2WbT3XxmmzkryYTA/o2GmFwTHqe4FbGiWxwht2gXqYB75XxnL8tBv3tn6zfXf8wijdc5OK219HJE5SJsttDllxkrtpu8ScG390D2WEjd17X4Ng5gruUNBy0Uby520jkIF/dGFf7Wbfx7qT26n4+3bUm/rCUDTKhPDA4A5e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LQiSJili; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.32.16] (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 977D12114DA7;
	Thu, 10 Apr 2025 15:29:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 977D12114DA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744324162;
	bh=lzClyl4jSujtrnGb0jX67wSU+NPlPXX70zMwzi9cA7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LQiSJiliUum98pWHRX3C1GObJBVaOi7WNpOKfrvnoRNZIhZaNfYCz+oAA1JvBigTW
	 m5VpmYNLevUZeMETiXmOJGydpCJ8xlIdOzfzVOtiMr2S6QsKUxLjt8Y+WHhN8Qgwsw
	 9Hmx+nzM6GkgHM5hmTs6eLgz7JTNvzAeC9LEg1tc=
Message-ID: <0ed85d5f-f1b2-4b9c-8817-193ae98ce286@linux.microsoft.com>
Date: Thu, 10 Apr 2025 15:29:21 -0700
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
>> +static int __init cortex_arm64_edac_driver_init(void)
>> +{
>> +	struct device_node *np;
>> +	int cpu;
>> +	struct platform_device *pdev;
>> +	int err;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		np = of_get_cpu_node(cpu, NULL);
> Copilot correctly points out that we don't check np for NULL here. I think
> of_match_node() handles that fine but we get fairly deep into the call stack
> before it is caught. Let's go ahead and proactive check the return value.
> 
> More importantly, it pointed out that we don't call of_node_put(np) before
> moving onto the next CPU. This would result in a refcount issue and will need
> to be fixed.

Good catch. Let me change in next version.

Thanks,
Vijay

