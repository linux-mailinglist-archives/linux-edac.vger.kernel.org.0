Return-Path: <linux-edac+bounces-4653-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFF5B342C4
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 16:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F5F5E7BED
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 14:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59E62F3C04;
	Mon, 25 Aug 2025 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EKpByuyw"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902682F3C0D;
	Mon, 25 Aug 2025 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130400; cv=none; b=ZbSzSSsgYnXyJBwDubCUIxv2jdjclDNdqYFlT63oFJq/3vM5qI3WAy0sCHNsbFVodsEoazPSJBs9VVb20PI4B583GVqqNl98i0BcPYsyZ+ODNHvfAQsUjmSunpMkCffH/Mql0bfXQWkqAmf0Bg1i1qOQfSnvCc8j3oSEURapKu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130400; c=relaxed/simple;
	bh=rYRD/HZ3Tpzk1DQ5Y829POkVTZM8tM0nQEqE/Y36k6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICwFrGe5hzvPCkZ+4jPHyalR9adqxjb9Pi89+YZCxXMF2A4iyKLI0q4EuZ2+zeUyDqcfgkvz5ExurYhxNObm14F9cm/DXrPMkx4BsfdZUtUr2Qd32i0UVsgE5Hng8mqlawrOQBCMU/DgRv6WGwVRx8xxcZQPsICN+xst62Cz+ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EKpByuyw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3774240E02A2;
	Mon, 25 Aug 2025 13:59:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PLN_WYZWnhHb; Mon, 25 Aug 2025 13:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756130391; bh=jUnQvc6mz4vGDxL//LckkTiwfWtaOdXiv2Ln9tXl+H4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EKpByuyw8kwp9sPrCsif66id90g9LoluXmrL3IDiCjYVG/30hEKbE27vOf71PG7v4
	 3yRg1OaOrr1HRmZ3doJNzkqHOZN7UWfubMp0xiXNNpq0QJcgv5l+1m3K1War8Z4/bi
	 xTtWmyCk4qmu5O+8SUk4nhYBb7YwxwTi1+k1rjb7XYuLIKR2RAIaaCtSyHCkkzZW6k
	 QdG7meNt7QtN14+JpcoXcGZPR1oBSnDgDI5g1oDBU+NQf300nVOhWEBa96Ii/sETH7
	 OsG4aY6O/lwcur5H9JCXkeejW599XyoQpXUcbNmslCLFVeQ6nt1XWTUUxMUFm3GSWZ
	 plVCGALeMhrourm+rr1789h7LzLkvUJK4TSccHwgkN7WZirW9UiUu13djB+D8ojMl5
	 xflkHYw1ZnD5y7XGDbW2XeDq+CddUg5o0IQI2CL7xFon+oG9H3IwsJKn8JNcdhlaIa
	 vTW4S/GY6BYOx3f7kysRVNqUgxHAA+a/3ESh6m20+XGuv5Q7UMeaStQAJhDJVVM5Hv
	 PprchRKq5dbNQxIjMvM/VeG79nI/UmtJDMQSLjzxaIIg1JTBiLUsSy8pOFwm5NXC7e
	 f8deXd+xqU/MXJDM19yjoSrgQg0P236effTJEoB69JBuhl4uXhM1iNBBlv2h9qx7En
	 SPNqiMaEfpz0/x429ixx4GwE=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9103D40E01A1;
	Mon, 25 Aug 2025 13:59:40 +0000 (UTC)
Date: Mon, 25 Aug 2025 15:59:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 08/22] x86/mce/amd: Put list_head in threshold_bank
Message-ID: <20250825135933.GTaKxsRXQSsvN1dN26@fat_crate.local>
References: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
 <20250624-wip-mca-updates-v4-8-236dd74f645f@amd.com>
 <68039ee2-5407-4bd4-9735-62674805eaad@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68039ee2-5407-4bd4-9735-62674805eaad@suse.com>

On Wed, Jun 25, 2025 at 07:52:26PM +0300, Nikolay Borisov wrote:
> That way you end up with a single btl (but I guess a version that uses btq
> should be added as well) inside the loop rather than a bunch of instructions
> moving data around for per_cpu.

There's also this_cpu_ptr() etc.

You know how I always take patches, right?

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

