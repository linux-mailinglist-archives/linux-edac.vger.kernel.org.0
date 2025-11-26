Return-Path: <linux-edac+bounces-5536-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96755C8A902
	for <lists+linux-edac@lfdr.de>; Wed, 26 Nov 2025 16:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55AE83A3A7D
	for <lists+linux-edac@lfdr.de>; Wed, 26 Nov 2025 15:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5970330F92B;
	Wed, 26 Nov 2025 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BNCYgRsX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E289730F534;
	Wed, 26 Nov 2025 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170042; cv=none; b=R1xszTLMVhP5JqGEypopwNkgwlI+o0Kfed5C44xtA6KkYEX3xdh0b4J83f0qj2Lq8GOUrHn/SWxrTBEqsgS+lq49cwXQagN6wT2HSyRa6JrPBZ+ef0nDYfxG0oqeN/vY/cDw2f6SEwUFWeMoMpxXjdmwFHx/Rj8edd6oZAKho7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170042; c=relaxed/simple;
	bh=dSbJS+jVRKAGJvmMm1kY438mxy9TbCHMr4buRPBAhKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5+BgU4hBUVLasLVykkdt5TXqoLPo8veABsBI5txvBFcfAvz+/2RH4QP8mYx0bgWswTYSrZe7QgKqkouyIzu1ErZ5eDHROZ0NUJzpiHjrIre5xAgNTPTI0RWmRCHynkv6wUqiaNpxm6caR6UEzGvDyiV+G57+46tKQEJ8oLvh7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BNCYgRsX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D32A140E0200;
	Wed, 26 Nov 2025 15:13:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PyEw0_TdL3VJ; Wed, 26 Nov 2025 15:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764170026; bh=btJVqATq4plsOClKXHmubGbB+S0XT5c2lsnhyZZ9nas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BNCYgRsXypIt2YFL/PZ6nGUMZz9o02d55d+tXPW8kTo+3HzpzgCG1jlvQdBT3u5mu
	 GHRYJfXvWznDWRxUC3WfgugAqxCRzAC0dhZa95UiVgObtepA+AasKuRiIOq+t1OIJf
	 lFGHlp1NR0LbCl3Ft9+ssutw2KPoNcM5foBDZm3BtI8iJwZu9y4sFqKP+OYHshXoBL
	 fINVe/cexWV7WbrsJ5NABrZPJ/jLNAYR3fwnzuTUC9q2YgJgRQen8cmEvP11zugork
	 TEqmjUSOYd9WG0GNmTigIIITd7fX10ahOBY0hFtN8Kl/frrT4YIRVdEeykWOTfnYOt
	 h9uYNUY5Wl20Up88tyAaM50GX49DQXhIUA5KYiFDWKGZL8KON7fHR9D4JRtDqv8eEZ
	 hzzac87JN7fR/dgb6fNrPfit4jhZ9zB4peqFo/JuWPELcn2EFOGM0Q6EoYMZqxvyLB
	 L9F29HiQP/GInS/NVAP5AgTY+a8+VQWXiyjV1Ueua7wwqVQOGU6g8qdJh0JfzPiWQn
	 zoQYTAsqyrAVBex2AjXlJVnrY+Ib0ZWyhL/lnHmCvfQtlWc5T109hd501tvrAQX8GU
	 dK5bG7CIGmBHq3RNzRE7U1y8HvtfJi/67XjEmhFOCvT6LgJHl3tHumY/LIbpvMfQjr
	 vUtGW0zS9qeFajmu6KB4G8Yo=
Received: from zn.tnic (p57969402.dip0.t-ipconnect.de [87.150.148.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 101EF40E016C;
	Wed, 26 Nov 2025 15:13:30 +0000 (UTC)
Date: Wed, 26 Nov 2025 16:13:25 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
	Jason Tian <jason@os.amperecomputing.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Len Brown <lenb@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] apei/ghes: don't go past allocated memory
Message-ID: <20251126151325.GCaScZFXvm-7PYy0Dh@fat_crate.local>
References: <cover.1764169337.git.mchehab+huawei@kernel.org>
 <3f6764ddbc0b596a43a73616d972c2ba0060d1b1.1764169337.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f6764ddbc0b596a43a73616d972c2ba0060d1b1.1764169337.git.mchehab+huawei@kernel.org>

On Wed, Nov 26, 2025 at 04:05:46PM +0100, Mauro Carvalho Chehab wrote:
> If the BIOS generates a very small ARM Processor Error, or
> an incomplete one, the current logic will fail to deferrence
> 
> 	err->section_length
> and
> 	ctx_info->size
> 
> Add checks to avoid that. With such changes, those GHESv2
> records won't cause OOPSes:
> 
>     GUID: e19e3d16-bc11-11e4-9caa-c2051d5d46b0
>     CPER:
>       00000000  23 da a0 ce 9a 1b 92 d7 08 2b 32 08 7b 56 1b 23   #........+2.{V.#

Surely you can summarize this gibberish instead of putting it in the commit
message.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

