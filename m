Return-Path: <linux-edac+bounces-4370-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFF7B07A6C
	for <lists+linux-edac@lfdr.de>; Wed, 16 Jul 2025 17:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD659169298
	for <lists+linux-edac@lfdr.de>; Wed, 16 Jul 2025 15:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262D72F3C3E;
	Wed, 16 Jul 2025 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jm/afVQ1"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7F2F2C5A;
	Wed, 16 Jul 2025 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681336; cv=none; b=oOrybdj6QkZ899/M0OaumS45Cq8aO1W/pYAGfkvPVrtjKGaItFGvJz8uRhqo3uT9T600GgCSrechoAliSXoU2/VkzGP+Flpgo3m1BuKOZiDbytQOFl22qYxMsWDULIRy0TCkmUs4ryDA/DCClTHHOJ90fQWZRqm/YDDKT9PbxbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681336; c=relaxed/simple;
	bh=a9Cg9NOcIUQupCuavDAFI79yKwc0Isv17jQ5UTa9D8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSP7ezPIxGAxPMs9vT277wU0ZZHqeiVM+aQjs8H1C2KU7b9SUXfqnTR9OwGQhtgrY1hexz8EtBYr5SbpXTg4K+AmzpwneE6jQAxUQ6ltVyIHFC/5CtXUAyu1eE0OduIzvCoeScL8jeXkjMof7UmCmgdTmmR6hAARQLWJEo1upqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jm/afVQ1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 773D940E00CE;
	Wed, 16 Jul 2025 15:55:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wQNLSl_5hiRE; Wed, 16 Jul 2025 15:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752681325; bh=VsP7hQUBZY9EYcZrcPke+dSpTYsqhDZGcDKwjNT91bQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jm/afVQ1W5lUuofxiirhazGqYU7W2tt9RaBhYIM+z7V7HflCiOgxSXn981NTRLJWO
	 VkOgZ9ruow62srw9D51xRouxpv0LUJJEYRPUJbcbjYsU78bz4E2kA1tHG2AH/FM6MI
	 /Dizobc0xZah+vjiul2mB5UgrDHaXBMIIwRfx/2f7mGgNH68MR0aCYUAS6wD0AKoEa
	 iqaoHAkXD/569TwLDwhlIHBHVcIb4u7aKODNSVABJfbzcvjda1e5NdWdIaHmxHPNcD
	 8Vrnf/3wsCUGSHIlrMPXVye8OMStvFKzb1T1RloXzQ6IqDhbySfNlfUcZw6zUdSzom
	 BtHQPeSfC0J1mS5h1lWLesn9HAdy3vCUJsqmmB6c0Kmk0PDkLB4sMTQrhmhPLbE0iS
	 IjbTdvcGLgT5bg/Clv5kBpp6OzExDnuEVpq/mG9ykLLz9RX+yqO/ztH8H+PYn9/9HG
	 TrxrF1xw4+DxsHrEpPEhInsumEuijZfj1I13dcmHvETzmEUF70nHbUyW4bhDfe8ZvA
	 b76Ze2G39VrMq7zAo0d9Q0qki06L6vqgq46RoIuAQeSI8rXZgIeRZ6GsgtdWciBhH1
	 y+satILbc74eT5MIo4wV+QaS4p6QLodwLJOojr8blu6qHSCuPMcw1Bo9oTCzd7h7oq
	 BB+vlpxGnuxZYJ/QqNq8J3BU=
Received: from rn.tnic (unknown [78.130.214.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9B30440E021C;
	Wed, 16 Jul 2025 15:54:50 +0000 (UTC)
Date: Wed, 16 Jul 2025 17:56:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, shiju.jose@huawei.com,
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, mchehab@kernel.org,
	linux-mm@kvack.org, linuxarm@huawei.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH v9 0/2] ACPI: Add support for ACPI RAS2 feature table
Message-ID: <20250716155647.GAaHfLv-S5YG71nLgY@renoirsky.local>
References: <20250617161417.1681-1-shiju.jose@huawei.com>
 <20250716152818.00006759@huawei.com>
 <CAJZ5v0hqFOssbnsgcc9c6HASc9FRvth804SJ8oSb5aUKZDu9hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hqFOssbnsgcc9c6HASc9FRvth804SJ8oSb5aUKZDu9hQ@mail.gmail.com>

On Wed, Jul 16, 2025 at 04:42:13PM +0200, Rafael J. Wysocki wrote:
> So what's missing is his ACK on this series.

Rafael forgot: Shiju, him and I had a private thread where you folks
wanted me to take it and I said, I need to review it properly first.

You need to decide what you wanna do and I'll try to find time to take
a look.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

