Return-Path: <linux-edac+bounces-4728-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEEDB425B7
	for <lists+linux-edac@lfdr.de>; Wed,  3 Sep 2025 17:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A4347A139E
	for <lists+linux-edac@lfdr.de>; Wed,  3 Sep 2025 15:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454F2283CBF;
	Wed,  3 Sep 2025 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="V0fsfZg9"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E898527FD78;
	Wed,  3 Sep 2025 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913997; cv=none; b=rz2NXSxp+yKowf1ksjzQNOsJSnEBfrpDQVijVrfWNaiGTr8FzJ3lhTUDq16H21nXPCH7+eKQmXxQGE+eqwuBC/j5YQT6YJR2+g86zS/ULC2Q16231h0Nuc50q4VyzGkqSsQGdla8e1LJP+DOI/rHgGsab48oQEAJEOBuOOqCGi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913997; c=relaxed/simple;
	bh=yEra3lMBgmntkeYUtl49sYAEYjq84wZRgNOZiqJ9768=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvxnmS+yh7QJVwx0k3WURSr7Pvt44pon3oZ+0MfBoof5sDDkbTQPPNIhgbQdMoDvfi2KU2wpIG9ORgxGMRMK/hkwhgRqIFAvtQ4Ph1VgR7yQeiHIld3cRAU4gWAn5sKMOk45lUNQjPY0vNt2EqhM/z5IgDgsClhlRlljL1gW92I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=V0fsfZg9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 776F940E016E;
	Wed,  3 Sep 2025 15:39:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IFeAcDB9JgAz; Wed,  3 Sep 2025 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756913972; bh=gZt5S953FuMmLNd9xFknMXERSFx/tD6LVwgV8tqL03A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0fsfZg9Rq1IOx868l07KxQeyuox7KJK6b3pVNfQHznEIsGmw2Qp9CstZMV4bc34G
	 5PvMuKPidFkWXp+2ZApGgZHKfaTzjmYswHBSRMDzS44Q2QBa+CJi6n+EdB8cfFZIws
	 ov+u03D6WoD5drG4GjKuhnHeks6Xrj18gStgMXV+E76Y7j2E1k2ww18qeF+K/gJThX
	 zH3SzcMvfcEwPQNElPzMnUYK1+DPmTejy/+I78THP22ZJgTq0yLrT9AaBhQqFiWkQC
	 oUe+CLSVwEV620vpJTUuyJMd6ZySIQgVkhHeiqN+Lm2GK9xLJdNmtPjqCsqW3xyu9l
	 lI7uX5lCPBEi7TRyBCa/DFePnBCEEHh+Mv4dvM4jLKK0TEFPK1WdW7Jsx/P8KflY2u
	 9M1NtnQguansyJZ0AZh8MKHk5rz+4u5jPt+i37BfB4oLxCJcETsotrXeSzt3ZvIaRP
	 /UHaSKvlNFIVaftxJEGZQHbxm/rrwtwfN3AeuBUZZNgLjwylVEmxEXWt6Fx0BtfC/R
	 kC66Pe2hb7Jxbvkczp/A6xLnNv9rbz5wQCP8CzG/ffalkBgQixmp81UZKhzBHDsi+v
	 nA/HtfxYKXzpyogiCA+6QYoRu1oG0fvzo6kxHwL4l7b+c7PgbqbzF1oikW28p+kJJn
	 5faB4IUAVCH47Q/9cavJF++U=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 6282440E00DE;
	Wed,  3 Sep 2025 15:39:22 +0000 (UTC)
Date: Wed, 3 Sep 2025 17:39:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 15/20] x86/mce/amd: Enable interrupt vectors once
 per-CPU on SMCA systems
Message-ID: <20250903153916.GCaLhhJHHK7oY-PTqz@fat_crate.local>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
 <20250825-wip-mca-updates-v5-15-865768a2eef8@amd.com>
 <20250903100317.GHaLgSZTPMDHrKbO7Q@fat_crate.local>
 <20250903140022.GA835@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903140022.GA835@yaz-khff2.amd.com>

On Wed, Sep 03, 2025 at 10:00:22AM -0400, Yazen Ghannam wrote:
> But any reason to use u32? Why not u8? Alignment or something?

Struct padding:

$ pahole --header elf64_hdr vmlinux

...

struct mce_amd_cpu_data {
        mce_banks_t                thr_intr_banks;       /*     0     8 */
        mce_banks_t                dfr_intr_banks;       /*     8     8 */
        u8                         thr_intr_en:1;        /*    16: 0  1 */
        u8                         dfr_intr_en:1;        /*    16: 1  1 */
        u8                         __resv:6;             /*    16: 2  1 */
 
        /* size: 24, cachelines: 1, members: 5 */
        /* padding: 7 */
	^^^^^^^^^^^

        /* last cacheline: 24 bytes */
};

vs

struct mce_amd_cpu_data {
        mce_banks_t                thr_intr_banks;       /*     0     8 */
        mce_banks_t                dfr_intr_banks;       /*     8     8 */
        u32                        thr_intr_en:1;        /*    16: 0  4 */
        u32                        dfr_intr_en:1;        /*    16: 1  4 */
        u32                        __resv:30;            /*    16: 2  4 */
 
        /* size: 24, cachelines: 1, members: 5 */
        /* padding: 4 */
	^^^^^^^^^^

        /* last cacheline: 24 bytes */
};

The end result is the same unless your do __packed.

But you might as well use the u32 in the distant case you need more flags
- you never know with our RAS folks.

:-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

