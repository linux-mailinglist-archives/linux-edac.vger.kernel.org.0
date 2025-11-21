Return-Path: <linux-edac+bounces-5495-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA6EC77B7A
	for <lists+linux-edac@lfdr.de>; Fri, 21 Nov 2025 08:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6F903548C0
	for <lists+linux-edac@lfdr.de>; Fri, 21 Nov 2025 07:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AA72D543A;
	Fri, 21 Nov 2025 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="N5/8B55n"
X-Original-To: linux-edac@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87309283683;
	Fri, 21 Nov 2025 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710753; cv=none; b=UERmcOLUSCKyisYyLrQuBciYPAaMkdYjjMmCbnPoMkdjIRCmDUymNubCB74dtWU2KJpXcaDW3sbVkUq37nkMHUG75GcZP3v09/zIEDjjNiQ1RRwpPXGo8WGsroRs00Eg3dvbTi4QSr6wRGZJM5zeuhis2QqjPPjv4eJgDYWBo5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710753; c=relaxed/simple;
	bh=AugTGMRA4pvKKAUuDdtPRrbisScHKer09i0AVJeGlPo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VFSiML5nZ22USIcHozRxh+hMkMPOoi6FzmBAN0E1SovhcF8cjQyETvb+QhD/YebPf9gDdo+y3qSvwwUQ4O8hnaSDxTDK8q7AtMrgQUAdpVqGzlmjjj8JgOnVt4RrI9Z2omNgX8fjqCCfmYtjnkroXp3PCPYAS2P9G30a4xBrVek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=N5/8B55n; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Jw7Ud8zh45h7Hnmg98SmQKRWVlaGwdOC5WqXH1EQ55o=;
	b=N5/8B55nKmRouJYEJQ31wAPlVWAbWvnSJEvXC4E4Y/iT7YlDm1xWdztV8ZlPBdi7UML01lUc1
	Fv8XbMPOj7kpwPW+tlnhHlLdprZnTT5vLaEvUbYWZSyYGWOxnOO7oHGFWOv5YELHAHIr5n25AxD
	y1ox9Sv5tlLGPqrKu9b8QeU=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dCRrL55nqz1cyP6;
	Fri, 21 Nov 2025 15:37:22 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id F1326180043;
	Fri, 21 Nov 2025 15:39:07 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Nov 2025 15:39:07 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Nov 2025 15:39:06 +0800
Subject: Re: [PATCH v3] mm/memory-failure: remove the selection of RAS
To: Xie Yuanbin <xieyuanbin1@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-trace-kernel@vger.kernel.org>,
	<will@kernel.org>, <liaohua4@huawei.com>, <lilinjie8@huawei.com>,
	<david@redhat.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<nao.horiguchi@gmail.com>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <akpm@linux-foundation.org>,
	<david@kernel.org>, <lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>,
	<vbabka@suse.cz>, <rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>
References: <20251119095943.67125-1-xieyuanbin1@huawei.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8567d8c5-e864-8f84-7805-c004698e72d7@huawei.com>
Date: Fri, 21 Nov 2025 15:39:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251119095943.67125-1-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/11/19 17:59, Xie Yuanbin wrote:
> The commit 97f0b13452198290799f ("tracing: add trace event for
> memory-failure") introduces the selection of RAS in memory-failure.
> This commit is just a tracing feature; in reality, there is no dependency
> between memory-failure and RAS. RAS increases the size of the bzImage
> image by 8k, which is very valuable for embedded devices.
> 
> Move the memory-failure traceing code from ras_event.h to
> memory-failure.h and remove the selection of RAS.
> 
> v2->v3: https://lore.kernel.org/20251104072306.100738-3-xieyuanbin1@huawei.com
>   - Change define TRACE_SYSTEM from ras to memory_failure
>   - Add include/trace/events/memory-failure.h to
>     "HWPOISON MEMORY FAILURE HANDLING" section in MAINTAINERS
>   - Rebase to latest linux-next source
> 
> v1->v2: https://lore.kernel.org/20251103033536.52234-2-xieyuanbin1@huawei.com
>   - Move the memory-failure traceing code from ras_event.h to
>     memory-failure.h
> 
> Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
> Cc: David Hildenbrand (Red Hat) <david@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Miaohe Lin <linmiaohe@huawei.com>

LGTM. With David's comment addressed,

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.


