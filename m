Return-Path: <linux-edac+bounces-5323-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DBBC31417
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 14:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 993F44EA2C8
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 13:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262283203A3;
	Tue,  4 Nov 2025 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="XjiOLUNL"
X-Original-To: linux-edac@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190F1314D04;
	Tue,  4 Nov 2025 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263186; cv=none; b=OnETTZoef7ERBjbY8XWdYq5vwtkC+D5Y+fwbL5tSNyYEQbzx6wG64jXfruda7+5j8MHVSg1SXgM35UEy+aGKjEiamcThiwT0Qm13iKQmYgiSFV/ROcXq49GXbc1p/czxpn0ybOCyIdLS/jYZFyw+aZ/4gu3fg6LZfI5j+hPteHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263186; c=relaxed/simple;
	bh=W0MxlqNfW9kG5hLgToFZqR9Hqo0Q65lVaYK+y9WBb/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LML4L+I12t8UnQJqjgaY1//0+xMAwMdfHP6Jd2t+5howgAaTQWQlT9TzPSHouNhMNoLPfEjTSQxGnFQByoiuyxrgh3NzHVtc38i4wAqg/Cjaa2C/TiIO1Y2ZMEilzo2Pjtaspf15NYpspaXS9yNo2F/+/GAn3glACexvS0zjsnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XjiOLUNL; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1ZS1VP48kWsjQkafbWNPso8jvsGsHuCySVWgpy/tEr4=;
	b=XjiOLUNLvWed5Pa1dui1w83KfEcXZfFYdQ60V9KqJ6gWCulwSDVr23cqlpcQiTFoiEyrWDYv3
	k0q42A2tavuKJqxKuvm6AK2vXfp+vMNfUuihI9mqGHwnD4AIQuOl6ChNFnal/PILbpB8IofIp8W
	WqLrUCXS9qCHio9d8TZiFAo=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d18Vp1QtkzpStX;
	Tue,  4 Nov 2025 21:31:30 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 703D41402F2;
	Tue,  4 Nov 2025 21:32:59 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 21:32:58 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <david@redhat.com>, <dave.hansen@intel.com>, <bp@alien8.de>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <lorenzo.stoakes@oracle.com>,
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <linmiaohe@huawei.com>,
	<nao.horiguchi@gmail.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<tony.luck@intel.com>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-edac@vger.kernel.org>, <will@kernel.org>, <liaohua4@huawei.com>,
	<lilinjie8@huawei.com>, Xie Yuanbin <xieyuanbin1@huawei.com>
Subject: Re: [PATCH v2 0/2] x86/mm: support memory-failure on 32-bits with SPARSEMEM
Date: Tue, 4 Nov 2025 21:32:54 +0800
Message-ID: <20251104133254.145660-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <1b316667-470b-4e1a-9c18-e42571e4769c@kernel.org>
References: <1b316667-470b-4e1a-9c18-e42571e4769c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj100009.china.huawei.com (7.202.194.3)

The previous email was corrupted; please ignore it.
I'm very sorry about this.

On Tue, 4 Nov 2025 10:33:39 +0100, David Hildenbrand wrote:
> This is a pretty generic description of MCEs.
>
> I think what we are missing is: who runs 32bit OSes on MCE-capable 
> hardware (or VMs?) and needs this to work.
>
> What's the use case?

I did indeed miss this part in my description, and I apologize for that.
Since the memory-failure feature was introduced, from
commit 6a46079cf57a7f7758e8 ("HWPOISON: The high level memory error
handler in the VM v7"), it can be enabled on x86_32, submitting these
patches only because MEMORY_FAILURE cannot be enabled together with
SPARSEMEM on x86_32. The memory-failure was introduced in 2009, when
64-bit hardware was not even very popular yet, and the first caller of
`memory_failure()` is from x86's MCE.
Even in latest version, with default i386_defconfig, MEMORY_FAILURE can be
enabled directly on x86_32, because i386_defconfig does not enable
SPARSEMEM by default.
Therefore, I did not consider the need to explain why MEMORY_FAILURE needs
to be enabled on the x86_32.

Now, let me try to explain it. From what I understand, it mainly comes
from two aspects:
1. Although almost all new CPUs are 64-bit, there are still many existing
32-bit x86 devices in uses.
2. On some embedded devices, in order to save memory overhead, even with
64-bit CPU hardware, a 32-bit kernel may still be used. You might wonder
why embedded devices need SPARSEMEM. This is because the MEMORY_HOTPLUG
feature depends on SPARSEMEM, not necessarily SPARSEMEM itself.

All of the above devices, the memory-failure feature may be used to
provide reliable memory errors handling, and to minimize service
interruptions as much as possible.

> Cheers
>
> David

Thanks!

Xie Yuanbin

