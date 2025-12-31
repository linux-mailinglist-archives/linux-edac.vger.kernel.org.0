Return-Path: <linux-edac+bounces-5593-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B61CEC372
	for <lists+linux-edac@lfdr.de>; Wed, 31 Dec 2025 17:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 796C53013380
	for <lists+linux-edac@lfdr.de>; Wed, 31 Dec 2025 16:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9E5277C9A;
	Wed, 31 Dec 2025 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DDJplSYz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9455F27AC54;
	Wed, 31 Dec 2025 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767197285; cv=none; b=tVqo/2h+F82jy2byiyfTQOja8KM/11phG0NCFOlW3321GgOg4q/w4ZLQUBSExcuR72dgM2mFo+F0PGeZYtwH24GNbm/3gbaIPm6SrwJK/4Ln94H44ohcSnnOul6es+3/cw+oZFzdFUL9Z8F3sylNC+wWAVHgXHMLzKOubaUN3Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767197285; c=relaxed/simple;
	bh=uF4mMitOhmGrYZZWgBHiG2QbuoA0AIgo3LSAqT7kU9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXNHsydq5RFWfMWagbl1qto24pXlUssTYnzAkbH0P7tR5w93DR/wHijEatjUMFEWuv9XQBBWD8FLckIV4xtgMgeU3EbWTzTzRxUgq721b58i2c9+XyGb3J84belreniiodeb29LmCPouKWXtEg6GDriUT+7vZ3Q7b1UUO692E30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DDJplSYz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DBD4040E0281;
	Wed, 31 Dec 2025 16:07:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IljZNyQjQjEF; Wed, 31 Dec 2025 16:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1767197270; bh=HWouBMiF1EMh2+jI6GLE3S/Gvu5KjkPQi5L7cekMJZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDJplSYzrglhEEbmZ0mRfZaOt3zwvpzuTwYLPVsof6rsoCbpVLSC96nBSs6sJZ53F
	 r4KdoaeGF4/+LewLHoiieG87nkutk8JbgcIJYbdXTwTkXTyFvfxZXuGIleyn9sZcc9
	 BcAs8YbvqWAggpP2XlY7M5l+gQpaX06Ltgg6LIIgvK+aPyjsUBKvkd+7SqenAP5IPW
	 AJWKodYRTVpNPr6bHQ4n75QwNuePw8LzroHCs9KLIWkz67rNuJ1hjGkYC46/VSNutn
	 ZEOBz90ZJbzZIQaiOhPx8p7xfOJUPgeNC8mnv0mXpV4MhUbC8ObjRd7t5iRvOFhRRa
	 ftxIcIDJYrLyaxkZ97E962kB6unDyW3gd9M7b6WyEnmDyF4//KX7HY6iTS0et3P+F3
	 MrxHpd42tAcWAnv7ERLij6+t52a3vzHiCjCgOMAFtHI0kmHp+2slxNsQPhjlzk7jqM
	 uvRewEESpB50jqP0hNOQ6Eh5u0UC+A45J6ciabtIvac6Y+68ksTzztgD5VJW28BOtp
	 89JbFQNRqBGCR2xNJz0DbYOav2IS0By8QBHilsLBzyo1mqrXsaLG41S9IrlB6I9o1h
	 xoSOWpgt36LbBIzAzRaVtQRday/5HW2zr2ygP2DaEHZL6BBd5KiUTYbKvtj5a2HTj5
	 GWhUmofThhIi+lD1MA4yZEy4=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E824240E01AD;
	Wed, 31 Dec 2025 16:07:13 +0000 (UTC)
Date: Wed, 31 Dec 2025 17:07:05 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: shiju.jose@huawei.com, rafael@kernel.org, akpm@linux-foundation.org,
	rppt@kernel.org, dferguson@amperecomputing.com,
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org, tony.luck@intel.com,
	lenb@kernel.org, leo.duran@amd.com, Yazen.Ghannam@amd.com,
	mchehab@kernel.org, linuxarm@huawei.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, wbs@os.amperecomputing.com,
	nifan.cxl@gmail.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com
Subject: Re: [PATCH v13 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature
 table
Message-ID: <20251231160705.GAaVVKKfj5o-s7xLv6@fat_crate.local>
References: <20251121182825.237-1-shiju.jose@huawei.com>
 <20251121182825.237-2-shiju.jose@huawei.com>
 <20251125073627.GLaSVce7hBqGH1a3ni@fat_crate.local>
 <20251208162924.00004a38@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251208162924.00004a38@huawei.com>

On Mon, Dec 08, 2025 at 04:29:24PM +0000, Jonathan Cameron wrote:
> No to this suggestion.  Doing so breaks the rules that Linus has laid
> out for use of __free. Constructor and destructor must be next to each
> other. See guidance in cleanup.h.

/me goes and reads...

Ah, ok, makes sense.

Thanks for pointing it out.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

