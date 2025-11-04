Return-Path: <linux-edac+bounces-5322-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A026C31401
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 14:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17BA74F9FB8
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 13:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC79322C83;
	Tue,  4 Nov 2025 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="vAARjTmh"
X-Original-To: linux-edac@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8123218BA;
	Tue,  4 Nov 2025 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262973; cv=none; b=CM9Qwjmx3KS8qk4YvkpFJajkTqifRc74UZkdJTuizqpPbIYC/SaXZ5bERCfF7q8fRc/gHQ+sj3CG3B9MmrbLjM1/1eycQ9VB43Gnng9gwcQliRd3ia/GazKArTptCkdVFMrhvVggXQtWK2W+IM6MkvTVbrElyjnse01CBlfRTGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262973; c=relaxed/simple;
	bh=Eco5OrdP0yzeZdUIo3So/CV6H+tWjeD3VGRriMmqnEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaWc8/pPDFwnTGLUCbIJfU98tVd/DaZwHKjrZZBY2pBmSGYtMg5wzQ0CDxZQhCo++RdO4ulL02DjIPAfxza9rPAFJ6Kzr9sH0SuZaZAylieFu/XdLtxUoZV5bpGkJ4XIWz3MYUSl8l9Y8MZc/d5jhvBPNxv6idGN1zU9ebN25eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vAARjTmh; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=UDPk3iLG0eDrVTCl9rDky3CFQfLdclSTPbN3316Yf1M=;
	b=vAARjTmhfdkMTg6kz24QdHijPIzqbQ709o2YuMI1IBCJCeK2ZHFk/2liIjNFLYAXJVkkEAx0Y
	xTrC+GpliI935FQmjp15aAkcUUwmlqDSM0id/87/I2Cq5JBapzunB2Ej1GR/LrgArjfBi2ZPLc+
	BPD9TGkcpKcpR4aKMQFU0Ig=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d18R40VY6z1T4G2;
	Tue,  4 Nov 2025 21:28:16 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 754D11800B4;
	Tue,  4 Nov 2025 21:29:28 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 21:29:27 +0800
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
Date: Tue, 4 Nov 2025 21:29:23 +0800
Message-ID: <20251104132923.145332-1-xieyuanbin1@huawei.com>
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

> This is a pretty generic description of MCEs.
>
> I think what we are missing is: who runs 32bit OSes on MCE-capable 
> hardware (or VMs?) and needs this to work.
>
> What's the use case?

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

