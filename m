Return-Path: <linux-edac+bounces-5038-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB34BD691B
	for <lists+linux-edac@lfdr.de>; Tue, 14 Oct 2025 00:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E36188A75A
	for <lists+linux-edac@lfdr.de>; Mon, 13 Oct 2025 22:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF3330CD88;
	Mon, 13 Oct 2025 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gLguihRa"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE3A30C608;
	Mon, 13 Oct 2025 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392845; cv=none; b=aFqX7wVLeGc0rPLA+QWXRs60qGWBXs1ZQMxk23yNCRyCo4pMNezkWi5uWgifaWpTV2Hs1v+ShC+fqFFDn6iYC3AFOAeJeaaiNt25IGpjqI6EBhcwpfYXR8aC7HkYhbRWQf+lvZdh7Z41InNCzcC8HRBLOYja+m3ZNiAYnT/J9j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392845; c=relaxed/simple;
	bh=OI1ZBAPELtqRShnNW0CjGtYWKDHL2NIt/skV5MV3bP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLJVp1MwuFfalNVoJTlkpE3AvktJ49YwHqZSF3y2HcEJiJC0p6iKw8VbfyE5NBqnESC6iF4mC+Qzia/dRchWkfx28kkwlwz4chQ6uTe3JKU8X6n2/PCwybOUiv8sspiLCs/Is9MnO/6+9JWgkBBmLV1m4ZDbEAKyrGtpiFI3Rn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gLguihRa; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DB64D40E019B;
	Mon, 13 Oct 2025 22:00:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dcHedyZRzE7N; Mon, 13 Oct 2025 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760392834; bh=sg+/+xup0pRS2lqQZsknmfDiom+mMq+GRZ0zs/i6p8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gLguihRahldcvuSumdDC5rMlqd4UZyn9YeNderP2cgG9c6nlgxFcgWvvUaWfJeJSM
	 HXzxExj5f6+q/QfYtU7EvQvaHu5u+ijpkXLtkzU2AK4Ni1OhIExK6zthexgYutNm5d
	 AZ7Ltza+CZQu3i+yElLY6Z34fkWgq6Romz8rNqlSJakgwabGbNw47cSGk1LFzbt13i
	 bPe/T5ahIfsFR6zDNA/SEg7k+eGLy0x3VgooGBC+so04X0j/xYkccSWN4KtQFlgEf/
	 YKiRCFJ0NbmadrkfaDu7rGbbhGOL5jXOFGm2zn5k7TKLt8IETAkzE0+tKz9EN9BUGa
	 SiiQPbeaANJS5Zn7NHLtOwPGpUx/EyJs8QRc6kvNVd3rEOxbhwTPJpps5OC2b0xihH
	 LXGKxHkgsUAAWnUEtA9sB83zcl8Hx4GmJ2GwYMN4IafHjnadvtIa8c9d/oOGCscPTe
	 VVxcEXHzNmWR71FJoL2pdQq7laalA+/s+39bch+bo8h5vb+sreQy3279RqkxW/b12f
	 RuF1Y0RHRcLilwAWsHTZwGN1QI0zErRzLipXeLb42nIiByg/Ux/gXvAdYT/q5yD79i
	 WvoEFz6y2pRb3U1Csi5fcY0Bu9MSRRC1NfkYi+AmhelwledaWrR5nRxicuxZ9L4D/k
	 vRUTwxoyEfjNeYhsSyH7cIjI=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 131CF40E01CD;
	Mon, 13 Oct 2025 22:00:29 +0000 (UTC)
Date: Tue, 14 Oct 2025 00:00:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, yazen.ghannam@amd.com, john.allen@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Incorporate DRAM address in EDAC messages
Message-ID: <20251013220019.GFaO12cwSvbedQwGr6@fat_crate.local>
References: <20251013193726.2221539-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013193726.2221539-1-avadhut.naik@amd.com>

On Mon, Oct 13, 2025 at 07:34:47PM +0000, Avadhut Naik wrote:
> Currently, the amd64_edac module only provides UMC normalized and system
> physical address when a DRAM ECC error occurs. DRAM Address is neither
> logged nor exported through tracepoint.
> 
> Modern AMD SOCs provide UEFI PRM module that implements various address
> translation PRM handlers. These PRM handlers can be leveraged to convert
> UMC normalized address into DRAM address at runtime on occurrence of a
> DRAM ECC error. This translated DRAM address can then be logged and
> exported through tracepoints.

And?

I read all three commit messages to figure out *why* those DRAM addresses want
to be logged. But it seems they don't want to be logged. Because there's not
a single reason why they should be, AFAICT. Without a proper justification,
this looks like a bunch of unnecessary code to me...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

