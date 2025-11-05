Return-Path: <linux-edac+bounces-5340-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE852C33CCC
	for <lists+linux-edac@lfdr.de>; Wed, 05 Nov 2025 03:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A9664F0EFA
	for <lists+linux-edac@lfdr.de>; Wed,  5 Nov 2025 02:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AFA248F69;
	Wed,  5 Nov 2025 02:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="vTL06P1R"
X-Original-To: linux-edac@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E720E1E4AB;
	Wed,  5 Nov 2025 02:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762310735; cv=none; b=fUQmMHZp3IE7z66IT0n+Hi/HL2bphmzTwfBClQmssofgCjCWsvJurR0BR93KhScLHJ2GQONBPPAD35k0GWYBtopO18vXpA6IwVI4jfK4KLANMK76v9UVjHISqAHLwpkoMzScHJyoYkChv7HrSrlWCR17w6jGcsFYmQow+AK+Jjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762310735; c=relaxed/simple;
	bh=3Ggi/Q/B9Jjx+W4BbCfJWgLqE0uFZ19wuYTgC69T+VI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdTXOdOToyVCfKJK1j0dVBneoTcTOwImTFq0YI1cPgDfVpIZph/jALP0OeyU8px9jg8uVt1ygqBlTeO7sNHQqCgdDltLpzGG83nkvjvM/x/mmtMrBj75af7ikRGVBY6UKXCUM56YScDByA9ow0QA8JhKDh0aDUCGC9rkw2B10lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vTL06P1R; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3Ggi/Q/B9Jjx+W4BbCfJWgLqE0uFZ19wuYTgC69T+VI=;
	b=vTL06P1RNNIlClyL1lwh43rq8s5bX7YszQJ7wdw8CC/98pbIztmydkexhOiDM2G6jZXESTZxf
	cXKvc+YlXQZ3kj62CtgIImOwKDQu7K8qtyI/8e6oY/B+18Tic/Q6vYCPhzVlGjszt8XnRPSK0Yx
	9j4OGKfkLgTJf7oa7VKtCos=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4d1V5567bFzmV7D;
	Wed,  5 Nov 2025 10:43:53 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C2C4140156;
	Wed,  5 Nov 2025 10:45:29 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 10:45:27 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <dave.hansen@intel.com>, <david@kernel.org>
CC: <Liam.Howlett@oracle.com>, <akpm@linux-foundation.org>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <david@redhat.com>, <hpa@zytor.com>,
	<liaohua4@huawei.com>, <lilinjie8@huawei.com>, <linmiaohe@huawei.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <lorenzo.stoakes@oracle.com>, <luto@kernel.org>,
	<mhocko@suse.com>, <mingo@redhat.com>, <nao.horiguchi@gmail.com>,
	<peterz@infradead.org>, <rppt@kernel.org>, <surenb@google.com>,
	<tglx@linutronix.de>, <tony.luck@intel.com>, <vbabka@suse.cz>,
	<will@kernel.org>, <x86@kernel.org>, <xieyuanbin1@huawei.com>
Subject: Re: [PATCH v2 0/2] x86/mm: support memory-failure on 32-bits with SPARSEMEM
Date: Wed, 5 Nov 2025 10:45:23 +0800
Message-ID: <20251105024523.14300-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <47b3e8ba-bc95-41ce-be0a-ddfd1323bab3@intel.com>
References: <47b3e8ba-bc95-41ce-be0a-ddfd1323bab3@intel.com>
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

On Tue, 4 Nov 2025 06:26:58 -0800, Dave Hansen wrote:
> Which LLM generated that for you, btw?

I wrote this myself; LLM just helped me with the translation. My English
isn't very good, so I apologize for any mistakes.

> I wanted to know _specifically_ what kind of hardware or 32-bit
> environment you wanted to support with this series, though.

I think I have explained it clearly enough in this email:
Link: https://lore.kernel.org/20251104133254.145660-1-xieyuanbin1@huawei.com

In simple terms, it refers to some old existing equipment and some
embedded devices. More specifically, it includes some routers, switches,
and similar devices. From what I know, there is no VM environment that
using it.
If you are asking about a specific CPU chip model, I'm sorry, but I may
not be able to provide that information for you.

Btw, why do you only ask about which x86_32 devices use memory-failure,
but not which x86_32 devices use sparsemem? This patch just allows both
to coexist, and perhaps both are important?

Thanks!

Xie Yuanbin

