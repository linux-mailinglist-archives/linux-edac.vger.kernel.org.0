Return-Path: <linux-edac+bounces-4275-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1414AEBDC9
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jun 2025 18:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80C8188E0EA
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jun 2025 16:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D442E9746;
	Fri, 27 Jun 2025 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pfB+Hrac"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C7C136327;
	Fri, 27 Jun 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751042993; cv=none; b=C69XlEEzIUqrOYS6K8WEXRj8xb+QbjoaKCviKtDG3Hc7CLddrCLKUdp6DAmtrQfrIBzNY0CrZ55fp3oSJSTuSFOjgDIkbYFF2Yvj3vxNMAEHUXwOB3taiYIjAuCqV848zBDkUTYtlw8S4sed4rlGqMn/d8vn+k+RGO/BjBacQDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751042993; c=relaxed/simple;
	bh=Ut0hDs2xzJjclDoUXoEl19F/suL8ZmdlnTYiWKO8xI8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nK4i6DtYHJe6/1aSuNTClMZXU0y/CZnNgVMJNXkE76BvDk+AgfCShF68qHP05+RKTm7ESjEnjaMPa/VeKizdWcZX5ZEcVlz0zJ8u13oCFx7tZcbTsDy4HI3DNAlS1FBtHoB40V1YY+JkU10uBkPHC+qpacnI5C0KWbnrL0jSGD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pfB+Hrac; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.93.64.84] (unknown [40.86.181.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id F228E211868B;
	Fri, 27 Jun 2025 09:49:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F228E211868B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751042991;
	bh=rNdlKLnZPLYy6iWQ0vPS3Zwmc9YtKKUxvYxLseth3KU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=pfB+Hrach67IKX2fa05SS07V9OFDcNFPWu82og4AVR6lO3I7RykWtdK7B0s7hdijI
	 vFJ1jJFLQIYMnArTMgUACq7x5ikxp2bNgLVGlutaBNL93YIQc1RGPfMTn3Ep2/xBa3
	 xbDSXtlKSLk3CVm0CYQ22QA2tasPKBmp4ZZXP+0I=
Message-ID: <3f7e0d7c-cddb-47f7-9520-6740ccd81579@linux.microsoft.com>
Date: Fri, 27 Jun 2025 09:49:50 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vijay Balakrishna <vijayb@linux.microsoft.com>
Subject: Re: [v11 PATCH 0/2] Add L1 and L2 error detection for A72
To: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tyler Hicks <code@tyhicks.com>, Marc Zyngier <maz@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, devicetree@vger.kernel.org
References: <1748487628-30123-1-git-send-email-vijayb@linux.microsoft.com>
 <20250529095547.GBaDgvI0mCLSXsM0dR@fat_crate.local>
Content-Language: en-US
In-Reply-To: <20250529095547.GBaDgvI0mCLSXsM0dR@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/29/25 02:55, Borislav Petkov wrote:
> On Wed, May 28, 2025 at 08:00:26PM -0700, Vijay Balakrishna wrote:
>> Changes since v10: 
>> - edac_a72.c: copyright line add (Jonathan)
>> - cpus.yaml: drop stale comment line (Krzysztof)
>> - added "Reviewed-by" tags
> 
> It seems you're new to kernel development:
> 
> From: Documentation/process/submitting-patches.rst
> 
> "Don't get discouraged - or impatient
> ------------------------------------
> 
> After you have submitted your change, be patient and wait.  Reviewers are
> busy people and may not get to your patch right away.
> 
> Once upon a time, patches used to disappear into the void without comment,
> but the development process works more smoothly than that now.  You should
> receive comments within a week or so; if that does not happen, make sure
> that you have sent your patches to the right place.  Wait for a minimum of
> one week before resubmitting or pinging reviewers - possibly longer during
> busy times like merge windows."
> 
> And we have a merge window right now.
> 

Hi Boris,

I apologize for sending v10 and v11 in quick succession during the merge
window last month. Our goal was to provide you with the latest patch
series, ensuring all comments were addressed and ready for your review
at your convenience. Please share your feedback so I can address it
accordingly. Thank you for your time.

Vijay


