Return-Path: <linux-edac+bounces-5318-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5363C3060C
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 10:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F8C3ACB5B
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DA6313277;
	Tue,  4 Nov 2025 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="w/wF74mo"
X-Original-To: linux-edac@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581A3313271;
	Tue,  4 Nov 2025 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249859; cv=none; b=NaxtqE+f2alId4CMgaWwdj8GxyVxIN373epP0mbKxF0YpdWjqoZW9+mAGRGSbKAig+tYXgqJflQTwQ1NGMe5gp1LS0S7fz0g40JdauuOnhbcitONZ6pKvu2Lqq1heg4teGTDLnzv7EQyKg+UM9nexa0VglU5w6DyvRKa4B5Vr/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249859; c=relaxed/simple;
	bh=HabB8ldMI2OOh45J3M/iCspbQZpiYRCHjHPqoBhZBuA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G791zLaUS0OYULJMs1uzN0GGvkXyKiChdzJSoZ0JSAiiRi/Yw/Q1gw5bzVxtRmhuWEx2t6n2sNRyTCuJ69obXYopy8c+ME3594bQRU3ibTTEeSmly1WOJgWX2hjQRow0HVV3WMwYypTdpZrW79DdFzBAqPgAzzo0NqCKWcxnplk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=w/wF74mo; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=t8ryYqzNzuomFM1qI/F9XXL0yM4A3U1rNvzkeTZ8nMY=;
	b=w/wF74mo1/KwoyB4tDKQy8+xB8kViYjE1uL7ZkflzS+/rP/iIWNQoEXBIzZjAZ3+X8X8iOLE9
	WnXgY/JOX/VGQ7dBqCOVHVi2P5xnsvukEBmMytUG9LEDroc5xVe3QENpNXf1HWq8jp+kA7FHJ3m
	DaRzAsYEEupFXMccVPL+ZcA=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4d13ZS5RNGz1K96k;
	Tue,  4 Nov 2025 17:49:20 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id B6A6C140155;
	Tue,  4 Nov 2025 17:50:53 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 17:50:52 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <david@kernel.org>
CC: <Liam.Howlett@oracle.com>, <akpm@linux-foundation.org>, <bp@alien8.de>,
	<dave.hansen@intel.com>, <dave.hansen@linux.intel.com>, <david@redhat.com>,
	<hpa@zytor.com>, <liaohua4@huawei.com>, <lilinjie8@huawei.com>,
	<linmiaohe@huawei.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <luto@kernel.org>, <mhocko@suse.com>,
	<mingo@redhat.com>, <nao.horiguchi@gmail.com>, <peterz@infradead.org>,
	<rppt@kernel.org>, <surenb@google.com>, <tglx@linutronix.de>,
	<tony.luck@intel.com>, <vbabka@suse.cz>, <will@kernel.org>, <x86@kernel.org>,
	<xieyuanbin1@huawei.com>
Subject: Re: [PATCH v2 2/2] mm/memory-failure: remove the selection of RAS
Date: Tue, 4 Nov 2025 17:50:48 +0800
Message-ID: <20251104095048.119012-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <01b44e0f-ea2e-406f-9f65-b698b5504f42@kernel.org>
References: <01b44e0f-ea2e-406f-9f65-b698b5504f42@kernel.org>
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

> This trace system should not be called "ras". All RAS terminology should 
> be removed here.
>
> #define TRACE_SYSTEM memory_failure
>
> We want to add that new file to the "HWPOISON MEMORY FAILURE HANDLING" 
> section in MAINTAINERS.
>
> Nothing else jumped at me.

Thanks, I will modify it in the v3 patches.

> Cheers
>
> David

Xie Yuanbin

