Return-Path: <linux-edac+bounces-3147-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6C7A3B1AA
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 07:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B771635D2
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 06:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FA81BB6BC;
	Wed, 19 Feb 2025 06:31:22 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E279816D9AF;
	Wed, 19 Feb 2025 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739946682; cv=none; b=F+C+vMOYtf/shUh48uZKwORJulR5ieDRAtgbhImf4xMOcQJV8QXwXDgriHCx96nPK5erH8FKRvxjo8Tato0mmIFflcJs9P3wZ4B+HVln2ixU+U4KyxTCsFLGxZdk+u+PdKIfPC6yDpTmPM41zYQK+arxTlPyUn7JCxl+diGrVXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739946682; c=relaxed/simple;
	bh=9I2lalwUly/vcyAgyPms8aYhlmg9iHb5AGF2bo/ao+w=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Z7awkBggONSl+I6P55pmFw1TfaB2kgV+Ec9x3Lzb2q7Du7juXFYx2UbshrDfRtammlAf5pc7dhtI7ZVcZiWpN6eKyDJHhcOcazxCqnWcP6KUIjY/0CfIvIswIJTh7HUSowRZcSioDONnIHWq6bhFF7sbdhrOuA/zQ5VBGfKQ7LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YyRK52DXSzhZx1;
	Wed, 19 Feb 2025 14:27:53 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id CC93B1402CF;
	Wed, 19 Feb 2025 14:31:16 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Feb 2025 14:31:15 +0800
Subject: Re: [PATCH v2 5/5] mm: memory-failure: move return value
 documentation to function declaration
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<peterz@infradead.org>, <jpoimboe@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<baolin.wang@linux.alibaba.com>, <tianruidong@linux.alibaba.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <nao.horiguchi@gmail.com>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-6-xueshuai@linux.alibaba.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <bdea7f63-c5ec-2e3b-8c88-e0a7ea745285@huawei.com>
Date: Wed, 19 Feb 2025 14:31:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250217063335.22257-6-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2025/2/17 14:33, Shuai Xue wrote:
> Part of return value comments for memory_failure() were originally
> documented at the call site. Move those comments to the function
> declaration to improve code readability and to provide developers with
> immediate access to function usage and return information.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Reviewed-by: Jane Chu <jane.chu@oracle.com>

LGTM.

Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.

