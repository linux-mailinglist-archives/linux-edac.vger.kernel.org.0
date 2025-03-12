Return-Path: <linux-edac+bounces-3355-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC27FA5DBB0
	for <lists+linux-edac@lfdr.de>; Wed, 12 Mar 2025 12:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5C6189CAE9
	for <lists+linux-edac@lfdr.de>; Wed, 12 Mar 2025 11:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB63523F28B;
	Wed, 12 Mar 2025 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Bv5Q+niz"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86FE1D63FF;
	Wed, 12 Mar 2025 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779414; cv=none; b=b3ul+wAaUOD9nm/vJg1o0XC6IOXJQN2xEFGH2mio4Z1erV3gOg0Honq5U0BPWc5srH59K2V64Rzfa4ZagdxpDscXmnQMVBCmeTU2jeutAmstlg/QYs6ucAAlduiGE5pOjyEPc/mGH4Q6NaisEhXx642wryhSy4yFAM3ogX20x98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779414; c=relaxed/simple;
	bh=1Fz8WhRnmBawJkwtKGHmqo+UYz5xPgWFag+s3Ew1uiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClF2aT5JqhUsE/6u0RYYYg2ypPFof2764mLVgxF8vsRC2hT18AsyLD4k+JOIZkx5bAo3u/DOXJ3u1vJoj5W+LAOWYA175rVGsHN7eCFNSp5moJ4P+NyGZr77Blt8tRueVFRlh/S8ygqB3jNe/eAMbSgbKG6mLGlYyoBgw5mjXTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Bv5Q+niz; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741779402; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1Fz8WhRnmBawJkwtKGHmqo+UYz5xPgWFag+s3Ew1uiM=;
	b=Bv5Q+nizoNbtdUQx7QfHvFuGW6wTTEPs5/dnwisUOi7KyzDBJjQjYEWUQ2FNRdIcXcgOx0aUxPesF9kNgccy6Rqxs68jPmGnnAweRjzNLd6vafhHEUvl0HUf7T2gbZ0SO4agUHTpEKIqJhTKtHeBjSO+JEyfFIWw4dhfwDCfa/o=
Received: from 30.221.65.55(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WRCdxxP_1741779400 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Mar 2025 19:36:40 +0800
Message-ID: <919fb668-35d4-42a8-8c28-082663e07f84@linux.alibaba.com>
Date: Wed, 12 Mar 2025 19:36:39 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] mm/hwpoison: Fix regressions in memory failure
 handling
To: akpm@linux-foundation.org
Cc: tony.luck@intel.com, bp@alien8.de, peterz@infradead.org,
 catalin.marinas@arm.com, yazen.ghannam@amd.com, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, jpoimboe@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com,
 "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
 "linmiaohe@huawei.com" <linmiaohe@huawei.com>
References: <20250312112852.82415-1-xueshuai@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250312112852.82415-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/12 19:28, Shuai Xue 写道:
> changes since v4:
> - fix typo and polish commit log for patch 1 per Borislav
> - collect Acked-by tag from Borislav and Miaohe
> - collect Tested-by tag from Tony
> - No code changes


Hi, Andrew,

I hope this mail finds you well.

Because this version has no code changes, but only collects
ack tags, I did not bump version to v5.

If you have more comments, please feel free to let me know.

Thanks.
Shuai




