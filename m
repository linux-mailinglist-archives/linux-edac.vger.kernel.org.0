Return-Path: <linux-edac+bounces-5297-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BE0C2C12B
	for <lists+linux-edac@lfdr.de>; Mon, 03 Nov 2025 14:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CF284E4B0C
	for <lists+linux-edac@lfdr.de>; Mon,  3 Nov 2025 13:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0C7260590;
	Mon,  3 Nov 2025 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="XN2VxKRZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8EB25393E;
	Mon,  3 Nov 2025 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176252; cv=none; b=e2bg1Uvt7FbE+xNXwciGtVYIC17S4RlJdPUrCOJzKDF5tT1VHhcrj6ak4zL3GIGDfKG2yoY7f20xtpmu/Osl0/lmirt/CDAH3jVDSMpLf3J8UYzFXg0Jm4FLjSs+1GtXKsZ4t5nRucf8cirqGH9trC2Z6PyIVzoi5hldTTp5jQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176252; c=relaxed/simple;
	bh=MW0QQtvUuz61MW0vqnGbwGynelcszYrrI9irHuPD5SM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BmhoTi9MDBKTsMIRnc+vLn/aOXlv9mehvA6s1yLZA1Y4eVS1K+0ErYBVW7Ryi+xsj/VyOhQyyFdmnIobe+pba0sDF5DkPKLwK6bTfubU9B3OYxZLnEd6Kj26aBYBFTIdELz5YbtGLlS/z7T1izyyAnpIDt2++/Y6PjK9ETwTyYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XN2VxKRZ; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mAK4GGZ6Wc0AlGtkULkNF5rra7UyoEYfK4R4QDVlWWY=;
	b=XN2VxKRZ3crT5GYeeWcFkjt4OALy8Rp9wM7ylmTQFH7kUhZ88qzDVCE5n8pywkFL/nevUvLYE
	BwLJxMPgMSFxeY3ZRf2IwNogn4eKh8IPohQlk3UBi7gNesWUVZl/0GcQ6vIZC2tpJj5Zoi4FPnt
	npWYlwA07OCHYgkB/eN8ZX4=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d0XLt3rgWzRhQp;
	Mon,  3 Nov 2025 21:22:30 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D4CA180491;
	Mon,  3 Nov 2025 21:24:04 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 21:24:03 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <tglx@linutronix.de>, <david@redhat.com>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <lorenzo.stoakes@oracle.com>,
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <linmiaohe@huawei.com>,
	<nao.horiguchi@gmail.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<tony.luck@intel.com>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-edac@vger.kernel.org>, <will@kernel.org>, <liaohua4@huawei.com>,
	<lilinjie8@huawei.com>, Xie Yuanbin <xieyuanbin1@huawei.com>
Subject: Re: [PATCH 1/2] x86/mm: support memory-failure on 32-bits with SPARSEMEM
Date: Mon, 3 Nov 2025 21:23:58 +0800
Message-ID: <20251103132358.79766-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <5ace86cc-0b2d-4306-8bc1-dfc34cccef1a@redhat.com>
References: <5ace86cc-0b2d-4306-8bc1-dfc34cccef1a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Mon, 3 Nov 2025 13:08:38 +0100, David Hildenbrand wrote:
>> The historical commit d949f36f1865c60239d4 ("x86: Fix hwpoison code
>> related build failure on 32-bit NUMAQ"), disabled x86_32's
>> memory-failure when SPARSEMEM is enabled, because the number of
>> page-flags are insufficient.
>> 
>> The commit 09022bc196d23484a7a5 ("mm: remove PG_error") removes a
>> page flag, so memory-failure can now be enable now.
>
> In the meantime, we added PG_dropbehind

Okay, I completely understand now.

For historical versions, MEMORY_FAILURE cannot be enabled with x86_32 &&
SPARSEMEM because the number of page-flags are insufficient. At least it
has been so from 5.10.x to 6.9.x.

The commit 46df8e73a4a3f1445f2a ("mm: free up PG_slab") from 6.10-rc1
remove a flag that allows MEMORY_FAILURE to be enabled from here on.

The commit 09022bc196d23484a7a5 ("mm: remove PG_error") from 6.12-rc1
remove another flag.

The commit cceba6f7e46c48deca43 ("mm: add PG_dropbehind folio flag") from
6.14-rc1 add a flag, but MEMORY_FAILURE can still be enabled.

At least for the current version, memory-failure can be safely enabled.
The number of pageflags reaches its maximum value under the following
conditions: HIGHMEM && SPARSEMEM && X86_PAE && X86_PAT. In this case, if
MEMORY_FAILURE is enabled, the number of pageflags just reached the limit
of 32.

I will update the V2 patch to describe it.

> Cheers
>
> David / dhildenb

Thanks!

Xie Yuanbin

