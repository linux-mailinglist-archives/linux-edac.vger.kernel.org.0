Return-Path: <linux-edac+bounces-5294-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3E9C2BCC4
	for <lists+linux-edac@lfdr.de>; Mon, 03 Nov 2025 13:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27923A55A6
	for <lists+linux-edac@lfdr.de>; Mon,  3 Nov 2025 12:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD7B310784;
	Mon,  3 Nov 2025 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bTzr4D7Q"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD8230E856;
	Mon,  3 Nov 2025 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173606; cv=none; b=Ufi5Lr0yLCnO5hVjVRDxYYk9e3KA+2FqvvsBZKQ5da6Lv5kAmY7v2PD1lsW5uvXu245kuij/DoSiw0Us+dJFnFdYzKfZ+byIynBj2HAWDcLlLJF/xon/c/xzSDfeLsmanRdjD6C8L1dnBWuCfu+q8lAvDeDkLbWPR2xtItkt0kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173606; c=relaxed/simple;
	bh=cCg/Acg0fGzyosLAg5+VW7InPIAAvH/46BuTOCSh9ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amJJr2X+xveYzXpTTXIOr1+XDm14+6K+pQVyqb3uWMSzPisqJuHKSbXuW20p+pLRYmW9YyhzK8077JnGPvmetl0IXSpB3K7RjCLZMk8bh4KyOBzuOMK2kHwJ9+E0/dxNGPEY9m7vvttScDJTxyHrSn+qqVKbvbS+iIUk4KiDgqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bTzr4D7Q; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 604D840E00DA;
	Mon,  3 Nov 2025 12:39:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KtrrO9iIlOm3; Mon,  3 Nov 2025 12:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762173591; bh=FFLwKgwx6WFvJkW1SsKMkTkIEWPqVqozlHZeum7DzeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bTzr4D7Q9+R8M2HmUNps/SjaU1a4dLaSFPp04M573KsTmbE0ij51zExSOukKSk4S0
	 DP94WNtHHPKkSinM4l8W8pf8mQ7AbLqEdnghTE+kTAjGl/QPTDihnlr69s7/3LjOz/
	 ZY92w1g3PJH9Pg/MKQY8wl5LZfI+VqGcSC6Lqp/T4m0mBf6DtpObIeSD1ONlzfQolG
	 RIDo/NMQc9wKm0/OGVAbu1G6ui4DsAWKh89LlScXzVH9/lAOsipQEOuXLYjkCFUG0c
	 Br4iUhT6qLiLZpvbca1ivrqE4Z3yq2RTAsU6sYT3mjZ5W2wilHvFxwK3EEgNVhDp9j
	 /b7xfTr8WLRBwisU9zbd4sJbafD15zbyV+FNUDW+Hc8KS1AxxZtDP2S0htntKOEswf
	 UXAXHompzT7Na3DM6/uzbokyfnJ/B7T6bPk+5HDmZs3R0XgWEsmT/LsIvAAuXhOI4+
	 A6fKJ5ZOZD+Xx86G/jTuyZ6jvVjjZPJwsTXsKlpwfIgWCW45a18KsKc+7KATcsgasc
	 FGaSbQm98KSLWWT3nKQ8ZO2gYtrJAbrwarUAC9DeHJCO5WEH2ueYYQ4i79u6+NZI9T
	 Ho43YZd4DjmHkb7nsGe5S2FaqtOG91C9pVK912aY0UpHX0+byeWKxeNE7v8JKYpwpF
	 f+0t9hMU6aTP6YzxBKVDzOeo=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 4B2AB40E01FA;
	Mon,  3 Nov 2025 12:39:26 +0000 (UTC)
Date: Mon, 3 Nov 2025 13:39:20 +0100
From: Borislav Petkov <bp@alien8.de>
To: David Hildenbrand <david@redhat.com>
Cc: Xie Yuanbin <xieyuanbin1@huawei.com>, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, luto@kernel.org, peterz@infradead.org,
	tony.luck@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-edac@vger.kernel.org, will@kernel.org,
	liaohua4@huawei.com, lilinjie8@huawei.com
Subject: Re: [PATCH 2/2] mm/memory-failure: remove the selection of RAS
Message-ID: <20251103123920.GCaQiieAtEGz1nspWZ@fat_crate.local>
References: <20251103033536.52234-1-xieyuanbin1@huawei.com>
 <20251103033536.52234-2-xieyuanbin1@huawei.com>
 <341ff738-255f-41c7-8b23-48aac4cf51e3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <341ff738-255f-41c7-8b23-48aac4cf51e3@redhat.com>

On Mon, Nov 03, 2025 at 01:15:58PM +0100, David Hildenbrand wrote:
> I rather wonder whether the memory-tracing code should live in a
> memory-failure.h instead.

Yah, move it pls. It doesn't belong there.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

